<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>productInput</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
<script src="${ctp}/ckeditor/ckeditor.js"></script>
<script>
	//상품 입력창에서 대분류 선택(Change)시 중분류가져와서 중분류 선택박스에 뿌리기
	function categoryMainChange(){
		var categoryMainCode = myform.categoryMainCode.value;
		
		$.ajax({
			type : "post",
			url : "${ctp}/product/getCategoryMiddleName",
			data : {categoryMainCode : categoryMainCode},
			success : function(data){
				var str = "";
				for(var i=0; i<data.length; i++){
					str += "<option value='"+data[i].categoryMiddleCode+"'>"+data[i].categoryMiddleName+"</option>";
				}
				$('#categoryMiddleCode').html(str);
			},
			error : function(){
				alert("처리 오류");
			}
		});
	}

	//상품 등록하기
	function fCheck() {
		var categoryMainCode = myform.categoryMainCode.value;
		var categoryMiddleCode = myform.categoryMiddleCode.value;
		var productName = myform.productName.value;
		var mainPrice = myform.mainPrice.value;
		var detail = myform.detail.value;
		var file = myform.file.value;												// 파일명
		var ext = file.substring(file.lastIndexOf(".")+1);  // 확장자 구하기
		var uExt = ext.toUpperCase();
		var regExpPrice = /^[0-9|_]*$/;   // 가격은 숫자로만 입력받음
		
		if(productName == "") {
			alert("상품명(모델명)을 입력하세요!");
			return false;
		}
		else if(file == "") {
			alert("상품 썸네일을 등록하세요");
			return false;
		}
		else if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "JPEG") {
			alert("업로드 가능한 파일이 아닙니다.");
			return false;
		}
		else if(mainPrice == "" || !regExpPrice.test(mainPrice)) {
			alert("상품금액은 숫자로 입력하세요.");
			return false;
		}
		else if(detail == "") {
			alert("상품의 초기 설명을 입력하세요");
			return false;
		}
		else if(document.getElementById("file").value != "") {
			var maxSize = 1024 * 1024 * 10;  // 10MByte까지 허용
			var fileSize = document.getElementById("file").files[0].size;
			if(fileSize > maxSize) {
				alert("첨부파일의 크기는 10MB 이내로 등록하세요");
				return false;
			}
			else {
				myform.submit();
			}
		}
	}


</script>
</head>

<body>
<p><br></p>
	<div class="container-lg">
		<h2>상 품 등 록</h2>
		<hr>
		<form name="myform" method="post" enctype="multipart/form-data">
			<div class="form-group">
				<label for="categoryMainCode">대분류</label>
				<select id="categoryMainCode" name="categoryMainCode" class="form-control" onchange="categoryMainChange()">
					<option value="">대분류</option>
					<c:forEach var="mainVo" items="${mainVos}">
						<option value="${mainVo.categoryMainCode}">${mainVo.categoryMainName}</option>
					</c:forEach>
				</select>
			</div>
			<div class="form-group">
				<label for="categoryMiddleCode">중분류</label>
				<select id="categoryMiddleCode" name="categoryMiddleCode" class="form-control">
					<option value="">중분류</option>
					<%-- <c:forEach var="middleVo" items="${middleVos}">
						<option value="${middleVo.categoryMiddleCode}">${middleVo.categoryMiddleName}</option>
						<option value=""></option>
					</c:forEach> --%>
				</select>
			</div>
			<div class="form-group">
        <label for="productName">상품(모델)명</label>
        <input type="text" name="productName" id="productName" class="form-control" placeholder="상품 모델명을 입력하세요" required/>
      </div>
			<div class="form-group">
        <label for="file">썸네일</label>
        <input type="file" name="file" id="file" class="form-control-file border" accept=".jpg,.gif,.png,.jpeg" required/>
        (업로드 가능파일:jpg, jpeg, gif, png)
      </div>
      <div class="form-group">
      	<label for="mainPrice">상품 기본가격(원)</label>
      	<input type="text" name="mainPrice" id="mainPrice" class="form-control" required/>
      </div>
      <div class="form-group">
      	<label for="detail">상품 기본설명</label>
      	<input type="text" name="detail" id="detail" class="form-control" required/>
      </div>
      <div class="form-group">
      	<label for="content">상품 메인이미지</label>
      	<textarea rows="5" name="content" id="CKEDITOR" class="form-control" required></textarea>
      </div>
      <script>
		    CKEDITOR.replace("content",{
		    	uploadUrl:"${ctp}/product/imageUpload",     /* 그림파일 드래그&드롭 처리 */
		    	filebrowserUploadUrl: "${ctp}/product/imageUpload",  /* 이미지 업로드 */
		    	height:460
		    });
		  </script>
		  <input type="button" value="상품등록" onclick="fCheck()" class="btn btn-secondary"/> &nbsp;
		</form>
	</div>
</body>
</html>