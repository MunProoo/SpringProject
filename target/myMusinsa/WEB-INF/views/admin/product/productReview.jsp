<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품 리뷰 관리</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
<style>
	.star-rating {
	  display:flex;
	  flex-direction: row-reverse;
	  font-size:1.5em;
	  justify-content:space-around;
	  padding:0 0.2em;
	  text-align:center;
	  width:5em;
	}
	
	.star-rating input { display:none;}
	
	.star-rating label {color:#ccc;cursor:pointer;}
	
	.star-rating :checked ~ label {color:#fc0;}
	
	.star-rating label:hover,
	.star-rating label:hover ~ label {color:#f90;}
	
	.review th{
		font-weight : bold;
		background-color: #A9D0F5;
	}
</style>
<script>
	function delCheck(idx){
		var ans = confirm("선택하신 리뷰을 삭제하시겠습니까?");
		if(!ans) return false;
		
		$.ajax({
			type : "post",
			url : "${ctp}/product/delReview",
			data : {
				idx : idx
			},
			success : function(){
				alert("선택하신 리뷰가 삭제되었습니다.");
				location.reload();
			},
			error : function(){
				alert("처리 오류!");
			}
		});
	}
	
	$(document).ready(function(){
		$("#productName").change(function(){
			let productCode = $(this).val();
			let productIdx = productCode.substring(3);
			location.href="${ctp}/product/productReview?productIdx="+productIdx;
		});
		
		$("#keywordSearch").click(function(){
			let nickName = $("#nickName").val();
			location.href="${ctp}/product/productReview?nickName="+nickName;
		});
		
	})
	
		
	
</script>
</head>

<body>
<p><br></p>
	<div class="container">
	
		<h2 style="text-align: center">상품 리뷰 관리</h2>
		<table>
			<tr>
				<th style="margin:5px">상품명으로 찾기 : </th>
				<td style="margin:5px">
		      <select name="productName" id="productName" class="form-control">
		        <option value="">상품선택</option>
		        <c:forEach var="vo" items="${productVos}">
		          <option value="${vo.productCode}" ${vo.idx == productIdx ? 'selected' : ''}>${vo.productName}</option>
		        </c:forEach>
		      </select>
	      </td>
	      <th>닉네임으로 찾기 : </th>
	      <td>
	      		<input type="text" id="nickName" style="width: 300px;" placeholder="${nickName }" />
        		<button type="button" name="keywordSearch" id="keywordSearch" ><i class="fas fa-search"></i></button>
	      </td>
	    </tr>
	  </table>
		<table class="table table-hover review">
		<c:forEach var="vo" items="${reviewVos}" varStatus="st">
			<tr>
				<th>상품명 : </th>
				<td>${vo.productName}</td>
				<th>옵션 : </th>
				<td>${vo.optionName}</td>
			</tr>
			<tr>
				<th>평점 : </th>
				<td>
					<div class="star-rating">
						<input type="radio" id="5-stars" name="rating${vo.idx}" value="5" ${vo.rating == '5' ? 'checked' : ''} disabled/>
						<label for="5-stars" class="star">&#9733;</label>
						<input type="radio" id="4-stars" name="rating${vo.idx}" value="4" ${vo.rating == '4' ? 'checked' : ''} disabled/>
						<label for="4-stars" class="star">&#9733;</label>
						<input type="radio" id="3-stars" name="rating${vo.idx}" value="3" ${vo.rating == '3' ? 'checked' : ''} disabled/>
						<label for="3-stars" class="star">&#9733;</label>
						<input type="radio" id="2-stars" name="rating${vo.idx}" value="2" ${vo.rating == '2' ? 'checked' : ''} disabled/>
						<label for="2-stars" class="star">&#9733;</label>
						<input type="radio" id="1-star" name="rating${vo.idx}" value="1" ${vo.rating == '1' ? 'checked' : ''} disabled/>
						<label for="1-star" class="star">&#9733;</label>
					</div>
				</td>
				<th>리뷰 삭제</th>
				<td>
					<input type="button" class="btn btn-warning" value="삭제" onclick="delCheck('${vo.idx}')"/>
				</td>
			</tr>
			<tr>
				<th>리뷰 제목 : </th>
				<td>${vo.title}</td>
				<th>작성자 : </th>
				<td>${vo.nickName}</td>
			</tr>
			<tr>
				<th>리뷰 내용</th>
				<td colspan="3">
		 			<textarea rows="6" class="form-control" disabled><c:out value="${vo.content}" /></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="4"><hr style="border: solid 1px skyblue"></td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(reviewVos) == 0 }">
			<div class="container">
			<p><br></p>
		 			아직 리뷰가 없습니다
		 	</div>
		</c:if>
		</table>
	</div>
</body>
</html>