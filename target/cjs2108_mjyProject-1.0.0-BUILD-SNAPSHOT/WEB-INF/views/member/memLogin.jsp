<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memLogin.jsp</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
</head>
<body>
<!-- 헤더 -->
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
<!-- 네비 -->
	<%@ include file="/WEB-INF/views/include/nav.jsp"%>
	<p><br></p>
	<div class="container">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="container" >
					<h1 style="text-align: center">로그인</h1>
						<br>
						<form name="myform"	method="post" class="was-validated">
							<div class="form-group">
								<label for="mid">아이디: </label>
								<input type="text" class="form-control" id="mid" placeholder="아이디를 입력하세요." 
									name="mid" value="${mid}" required autofocus >
								<div class="invalid-feedback"></div>
							</div>
							<div class="form-group">
								<label for="pwd">비밀번호 : </label>
								<input type="password" class="form-control" id="pwd" placeholder="비밀번호를 입력하세요."
									name="pwd" maxlength="12" required >
								<div class="invalid-feedback"></div>
							</div>
							<button type="submit" class="btn btn-primary">로그인</button>
							<button type="button" onclick="location.href='${ctp}/';" class="btn btn-primary">돌아가기</button>
							<button type="button" onclick="location.href='${ctp}/member/memJoin';" class="btn btn-warning">회원가입</button>
							<div class="row" style="font-size:16px;">
								<span class="col mt-3 mb-3">
									<label for="idCheck" style="cursor:pointer">
										<input type="checkbox" name="idCheck" id="idCheck" checked> 아이디 저장
									</label>
								</span>
								<span class="col mt-3">[<a href="${ctp}/member/idFind">아이디찾기</a>] / [<a href="${ctp}/member/pwdFind">비밀번호찾기</a>]</span>
								<p><br></p>
							</div>
						</form>
				</div>
			</div>
		</div>
	</div>
	<br>
<!-- footer -->
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>