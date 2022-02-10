<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>noticeContent</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
</head>
<script>
	function delCheck(){
		var ans = confirm("공지사항을 정말 삭제하시겠습니까?");
		if(ans) location.href='${ctp}/notice/noticeDelete?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';
		
	}

</script>
<style>
	th{
		background-color: #eee;
	}
</style>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br></p>
	<div class="container">
		<h3 style="text-align:center">공 지 사 항</h3>
  	<br/>
  	<table class="table table-bordered">
	    <tr>
	      <th>글쓴이</th>
	      <td>${vo.nickName}</td>
	      <th>조회수</th>
	      <td>${vo.readNum}</td>
	      <th>등록일</th>
	      <td>
	      	<c:if test="${vo.diffTime <= 24}">${fn:substring(vo.WDate,11,19)}</c:if>
	        <c:if test="${vo.diffTime >  24}">${fn:substring(vo.WDate,0,10)}</c:if>
	      </td>
	    </tr>
	    <tr>
	      <th>제목</th>
	      <td colspan="5">${vo.title}</td>
	    </tr>
	    <tr>
	      <th>내용</th>
	      <td colspan="5" style="height:500px">${fn:replace(vo.content,newLine,'<br/>')}</td>
	    </tr>
	    <tr>
	      <td colspan="6" class="text-center">
		        <input type="button" value="돌아가기" onclick="location.href='${ctp}/notice/noticeList?pag=${pag}&pageSize=${pageSize}';"/>
		        <c:if test="${sMid == vo.mid}">
		          <input type="button" value="수정하기" onclick="location.href='${ctp}/notice/noticeUpdate?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';"/>
		          <input type="button" value="삭제하기" onclick="delCheck()"/>
		        </c:if>
	      </td>
	    </tr>
  </table>
  
  <!-- 이전글/다음글 처리 -->
	  <table class="table table-borderless">
	    <tr>
	      <td>
	        <c:if test="${!empty pnVos[1]}">
		        👆 <a href="${ctp}/notice/noticeContent?idx=${pnVos[1].idx}&pag=${pag}&pageSize=${pageSize}">다음글 : ${pnVos[1].title}</a><br/>
	        </c:if>
	        <c:if test="${!empty pnVos[0]}">
		        👇 <a href="${ctp}/notice/noticeContent?idx=${pnVos[0].idx}&pag=${pag}&pageSize=${pageSize}">이전글 : ${pnVos[0].title}</a><br/>
	        </c:if>
	      </td>
	    </tr>
	  </table>
  <br/>
  
	</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>