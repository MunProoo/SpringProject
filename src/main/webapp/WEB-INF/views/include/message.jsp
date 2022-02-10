<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>title</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
<script>
	var msg = "${msg}";
	var url = "${ctp}${url}";

	alert(msg);
	if(msg == "장바구니에 추가되었습니다.") {
		var ans = confirm("장바구니로 이동하시겠습니까?");
		if(ans) location.href= url;
		else history.back();
	}
	if (url != "") location.href = url;
	
</script>

</head>

</html>