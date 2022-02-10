<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>구매내역 조회</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script>
//배송지 정보보기
function nWin(orderIdx) {
	let popupX = (document.body.offsetWidth / 2) - (600/2);
	let popupY = (window.screen.height / 2) - (500/2);
	var url = "${ctp}/product/orderBaesong?orderIdx="+orderIdx;
	window.open(url,"orderBaesong","width=600px,height=500px,left="+popupX+",top="+popupY+"");
}

$(document).ready(function() {
	// 주문 상태별 조회
	$("#orderStatus").change(function() {
  	var orderStatus = $(this).val();
  	var pag = '${pag}';
  	var startDateJumun = new Date(document.getElementById("startJumun").value);
  	var endDateJumun = new Date(document.getElementById("endJumun").value);
  	
  	if((startDateJumun - endDateJumun) > 0) {
  		alert("주문일자를 확인하세요!");
  		return false;
  	}
  	//let today = new Date();
  	let today = moment().format("YYYY-MM-DD");
  	let startJumun = moment(startDateJumun).format("YYYY-MM-DD");
  	let endJumun = moment(endDateJumun).format("YYYY-MM-DD");
  	
  	if(startJumun == today){
  		startJumun = moment(startJumun).subtract(1, 'days').format("YYYY-MM-DD");
  	}
  	
  	location.href="${ctp}/product/purchaseHistory?orderStatus="+orderStatus+"&startJumun="+startJumun+"&endJumun="+endJumun;
	});
});

// 날짜별 주문 조건 조회
function orderCondition(conditionDate) {
	var orderStatus = document.getElementById("orderStatus").value;
	var pag = '${pag}';
	location.href="${ctp}/product/purchaseHistory?orderStatus="+orderStatus+"&conditionDate="+conditionDate;
}

// 날찌기간에 따른 조건검색
function myOrderStatus() {
	var startDateJumun = new Date(document.getElementById("startJumun").value);
	var endDateJumun = new Date(document.getElementById("endJumun").value);
	var orderStatus = document.getElementById("orderStatus").value;
	var pag = '${pag}';
	
	if((startDateJumun - endDateJumun) > 0) {
		alert("주문일자를 확인하세요!");
		return false;
	}
	//let today = new Date();
	let today = moment().format("YYYY-MM-DD");
	let startJumun = moment(startDateJumun).format("YYYY-MM-DD");
	let endJumun = moment(endDateJumun).format("YYYY-MM-DD");
	
	if(startJumun == today){
		startJumun = moment(startJumun).subtract(1, 'days').format("YYYY-MM-DD");
	}
	location.href="${ctp}/product/purchaseHistory?orderStatus="+orderStatus+"&startJumun="+startJumun+"&endJumun="+endJumun;
}

// 구매후기
function review(productIdx,orderIdx){
	let popupX = (document.body.offsetWidth / 2) - (1000/2);
	let popupY = (window.screen.height / 2) - (800/2);
	var url = "${ctp}/product/review?orderIdx="+orderIdx+"&productIdx="+productIdx;
	window.open(url,"orderBaesong","width=1000px,height=800px,left="+popupX+",top="+popupY+"");
}

// 주문취소
function delOrder(productIdx,orderIdx){
	let ans = confirm("주문을 취소하시겠습니까?");
	if(!ans) return false;
	
	$.ajax({
		type : "post",
		url : "${ctp}/product/delOrder",
		data : {
			productIdx : productIdx,
			orderIdx : orderIdx
		},
		success : function(){
			alert("주문이 취소되었습니다.");
			location.reload();
		},
		error : function(){
			alert("처리오류");
		}
	});
	
}

</script>
</head>

