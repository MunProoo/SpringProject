<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<% pageContext.setAttribute("crcn", "\r\n"); //space,enter
   pageContext.setAttribute("br", "<br/>"); //br tag
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>productContent</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
 <script>
    var idxArray = new Array();
    let colorName;
    let colorPrice; // 스크립트에 저장해놓자.
    let commaColorPrice;
    
  	// 문자열 파라미터를 쓸때면 '<input type="button" onClick="gotoNode(\'' + result.name + '\')" />' 꼴로 맞춰야함
    // 옵션추가
    $(function(){
    	$("#selectOption").change(function(){						// <option value="0:기본품목_${productVo.mainPrice}">기본품목</option>
    		var selectOption = $(this).val();							// <option value="${vo.optionName}_${vo.optionPrice}">${vo.optionName}</option>
    		colorName = selectOption.substring(selectOption.indexOf(":")+1,selectOption.indexOf("_"));  // 옵션명
    		colorPrice = selectOption.substring(selectOption.indexOf("_")+1);  					// 옵션가격
    		commaColorPrice = numberWithCommas(colorPrice);																					// 콤마붙인 가격
    		
    		var productIdx = $("#productIdx").val();          // 제품 고유번호
    		var colorIdx = selectOption.substring(0,selectOption.indexOf(":"));    // 색상 고유번호
    		
    		if(selectOption != "") {
	    		
  				let selectOption2 = document.querySelector("#selectOption2");
  				$(selectOption2).empty();
  				$(selectOption2).append("<option value=''>사이즈 선택(필수)</option>");
	    		
	    		// size값 가져오기
	    		$.ajax({
	    			type : "post",
	    			url : "${ctp}/product/bringSize",
	    			data : {
	    				productIdx : productIdx,
	    				colorIdx : colorIdx
	    			},
	    			success : function(data){
	    				for(var i=0; i<data.length; i++){
	    					let idx = data[i].idx;   // 사이즈 고유번호
	    					let name = data[i].sizeName; // 사이즈이름
	    					let price = data[i].sizePrice; // 사이즈가격
		    				$(selectOption2).append("<option value='"+idx+":"+name+"_"+price+"'>"+name+"(+"+numberWithCommas(price)+"원)</option>");
	    				}
	    			},
	    			error : function(){
	    				alert("처리 오류");
	    			}
	    		}); 
    	  }
    	  else {
    		  alert("이미 선택한 옵션입니다.");
    	  }
    	});
    	
    	$("#selectOption2").change(function(){						
    		var selectOption2 = $(this).val();			
    		
    		var sizeIdx = selectOption2.substring(0,selectOption2.indexOf(":"));
    		var sizeName = selectOption2.substring(selectOption2.indexOf(":")+1,selectOption2.indexOf("_"));  // 옵션명
    		var mainPrice = $("#mainPrice").val();
    		var sizePrice = selectOption2.substring(selectOption2.indexOf("_")+1);  
    		
    		let optionName = colorName + "/" +sizeName;     // cnt로 하면 컬러이름이 달라도 사이즈이름이 같으면 옵션추가가 안됨
    		let optionPrice = parseInt(mainPrice)+ parseInt(colorPrice) + parseInt(sizePrice);    //기본가격 + 색 + 사이즈 조합의 총 가격
    		var commaPrice = numberWithCommas(optionPrice);																				// 콤마붙인 가격
    		
    		if($("#layer"+sizeIdx).length == 0 && selectOption2 != "") {
    		  idxArray[sizeIdx] = sizeIdx;		// 옵션을 선택한 개수만큼 배열의 크기로 잡는다.
    		  
	    		var str = "";
	    		str += "<div class='layer row' id='layer"+sizeIdx+"'><div class='col'>"+optionName+"</div>";
	    		str += "<input type='number' class='numBox' id='numBox"+sizeIdx+"' name='optionNum' onchange='numChange("+sizeIdx+")' value='1' min='1'/> &nbsp;";
	    		str += "<input type='text' id='imsiPrice"+sizeIdx+"' class='price' value='"+commaPrice+"' readonly />"; // 보여주는곳이니까 컴마찍기
	    		str += "<input type='hidden' id='price"+sizeIdx+"' class='price' value='"+optionPrice+"'/> &nbsp;";   // 정수형으로 옵션가격 저장(수량별 증감)
	    		str += "<input type='button' class='btn btn-outline-secondary btn-sm' onclick='remove("+sizeIdx+")' value='삭제'/>";
	    		str += "<input type='hidden' name='optionName' value='"+optionName+"'/>";
	    		str += "<input type='hidden' name='statePrice"+sizeIdx+"' id='statePrice"+sizeIdx+"' value='"+optionPrice+"'/>";   // 수량변경시 가격변동
	    		str += "<input type='hidden' name='optionPrice' id='optionPrice' value='"+optionPrice+"'/>";     // form으로 전송할때 편하게
	    		str += "</div>";
	    		$("#product1").append(str);
	    		onTotal();
	    		
	    		$("#selectOption").val("").prop("selected", true);
	    		$("#selectOption2").val("").prop("selected", true);
    	  }
    	  else {
    		  alert("이미 선택한 옵션입니다.");
    	  }
    	});
    });
    
    // 등록(추가)시킨 옵션 상품 삭제하기
    function remove(idx) {
  	  document.getElementById("layer"+idx).remove();
  	  onTotal();
    }
    
    // 상품의 총 금액 (재)계산하기
    function onTotal() {
  	  var total = 0; // 기본금액
  	  
  	  for(var i=0; i<idxArray.length; i++) {
  		  if($("#layer"+idxArray[i]).length != 0 ) {
  		  	total +=  parseInt(document.getElementById("price"+idxArray[i]).value);  // parseInt 이거 해야 앞에 0이 안붙네..
  		  	document.getElementById("totalPriceResult").value = total;
  		  }
  	  }
  	  document.getElementById("totalPrice").value = numberWithCommas(total)+"원";
    }
    
    // 수량 변경시 처리하는 함수
    function numChange(idx) {
    	var price = document.getElementById("statePrice"+idx).value * document.getElementById("numBox"+idx).value;
    	document.getElementById("imsiPrice"+idx).value = numberWithCommas(price);
    	document.getElementById("price"+idx).value = price;    // 정수형으로도 저장?
    	onTotal();
    }
    
    // 장바구니 호출시 수행함수
    function cart() {
    	var mid = $("#mid").val();
    	if(mid == "") {
    		alert("로그인 후 이용 가능합니다.");
    		location.href = "${ctp}/member/memLogin";
    		return false;
    	}
    	if(document.getElementById("totalPrice").value=="0원") {
    		alert("옵션을 선택해주세요");
    		return false;
    	}
    	else {
    		var ans = confirm("장바구니에 넣으시겠습니까?");
    		if(!ans) {
    			return false;
    		}
    		else {
    			/* document.myform.sw.value = "cart"; */
    			document.myform.action = "${ctp}/product/productContent";
	    		document.myform.submit();
    		}
    	}
    }
    
    // 직접 주문하기
    function order() {
    	var ans = confirm("지금 바로 주문하시겠습니까?");
    	if (!ans) return false;
    	var mid = $("#mid").val();
    	if(mid == "") {
    		alert("로그인 후 이용 가능합니다.");
    		location.href = "${ctp}/member/memLogin";
    	}
    	else if(document.getElementById("totalPrice").value=="0원") {
    		alert("옵션을 선택해주세요");
    		return false;
    	}
    	else {
  			/* document.myform.sw.value = "order"; */
    	/* 	var option = document.optionForm.selectOption.value;
    		var optionIdx = option.split(":")[0];
    		var optionName = option.split(":")[1].split("_")[0];
    		var optionPrice = option.split(":")[1].split("_")[1]; */
    		
    		let formElement = $("#myform");
    		formElement.attr("action","${ctp}/product/orderPage");
    		formElement.attr("method","post");
    		document.myform.submit(); 
    	}
    }
    
    // 천단위마다 콤마를 표시해 주는 함수
    function numberWithCommas(x) {
    	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    }
  </script>
  <style>
  .layer  {
    border:0px;
    width:100%;
    padding:15px;
    margin-left:1px;
    background-color:#eee;
  }
  .numBox {width:60px}
  .price  {
    width:160px;
    background-color:#eee;
    text-align:right;
    font-size:1.2em;
    border:0px;
    outline: none;
  }
  .totalPrice {
    text-align:right;
    margin-right:10px;
    color:#f63;
    font-size:1.5em;
    font-weight: bold;
    border:0px;
    outline: none;
  }
  .buttongroup {
    padding: 5px;
    text-align: center;
  }
    
    
 #content img { 
 	display: block; 
 	margin: 0px auto; 
 }
    
 .tabId {
	font-size: 35px; 
	margin : 5px 25px 25px 1px; 
	padding:5px;
	color: #084B8A;
	border-radius: 20px;
	}
	
	.explain{
	background-color: #eee;
	vertical-align: middle; 
	text-align: center;
	vertical-align: middle;
}
    
