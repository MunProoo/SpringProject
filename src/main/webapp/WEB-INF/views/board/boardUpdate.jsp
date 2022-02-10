<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>boardUpdate</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
 <script src="${ctp}/ckeditor/ckeditor.js"></script>
<script>
  function fCheck() {
  	var title = myform.title.value;
  	
  	if(title.trim() == "") {
  		alert("게시글 제목을 입력하세요");
  		myform.title.focus();
  	}
  	else {
  		myform.oriContent.value = document.getElementById("oriContent").innerHTML;
  		myform.submit();
  	}
  }
  
	//게시글 삭제처리
	function delCheck() {
		var ans = confirm("게시글을 삭제하시겠습니까?");
		if(ans) location.href="${ctp}/board/boardDelete?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&lately=${lately}";
	}
</script>
 
 
</head>

<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br></p>
	<div class="container">
		<form name="myform" method="post">
	  <h3 style="text-align:center">게시판 글 수정</h3>
  	<br/>
  	<table class="table table-bordered">
	    <tr>
	      <th>글쓴이</th>
	      <td>${vo.nickName}</td>
	      <th>접속IP</th>
      	<td>${vo.hostIp}</td>
	    </tr>
	    <tr>
	      <th>등록일</th>
	      <td>
	      	<c:if test="${vo.diffTime <= 24}">${fn:substring(vo.WDate,11,19)}</c:if>
	        <c:if test="${vo.diffTime >  24}">${fn:substring(vo.WDate,0,10)}</c:if>
	      </td>
	      <th>조회수</th>
	      <td>${vo.readNum}</td>
    	</tr>
    	<tr>
				<th>추천수</th>
      	<td colspan="3">${vo.good}</td>
    	</tr>
	    <tr>
	      <th>제목</th>
	      <td colspan="3"><input type="text" name="title" value="${vo.title}" class="form-control" required ></td>
	    </tr>
	    <tr>
	      <th>내용</th>
	      <td colspan="3" style="height:500px"><textarea rows="6" name="content" id="CKEDITOR" class="form-control" required autofocus>${vo.content}</textarea></td>
	      <script>
	      	CKEDITOR.replace("content",{
	      		uploadUrl: "${ctp}/imageUpload",							/* 여러개의 그림파일을 드래그&드롭으로 처리 */
	      		filebrowserUploadUrl : "${ctp}/imageUpload",	/* 파일(이미지) 업로드시 처리 */
	      		height:460
	      	});
	      </script>
	    </tr>
	    <tr>
	      <td colspan="4" class="text-center">
	      	<a href="javascript:goodCheck()" class="btn btn-warning">추천!😍</a>
	      	<c:if test="${sw != 'search' }" >
		        <input type="button" class="btn btn-outline-info" value="돌아가기" onclick="location.href='${ctp}/board/boardContent?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&lately=${lately}';"/>
		        <c:if test="${sMid == vo.mid}">
		          <input type="button" class="btn btn-outline-warning" value="수정하기" onclick="fCheck()"/>
		          <input type="button" class="btn btn-outline-danger" value="삭제하기" onclick="delCheck()"/>
		        </c:if>
		      </c:if>
		      <c:if test="${sw == 'search'}">
        		<input type="button" value="돌아가기" onclick="history.back()"/>
        	</c:if>
	      </td>
	    </tr>
  	</table>
	  <input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
	  <input type="hidden" name="idx" value="${vo.idx}"/>
	  <input type="hidden" name="pag" value="${pag}"/>
	  <input type="hidden" name="pageSize" value="${pageSize}"/>
	  <input type="hidden" name="lately" value="${lately}"/>
	  <input type="hidden" name="oriContent"/>
	  <div id="oriContent" style="display:none;">${vo.content}</div>
  	</form>
	</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>