<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<c:set var="conditionOrderStatus" value="${conditionOrderStatus}"/>
<c:set var="orderStatus" value="${orderStatus}"/> 
<p><br></p>
	<div class="container">
	  <c:if test="${conditionDate=='1'}"><c:set var="condition" value="1일 이내 조회"/></c:if>
	  <c:if test="${conditionDate=='7'}"><c:set var="condition" value="7일 이내 조회"/></c:if>
	  <c:if test="${conditionDate=='30'}"><c:set var="condition" value="1개월 이내 조회"/></c:if>
	  <c:if test="${conditionDate=='180'}"><c:set var="condition" value="6개월 이내 조회"/></c:if>
	  <h2>주문/배송 확인</h2>
	  <hr/>
	  <table class="table table-borderless">
	    <tr>
	      <td style="text-align:left;">주문조회 : 
				 <%--  <c:choose>
				    <c:when test="${conditionDate == '1'}"><c:set var="conditionDate" value="1일 이내"/></c:when>
				    <c:when test="${conditionDate == '7'}"><c:set var="conditionDate" value="7일 이내"/></c:when>
				    <c:when test="${conditionDate == '30'}"><c:set var="conditionDate" value="1개월 이내 조회"/></c:when>
				    <c:when test="${conditionDate == '180'}"><c:set var="conditionDate" value="6개월 이내 조회"/></c:when>
				    <c:otherwise><c:set var="conditionDate" value="전체"/></c:otherwise>
				  </c:choose> --%>
	        <input type="button" value="오늘" onclick="orderCondition(1)"/>
	        <input type="button" value="7일 이내" onclick="orderCondition(7)"/>
	        <input type="button" value="1개월 이내" onclick="orderCondition(30)"/>
	        <input type="button" value="6개월 이내" onclick="orderCondition(180)"/>
	        <input type="button" value="전체조회(1년)" onclick="orderCondition(99999)"/>
	      </td>
	      <td style="text-align:right;">주문상태 :
	        <select name="orderStatus" id="orderStatus">
	          <option value="전체" ${orderStatus == '전체' ? 'selected' : ''}>전체조회</option>
	          <option value="결제완료" ${orderStatus == '결제완료' ? 'selected' : ''}>결제완료</option>
	          <option value="배송중"  ${orderStatus == '배송중' ? 'selected' : ''}>배송중</option>
	          <option value="배송완료"  ${orderStatus == '배송완료' ? 'selected' : ''}>배송완료</option>
	          <option value="구매완료"  ${orderStatus == '구매완료' ? 'selected' : ''}>구매완료</option>
	          <option value="반품처리"  ${orderStatus == '반품처리' ? 'selected' : ''}>반품처리</option>
	        </select>
	      </td>
	    </tr>
	    <tr>
	      <td style="text-align:left;">날짜기간 및 조건검색 :
	        <input type="date" name="startJumun" id="startJumun" value="${startJumun}"/>~~<input type="date" name="endJumun" id="endJumun" value="${endJumun}"/>
	        <input type="button" value="조회하기" onclick="myOrderStatus()"/>
	      </td>
	      <td style="text-align:right;">
		      <a href="${ctp}/product/cartList" class="btn btn-secondary btn-sm">장바구니조회</a>
		      <a href="${ctp}/product/productList" class="btn btn-secondary btn-sm">계속쇼핑하기</a>
	      </td>
	    </tr>
	  </table>
	  <table class="table table-hover">
	    <tr style="text-align:center;background-color:#ccc;">
	      <th>주문정보</th>
	      <th>상품</th>
	      <th>주문내역</th>
	      <th>주문일시</th>
	      <th>구매후기</th>
	      <th>주문취소</th>
	    </tr>
	    <c:forEach var="vo" items="${orderVos}">
	      <tr>
	        <td style="text-align:center;">
	          <br><p>주문번호 : ${vo.orderIdx}</p><br>
	          <%-- <p>총 주문액 : <fmt:formatNumber value="vo.totalPrice"/>원</p> --%>
	          <p>총 주문액 : <fmt:formatNumber value="${vo.totalPrice}"/>원</p>
	          <p><input type="button" value="배송지정보" onclick="nWin('${vo.orderIdx}')"></p>
	        </td>
	        <td style="text-align:center; margin-top:0px "><a href="${ctp}/product/productContent?idx=${vo.productIdx}"><img src="${ctp}/product/${vo.thumbImg}" class="thumb" width="200px"/></a></td>
	        <td align="left">
		        <p><br/>모델명 : <span style="color:orange;font-weight:bold;">${vo.productName}</span><br/> &nbsp; &nbsp;</p><br/>
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
	          주문상태 : <font color="brown">${vo.orderStatus}</font><br/>
	          <c:if test="${vo.orderStatus eq '결제완료'}">(배송준비중)</c:if>
	        </td>
	        <td style="vertical-align: middle">
	        	<input type="button" class="btn btn-outline-info btn-sm" value="구매후기" onclick="review(${vo.productIdx},'${vo.orderIdx}')">
	        </td>
	        <td style="vertical-align: middle">
	        	<input type="button" class="btn btn-outline-danger btn-sm" value="주문취소" onclick="delOrder(${vo.productIdx},'${vo.orderIdx}')">
	        </td>
	      </tr>
	    </c:forEach>
	  </table>
  <!-- 블록 페이징처리 시작(BS4 스타일적용) -->
	<div class="container">
		<ul class="pagination justify-content-center">
			<c:if test="${totPage == 0}"><p style="text-align:center"><b>내역이 없습니다.</b></p></c:if>
			<c:if test="${totPage != 0}">
			  <c:if test="${pag != 1}">
			    <li class="page-item"><a href="${ctp}/product/purchaseHistory?orderStatus=${orderStatus}&startJumun=${startJumun}&endJumun=${endJumun}&pag=1" title="첫페이지" class="page-link text-secondary">◁◁</a></li>
			  </c:if>
			  <c:if test="${curBlock > 0}">
			    <li class="page-item"><a href="${ctp}/product/purchaseHistory?orderStatus=${orderStatus}&startJumun=${startJumun}&endJumun=${endJumun}&pag=${(curBlock-1)*blockSize + 1}" title="이전블록" class="page-link text-secondary">◀</a></li>
			  </c:if>
			  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
			    <c:if test="${i == pag && i <= totPage}">
			      <li class="page-item active"><a href='${ctp}/product/purchaseHistory?orderStatus=${orderStatus}&startJumun=${startJumun}&endJumun=${endJumun}&pag=${i}' class="page-link text-light bg-secondary border-secondary">${i}</a></li>
			    </c:if>
			    <c:if test="${i != pag && i <= totPage}">
			      <li class="page-item"><a href='${ctp}/product/purchaseHistory?orderStatus=${orderStatus}&startJumun=${startJumun}&endJumun=${endJumun}&pag=${i}' class="page-link text-secondary">${i}</a></li>
			    </c:if>
			  </c:forEach>
			  <c:if test="${curBlock < lastBlock}">
			    <li class="page-item"><a href="${ctp}/product/purchaseHistory?orderStatus=${orderStatus}&startJumun=${startJumun}&endJumun=${endJumun}&pag=${(curBlock+1)*blockSize + 1}" title="다음블록" class="page-link text-secondary">▶</a>
			  </c:if>
			  <c:if test="${pag != totPage}">
			    <li class="page-item"><a href="${ctp}/product/purchaseHistory?orderStatus=${orderStatus}&startJumun=${startJumun}&endJumun=${endJumun}&pag=${totPage}" title="마지막페이지" class="page-link" style="color:#555">▷▷</a>
			  </c:if>
			</c:if>
		</ul>
	</div>
	<!-- 블록 페이징처리 끝 -->
  <hr/>
  <p class="text-center"><a href="${ctp}/product/productContent" class="btn btn-secondary">계속쇼핑하기</a></p>
  <hr/>
	</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>