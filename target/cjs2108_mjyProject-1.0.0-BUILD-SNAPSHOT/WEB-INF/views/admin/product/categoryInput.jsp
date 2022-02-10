<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>categoryInput</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
</head>
<script>

	//대분류 등록
	function categoryMainCheck(){
		var categoryMainCode = categoryMainForm.categoryMainCode.value;
		var categoryMainName = categoryMainForm.categoryMainName.value;
		var mainCodeReg = /^[A-Z]*$/; 
		
		if(categoryMainCode == ""){
			alert("대분류 코드를 입력하세요.");
			categoryMainForm.categoryMainCode.focus();
			return false;
		}
		else if(!mainCodeReg.test(categoryMainCode)){
			alert("코드가 형식에 맞지 않습니다.");
			categoryMainForm.categoryMainCode.focus();
			return false;
		}
		else if(categoryMainName == "") {
  		alert("대분류명을 입력하세요");
  		categoryMainForm.categoryMainName.focus();
  		return false;
  	}
		else{
			$.ajax({
				type : "post",
				url : "${ctp}/product/categoryMainInput",
				data : {
					categoryMainCode : categoryMainCode,
					categoryMainName : categoryMainName
				},
				success : function(data){
					if(data == "0") alert("이미 존재하는 카테고리입니다.");
					else if(data == "1") alert("코드가 형식에 맞지 않습니다.")
					else location.reload();
				},
				error : function(){
					alert("처리 오류");
				}
			});
		}
	}
	
	// 중분류 등록
	function categoryMiddleCheck(){
		var categoryMainCode = categoryMiddleForm.categoryMainCode.value;
  	var categoryMiddleCode = categoryMiddleForm.categoryMiddleCode.value;
  	var categoryMiddleName = categoryMiddleForm.categoryMiddleName.value;
  	var middleCodeReg = /^[0-9]*$/; 
		
  	if(categoryMainCode == "") {
  		alert("대분류명을 선택하세요");
  		return false;
  	}
  	else if(categoryMiddleCode == "") {
  		alert("중분류코드를 입력하세요");
  		categoryMiddleForm.categoryMiddleCode.focus();
  		return false;
  	}
  	else if(!middleCodeReg.test(categoryMiddleCode)){
  		alert("형식에 맞지 않습니다.");
  		categoryMiddleForm.categoryMiddleCode.focus();
			return false;
  	}
  	else if(categoryMiddleName == "") {
  		alert("중분류명을 입력하세요");
  		categoryMiddleForm.categoryMiddleName.focus();
  		return false;
  	}
  	else{
  		$.ajax({
  			type : "post",
  			url : "${ctp}/product/categoryMiddleInput",
  			data : {
  				categoryMainCode : categoryMainCode,
  				categoryMiddleCode : categoryMiddleCode,
    			categoryMiddleName : categoryMiddleName
  			},
  			success : function(data){
  				if(data == "0") alert("이미 존재하는 카테고리입니다.");
  				else location.reload();
  			},
  			error : function(){
  				alert("처리 오류");
  			}
  		});
  	}
	}
	
	// 대분류 삭제
	function delCategoryMain(categoryMainCode){
		var ans = confirm("선택한 대분류를 삭제하시겠습니까?");
		if(!ans) return false;
		
		$.ajax({
			type : "post",
			url : "${ctp}/product/delCategoryMain",
			data : {
				categoryMainCode : categoryMainCode
			},
			success : function(data){
				if (data == "0") alert("하위 카테고리가 있어 삭제할 수 없습니다. \n하위 카테고리를 먼저 삭제하세요.");
				else {
					alert("선택한 카테고리가 삭제되었습니다.");
					location.reload();
				}
			},
			error : function(){
				alert("처리 오류!");
			}
		});
	}
	
	// 중분류 삭제
	function delCategoryMiddle(categoryMiddleCode){
		var ans = confirm("선택한 중분류를 삭제하시겠습니까?");
		if(!ans) return false;
		
		$.ajax({
			type : "post",
			url : "${ctp}/product/delCategoryMiddle",
			data : {categoryMiddleCode : categoryMiddleCode},
			success : function(data){
				alert("선택한 카테고리가 삭제되었습니다.");
				location.reload();
			},
			error : function(){
				alert("처리 오류!");
			}
		});
	}
	
	
	

</script>
<body>
<p><br></p>
	<div class="container">
		<h2>상품 분류 등록하기</h2>
  <hr/>
  <form name="categoryMainForm">
  	<h5>대분류 관리(코드는 영문대문자1자리)</h5>
  	대분류코드(A,B,C,...)
  	<input type="text" name="categoryMainCode" maxlength="1"/> &nbsp; &nbsp;
  	대분류명
  	<input type="text" name="categoryMainName"/>
  	<input type="button" value="대분류등록" onclick="categoryMainCheck()" class="btn btn-secondary btn-sm"/>
	  <table class="table table-hover m-3">
	    <tr class="table-dark text-dark text-center">
	      <th>대분류코드</th>
	      <th>대분류명</th>
	      <th>삭제</th>
	    </tr>
	    <c:forEach var="mainVo" items="${mainVos}" varStatus="st">
	    	<tr class="text-center">
	    	  <td>${mainVo.categoryMainCode}</td>
	    	  <td>${mainVo.categoryMainName}</td>
	    	  <td><input type="button" value="삭제" onclick="delCategoryMain('${mainVo.categoryMainCode}')"/></td>
	    	</tr>
	    </c:forEach>
	  </table>
  </form>
  <hr/><hr/>
  <form name="categoryMiddleForm">
  	<h5>중분류 관리(코드는 숫자 2자리)</h5>
  	<select name="categoryMainCode">
  	  <option value="">대분류명</option>
  	  <c:forEach var="mainVo" items="${mainVos}">
  	    <option value="${mainVo.categoryMainCode}">${mainVo.categoryMainName}</option>
  	  </c:forEach>
  	</select> &nbsp; &nbsp;
  	중분류코드(01,02,...)
  	<input type="text" name="categoryMiddleCode" maxlength="2"/> &nbsp; &nbsp;
  	중분류명
  	<input type="text" name="categoryMiddleName"/>
  	<input type="button" value="중분류등록" onclick="categoryMiddleCheck()" class="btn btn-secondary btn-sm"/>
	  <table class="table table-hover m-3">
	    <tr class="table-dark text-dark text-center">
	      <th>대분류명</th>
	      <th>중분류코드명</th>
	      <th>중분류명</th>
	      <th>삭제</th>
	    </tr>
	    <c:forEach var="middleVo" items="${middleVos}" varStatus="st">
	    	<tr class="text-center">
	    	  <td>${middleVo.categoryMainName}</td>
	    	  <td>${middleVo.categoryMiddleCode}</td>
	    	  <td>${middleVo.categoryMiddleName}</td>
	    	  <td><input type="button" value="삭제" onclick="delCategoryMiddle('${middleVo.categoryMiddleCode}')"/></td>
	    	</tr>
	    </c:forEach>
	  </table>
  </form>
  <hr/><hr/>
	</div>
</body>
</html>