<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%> 
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet" />
<script>
$(document).ready(function() {
		$("#expandbtn").click(function(){
    	$("#collapsibleNavbar").toggle(200);
    });
    $(".bigMenu").mouseover(function(){
    	$(this).css("font-size","1.6em");
    	$(this).css("transition","0.2s");
    });
    
    $(".bigMenu").mouseout(function(){
    	$(this).css("font-size","1.3em");
    	$(this).css("transition","0.2s");
    });
});
	
</script>

<%-- <c:set var="main_name" value="외투" /> --%>
 <nav class="navbar navbar-expand-lg navbar-light sticky-top" style="background-color:rgb(59, 59, 153); padding:0;">
     <button class="navbar-toggler" type="button" id="expandbtn" data-toggle="collapse" style="border:1px solid white; margin:10px;">
       <i class="fas fa-bars" style="color: white; font-size:1.5em;"></i>
     </button> 
    <div class="collapse navbar-collapse" id="collapsibleNavbar">
      <ul class="navbar-nav nav-main-ul">
        <li class="nav-item nav-main-li" style="border-right:1px solid white; border-left:1px solid white;" style="padding: 20px;"><a class="nav-link" href="${ctp}/introduction">
          <b><span class="bigMenu" style="font-size:1.3em; color:white">MUSINSA 소개</span></b></a>
          <ul class="nav-sub-ul">
            <hr>
            <li><a href="${ctp}/introduction" class="nav-sub-li">회사 소개</a></li>
            <li>&nbsp;</li>
            <li><a href="${ctp}/map" class="nav-sub-li">회사 오시는길</a></li>
          </ul>  
        </li>
        <li class="nav-item nav-main-li" style="border-right:1px solid white; border-left:1px solid white;" style="padding: 20px;"><a class="nav-link" href="${ctp}/product/productList?main=A">
          <b><span class="bigMenu" style="font-size:1.3em; color:white">외투</span></b></a>
          <ul class="nav-sub-ul">
            <hr>
            <li><a href="${ctp}/product/productList?middle=01" class="nav-sub-li">재킷</a></li>
            <li>&nbsp;</li>
            <li><a href="${ctp}/product/productList?middle=06" class="nav-sub-li">점퍼</a></li>
            <li>&nbsp;</li>
            <li><a href="${ctp}/product/productList?middle=00" class="nav-sub-li">패딩</a></li>
            <li>&nbsp;</li>
            <li><a href="${ctp}/product/productList?middle=02" class="nav-sub-li">코트</a></li>
          </ul>  
        </li>
        <li class="nav-item nav-main-li" style="border-right:1px solid white; border-left:1px solid white;" style="padding: 20px;"><a class="nav-link" href="${ctp}/product/productList?main=B">
          <b><span class="bigMenu" style="font-size:1.3em; color:white">상의</span></b></a>
          <ul class="nav-sub-ul">
            <hr>
            <li><a href="${ctp}/product/productList?middle=03" class="nav-sub-li">반팔티</a></li>
            <li>&nbsp;</li>
            <li><a href="${ctp}/product/productList?middle=07" class="nav-sub-li">긴팔티</a></li>
            <li>&nbsp;</li>
            <li><a href="${ctp}/product/productList?middle=04" class="nav-sub-li">맨투맨</a></li>
            <li>&nbsp;</li>
            <li><a href="${ctp}/product/productList?middle=08" class="nav-sub-li">후드티</a></li>
          </ul>  
        </li>
        <li class="nav-item nav-main-li" style="border-right:1px solid white; border-left:1px solid white;" style="padding: 20px;"><a class="nav-link" href="${ctp}/product/productList?main=C">
          <b><span class="bigMenu" style="font-size:1.3em; color:white">바지</span></b></a>
          <ul class="nav-sub-ul">
            <hr>
            <li><a href="${ctp}/product/productList?middle=09" class="nav-sub-li">슬랙스</a></li>
            <li>&nbsp;</li>
            <li><a href="${ctp}/product/productList?middle=05" class="nav-sub-li">청바지</a></li>
            <li>&nbsp;</li>
            <li><a href="${ctp}/product/productList?middle=10" class="nav-sub-li">반바지</a></li>
          </ul>  
        </li>
        <li class="nav-item nav-main-li" style="border-right:1px solid white; border-left:1px solid white;" style="padding: 20px;"><a class="nav-link" href="${ctp}/notice/noticeList">
          <b><span class="bigMenu" style="font-size:1.3em; color:white">고객센터</span></b></a>
          <ul class="nav-sub-ul">
            <hr>
            <li><a href="${ctp}/notice/noticeList" class="nav-sub-li">공지사항</a></li>
            <li>&nbsp;</li>
            <li><a href="${ctp}/board/boardList" class="nav-sub-li">자유 게시판</a></li>
            <li>&nbsp;</li>
            <li><a href="${ctp}/notice/qna" class="nav-sub-li">자주 묻는 질문</a></li>
            <li>&nbsp;</li>
            <li><a href="${ctp}/inquiry/inquiryList" class="nav-sub-li">1대1 문의</a></li>
            <li>&nbsp;</li>
          </ul>  
        </li>  
        <li class="nav-item nav-main-li" style="border-right:1px solid white; border-left:1px solid white;" style="padding: 20px;"><a class="nav-link" href="${ctp}/member/mypage">
          <b><span class="bigMenu" style="font-size:1.3em; color:white">MyPage</span></b></a>
          <ul class="nav-sub-ul">
            <hr>
            <li><a href="${ctp}/member/memPwdCheck" class="nav-sub-li">회원정보변경</a></li>
            <li>&nbsp;</li>
            <li><a href="${ctp}/product/cartList" class="nav-sub-li">장바구니</a></li>
            <li>&nbsp;</li>
            <li><a href="${ctp}/product/purchaseHistory" class="nav-sub-li">주문내역</a></li>
						<li>&nbsp;</li>
          </ul>  
        </li>  
      </ul>
    </div>
  </nav>