<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품 리뷰</title>
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
	.ustar-rating {
	  display:flex;
	  flex-direction: row-reverse;
	  font-size:1.5em;
	  justify-content:space-around;
	  padding: 0em 0.2em;
	  text-align:center;
	  width:5em;
	}
</style>
<script type="text/javascript">
	function fCheck(){
		var title = myform.title.value;
		var content = myform.content.value;
		var orderIdx = myform.orderIdx.value;
		var productIdx = myform.productIdx.value;
		var mid = myform.mid.value;
		var rating = myform.rating.value;
  	
  	if(title.trim() == "") {
  		alert("리뷰 제목을 입력하세요.");
  		myform.title.focus();
  	}
  	else if(content.trim() == ""){
  		alert("리뷰 내용을 입력하세요.");
  		myform.content.focus();
  	}
  	else{
  		$.ajax({
  			type : "post",
  			url : "${ctp}/product/review",
  			data : {
  				title : title,
  				content : content,
  				orderIdx : orderIdx,
  				productIdx : productIdx,
  				mid : mid,
  				rating : rating
  			},
  			success : function(){
  				alert("상품 리뷰가 등록되었습니다.");
  				window.close();
  			},
  			error : function(){
  				alert("처리오류");
  			}
  		});
  	}
	}
	function fUpdate(){
		var title = myform.title.value;
		var content = myform.content.value;
		var orderIdx = myform.orderIdx.value;
		var productIdx = myform.productIdx.value;
		var mid = myform.mid.value;
		var rating = myform.rating.value;
  	
  	if(title.trim() == "") {
  		alert("리뷰 제목을 입력하세요.");
  		myform.title.focus();
  	}
  	else if(content.trim() == ""){
  		alert("리뷰 내용을 입력하세요.");
  		myform.content.focus();
  	}
  	else{
  		$.ajax({
  			type : "post",
  			url : "${ctp}/product/reviewUpdate",
  			data : {
  				title : title,
  				content : content,
  				orderIdx : orderIdx,
  				productIdx : productIdx,
  				mid : mid,
  				rating : rating
  			},
  			success : function(){
  				alert("상품 리뷰가 수정되었습니다.");
  				window.close();
  			},
  			error : function(){
  				alert("처리오류");
  			}
  		});
  	}
	}
	function fDelete(){
		var title = myform.title.value;
		var content = myform.content.value;
		var orderIdx = myform.orderIdx.value;
		var productIdx = myform.productIdx.value;
		var mid = myform.mid.value;
		var rating = myform.rating.value;
		
		var ans = confirm("리뷰를 삭제하시겠습니까?");
		if(!ans) return false;
		
		$.ajax({
			type : "post",
			url : "${ctp}/product/reviewDelete",
			data : {
				orderIdx : orderIdx,
				productIdx : productIdx,
			},
			success : function(){
				alert("상품 리뷰가 삭제되었습니다.");
				window.close();
			},
			error : function(){
				alert("처리오류");
			}
		});
	}
</script>
</head>

<body>
<p><br></p>
	<div class="container">
	<form name="myform" method="post">
		<table class="table table-hover">
			<tr>
				<th>제품명</th>
				<td>${vo.productName}</td>
			</tr>
			<tr>
				<th>옵션</th>
				<td>${vo.optionName}</td>
			</tr>
			<c:if test="${empty reVo }">
				<tr>
					<th>평점</th>
					<td>
						<div class="star-rating">
							<input type="radio" id="5-stars" name="rating" value="5" />
							<label for="5-stars" class="star">&#9733;</label>
							<input type="radio" id="4-stars" name="rating" value="4" />
							<label for="4-stars" class="star">&#9733;</label>
							<input type="radio" id="3-stars" name="rating" value="3" />
							<label for="3-stars" class="star">&#9733;</label>
							<input type="radio" id="2-stars" name="rating" value="2" />
							<label for="2-stars" class="star">&#9733;</label>
							<input type="radio" id="1-star" name="rating" value="1" />
							<label for="1-star" class="star">&#9733;</label>
						</div>
					</td>
				</tr>
				<tr>
					<th>리뷰 제목</th>
					<td><input type="text" name="title" placeholder="후기 제목을 입력하세요" class="form-control" autofocus required /></td>
				</tr>
				<tr>
					<th>리뷰 내용</th>
					<td>
						<textarea rows="6" name="content" id="content" class="form-control" required></textarea>
					</td>
				</tr>
				<tr>
		      <td colspan="2" style="text-align:center">
		        <input type="button" value="후기 남기기" onclick="fCheck()" class="btn btn-info"/> &nbsp;
		        <input type="button" value="창닫기" class="btn btn-secondary" onclick="window.close()"/>
		      </td>
		    </tr>
	    </c:if>
	    <c:if test="${!empty reVo }">
	    <c:set var="rating" value="${reVo.rating}" />
	    	<tr>
					<th>평점</th>
					<td>
						<div class="star-rating">
							<input type="radio" id="5-stars" name="rating" value="5" ${rating == '5' ? 'checked' : ''} />
							<label for="5-stars" class="star">&#9733;</label>
							<input type="radio" id="4-stars" name="rating" value="4" ${rating == '4' ? 'checked' : ''}/>
							<label for="4-stars" class="star">&#9733;</label>
							<input type="radio" id="3-stars" name="rating" value="3" ${rating == '3' ? 'checked' : ''}/>
							<label for="3-stars" class="star">&#9733;</label>
							<input type="radio" id="2-stars" name="rating" value="2" ${rating == '2' ? 'checked' : ''}/>
							<label for="2-stars" class="star">&#9733;</label>
							<input type="radio" id="1-star" name="rating" value="1" ${rating == '1' ? 'checked' : ''}/>
							<label for="1-star" class="star">&#9733;</label>
						</div>
					</td>
				</tr>
				<tr>
					<th>리뷰 제목</th>
					<td><input type="text" name="title" value="${reVo.title}" placeholder="후기 제목을 입력하세요" class="form-control" autofocus required /></td>
				</tr>
				<tr>
					<th>리뷰 내용</th>
					<td>
						<textarea rows="6" name="content" id="content" class="form-control" required>${reVo.content}</textarea>
					</td>
				</tr>
				<tr>
		      <td colspan="2" style="text-align:center">
		        <input type="button" value="리뷰 수정" onclick="fUpdate()" class="btn btn-info"/> &nbsp;
		        <input type="button" value="창닫기" class="btn btn-secondary" onclick="window.close()"/>
		        <input type="button" value="리뷰 삭제" onclick="fDelete()" class="btn btn-danger" style="float:right"/> &nbsp;
		      </td>
		    </tr>
	    </c:if>
		</table>
		<input type="hidden" name="mid" value="${sMid}"> 
		<input type="hidden" name="orderIdx" value="${vo.orderIdx}">
		<input type="hidden" name="productIdx" value="${vo.productIdx}">
		</form>
	</div>
</body>
</html>