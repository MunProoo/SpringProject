<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>productDelete</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
<script>
$(function($){
  //하나라도 체크 풀을시 전체선택도 해제
	$("input[name^=deletecheck]").click(function(){
		if(!$(this).prop('checked')){
			$('input[name=allCheck]').prop('checked',false);
		}
	});
  // 전체선택
	$("input[name=allCheck]").click(function() {
    if ($(this).prop('checked')) {
        $("input[name^=deletecheck]").prop('checked', true);
    } else {
        $("input[name^=deletecheck]").prop("checked", false);
    }
 	});
  
	// 게시글 선택 삭제
	$("input[name=deleteProductList]").click(function(){
		var ans = confirm("선택한 상품들을 삭제하시겠습니까?");
    if(!ans) return false;
    
		const query = 'input[name^="deletecheck"]:checked';
		const selectedEls = document.querySelectorAll(query);
		var idxArr = "";
		
		selectedEls.forEach((el) => {
      idxArr += el.value + '/';
    });
		
		if(idxArr == ""){
			alert("삭제하실 상품들을 선택하세요");
		}
		else{
			$.ajax({
				type: "post",
				url: "${ctp}/product/deleteProductList",
				data : {
					idxArr : idxArr
				},
				success : function(){
					alert("선택한 상품들이 삭제되었습니다.");
					location.reload();
				},
				error : function(){
					alert("처리 오류!");
				}
			});
		}
	});
});


	//상품 삭제
	function delCategoryMain(idx){
		var ans = confirm("선택하신 상품을 삭제하시겠습니까?");
		if(!ans) return false;
		
		$.ajax({
			type : "post",
			url : "${ctp}/product/delProduct",
			data : {
				idx : idx
			},
			success : function(){
				alert("선택하신 상품이 삭제되었습니다.");
				location.reload();
			},
			error : function(){
				alert("처리 오류!");
			}
		});
	}
	
	// 대분류로 조회
	function cateMainSearch(){
		var categoryMainCode = $("#categoryMainCode").val();
		var	url = "${ctp}/product/categoryMainSearch?categoryMainCode="+categoryMainCode;
		location.href= url;
	}
	
	// 중분류까지 해서 조회 
	function cateMiddleSearch(){
		var categoryMainCode = $("#categoryMainCode").val();
		var categoryMiddleCode = $("#categoryMiddleCode").val();
		var url = "${ctp}/product/categoryMiddleSearch?categoryMainCode="+categoryMainCode+"&categoryMiddleCode="+categoryMiddleCode;
		location.href = url;
	}
	
	// 이름으로 검색조회
	function productNameSearch(){
		var productName = $("#productName").val();
		var url ="${ctp}/product/productNameSearch?productName="+productName;
		location.href= url;
	}
	
</script>
</head>

<body>
<p><br></p>
	<div class="container">
	  <form name="categoryMainForm">
	  	<table class="table table-borderless m-0">
	    <tr>
	      <td colspan="2">
	        <c:choose>
	          <c:when test="${level==99}"><c:set var="categoryMainName" value="전체"/></c:when>
	          <c:when test="${level==1}"><c:set var="categoryMainName" value="정"/></c:when>
	          <c:when test="${level==2}"><c:set var="categoryMainName" value="우수"/></c:when>
	          <c:when test="${level==3}"><c:set var="categoryMainName" value="특별"/></c:when>
	        </c:choose>
	        <c:if test="${!empty mid}"><c:set var="title" value="${mid}"/></c:if>
	        <h2 style="text-align:center;"><font color="blue">상품</font> 리스트 (총 : <font color="red">${fn:length(vos)}</font>건)</h2>
	      </td>
	    </tr>
	    <tr>
	      <td style="text-align:left">
	        <input type="text" id="productName" name="productName" value="${productName}" placeholder="상품이름"/>
	        <input type="button" value="상품 검색" onclick="productNameSearch()"/>
	        <input type="button" value="전체보기" onclick="location.href='${ctp}/product/productDelete';" class="btn btn-secondary btn-sm"/>
	      </td>
	      <td style="text-align:right">대분류 :   
	        <select id="categoryMainCode" name="categoryMainCode" onchange="cateMainSearch()">
	          <option value="전체">전체</option>
	        	<c:forEach var="vo" items="${mainVos}">
		          <option value="${vo.categoryMainCode}" ${vo.categoryMainCode == categoryMainCode ? 'selected' : ''}>${vo.categoryMainName}</option>
	          </c:forEach>
	        </select>
	        <label for="categoryMiddleCode">중분류 : </label>
	        <select id="categoryMiddleCode" name="categoryMiddleCode" onchange="cateMiddleSearch()">
	        	 <option value="전체">전체</option>
	        	 <c:forEach var="vo" items="${middleVos}">
		          <option value="${vo.categoryMiddleCode}" ${vo.categoryMiddleCode == categoryMiddleCode ? 'selected' : ''}>${vo.categoryMiddleName}</option>
	          </c:forEach>
	        </select>
	      </td>
	    </tr>
	  	</table>
		  <table class="table table-hover m-3">
		    <tr class="table-dark text-dark text-center">
	    		<th><label for="allCheck" style="cursor:pointer">전체&nbsp;<input type="checkbox" name="allCheck" id="allCheck" /></label></th>
		      <th>상품코드</th>
		      <th>상품명</th>
		      <th>가격</th>
		      <th>썸네일(상품수정)</th>
		      <th style="width:100px"><input type="button" class="btn btn-danger" id="deleteProductList" name="deleteProductList" value="선택 모두 삭제" style="padding:5px;margin:10px;" /></th>
		    </tr>
		    <c:forEach var="vo" items="${vos}" varStatus="st">
		    	<tr class="text-center">
			    	<td class="vtd"><span class="lineheight"><input type="checkbox" value="${vo.idx}" name="deletecheck" id="deletecheck" /></span></td>
		    	  <td>${vo.productCode}</td>
		    	  <td>${vo.productName}</td>
		    	  <td><fmt:formatNumber value="${vo.mainPrice}" pattern='#,###원'/></td>
		    	  <td><a href="${ctp}/admin/productUpdate?idx=${vo.idx}"><img src="${ctp}/product/${vo.FSName}" width="150px" height="150px"/></a></td>
		    	  <td><input type="button" value="삭제" onclick="delCategoryMain('${vo.idx}')"/></td>
		    	</tr>
		    </c:forEach>
		  </table>
	  </form>
	</div>
</body>
</html>