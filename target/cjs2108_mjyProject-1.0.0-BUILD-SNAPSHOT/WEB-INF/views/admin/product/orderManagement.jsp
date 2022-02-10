<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<% pageContext.setAttribute("newLine", "\n"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>orderManagement</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
 <script>
    function nWin(orderIdx) {
    	let popupX = (document.body.offsetWidth / 2) - (600/2);
    	let popupY = (window.screen.height / 2) - (500/2);
    	var url = "${ctp}/product/orderBaesong?orderIdx="+orderIdx;
    	window.open(url,"orderBaesong","width=600px,height=500px,left="+popupX+",top="+popupY+"");
    }
    
    $(document).ready(function() {
    	// 주문상태로 조회
    	$("#orderStatus").change(function() {
	    	var startJumun = document.getElementById("startJumun").value;
	    	var endJumun = document.getElementById("endJumun").value;
	    	var orderStatus = $(this).val();
	    	location.href="${ctp}/product/orderManagement?startJumun="+startJumun+"&endJumun="+endJumun+"&orderStatus="+orderStatus;
    	});
    	
    	// 날짜별 조회
    	$("#orderDateSearch").click(function() {
	    	var startJumun = document.getElementById("startJumun").value;
	    	var endJumun = document.getElementById("endJumun").value;
	    	var orderStatus = $("#orderStatus").val();
	    	
	    	if((startJumun - endJumun) > 0) {
	    		alert("주문일자를 확인하세요!");
	    		return false;
	    	}
	    	let today = moment().format("YYYY-MM-DD");
	    	
	    	/* if(startJumun == today){
	    		startJumun = moment(startJumun).subtract(1, 'days').format("YYYY-MM-DD"); // 하루전으로 
	    	} */
	    	
	    	location.href="${ctp}/product/orderManagement?startJumun="+startJumun+"&endJumun="+endJumun+"&orderStatus="+orderStatus;
    	});
    	
    });
    
    function orderStatusChange(orderIdx, currentStatus, obj) {
    	var orderStatus = $(obj).val();
    	
    	var ans = confirm("주문상태를 변경하시겠습니까? \n'"+currentStatus+"' ⨠⨠ "+orderStatus+"' ");
    	if(!ans) return false;
  		var query = {
  				orderStatus : $(obj).val(),
  				orderIdx : orderIdx
  		};
  		$.ajax({
  			type  : "post",
  			url   : "${ctp}/product/orderStatusChange",
  			data  : query,
  			success : function(data) {
  				alert("주문상태가 변경되었습니다.");
  				location.reload();
  			},
  			error : function(){
  				alert("처리오류")
  			}
    	}); 
    }
    
  </script>
</head>

<body>
<p><br></p>
	<div class="container">
	 	<h2>주문/배송 확인</h2>
	  <hr/>
	  <table class="table table-borderless ">
	    <tr>
	      <td>주문/배송일자 조회 :
	        <input type="date" name="startJumun" id="startJumun" value="${startJumun}"/>~~<input type="date" name="endJumun" id="endJumun" value="${endJumun}"/>
	        <button type="button" id="orderDateSearch" class="btn btn-outline-secondary m-0 p-1">조회</button>
	        <!-- <button type="button" class="btn btn-outline-info m-0 p-1" onclick="location.reload()">전체 조회</button> -->
	      </td>
	      <td align="right">주문상태조회 :
	        <select name="orderStatus" id="orderStatus">
	          <option value="전체"    ${orderStatus == '전체'    ? 'selected' : ''}>전체</option>
	          <option value="결제완료" ${orderStatus == '결제완료' ? 'selected' : ''}>결제완료</option>
	          <option value="배송중"  ${orderStatus == '배송중'   ? 'selected' : ''}>배송중</option>
	          <option value="배송완료" ${orderStatus == '배송완료' ? 'selected' : ''}>배송완료</option>
	          <option value="구매완료" ${orderStatus == '구매완료' ? 'selected' : ''}>구매완료</option>
	          <option value="반품처리" ${orderStatus == '반품처리' ? 'selected' : ''}>반품처리</option>
	        </select>
	      </td>
	    </tr>
	  </table>
	  <table class="table table-hover">
	    <tr style="text-align:center;background-color:#ccc;">
	      <th>주문정보</th>
	      <th>아이디</th>
	      <th>상품</th>
	      <th>주문내역</th>
	      <th>주문일시</th>
	    </tr>
	    <c:forEach var="vo" items="${orderVos}">
	      <tr>
	        <td style="text-align:center;">
	          <p>주문번호 : ${vo.orderIdx}</p>
	          <p>총 주문액 : <fmt:formatNumber value="${vo.totalPrice}"/>원</p>
	          <p><input type="button" value="배송지정보" onclick="nWin('${vo.orderIdx}')"></p>
	        </td>
	        <td style="text-align:center; vertical-align: middle"><font color="blue"><b>${vo.mid }</b></font></td>
	        <td style="text-align:center;"><br/><img src="${ctp}/product/${vo.thumbImg}" class="thumb" width="100px"/></td>
	        <td align="left">
		        <p>모델명 : <span style="color:orange;font-weight:bold;">${vo.productName}</span><br/> &nbsp; &nbsp; </p>
		        <c:set var="optionNames" value="${fn:split(vo.optionName,',')}"/>
		        <c:set var="optionPrices" value="${fn:split(vo.optionPrice,',')}"/>
		        <c:set var="optionNums" value="${fn:split(vo.optionNum,',')}"/>
		        <p>
		          - 주문 내역
		          <c:if test="${fn:length(optionNames) > 1}">(옵션 ${fn:length(optionNames)-1}개 포함)</c:if><br/>
		          <c:forEach var="i" begin="1" end="${fn:length(optionNames)}">
		            &nbsp; &nbsp; ㆍ ${optionNames[i-1]} / <fmt:formatNumber value="${optionPrices[i-1]}"/>원 / ${optionNums[i-1]}개<br/>
		          </c:forEach>
		        </p>
		      </td>
	        <td style="text-align:center;"><br/>
	          주문일자 : ${fn:substring(vo.orderDate,0,10)}<br/><br/>
	          <select name="orderStatusChange" id="orderStatusChange" onchange="orderStatusChange('${vo.orderIdx}' ,'${vo.orderStatus}' ,this)">
		          <option value="전체"    ${vo.orderStatus == '전체'    ? 'selected' : ''}>전체</option>
		          <option value="결제완료" ${vo.orderStatus == '결제완료' ? 'selected' : ''}>결제완료</option>
		          <option value="배송중"  ${vo.orderStatus == '배송중'   ? 'selected' : ''}>배송중</option>
		          <option value="배송완료" ${vo.orderStatus == '배송완료' ? 'selected' : ''}>배송완료</option>
		          <option value="구매완료" ${vo.orderStatus == '구매완료' ? 'selected' : ''}>구매완료</option>
		          <option value="반품처리" ${vo.orderStatus == '반품처리' ? 'selected' : ''}>반품처리</option>
	       		</select>
	        </td>
	      </tr>
	    </c:forEach>
	  </table>
	  <hr/>
	<p><br/></p>
	  <!-- 블록 페이징처리 시작(BS4 스타일적용) -->
		<div class="container">
			<ul class="pagination justify-content-center">
				<c:if test="${totPage == 0}"><p style="text-align:center"><b>자료가 없습니다.</b></p></c:if>
				<c:if test="${totPage != 0}">
				  <c:if test="${pag != 1}">
				    <li class="page-item"><a href="${ctp}/product/orderManagement?orderManagement?startJumun=${startJumun}&endJumun=${endJumun}&orderStatus=${orderStatus}&pag=1" title="첫페이지" class="page-link text-secondary">◁◁</a></li>
				  </c:if>
				  <c:if test="${curBlock > 0}">
				    <li class="page-item"><a href="${ctp}/product/orderManagement?startJumun=${startJumun}&endJumun=${endJumun}&orderStatus=${orderStatus}&pag=${(curBlock-1)*blockSize + 1}" title="이전블록" class="page-link text-secondary">◀</a></li>
				  </c:if>
				  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
				    <c:if test="${i == pag && i <= totPage}">
				      <li class="page-item active"><a href='${ctp}/product/orderManagement?startJumun=${startJumun}&endJumun=${endJumun}&orderStatus=${orderStatus}&pag=${i}' class="page-link text-light bg-secondary border-secondary">${i}</a></li>
				    </c:if>
				    <c:if test="${i != pag && i <= totPage}">
				      <li class="page-item"><a href='${ctp}/product/orderManagement?startJumun=${startJumun}&endJumun=${endJumun}&orderStatus=${orderStatus}&pag=${i}' class="page-link text-secondary">${i}</a></li>
				    </c:if>
				  </c:forEach>
				  <c:if test="${curBlock < lastBlock}">
				    <li class="page-item"><a href="${ctp}/product/orderManagement?startJumun=${startJumun}&endJumun=${endJumun}&orderStatus=${orderStatus}&pag=${(curBlock+1)*blockSize + 1}" title="다음블록" class="page-link text-secondary">▶</a>
				  </c:if>
				  <c:if test="${pag != totPage}">
				    <li class="page-item"><a href="${ctp}/product/orderManagement?startJumun=${startJumun}&endJumun=${endJumun}&orderStatus=${orderStatus}&pag=${totPage}" title="마지막페이지" class="page-link" style="color:#555">▷▷</a>
				  </c:if>
				</c:if>
			</ul>
		</div>
		<!-- 블록 페이징처리 끝 -->
	</div>
</body>
</html>