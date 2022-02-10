<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>pwdFind</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
</head>

<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br></p>
	<div class="container">
		<h2>비밀번호 찾기</h2>
  <hr/>
  <form method="post">
    <table class="table table-bordered">
      <tr>
        <th>아이디</th>
        <td><input type="text" name="mid" placeholder="회원 아이디를 입력하세요" class="form-control"/></td>
      </tr>
      <tr>
        <th>이메일</th>
        <td><input type="text" name="email" placeholder="회원가입시에 등록된 이메일주소를 입력하세요" class="form-control"/></td>
      </tr>
      <tr>
        <td colspan="2">
          <button type="submit" class="btn btn-secondary">임시비밀번호발급</button> &nbsp;
          <button type="button" onclick="location.href='${ctp}/member/memLogin';" class="btn btn-secondary">돌아가기</button>
        </td>
      </tr>
    </table>
  </form> 
	</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>