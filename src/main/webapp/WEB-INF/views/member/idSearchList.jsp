<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>idSearchList</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
</head>

<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br></p>
	<div class="container">
		<h2>검색된 아이디 리스트</h2>
	  <hr/>
	  <p>입력하신 이메일아이디로 검색된 아이디(<font color="red">${fn:split(vos[0].email,'@')[0]}</font>)는 아래와 같습니다.</p>
	  <hr/>
	  <div>
	    <c:forEach var="vo" items="${vos}" varStatus="st">
	      <c:set var="mid1" value="${fn:substring(vo.mid,0,2)}"/>
	      <c:set var="mid2" value="${fn:substring(vo.mid,4,fn:length(vo.mid))}"/>
	      <p>${st.count}. <font color="blue">${mid1}**${mid2}</font> &nbsp;&nbsp;&nbsp;(${vo.email})</p>
	    </c:forEach>
	    <hr/>
	    <p><input type="button" value="로그인창으로이동" onclick="location.href='${ctp}/member/memLogin';"/></p>
  </div>
	</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>