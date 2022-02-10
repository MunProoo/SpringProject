<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 정보</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
<link type="text/css" rel="stylesheet" href="${ctp}/css/mypage.css?ss">
</head>

<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br></p>
	<div class="container">
		<h6>마이페이지</h6>
		<hr />
		<c:set var="s1" value="0" />
		<c:set var="s2" value="0" />
		<c:set var="s3" value="0" />
		<c:set var="s4" value="0" />
		<c:set var="s5" value="0" />
		<c:forEach var="bVo" items="${bVos}" varStatus="status">
			<c:choose>
				<c:when test="${bVo.orderStatus == '결제완료'}" ><c:set var="s1" value="${s1+1}" /></c:when>
				<c:when test="${bVo.orderStatus == '배송중'}" ><c:set var="s2" value="${s2+1}" /></c:when>
				<c:when test="${bVo.orderStatus == '배송완료'}" ><c:set var="s3" value="${s3+1}" /></c:when>
				<c:when test="${bVo.orderStatus == '구매완료'}" ><c:set var="s4" value="${s4+1}" /></c:when>
				<c:when test="${bVo.orderStatus == '반품처리'}" ><c:set var="s5" value="${s5+1}" /></c:when>
			</c:choose>
			<c:if test="${status.last}"><c:set var="cnt" value="${status.count}"/></c:if>
		</c:forEach>
		
		<div class="row orderstatus">
		    <div class="col">
		    	<div class="mytitle">
		    		<h3>ORDER STATUS</h3>
		    	</div>
		    	<div class="col state">
		    		<ul class = "order">
						<li>
							<strong>결제완료</strong>
							<span>${s1}</span>
						</li>
						<li>
							<strong>배송중</strong>
							<span>${s2}</span>
						</li>
						<li>
							<strong>배송완료</strong>
							<span>${s3}</span>
						</li>
						<li>
							<strong>구매완료</strong>
							<span>${s4}</span>
						</li>
						<li>
							<strong>반품처리</strong>
							<span>${s5}</span>
						</li>
					</ul>
		    	</div>
		    </div>
	  	</div>
	  	
		<div class="row bankbook">
    	<div class="col">
				<ul>
					<li>
						<span class="title">포인트</span>
						<span class="data use"><fmt:formatNumber value="${vo.point}"/>원</span>
					</li>
					<li>
						<span class="title">주문 횟수</span>
						<span class="data use">${cnt} 회</span>
					</li>
				</ul>
  	</div>
	  	
	 	<hr>
		<div class="row myshopMain">
		    <div class="col shopMain">
		    	<a href="${ctp}/product/purchaseHistory">
		    		<strong>order</strong>
		    		고객님께서 주문하신 상품의 주문내역을 확인하실 수 있습니다.
		    		<br/>
		    	</a>
		    </div>
		    <div class="col shopMain">
		   		<a href="${ctp}/member/memPwdCheck">
		    		<strong>Update</strong>
		    		고객님의 개인정보를 관리하는 공간입니다.
		    		<br/>
		    		개인정보를 최신 정보로 유지하시면 보다 간편히 쇼핑을 즐기실 수 있습니다.
		    	</a>
		    </div>
	  	</div>
			<div class="row myshopMain">
		    <div class="col shopMain">
		    	<a href="${ctp}/board/boardSearch?searchString=${sNickName}">
		    		<strong>My Board</strong>
		    		고객님께서 작성하신 게시물을 관리하는 공간입니다.
		    		<br/>
		    		고객님께서 작성하신 글을 한눈에 관리하실 수 있습니다.
		    	</a>
		    </div>
	  	</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>