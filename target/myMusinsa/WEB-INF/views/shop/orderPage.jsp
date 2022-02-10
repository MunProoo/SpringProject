<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>주문 페이지</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctp}/css/ex.css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${ctp}/js/woo.js"></script>
<script>
	//결제하기
	function order() {
		var payment = $('input[name="oPayment"]:checked').val();
		var point = $('input[name="point"]').val();
		
		var ans = confirm("결제하시겠습니까?");
		if(ans) {
			document.getElementById("usingPoint").value = point;  // 사용한 포인트 input태그에 저장
			
			var tel = myform.tel1.value + "-" + myform.tel2.value + "-" + myform.tel3.value;
			var email = $("#email").val();
			var regExpEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; // 이메일 체크
			if(!regExpEmail.test(email)) {
				alert("이메일 형식에 맞게 써주세요.");
				return false;
			}
			var postcode = myform.postcode.value;
			var roadAddress = myform.roadAddress.value;
			var detailAddress = myform.detailAddress.value;
			var extraAddress = myform.extraAddress.value;
			var address = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress;
			if(address == "///") {
				address == "";
				alert("주소를 입력하세요.");
				return false;
			}
			
			$("#address").val(address);
			$("#tel").val(tel);
			$("#payment").val(payment);    
			
	  	myform.action = "${ctp}/product/orderInput";
	  	myform.submit();
		}
	}
	
	$(document).ready(function(){
		$("#point").change(function(){
			if($("#point").val() == ""){
				$("#point").val(0);
			}
			else if($("#point").val()<$("#mPoint").val()){
				alert("현재 가진 포인트보다 많습니다.");
				$("#point").val(0);
			}
			let orderTotalPrice = $("#imsiOrderTotalPrice").val();
			orderTotalPrice = parseInt(orderTotalPrice) - parseInt($("#point").val());
			$("#orderTotalPrice").val(orderTotalPrice);
			$("#commaOrderTotalPrice").val(numberWithCommas(orderTotalPrice) + " 원");
			
			
		})
	});
	
	 // 천단위마다 쉼표 표시하는 함수
  function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  }
	
	// 포인트 모두사용 버튼
	function pointUse(point){
		$("#point").val(point);
		let orderTotalPrice = $("#imsiOrderTotalPrice").val();
		orderTotalPrice = parseInt(orderTotalPrice) - parseInt($("#point").val());
		$("#orderTotalPrice").val(orderTotalPrice);
		$("#commaOrderTotalPrice").val(numberWithCommas(orderTotalPrice) + " 원");
	}
</script>
<style>
    .totalPrice {
    	width : 50%;
      text-align:right;
      margin-right:10px;
      color:#f63;
      font-size:1.2em;
      font-weight: bold;
      border:0px;
      outline: none;
    }

    .totSubBox {
      background-color:#ddd;
      border : none;
      width : 95px;
      text-align : center;
      font-weight: bold;
      padding : 5 0px;
      color : brown;
    }
</style>
</head>

