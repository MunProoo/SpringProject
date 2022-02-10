<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>추천상품 관리</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>

</head>

<body>
<p><br></p>
	<div class="container">
	<h2 style="text-align: center">추천상품 목록</h2>
	<hr>
	<div class="row">
		<c:forEach var="vo" items="${recoVos}" varStatus="status">
			<div class="col-3">
				<a href="#" onclick="recoDelete(${vo.idx})"><img src="${ctp}/product/${vo.FSName}" width="300px" height="180px"/></a>
			</div>
			<c:if test="${status.last}"><c:set var="cnt" value="${status.index}"/></c:if>
		</c:forEach>
	</div>
	
	<hr style="border: solid 10px blue">
	<h2 style="text-align: center">상품 목록</h2>
		<div class="row mt-3">
    <c:forEach var="vo" items="${vos}" varStatus="st">
    	<div class="col-md-3">
    	  <a href="javascript:recoChange(${vo.idx})"><img src="${ctp}/product/${vo.FSName}" width="300px" height="180px"/></a>
  	  </div>
    </c:forEach>
    </div>
	</div>
</body>
<script>
	function recoDelete(idx){
		var ans = confirm("이 상품을 추천상품에서 내리시겠습니까?");
		if(!ans) return false;
		
		$.ajax({
			type : "post",
			url : "${ctp}/product/recoDelete",
			data : {
				idx : idx
			},
			success : function(){
				location.reload();
			},
			error : function(){
				alert("처리 오류");
			}
		});
	}

	function recoChange(idx){
		// 추천상품 자리가 비었는가 체크
		var cnt = '${cnt}';    // 먼저 변수cnt에 el변수를 집어넣고서 body가 실행되므로 밑에 넣어줘야ㅕ한다
		if(cnt == 3){  // index니까 4개면 3
			alert("추천 상품의 자리를 비워주세요.");
			return false;
		}
		
		let ans = confirm("이 상품을 추천상품으로 하시겠습니까?");
		if(!ans) return false;
		
		$.ajax({
			type : "post",
			url : "${ctp}/product/recoChange",
			data : {
				idx : idx
			},
			success : function(data){
				if(data == 0) {
					alert("추천상품이 변경되었습니다.");
					location.reload();
				}
				else if(data == 1) alert("먼저 추천상품의 자리를 비워주세요.");
				else alert("이미 추천상품으로 등록된 상품입니다.");
			},
			error : function(){
				alert("처리 오류");
			}
		});
	}
</script>
</html>