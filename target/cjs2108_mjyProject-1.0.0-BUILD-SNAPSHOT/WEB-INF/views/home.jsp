<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="/WEB-INF/views/include/bs4.jsp" %>
<style>
@media screen and (max-width:1000px){
	.nav-main-ul:hover .nav-sub-ul{
	height:0px;
	}
	.nav-main-li{
		width:100%;
		display: inline-block;
	}
}
</style>
  <title>Musinsa</title>
  
</head>
<body>
<!-- 헤더 -->
  <jsp:include page="/WEB-INF/views/include/header.jsp" />
<!-- 네비 -->
  <jsp:include page="/WEB-INF/views/include/nav.jsp" />

  <div id="demo" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ul class="carousel-indicators">
      <li data-target="#demo" data-slide-to="0" class="active"></li>
      <li data-target="#demo" data-slide-to="1"></li>
      <li data-target="#demo" data-slide-to="2"></li>
    </ul>

    <!-- The slideshow -->
    <div class="carousel-inner">
      <div class="carousel-item active">
        <img src="https://image.brandi.me/home/banner/bannerImage_538001_1634175598.jpg" width="100%" height="500px">
      </div>
      <div class="carousel-item">
        <img src="https://image.brandi.me/home/banner/bannerImage_555521_1635494528.jpg" width="100%" height="500px">
      </div>
      <div class="carousel-item">
        <img src="https://image.brandi.me/home/banner/bannerImage_0_1634884735.jpg" width="100%" height="500px">
      </div>
    </div>

    <!-- Left and right controls -->
    <a class="carousel-control-prev" href="#demo" data-slide="prev">
      <span class="carousel-control-prev-icon"></span></a> 
    <a class="carousel-control-next" href="#demo" data-slide="next">
      <span class="carousel-control-next-icon"></span></a>
  </div>
  
  <div class="mainDiv">
		<h2 class="h2"><span class="h2span">인기 상품</span></h2>
		<hr>
		 <div class="row">
		  <c:forEach var="vo" items="${popularVos}">
		    <div class="col-3">
		      <div style="text-align:center">
		        <a href="${ctp}/product/productContent?idx=${vo.idx}">
		          <img src="${ctp}/product/${vo.FSName}" width="500px" height="400px"/>
		          	<p style="font-weight: bold"><label style="color:#FACC2E">&#9733;</label> ${vo.ratingAvg}점</p>
		          	<p><font size="2">${vo.productName}</font></p>
		          	<p><font size="2">${vo.detail}</font></p>
		          	<p><font size="2" color="orange"><fmt:formatNumber value="${vo.mainPrice}" pattern="#,###"/>원</font></p>	
		        </a>
		      </div>
		    </div>
		  </c:forEach>
		  <div class="container" style="text-align: center">
		    <c:if test="${fn:length(popularVos) == 0}"><h3>제품 준비 중입니다.</h3></c:if>
		  </div>
		</div>
  
    <h2 class="h2"><span class="h2span">추천 상품</span></h2>
    <hr>
     <div class="row">
		  <c:forEach var="vo" items="${recoVos}">
		    <div class="col-3">
		      <div style="text-align:center">
		        <a href="${ctp}/product/productContent?idx=${vo.idx}">
		          <img src="${ctp}/product/${vo.FSName}" width="500px" height="400px"/>
		          	<p><font size="2">${vo.productName}</font></p>
		          	<p><font size="2">${vo.detail}</font></p>
		          	<p><font size="2" color="orange"><fmt:formatNumber value="${vo.mainPrice}" pattern="#,###"/>원</font></p>	
		        </a>
		      </div>
		    </div>
		  </c:forEach>
		  <div class="container" style="text-align: center">
		    <c:if test="${fn:length(recoVos) == 0}"><h3>제품 준비 중입니다.</h3></c:if>
		  </div>
		</div>
  
    <h2 class="h2"><span class="h2span">신상 모아보기</span></h2>
    <hr>
     <div class="row">
		  <c:forEach var="vo" items="${newVos}">
		    <div class="col-3">
		      <div style="text-align:center">
		        <a href="${ctp}/product/productContent?idx=${vo.idx}">
		          <img src="${ctp}/product/${vo.FSName}" width="500px" height="400px"/>
		          	<p><font size="2">${vo.productName}</font></p>
		          	<p><font size="2">${vo.detail}</font></p>
		          	<p><font size="2" color="orange"><fmt:formatNumber value="${vo.mainPrice}" pattern="#,###"/>원</font></p>	
		        </a>
		      </div>
		    </div>
		  </c:forEach>
		  <div class="container" style="text-align: center">
		    <c:if test="${fn:length(newVos) == 0}"><h3>제품 준비 중입니다.</h3></c:if>
		  </div>
		</div>

  </div>
<!-- footer -->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>