.productTab{
	position: sticky;
	top : 45px;
	opacity: 1;
	background-color: #eee;
	height: 100px;
}    

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

</head>

<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br></p>
	<div class="container">
		<div class="row">
    <div class="col p-4 text-center" style="border:1px solid #ccc">
		  <!-- 상품메인 이미지 -->
		  <div id="Thumbnail">
		    <img src="${ctp}/product/${productVo.FSName}" width="100%"/>
		  </div>
		</div>
		<div class="container col  text-left">
		  <!-- 상품 기본정보 -->
		  <div id="iteminfor">
		    <h3>${productVo.productName}</h3>
		    <h3><fmt:formatNumber value="${productVo.mainPrice}"/>원</h3>
		    <p>${productVo.detail}</p>
		  </div>
		  
		  <!-- 상품주문을 위한 옵션정보 출력 -->
		  <div class="form-group select_box">
		    <form name="optionForm">  <!-- 옵션의 정보를 보여주기위한 form -->
		      <select size="1" class="form-control" id="selectOption" required>
		        <option value="" disabled selected>상품 색상(필수)</option>
		        <c:forEach var="vo" items="${colorVos}">
		          <option value="${vo.idx}:${vo.colorName}_${vo.colorPrice}">${vo.colorName} (+<fmt:formatNumber value="${vo.colorPrice}" pattern='#,###원'/>)</option>
		        </c:forEach>
		      </select>
		      
		      
		      <select size="1" class="form-control" id="selectOption2" required>
		        <option value="" disabled selected>상품 사이즈</option>
		        <%-- <option value="0:기본품목_${productVo.mainPrice}" >기본품목</option> --%>
		        <c:forEach var="vo" items="${sizeVos}">
		          <option value="${vo.sizeName}_${vo.sizePrice}">${vo.sizeName}</option>
		        </c:forEach>
		      </select>
		    </form>
		  </div>
		  
		  
		  <form name="myform" id="myform" method="post">  <!-- 실제 상품의 정보를 넘겨주기 위한 form -->
		    <input type="hidden" name="mid" id="mid" value="${sMid}"/>
		    <input type="hidden" id="productIdx" name="productIdx" value="${productVo.idx}"/>
		    <input type="hidden" name="productName" value="${productVo.productName}"/>
		    <input type="hidden" id ="mainPrice" name="mainPrice" value="${productVo.mainPrice}"/>
		    <input type="hidden" name="thumbImg" value="${productVo.FSName}"/>
		    <input type="hidden" name="totalPrice" id="totalPriceResult"/>
		    <div id="product1">
		    	<div class="layer row" id="layer">
		    	</div>
		    </div>
		  </form>
		  <!-- 상품의 총가격(옵션포함가격) 출력처리 -->
		  <div class="product2">
		    <hr/>
		    <font size="4" color="black">총 상품금액</font>
		    <p align="right">
	        <b><input type="text" class="totalPrice text-right" id="totalPrice" value="0원" readonly /></b>
		    </p>
		  </div>
		  <!-- 장바구니보기/주문하기/계속쇼핑하기 처리 -->
		  <div class="buttongroup">
		    <button class="btn btn-outline-info" onclick="cart()">장바구니</button> &nbsp;
		    <button class="btn btn-outline-info" onclick="order()">주문하기</button> &nbsp;
		    <%-- <button class="btn btn-secondary" onclick="location.href='${ctp}/shop/dbShopList';">계속쇼핑하기</button> --%>
		  </div>
		</div>
  </div>
