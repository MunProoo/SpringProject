<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>주문확인</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
<script>
	  function nWin(orderIdx) {
	  	let popupX = (document.body.offsetWidth / 2) - (600/2);
	  	let popupY = (window.screen.height / 2) - (500/2);
	  	var url = "${ctp}/product/orderBaesong?orderIdx="+orderIdx;
	  	window.open(url,"orderBaesong","width=600px,height=500px,left="+popupX+",top="+popupY+"");
	  }
  </script>
</head>

<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br></p>
	<div class="container">
	 <h2>주문완료</h2>
	  <hr/>
	  <table class="table table-bordered">
	    <tr style="text-align:center;background-color:#ccc;">
	      <th>상품이미지</th>
	      <th>주문일시</th>
	      <th>주문내역</th>
	      <th>비고</th>
	    </tr>
	    <c:forEach var="vo" items="${orderVos}">
	      <tr>
	        <td style="text-align:center;">
	          <img src="${ctp}/product/${vo.thumbImg}" class="thumb" width="200px"/>
	        </td>
	        <td style="text-align:center;"><br/>
	          <p>주문번호 : ${vo.orderIdx}</p>
	          <p>총 주문액 : <fmt:formatNumber value="${vo.totalPrice}"/>원</p>
	          <p><input type="button" value="배송지정보" onclick="nWin('${vo.orderIdx}')"></p>
	        </td>
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
	        <td style="text-align:center; vertical-align: middle"><br/>결제완료<br/>(배송준비중)</td>
	      </tr>
	    </c:forEach>
	  </table>
	  <hr/>
	  <p class="text-center"><a href="${ctp}/product/productList" class="btn btn-secondary">계속쇼핑하기</a> &nbsp;
	    <a href="${ctp}/product/purchaseHistory" class="btn btn-secondary">구매내역보기</a>
	  </p>
	  <hr/>
	<p><br/></p>
	</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>