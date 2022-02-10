<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>productOption</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
<script>
var cnt = 0;
var regExpPrice = /^[0-9|_]*$/;  // 가격은 숫자로만 입력받음

// 색상옵션만 등록
function colorInput(){
	if(document.getElementById("colorName").value=="") {
		alert("상품 색상 이름을 등록하세요");
		return false;
	}
	else if(document.getElementById("colorPrice").value=="" || !regExpPrice.test(document.getElementById("colorPrice").value)) {
		alert("상품 색상 가격을 숫자로 등록하세요");
		return false;
	}
	else if(document.getElementById("productName").value=="") {
		alert("상품명을 선택하세요");
		return false;
	}
	else {
		let productIdx = $("input[name='productIdx']").val();
		let colorName = document.getElementById("colorName").value;
		let colorPrice = document.getElementById("colorPrice").value;
		
		$.ajax({
			type : "post",
			url : "${ctp}/product/colorInput",
			data : {
				colorName : colorName,
				colorPrice : colorPrice,
				productIdx : productIdx
			},
			success : function(data){
				if(data == '0') {
					bringColor();
					alert("색상 옵션이 등록되었습니다.");
				}
				else alert("이미 있는 색상입니다.");
			},
			error : function(){
				alert("처리 오류");
			}
		});
	}
}

// 색상 조회하기
function bringColor(){
	var product = $("#productName").val();
	if(product == ""){
		alert("먼저 상품을 선택하세요");
		return false;
	}
	
	let productIdx = $("input[name='productIdx']").val();
	$("#colorDemo").html("");
		
	$.ajax({
		type : "post",
		url : "${ctp}/product/getColor",
		data : {
			productIdx : productIdx
		},
		success : function(vos){
			var str = "";
			str += "<table class='table table-hover m-3'>"
			str += "<tr class='table-dark text-dark text-center'>"
			str += "<th>상품 이름</th>"
			str += "<th>색상 이름</th>"
			str += "<th>색상 가격</th>"
			str += "<th>삭제</th>"
			str += "</tr>"
			
			for(var i=0; i<vos.length; i++){
				var idx = vos[i].idx;
				str += "<tr class='text-center'>";
				str += "<td>"+vos[i].productName+"</td>";
				//str += "<td style='cursor:pointer'><p id='colorCheck1'>"+vos[i].colorName+"</p></td>";
				str += "<td><input type='button' class='btn' value="+vos[i].colorName+" onclick='colorCheck(\""+idx+"\")'/></td>"
				str += "<td>"+vos[i].colorPrice+"</td>";
				str += "<td><input type='button' class='btn btn-secondary' value='삭제' onclick='delColor("+vos[i].idx+")'/>";
				str += "<input type='hidden' id='colorIdx"+idx+"' name='colorIdx"+idx+"' value='"+idx+"' />"; 
				str += "<input type='hidden' id='colorName"+idx+"' name='colorName"+idx+"' value='"+vos[i].colorName+"' /></td>"; 
				str += "</tr>"
			}
			str += "</table>"
			$("#colorDemo").append(str);
		},
		error : function(){
			alert("처리 오류");
		}
		
	});
}

// 색상 삭제
function delColor(idx){
	var ans = confirm("정말 삭제하시겠습니까?");
	if(!ans) return false;
	
	$.ajax({
		type : "post",
		url : "${ctp}/product/delColor",
		data : {
			idx : idx
		},
		success : function(data){
			alert("색상이 삭제되었습니다.");
		},
		error : function(){
			alert("처리오류");
		}
	});
}

// 색상 누르면 sizeForm에 색상 정보 보내기
function colorCheck(idx){
	
	document.sizeForm.imsiColorIdx.value=idx;   // 선택한 컬러idx 저장.
	
	colorName = $("input[name='colorName"+idx+"']").val();
	productName = document.myform.productNameGet.value;
	productIdx = document.myform.productIdx.value;
	
	let productName3 = document.querySelector("#productName3");
	$(productName3).append("<option value='"+productName+"'>"+productName+"</option>");
	$("#productName3").val(productName).prop("selected", true);
	
	
	let colorName3 = document.querySelector("#colorName3");
	$(colorName3).append("<option value='"+colorName+"'>"+colorName+"</option>");
	$("#colorName3").val(colorName).prop("selected", true);
	
}