</div>
  <br/><br/>
  	<!-- 상품 상세설명 보여주기 -->
	 
	<ul class="nav nav-tabs justify-content-center productTab" role="tablist">
    <li class="nav-item">
      <a class="nav-link active tabId" data-toggle="tab" href="#content" >상품설명</a>
    </li>
    <li class="nav-item">
      <a class="nav-link tabId" data-toggle="tab" href="#review">상품후기</a>
    </li>
    <li class="nav-item">
      <a class="nav-link tabId" data-toggle="tab" href="#inquiry">주문정보</a>
    </li>
  </ul>
    <!-- Tab panes -->
    <div class="tab-content">
      <!-- 상품설명 -->
      <div id="content" class="tab-pane active" ><br>
       	${productVo.content}
      </div>
			
			<div id="review" class="tab-pane fade"><br>
        <!-- 상품 후기 -->

       <div class="container">
	       <table class="table table-hover review">
	       	<c:forEach var="vo" items="${reVos}" varStatus="st">
	       		<tr>
	       			<th>옵션 : </th>
	       			<td>${vo.optionName}</td>
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
	     	 </table>
	     	 <c:if test="${fn:length(reVos) == 0}" >
	     	 <p style="text-align: center; font-size: 30px">
		     	 아직 후기가 없습니다.😭😭 <br>고객님들의 소중한 후기를 들려주세요.
		     	 <br>  
		     	 <br>  
		     	 <br>  
		     	 <br>  
	     	 </p>
   	   	 </c:if>
       </div>
      </div>
      

      <div id="inquiry" class="tab-pane fade">
        <!-- 주문정보 -->
        <div>
        	<table class="table table-bordered">
        		<tr>
        			<th scope="row" class="explain">스토어 고객센터</th>
        			<td>주중 10:00 AM ~ 5:00 PM, 주말 및 공휴일 휴무<br>
