<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>장바구니</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
<link rel="stylesheet" href="${ctp}/css/cart.css?after">

<script>
    function onTotal(){
      var total = 0;
      var maxIdx = document.getElementById("maxIdx").value;
      for(var i=1;i<=maxIdx;i++){
        if($("#totalPrice"+i).length != 0 && document.getElementById("idx"+i).checked){  
          total = total + parseInt(document.getElementById("totalPrice"+i).value); 
        }
      }
      document.getElementById("total").value=numberWithCommas(total);
      
      if(total>=50000||total==0){
        document.getElementById("baesong").value=0;
      } else {
        document.getElementById("baesong").value=2500;
      }
      var lastPrice=parseInt(document.getElementById("baesong").value)+total;
      document.getElementById("lastPrice").value = numberWithCommas(lastPrice);  // 화면에 보여주는 주문 총금액
      document.getElementById("orderTotalPrice").value = lastPrice;  // 값을 넘겨주는 '주문 총 금액 필드'
    }
    
    // 상품 체크누르기
    function onCheck(){
      var maxIdx = document.getElementById("maxIdx").value;

      var cnt=0;
      for(var i=1;i<=maxIdx;i++){
        if($("#idx"+i).length != 0 && document.getElementById("idx"+i).checked==false){
          cnt++;
          break;
        }
      }
      if(cnt!=0){
        document.getElementById("allcheck").checked=false;
      } 
      else {
        document.getElementById("allcheck").checked=true;
      }
      onTotal();
    }
    
    // 전부체크하기
    function allCheck(){
      var maxIdx = document.getElementById("maxIdx").value;
      if(document.getElementById("allcheck").checked){
        for(var i=1;i<=maxIdx;i++){
          if($("#idx"+i).length != 0){
            document.getElementById("idx"+i).checked=true;
          }
        }
      }
      else {
        for(var i=1;i<=maxIdx;i++){
          if($("#idx"+i).length != 0){
            document.getElementById("idx"+i).checked=false;
          }
        }
      }
      onTotal();
    }
    
    // cart에 들어있는 품목 삭제하기
    function cartDel(idx){
    	if(!document.getElementById("idx"+idx).checked) {
    		alert("현재 상품을 삭제하시려면 현상품의 체크박스에 체크해주세요.");
    		return false;
    	}
      var ans = confirm("선택하신 현재상품을 장바구니에서 삭제하시겠습니까?");
      if(!ans) return false;
      
      $.ajax({
        type : "post",
        url  : "${ctp}/product/cartDel",
        data : {idx : idx},
        success:function() {
          location.reload();
        },
        error : function() {
        	alert("처리오류!");
        }
      });
    }
    
    function order(){
      //구매하기위해 체크한 장바구니에만 아이디가 check인 필드의 값을 1로 셋팅. 체크하지 않은것은 check아이디필드가 0이다.
      /*
      var maxIdx = document.getElementById("maxIdx").value;
      for(var i=1;i<=maxIdx;i++){
        if($("#idx"+i).length != 0 && document.getElementById("idx"+i).checked){
        	//var length = $("#idx"+i).length 체크안하면 0 체크하면 1
          document.getElementById("checkItem"+i).value="1";
        }
      }
      */
      
      //배송비넘기기
      //document.myform.baesong.value=document.getElementById("baesong").value;
      
      if(document.getElementById("lastPrice").value==0){
        alert("장바구니에서 상품을 선택해주세요!");
        return false;
      } 
      else {
        document.myform.submit();
      }
      
    }
    
    
    // 천단위마다 쉼표 표시하는 함수
    function numberWithCommas(x) {
      return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
    
    // 수량올리면 총 상품금액 올라가게.
    $(function($){
    	$("input[name^='quantity']").change(function(){
    		var idx = $(this).attr('id').replace("quantity","");
    		var totalPrice = $("input[id='imsiTotalPrice"+idx+"']").val();
    		var num = $("input[name='quantity"+idx+"']").val();
    		
    		totalPrice = parseInt(totalPrice) * parseInt(num);
    		var commaPrice = numberWithCommas(totalPrice);
    		$("input[id ='totalPrice"+idx+"']").val(totalPrice);
    		$("input[id ='totalProductPrice"+idx+"']").val(commaPrice + " 원");
    		//document.getElementById("totalProductPrice"+idx+"").value = commaPrice+" 원";
    		
    	});
    	
    	// 선택물품 전부삭제
    	$("input[name='deleteCartList']").click(function(){
    		var ans = confirm("선택한 장바구니를 삭제하시겠습니까?");
        if(!ans) return false;
        
    		const query = 'input[name^="idxChecked"]:checked';
    		const selectedEls = document.querySelectorAll(query);
    		var idxArr = "";
    		
    		selectedEls.forEach((el) => {
          idxArr += el.value + '/';
        });
    		
    		if(idxArr == ""){
    			alert("삭제하실 장바구니를 선택하세요");
    		}
    		else{
    			$.ajax({
    				type: "post",
    				url: "${ctp}/product/deleteCartList",
    				data : {
    					idxArr : idxArr
    				},
    				success : function(){
    					alert("선택한 장바구니들이 삭제되었습니다.");
    					location.reload();
    				},
    				error : function(){
    					alert("처리 오류!");
    				}
    			});
    		}
    		
    		
    	});
    	
    })
  </script>
   <style>
    .finalTot {
      width : 520px;
      height: 85px;
      margin : 0 auto;
      background-color:#ddd;
      padding:5px;
    }
    .totBox {
      float : left;
      background-color:#ddd;
      width : 95px;
      text-align : center;
      padding : 10px;
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
    .totalPrice {
      text-align:right;
      margin-right:10px;
      color:#f63;
      font-size:1.5em;
      font-weight: bold;
      border:0px;
      outline: none;
    }
  </style>
</head>
	
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br></p>
	<div class="container">
		<div class="head"><h2>장바구니</h2></div>
		<p><br/></p> 
		<c:if test="${empty cartListVos}">
			<h3 style="text-align: center"><font color=blue>장바구니가 비었습니다.</font></h3>
			<div align="center" style="clear:both;">
		  <button class="btn btn-info" onClick="location.href='javascript:history.back()';">돌아가기</button>
		</div>
		</c:if>
		<c:if test="${!empty cartListVos}">
			<form name="myform" method="post">
				<div align="center">
				<table class="table-bordered">
				 <thead>
				  <tr class="tablehead">
				    <td><label for="allcheck" style="cursor:pointer">전체</label>
				    	<input type="checkbox" name="allcheck" id="allcheck" onClick="allCheck()" class="m-2"/>
				    </td>
				    <td colspan="2">상품</td>
				    <td>수량</td>
				    <td style="width:200px">총상품금액</td>
				    <td>장바구니 담은 날</td>
				    <td style="width:100px"><input type="button" class="btn btn-warning" name="deleteCartList" value="선택 모두 삭제" style="padding:5px;margin:10px;" /></td>
				  </tr>
				  </thead>
				    
				  <!-- 장바구니 목록출력 -->
				  <c:forEach var="listVo" items="${cartListVos}">
				    <tbody>
				    <tr align="center">
				      <td><input type="checkbox" name="idxChecked" id="idx${listVo.idx}" value="${listVo.idx}" onClick="onCheck()" /></td>
				      <td><a href="${ctp}/product/productContent?idx=${listVo.productIdx}"><img src="${ctp}/product/${listVo.thumbImg}" class="thumb"/></a></td>
				      <td align="left" style="width:25%">
				        <p class="contFont"><br/>
				          제품명 : <span style="color:orange;font-weight:bold;">${listVo.productName}</span><br/>
				        </p><br/>
				        <c:set var="optionNames" value="${fn:split(listVo.optionName,',')}"/>
				        <c:set var="optionPrices" value="${fn:split(listVo.optionPrice,',')}"/>
				        <c:set var="optionNums" value="${fn:split(listVo.optionNum,',')}"/>
				        <p class="contFont">
				          <%-- <c:set var="optionNames" value="${fn:length(optionNames)}"/>-${optionNames} --%>
				          - 주문 내역
				          <c:if test="${fn:length(optionNames) > 1}">(옵션 ${fn:length(optionNames)}개)</c:if><br/>
				          <c:forEach var="i" begin="0" end="${fn:length(optionNames)-1}">
				            &nbsp;&nbsp; ㆍ${optionNames[i]} / <fmt:formatNumber value="${optionPrices[i]}"/>원 / ${optionNums[i]}개<br/>
				          </c:forEach> 
				        </p>
				      </td>
				      <td style="width:5%"><input type="number" value="1" name="quantity${listVo.idx}" id="quantity${listVo.idx}" min="1" style="width:80%" /></td>
				      <td>
				        <div class="totalFont">
					        <b>
					        	<input type="text" class="totalPrice text-right" id="totalProductPrice${listVo.idx}" 
					        							value="<fmt:formatNumber value='${listVo.totalPrice}'/> 원" readonly />
					        </b>
				        </div>
				      </td>
				      <td><span style="color:blue;" class="buyFont">${fn:substring(listVo.cartDate,0,10)}</span></td>
				      <td>
				        <%-- <input type="button" class="btn btn-secondary btn-sm btnFont" value="삭제" onClick="cartDel(${listVo.idx})"/> --%>
				        <button type="button" class="btn btn-secondary btn-sm btnFont" onClick="cartDel(${listVo.idx})">X</button>
				        <input type="hidden" id="imsiTotalPrice${listVo.idx}" value="${listVo.totalPrice}"/>     <!-- 수량 변동시 가격조정에 있어서 필요 -->
				        <input type="hidden" id="totalPrice${listVo.idx}" value="${listVo.totalPrice}"/>
				       
				       <!-- 필요할진 모르겠지만.. -> 필요하지.. orderVo 작성해야하는데 -->
				        <input type="hidden" name="idx" value="${listVo.idx }"/>
				        <input type="hidden" name="thumbImg" value="${listVo.thumbImg}"/>
				        <input type="hidden" name="productName" value="${listVo.productName}"/>
				        <input type="hidden" name="mainPrice" value="${listVo.mainPrice}"/>
				        <input type="hidden" name="optionName" value="${optionNames}"/>
				        <input type="hidden" name="optionPrice" value="${optionPrices}"/>
				        <input type="hidden" name="optionNum" value="${optionNums}"/>
				        
				      </td>
				    </tr>
				    </tbody>
				    <c:set var="maxIdx" value="${listVo.idx}"/>
				  </c:forEach>
				  <!-- <input type="hidden" name="post" value="0" /> -->
				</table>
			  <input type="hidden" id="maxIdx" name="maxIdx" value="${maxIdx}"/>
			  <input type="hidden" name="orderTotalPrice" id="orderTotalPrice"/>
			  <input type="hidden" name="mid" value="${sMid}"/>
			  </div>
			</form>
		<br/>
		<div align="center">
		  <b>실제 주문총금액</b>(구매하실 상품에 체크해 주세요. 총주문금액이 산출됩니다.)
		</div>
		<div class="finalTot">
		  <div class="totBox">
		    상품금액<br/>
		    <input type="text" id="total" value="0" class="totSubBox" readonly/>
		  </div>
		  <div class="totBox"> + </div>
		  <div class="totBox">
		    배송비<br/>
		    <input type="text" id="baesong" value="0" class="totSubBox" readonly/>
		  </div>
		  <div class="totBox"> = </div>
		  <div class="totBox">
		    총주문금액<br/>
		    <input type="text" id="lastPrice" value="0" class="totSubBox" readonly/>
		  </div>
		</div>
		<p><br/></p>
		<div align="center" style="clear:both;">
		  <button class="btn btn-info" onClick="order()">주문하기</button> &nbsp;&nbsp;
		  <button class="btn btn-info" onClick="location.href='${ctp}/product/productList';">계속 쇼핑하기</button>
		</div>
		</c:if>
	</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>