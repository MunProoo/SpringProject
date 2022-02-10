<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>adTop</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
<style>
	a:link{
		color:black;
	}
	a:visited{
		color:black;
	}
	.manage1{
		/* background-color: -webkit-linear-gradient(to right, #12c2e9, #c471ed, #f64f59);  */
		background: linear-gradient(to right, #12c2e9, #c471ed, #f64f59);
	}
	.manage2{
		background: linear-gradient(to bottom, #7f7fd5, #86a8e7, #91eae4);
	}
	.manage3{
		background: linear-gradient(to bottom, #f12711, #f5af19);
	}
	.manage3 a:linked{
		color:white;
	}
	.manage3 a:visited{
		color:white;
	}
</style>
</head>

<body>
<p><br></p>
	<div class="container">
		<h6><a href="${ctp}/admin/adContent" target="adContent">관리자 메인메뉴</a></h6>
	  <hr/>
	  <p class="manage1"><a href="${ctp}/admin/adMemberList" target="adContent">회원관리</a><br>
	  <a href="${ctp}/admin/adBoardList" target="adContent">게시판관리</a></p>
	  <hr/>
	  <p class="manage2"><a href="${ctp}/inquiry/inquiryAns" target="adContent">1:1문의</a></p>
	  <hr/>
	  <p class="manage3"><a href="${ctp}/product/categoryInput" target="adContent">상품분류등록</a><br>
	  <a href="${ctp}/product/productInput" target="adContent">상품등록</a><br>
	  <a href="${ctp}/product/productDelete" target="adContent">상품관리</a><br>
	  <a href="${ctp}/product/productOption" target="adContent">옵션등록</a><br>
	  <a href="${ctp}/product/orderManagement" target="adContent">주문관리</a><br>
	  <a href="${ctp}/product/recoManagement" target="adContent">추천상품관리</a><br>
	  <a href="${ctp}/product/productReview" target="adContent">상품리뷰관리</a><br>
	  <a href="${ctp}/admin/chart" target="adContent">판매현황</a></p>
	  <hr/>
	  <p><a href="${ctp}/admin/tempFileDelete" target="adContent">임시파일삭제</a></p>
	  <hr/>
	  <p><a href="${ctp}/" target="_top">홈으로</a></p>
	</div>
</body>
</html>