이메일 : mjo5178@gmail.com<br>
전화번호 : 070-5223-2929<br>
카톡문의 : EXCONTAINER</td>
        		</tr>
        		<tr>
	        		<th scope="row" class="explain">배송 정보</th>
	        		<td>
	        			배송비의 경우 업체의 배송기준에 따라 배송비 차이가 있습니다.<br>
도서산간 및 제주도는 추가 배송료가 발생 할 수 있습니다.<br>
해외 발송 상품의 경우 개별 배송비가 추가됩니다. 각 상품 별 배송비 확인은 주문서에서 확인 가능합니다.<br>
예약 배송, 배송 지연이 표기 되어있는 상품은 배송이 3~10일 지연 될 수 있습니다.<br>
수제화와 같은 제작 상품은 상품 설명의 제작 기간을 숙지해주시기 바랍니다.
	        		</td>
        		</tr>
        		<tr>
        			<th scope="row" class="explain">교환/환불정보</th>
        			<td>
        			반품 및 교환은 상품 수령 후 7일 이내에 신청하실 수 있습니다.<br>
재화 등의 내용이 표시, 광고의 내용과 다르거나 계약내용과 다르게 이행된 경우에는 전자상거래법 제17조3항에 따라 청약철회를 할 수 있습니다.<br>
교환/환불이 발생하는 경우 그 원인을 제공한 자가 배송비를 부담합니다.<br>
- 고객변심 : 최초 배송비 + 반품 배송비 + (교환의 경우) 교환 배송비는 고객이 부담<br>
- 판매자귀책 : 최초 배송비 + 반품 배송비 + (교환의 경우) 교환 배송비는 판매자가 부담<br>
다음의 경우는 교환 및 환불이 불가능합니다.<br>
- 반품/교환 가능 기간을 초과한 경우<br>
- 상품 및 구성품을 분실하였거나 취급부주의로 인한 오염/파손/고장된 경우<br>
- 상품을 착용하였거나 세탁, 수선한 경우<br>
- 소비자 과실로 인한 옷의 변색(예 : 착생, 화장품 오염 등)<br>
- 착용으로 인한 니트류 상품의 늘어남 발생 및 가죽 제품의 주름 발생<br>
- 명품은 택 제거 후 반품 불가<br>
- 상품의 가치가 현저히 감소하여 재판매가 불가할 경우<br>
- 구매확정된 주문의 경우<br>
- 귀금속류의 경우는 소비자분쟁해결 기준에 의거 교환만 가능합니다.<br>
(단, 함량미달의 경우에는 환불이 가능함)<br>
상품 수령일로부터 7일 이내 반품/환불 가능합니다.<br>
단순변심 반품의 경우 왕복 배송비를 차감한 금액이 환불되며, 제품 및 포장 상태가 재판매 가능하여야 합니다.<br>
상품 불량인 경우는 배송비를 포함한 전액이 환불됩니다.<br>
출고 이후 환불 요청 시 상품 회수 후 처리됩니다.<br>
주문 제작 상품/카메라/밀봉 포장 상품 등은 변심에 따른 반품/환불이 불가합니다.<br>
일부 완제품으로 수입된 상품의 경우 A/S가 불가합니다.<br>
특정 브랜드의 상품 설명에 별도로 기입된 교환/환불/AS 기준이 우선합니다.<br>
        			</td>
        		</tr>
        		<tr>
        			<th scope="row" class="explain">상품정보 고시</th>
        			<td>
        			상품상세 참조
        			</td>
        		</tr>
        		<tr>
        			<th scope="row" class="explain">미성년자 주문취소 안내</th>
        			<td>미성년자가 법정대리인의 동의 없이 구매계약을 체결한 경우 미성년자와 법정대리인은 구매계약을 취소할 수 있습니다
        			</td>
        		</tr>
        		
        	</table>
        </div>
        <p style="text-align: center; font-size: 20px">
        <b>상품 문의를 하고 싶으신가요? -> </b>&nbsp;
      	<input type="button" value="문의하기" onClick="location.href='${ctp}/inquiry/inquiryInput'" class="btn btn-success"/>
      	</p>	
      </div>
 	  </div>
	
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>