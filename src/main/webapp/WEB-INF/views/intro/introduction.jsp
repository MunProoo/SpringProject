<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회사소개</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
</head>

<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br></p>
	<div>
		<img src="${ctp}/images/intro/introduction.png">
	</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>