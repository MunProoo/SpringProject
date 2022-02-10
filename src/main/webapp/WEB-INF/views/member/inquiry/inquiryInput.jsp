<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>inquiryInput</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
<script>
function fCheck(){
  var title = document.myform.title.value;
  
  if(title==""){
    alert("제목을 입력하세요!");        
    return false;
  }
  else {
    document.myform.submit();
  }
}
</script>

</head>

<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br></p>
	<div class="container">
		<div style="padding:20px;text-align:center;"><h2>1:1 문의하기</h2></div>
	  <div style="border:1px solid #ccc;padding:20px;width:65%;margin:0 auto;">
	    <form name="myform" method="post" >
	      <div class="form-group">
	          <label for="category">문의 유형</label><br/>
	          <input type="radio" name="category" value="상품관련" checked />상품관련 &nbsp;
	          <input type="radio" name="category" value="주문및결제" />주문 및 결제 &nbsp;
	          <input type="radio" name="category" value="배송관련" />배송관련 &nbsp;
	          <input type="radio" name="category" value="취소/반품" />취소/반품 &nbsp;
	          <input type="radio" name="category" value="포인트" />포인트 &nbsp;
	          <input type="radio" name="category" value="기타" />기타 &nbsp;
	      </div>        
	      <div class="form-group">
	        <label for="title">제목</label>
	        <input type="text" class="form-control" id="title" placeholder="Enter title" name="title"/>
	      </div>      
	      <div class="form-group">
	        <label for="content">문의 내용</label> <!-- ck에디터 사용위해 id바꿔야함 -->
	        <!-- <textarea class="form-control" rows="5" id="CKEDITOR" name="content" required></textarea> -->
	        <textarea class="form-control" rows="5" name="content" required placeholder="문의 내용을 적어주세요"></textarea>
	      </div>
	      <!-- <script>
	        CKEDITOR.replace("content",{
	          filebrowserUploadUrl: "/lajin/imageUpload"
	        });
	      </script> -->
	      <input hidden="nickName" name="nickName" value="${sNickName}"/>      
	    </form>  
	  </div>
	  <div class="btngroup" style="text-align:center;margin:20px; ">
	    <button type="button" class="btn btn-success" onclick="fCheck()">문의하기</button>
	    <button type="button" class="btn btn-success" onclick="location.href='${ctp}/inquiry/inquiryList'">돌아가기</button>
	  </div>
	</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>