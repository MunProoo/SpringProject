<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>memPwdCheck.jsp</title>
</head>

<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br></p>
	<div class="container">
		<h4>회원 정보를 수정하려면 비밀번호를 입력해주십시오.</h4>
			<form name="myform"	method="post" class="was-validated">
				<div class="form-group">
					<label for="mid">아이디: </label>
					<input type="text" class="form-control" id="mid" value="${sMid}" disabled
						name="mid" required autofocus >
				</div>
				<div class="form-group">
					<label for="pwd">비밀번호 : </label>
					<input type="password" class="form-control" id="pwd" placeholder="비밀번호를 입력하세요."
						name="pwd" maxlength="12" required >
					<div class="invalid-feedback">비밀번호를 입력하십시오.</div>
				</div>
				<button type="submit" class="btn btn-primary p-2" >정보 수정하러 가기</button>
				<input type="button" value="돌아가기" onclick="location.href='${ctp}/member/memMain';" class="btn btn-info p-2">
				<p><br></p>
			</form>
	</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>