/* $(function($){
	$("[id^='colorCheck']").click(function(){
		var dd = $(this).attr("id").replace("colorCheck","");
		alert(dd);
	})
	
	$("[id^='cc']").click(function(){
		alert("하이")
	})
}) */

// 사이즈 등록
function sizeInput(){
	if(document.getElementById("sizeName").value=="") {
		alert("상품 사이즈 이름을 등록하세요");
		return false;
	}
	else if(document.getElementById("sizePrice").value=="" || !regExpPrice.test(document.getElementById("sizePrice").value)) {
		alert("상품 사이즈 가격을 숫자로 등록하세요");
		return false;
	}
	else if(document.getElementById("productName").value=="") {
		alert("상품명을 선택하세요");
		return false;
	}
	else {
		let productIdx = $("input[name='productIdx']").val();
		let colorIdx = $("input[name='imsiColorIdx']").val();
		let sizeName = document.getElementById("sizeName").value;
		let sizePrice = document.getElementById("sizePrice").value;
		
		$.ajax({
			type : "post",
			url : "${ctp}/product/sizeInput",
			data : {
				productIdx : productIdx,
				colorIdx : colorIdx,
				sizeName : sizeName,
				sizePrice : sizePrice
			},
			success : function(data){
				if(data == '0') {
					bringSize();
					alert("사이즈 옵션이 등록되었습니다.");
				}
				else alert("이미 있는 사이즈옵션입니다.");
			},
			error : function(){
				alert("처리 오류");
			}
		}); 
	}
}

// 사이즈 값 조회
function bringSize(){
	var product = $("#productName").val();
	var color = $("#colorName3").val();
	if(product == ""){
		alert("먼저 상품을 선택하세요");
		return false;
	}
	else if(color == ""){
		alert("색상을 선택하세요");
		return false;
	}
	
	let productIdx = $("input[name='productIdx']").val();
	let colorIdx = $("input[name='imsiColorIdx']").val();
	$("#sizeDemo").html("");
		
	$.ajax({
		type : "post",
		url : "${ctp}/product/bringSize",
		data : {
			productIdx : productIdx,
			colorIdx : colorIdx
		},
		success : function(vos){
			var str = "";
			str += "<table class='table table-hover m-3'>"
			str += "<tr class='table-dark text-dark text-center'>"
			str += "<th>상품 이름</th>"
			str += "<th>색상 이름</th>"
			str += "<th>사이즈 이름</th>"
			str += "<th>사이즈 가격</th>"
			str += "<th>삭제</th>"
			str += "</tr>"
			
			for(var i=0; i<vos.length; i++){
				var idx = vos[i].idx;
				str += "<tr class='text-center'>";
				str += "<td>"+vos[i].productName+"</td>";
				//str += "<td style='cursor:pointer'><p id='colorCheck1'>"+vos[i].colorName+"</p></td>";
				str += "<td>"+vos[i].colorName+"</td>"
				str += "<td>"+vos[i].sizeName+"</td>"
				str += "<td>"+vos[i].sizePrice+"</td>";
				str += "<td><input type='button' class='btn btn-secondary' value='삭제' onclick='delSize("+vos[i].idx+")'/>";
				str += "<input type='hidden' id='sizeIdx"+idx+"' name='sizeIdx"+idx+"' value='"+idx+"' />"; 
				str += "</tr>"
			}
			str += "</table>"
			$("#sizeDemo").append(str);
		},
		error : function(){
			alert("처리 오류");
		}
	});
}

// 사이즈옵션 삭제하기
function delSize(idx){
	var ans = confirm("정말 삭제하시겠습니까?");
	if(!ans) return false;
	
	$.ajax({
		type : "post",
		url : "${ctp}/product/delSize",
		data : {
			idx : idx
		},
		success : function(data){
			alert("사이즈 옵션이 삭제되었습니다.");
		},
		error : function(){
			alert("처리 오류");
		}
	})
}

