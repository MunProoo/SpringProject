<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>배송지 조회</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
</head>
 <!-- 테이블로 만들자 -->
<body>
<p><br></p>
	<div class="container">
		<h2>배송조회</h2>
  <hr/>
  <p>주문번호 : ${vo.orderIdx}</p>
  <p>주문자 : ${vo.name}</p>
  <p>연락처 : ${vo.tel}</p>
  <p>주소 : ${vo.address}</p>
  <p>이메일 : ${vo.email}</p>
  <p>배송메세지 : ${vo.message}</p>
  <p>결재수단 : ${vo.payment}</p>
  <hr/>
  <p><input type="button" value="창닫기" onclick="window.close()"/></p>
	</div>
</body>
</html>