<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br></p>
	<div class="container">
		<div class="head"><h2>주문 / 결제</h2></div>
		<div class="xans-element- xans-order xans-order-dcinfo ec-base-box typeMember  ">
			<div class="information">
      	<h3 class="title" style="font-size:13px">혜택정보</h3>
	      <div class="description">
	        <div class="member ">
	          <p><strong>${memberVo.nickName}</strong> 님은 <font color="#FFA500"><b>${sStrLevel}</b></font> 이십니다.</p>
					</div>
	        <ul class="mileage">
						<li><a href="#">포인트 : <strong style="color: #f76560;"><fmt:formatNumber value="${memberVo.point}" pattern='#,###원'/></strong></a></li>
	          <li><a href="#">쿠폰 : <strong style="color: #f76560;">0개</strong></a></li>
	        </ul>
				</div>
			</div>
		</div>
		
		<p><br/></p> 
		
		<table class="list table-bordered">
		 <thead>
		  <tr class="tablehead" style="font-size: 17px;">
		    <th colspan="2">상품</th>
		    <th>총상품 금액</th>
		    <th>적립포인트</th>
		  </tr>
		  </thead>
		    
		  <!-- 주문서 목록출력 -->
		  <%-- <c:set var="orderTotalPrice" value="0"/> --%>
		  <c:forEach var="vo" items="${orderVos}">  <!-- 세션에 담아놓은 orderVos의 품목내역들을 화면에 각각 보여주는 작업처리 -->
		    <tbody>
		    <tr align="center">
		      <td><img src="${ctp}/product/${vo.thumbImg}" class="thumb" width="180px" height="180px"/></td>
		      <td align="left">
		        <p><br/>주문번호 : ${orderIdx}</p>
		        <p><br/>모델명 : <span style="color:orange;font-weight:bold;">${vo.productName}</span><br/> &nbsp; &nbsp; <fmt:formatNumber value="${vo.mainPrice}"/>원</p><br/>
		        <c:set var="optionNames" value="${fn:split(vo.optionName,',')}"/>
		        <c:set var="optionPrices" value="${fn:split(vo.optionPrice,',')}"/>
		        <c:set var="optionNums" value="${fn:split(vo.optionNum,',')}"/>
		        <p>
		          - 주문 옵션 내역 : 총 ${fn:length(optionNames)}개<br/>
		          <c:forEach var="i" begin="1" end="${fn:length(optionNames)}">
		            &nbsp; &nbsp; ㆍ ${optionNames[i-1]} / <fmt:formatNumber value="${optionPrices[i-1]}"/>원 / ${optionNums[i-1]}개<br/>
		          </c:forEach> 
		        </p>
		      </td>
		      <td>
		        <b>총 : <fmt:formatNumber value="${vo.totalPrice}" pattern='#,###원'/></b><br/><br/>
		      </td>
		     <td><b><fmt:formatNumber value="${vo.totalPrice*0.01}" pattern='#,###원'/></b><br/><br/>
		     </td>
		    </tr>
		    </tbody>
		    
			  <%-- <input type="hidden" name="cartIdx" value="${idx}"/> --%>  <!-- 장바구니고유번호를 비롯한 주문된 상품의 정보들은 세션에 담겨있기에 굳이 따로 넘길필요없다. 즉 따로이 입력된 배송지 정보들만 넘긴다. -->
		    <%-- <c:set var="orderTotalPrice" value="${orderTotalPrice + vo.totalPrice}"/> <!-- 각 카트의 totalPrice 더하기 --> --%>
		  </c:forEach>
		</table>
		<p></p>
		
			<!-- 포인트 사용 및 결제수단 -->
		  <table border="1" class="order">
				<!-- 적립금 -->
					<tr class="txt15">
						<th>포인트 사용</th>
				      <td>
				      	<p><input id="point" name="point" size="10" value="0" type="text" style="width: 200px;"> 원 (총 사용가능 적립금 : <strong class="txtWarn" style="color: #f76560;"><fmt:formatNumber value="${memberVo.point}" pattern='#,###'/></strong>원)</p>
								<input type="button" class="btn btn-info" onclick="pointUse('${memberVo.point}')" value="모두사용">
								<input type="hidden" name="mPoint" id="mPoint" value = "${memberVo.point}"/>
						</td>
		      </tr>
					<tr class="txt15">
						<th>결제수단</th>
		        	<td>
				        <input type=radio name="oPayment" value="무통장" checked="checked">무통장&nbsp;&nbsp;&nbsp; 
								<input type=radio name="oPayment" value="카드">카드
							</td>
    			</tr>
			</table>
			<hr>
			
			─────────────────────────────────────────────────────────────────────────────
			<div style="width:100%; background-color:#eee;text-align:center;">
				<table>
					<tr>
						<th>총 주문 금액</th>
						<td>
								*50,000원 미만의 제품에는 배송비 2,500원이 추가됩니다.
			    			<input type="text" class="totalPrice" id="commaOrderTotalPrice" name="commaOrderTotalPrice" 
					        							value="<fmt:formatNumber value='${orderTotalPrice}'/> 원" readonly />
						</td>
					</tr>
				</table>
			</div>
			
			<div class="container">
					<form name="myform" method="post">
					<hr>
					<h5 style="margin-top: 40px">배송정보<font color="red"><b>*</b></font>(주문 번호 : ${orderIdx})</h5>
					<hr>
					<table>
					<tr>
						<td class="ftd">받으시는 분</td>
						<td colspan="3"><input type="text" class="form-control" name="name" id="name" maxlength="30" required value="${memberVo.name}"></td>
					</tr>
					<tr>
						<td class="ftd">주소</td>
						<td colspan="2">
							<input type="text" id="sample4_postcode" name="postcode" placeholder="우편번호" readonly="readonly" required maxlength="14" value="${fn:split(memberVo.address, '/')[0] }">
						</td>
						<td class="btninput">
							<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
						</td>
					</tr>
					<tr>
						<td></td>
						<td colspan="3"><input type="text" name="roadAddress" id="sample4_roadAddress" value="${fn:split(memberVo.address, '/')[1] }"  size="50" placeholder="도로명주소"><br></td>
					</tr>
					<tr>
						<td></td>	
						<td colspan="2"><input type="text" name="detailAddress" id="sample4_detailAddress" value="${fn:split(memberVo.address, '/')[2] }" size="30" placeholder="상세주소"></td>
						<td><input type="text" name="extraAddress" id="sample4_extraAddress" value="${fn:split(memberVo.address, '/')[3] }" placeholder="참고항목"></td>
					</tr>
					<tr>
						<td class="ftd">휴대전화</td>
						<td class="tel1">
							<select name="tel1">
						    	<option value="010" selected>010</option>
								<option value="011" >011</option>
								<option value="016" >016</option>
								<option value="017" >017</option>
								<option value="018" >018</option>
								<option value="019" >019</option>
						    </select>
						</td>
						<td class="tel2"><input type="text" name="tel2" maxlength="4" required value="${fn:split(memberVo.tel,'-')[1]}"></td>
						<td class="tel3"><input type="text" name="tel3" maxlength="4" required value="${fn:split(memberVo.tel,'-')[2]}"></td>
					</tr>
					<tr>
						<td class="ftd">이메일</td>
						<td colspan="3"><input type="email" name="email" id="email" value="${memberVo.email}" required></td>
					</tr>
					<tr class="ftd">
						<td>배송메시지</td>
	          <td colspan="3">
	         		<textarea id="message" name="message" maxlength="255" cols="70" style="margin: 0px; height: 60px;"></textarea>
		        </td>
	        </tr>
				</table>
				<hr/>
				
				<div align="center">
				  <button type="button" class="btn btn-secondary" onClick="order()">결제하기</button>
					<button type="button" class="btn btn-secondary" onclick="location.href='${ctp}/product/cartList';">장바구니보기</button>
				  <button type="button" class="btn btn-secondary" onClick="location.href='${ctp}/dbShop/dbShopList';">계속 쇼핑하기</button>
				  <%-- <a href="${ctp}/dbShop/dbShopList" class="btn btn-secondary">계속쇼핑하기</a> --%>
				</div>
		    <%-- <input type="hidden" name="oIdx" value="${oIdx}"/> --%>  				<!-- 주문테이블 고유번호 -->
			  <input type="hidden" name="orderIdx" value="${orderIdx}"/>  <!-- 주문번호 -->
			  <input type="hidden" name="orderTotalPrice" id="orderTotalPrice" value="${orderTotalPrice}"/>
			  
			  <input type="hidden" name="address" id="address" />
			  <input type="hidden" name="tel" id="tel"/>
			  <input type="hidden" id="usingPoint" name="usingPoint" value="0">
			  
			  <input type="hidden" id="imsiOrderTotalPrice" value="${orderTotalPrice}"/>
			  <input type="hidden" name="mid" value="${sMid}"/>
			  <input type="hidden" name="payment" id="payment"/>
			</form>
		</div>
	</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>