// 상품명을 선택하면 상품의 설명을 띄워준다.
function productNameCheck() {
	$("#colorName").val("");
	$("#colorPrice").val("");
	$("#productName2").val("").prop("selected",true);
	$("#productName3").val("").prop("selected",true);
	$("#colorName3").val("");
	$("#sizeName").val("");
	$("#sizePrice").val("");
	$("#demo").empty();
	$("#sizeDemo").empty();
	$("#colorDemo").empty();
	
	var product = document.getElementById("productName").value;
	productCode = product.split(":")[0];
	productName = product.split(":")[1];
	var categoryMainCode = productCode.substr(0,1);
	var categoryMiddleCode = productCode.substr(1,2);
	$("#productName2").val(product).prop("selected", true);
	
	$.ajax({
		type:"post",
		url : "${ctp}/product/getProductInfor",
		data: {
			productName : productName,
			categoryMainCode : categoryMainCode,
			categoryMiddleCode : categoryMiddleCode
		},
		success:function(data) {
			str = '<hr>';
			str += '썸네일  : <img src="${ctp}/product/'+data.fsname+'" width="180px"><br>';
			str += '대분류명 : '+data.categoryMainName+'<br>';
			str += '중분류명 : '+data.categoryMiddleName+'<br>';
			str += '상 품 명  : '+data.productName+'<br>';
			str += '간단설명  : '+data.detail+'<br>';
			str += '상품코드 : '+data.idx+'<br>';
			str += '상품가격 : '+numberWithCommas(data.mainPrice)+'원<br>';
			str += '<hr>';
			$("#demo").html(str);
			document.myform.productIdx.value = data.idx;
			document.myform.productNameGet.value = data.productName;
		},
		error : function(data) {
			alert("전송오류!");
		}
	});
}

// 콤마찍기
function numberWithCommas(x) {
  return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
</script>
</head>
<body>
<p><br></p>
	<div class="container">
		<h2>상품에 따른 옵션 등록</h2>
		
	  <form name="myform" method="post">
	    <div class="form-group">
	      <label for="productName">상품명</label>
	      <select name="productName" id="productName" class="form-control" onchange="productNameCheck()">
	        <option value="">상품선택</option>
	        <c:forEach var="vo" items="${vos}">
	          <option value="${vo.productCode}:${vo.productName}">${vo.productName}</option>
	        </c:forEach>
	      </select>
	      <div id="demo">
	      </div>
	    </div>
	    
	    <input type="hidden" name="productIdx">
	    <input type="hidden" name="productNameGet">     <!-- 상품 고유정보 저장 -->
	  </form>
	    <p><br></p>
	    
	    
	    <form name="colorForm">
		  	<h5 style="cursor:pointer" id="cc">색상 관리</h5>
		  	<label for="productName2">상품 : &nbsp;</label>
		  	<select id="productName2" name="productName2" disabled>
		  	  <option value="">상품 이름</option>
	        <c:forEach var="vo" items="${vos}">
	          <option value="${vo.productCode}:${vo.productName}">${vo.productName}</option>
	        </c:forEach>
		  	</select> &nbsp; &nbsp;
		  	색상 이름 : 
		  	<input type="text" name="colorName" id="colorName"/> &nbsp; &nbsp;
		  	색상 가격 :
		  	<input type="text" name="colorPrice" id="colorPrice"/>&nbsp;&nbsp;
		  	<input type="button" value="색상 등록" onclick="colorInput()" class="btn btn-secondary btn-sm"/>
		  	<input type="button" value="색상 조회" onclick="bringColor()" class="btn btn-info btn-sm"/>
		  	<p id="colorDemo"></p>
		  	
		  </form>
	    <p></p>
	    <hr/><hr/>
	    
	    
  <form name="sizeForm">
  	<h5>사이즈 관리</h5>
  	<label for="productName3">상품 : &nbsp;</label>
	  <select id="productName3" name="productName3" disabled>
	  	 <option value="">상품 이름</option>
	  </select>
	  	
  	<label for="colorName3">색상 : &nbsp;</label>
	  	<select id="colorName3" name="colorName3" disabled>
	  	  <option value="">색상 이름</option>
	  	</select>
  	
  	사이즈 이름 : 
  	<input type="text" id="sizeName" name="sizeName" style="width:5%"/> &nbsp; &nbsp;
  	사이즈 가격 : 
  	<input type="text" id="sizePrice" name="sizePrice" style="width:5%"/>&nbsp;&nbsp;
  	<input type="button" value="사이즈 등록" onclick="sizeInput()" class="btn btn-secondary btn-sm"/>
  	<input type="button" value="사이즈 조회" onclick="bringSize()" class="btn btn-info btn-sm"/>
	 	<p id="sizeDemo"></p>
	  
	  <input type="hidden" id="imsiColorIdx" name="imsiColorIdx" >    <!-- 색상 선택시 임시로 저장 -->
	  
  </form>
  <hr/><hr/>

	</div>
</body>
</html>