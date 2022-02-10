<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/bs4.jsp" %>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script>
 $(function($){
	 $("#keywordSearch").click(function(){
		 var keyword = $("#keyword").val();
		 location.href = "${ctp}/product/keywordSearch?keyword="+keyword;  // 띄어쓰기 잘못하면 안간다 조심하자
	 });
	 
	 $(window).scroll(function() {
     if ($(this).scrollTop() > 50) {
       $('#MOVE_TOP_BTN').fadeIn();
     } else {
       $('#MOVE_TOP_BTN').fadeOut();
     }
	 });
 
 	$("#MOVE_TOP_BTN").click(function() {
		$('html, body').animate({
		   scrollTop : 0
		}, 400);
		return false;
		});
 })	
</script>

  <div style="width:90%; margin:0 10% 0 5%;">
    <button type="button" id="MOVE_TOP_BTN">맨위로 ↑</button>
    <div class="row" style="margin-top:10px; margin-bottom:10px;">
      <div class="col-4"> 
        <a href="${ctp}/" class="atag" style="color:rgb(59, 43, 43);">
          <img src="https://png.pngtree.com/png-vector/20200318/ourlarge/pngtree-alphabet-letter-m-with-ornaments-vintage-floral-png-image_2162406.jpg" width="90px">
          <span style="display: inline-block;"><font size="6px" style="vertical-align: middle;" class="toMain">MUSINSA</font></span>
        </a>
      </div>
      <!-- 검색창 -->
      <div class="col-4" style="margin-top: 30px;">
        <p><input type="text" id="keyword" style="width: 300px; border: 0px; height : 30px;" placeholder="상품 검색창"/>
        <button type="button" name="keywordSearch" id="keywordSearch" ><i class="fas fa-search"></i></button></p>
				<hr style="width: 320px; border: 1px solid black;">
      </div>
      <div class="col-4 text-right" style="margin-bottom:0; padding-top:30px;">
      	
	      <c:if test="${sLevel >=0 && sLevel <= 3}" >
	      	<font color="skyblue"><b>${sNickName}</b></font>님 로그인 중입니다.
	        <a class="btn btn-info" href="${ctp}/member/memLogout">로그아웃</a>
	        <a class="btn btn-info" href="${ctp}/product/cartList" style="width:50px"><i class="fas fa-shopping-cart" style="width:100%"></i></a>
	      </c:if>
	      <c:if test="${sLevel == 0 }">
	        <a href="${ctp}/admin/adMenu" class="btn btn-info">관리자메뉴</a>	
	      </c:if>
	      <c:if test="${!(sLevel >=0 && sLevel <= 3)}" >
	        <a class="btn btn-info" href="${ctp}/member/memLogin">로그인</i></a>
	        <a class="btn btn-info" href="${ctp}/member/memJoin">회원가입</a>
	      </c:if>
      </div>
    </div>
  </div>