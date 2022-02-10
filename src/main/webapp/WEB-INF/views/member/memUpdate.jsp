<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	Date today = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String sToday = sdf.format(today);
%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memUpdate.jsp</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
 <!-- 아래는 다음 주소 API를 활용한 우편번호검색 -->
 <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
 <script src="${ctp}/js/woo.js"></script>
 <script>
 	var nickCheckOn = 1;
 	var pwdValid = 1;
 	
 	// 비밀번호 정규식 체크
 	function pwdFunc(){
 		var pwd = myform.pwd.value;
 		
 		if(isPassword(pwd)){
 			document.getElementById("pwdValid").innerHTML=" ";
 			pwdValid = 1;
 		}
 		else{
 			pwdValid = 0;
 			document.getElementById("pwdValid").innerHTML="비밀번호를 형식에 맞게 입력하세요.";
 			return false;
 		}
 	}
 	
 	// 비밀번호 확인칸
 	function pwdConfirmCheck(){
 		var pwd = myform.pwd.value;
 		var pwdConfirm = myform.pwdConfirm.value;
 		
 		if(!(pwdConfirm == pwd)){
 			document.getElementById("pwdConfirmDemo").innerHTML="비밀번호가 일치하지 않습니다.";
 			myform.pwdConfirm.value = "";
 		}
 		else{
 			document.getElementById("pwdConfirmDemo").innerHTML="비밀번호가 일치합니다.^^";
 		}
 	}
 	
 // 닉네임 중복체크
  function nickCheck() {
	  var nickName = $("#nickName").val();
		
		if(nickName==""){
			alert("닉네임을 입력하세요");
			myform.nickName.focus();
			return false;
		}
		else {
			$.ajax({
				type : "post",
				url : "${ctp}/member/nickCheck",
				data : {nickName : nickName},
				success : function(data){
					if(data == "1"){
						alert("이미 사용중인 닉네임입니다.");
						$('#nickName').focus();
					}
					else{
						alert('사용 가능한 닉네임입니다.');
						nickCheckOn = 1;
					}
				},
				error : function(){
					alert("전송 오류");
				}
			});
		}
  }
 	
  function nickReset() {
  		nickCheckOn = 0;
  }
 	
//회원가입폼 체크
  function fCheck() {
  	var pwd = myform.pwd.value;
  	var nickName = myform.nickName.value;
  	var name = myform.name.value;
  	var tel = myform.tel1.value + "-" + myform.tel2.value + "-" + myform.tel3.value;
  	
  	var regExpEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; // 이메일 체크
  	
 		if(pwd == "") {
  		alert("비밀번호를 입력하세요");
  		myform.pwd.focus();
  	}
  	else if(nickName == "") {
  		alert("닉네임을 입력하세요");
  		myform.nickName.focus();
  	}
  	else if(name == "") {
  		alert("성명을 입력하세요");
  		myform.name.focus();
  	}
  	else if(email1 == "") {
  		alert("이메일을 입력하세요");
  		myform.email1.focus();
  	}
  	// 기타 추가 체크해야 할 항목들을 모두 체크하세요.
  	else {
  		if(nickCheckOn == 1 && pwdValid == 1) {
  			//alert("입력처리 되었습니다.!");
		  	var email = myform.email1.value + "@" + myform.email2.value;
  			var postcode = myform.postcode.value;
  			var roadAddress = myform.roadAddress.value;
  			var detailAddress = myform.detailAddress.value;
  			var extraAddress = myform.extraAddress.value;
  			var address = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress;
  			if(address == "///") address = "";
  			
  			myform.address.value = address;
  			myform.email.value = email;
  			myform.tel.value = tel;
  			
		    myform.submit();
		}
  		else {
  			if(nickCheckOn == 0){
  				alert("닉네임 중복체크버튼을 눌러주세요!");
  			}
  			else {
  				alert("비밀번호 형식을 맞춰주세요!");
  			}
  		}
  	}
  }
  
  // ---------------------정규식--------------------------
  
 	// 비밀번호 정규식
 	function isPassword(pwd){
 		var regExp = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,12}$/;
 		
 		return regExp.test(pwd);
 	}
  
  function delCheck(){
  	var ans = confirm("정말 탈퇴하시겠습니까?");
  	
  	if(ans){
  		location.href='${ctp}/member/memDelete';
  	}
  }
 	
 </script>
 
</head>
<body>
<!-- 헤더 -->
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
<!-- 네비 -->
	<%@ include file="/WEB-INF/views/include/nav.jsp"%>
	<p><br></p>
	<div class="container" style="padding:30px">
		<form name="myform" method="post" >
    <h2>회 원 정 보 수 정 ( <font color="red">*</font> 표시는 필수 입력칸 입니다.)</h2>
    <br/>
    <div class="form-group">
     아이디 : ${sMid}
    </div>
    <div class="form-group">
      <label for="pwd"><font color="red">*</font>비밀번호 :</label>
      <input type="password" class="form-control" id="pwd" placeholder="영문,숫자,특수문자 1개를 포함한 8~12자" name="pwd" value="${sPwd}" maxlength="12" onchange="pwdFunc()" required/>
      <p id="pwdValid" class="text-danger"></p>
    </div>
    <div class="form-group">
      <label for="pwdConfirm"><font color="red">*</font>비밀번호확인 :</label>
      <input type="password" class="form-control" id="pwdConfirm" placeholder="비밀번호를 한번 더 입력해주세요" name="pwdConfirm" value="${sPwd}" maxlength="12" onchange="pwdConfirmCheck()" required/>
      <p id="pwdConfirmDemo" class="text-danger"></p>
    </div>
    <div class="form-group">
      <label for="nickName"><font color="red">*</font>닉네임 : &nbsp; &nbsp;<input type="button" value="닉네임 중복체크" class="btn btn-secondary" onclick="nickCheck()"/></label>
      <input type="text" class="form-control" id="nickName" onkeyup="nickReset()" value="${vo.nickName}" placeholder="별명을 입력하세요." name="nickName" required/>
    </div>
    <div class="form-group">
      <label for="name"><font color="red">*</font>성명 :</label>
      <input type="text" class="form-control" id="name" placeholder="성명을 입력하세요." name="name" value="${vo.name}" required/>
    </div>
    <div class="form-group">
      <label for="email"><font color="red">*</font>Email address: </label>
				<div class="input-group mb-3">
				  <input type="text" class="form-control" placeholder="Email" id="email1" name="email1" value="${fn:split(vo.email, '@')[0]}" required/>
				  <div class="input-group-append">
				    <select name="email2" class="custom-select">
				    	<c:set var = "email2" value="${fn:split(vo.email, '@')[1]}" />
					    <option value="naver.com" ${email2 == 'naver.com' ? 'selected' : ''}>naver.com</option>
					    <option value="hanmail.net" ${email2 == 'hanmail.net' ? 'selected' : ''} >hanmail.net</option>
					    <option value="hotmail.com" ${email2 == 'hotmail.com' ? 'selected' : ''} >hotmail.com</option>
					    <option value="gmail.com" ${email2 == 'gmail.com' ? 'selected' : ''} >gmail.com</option>
					    <option value="nate.com" ${email2 == 'nate.com' ? 'selected' : ''} >nate.com</option>
					    <option value="yahoo.com" ${email2 == 'yahoo.com' ? 'selected' : ''} >yahoo.com</option>
					  </select>
				  </div>
				</div>
	  </div>
	  <hr>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">성별 :</span> &nbsp; &nbsp;
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="gender" ${vo.gender == '남자' ? 'checked' : ''} >남자
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="gender" ${vo.gender == '여자' ? 'checked' : ''}>여자
			  </label>
			</div>
    </div>
    <div class="form-group">
      <label for="birthday">생년월일</label>
			<input type="date" name="birthday" value="${fn:substring(vo.birthday, 0, 10) }" class="form-control"/>
    </div>
    <div class="form-group">
      <div class="input-group mb-3">
	      <div class="input-group-prepend">
	        <span class="input-group-text">전화번호 :</span> &nbsp;&nbsp;
			      <select name="tel1" class="custom-select">
			      	<c:set var = "tel1" value="${fn:split(vo.tel, '-')[0] }" />
					    <option value="010" ${tel1 == '010' ? 'selected' : ''}>010</option>
					    <option value="02" ${tel1 == '02' ? 'selected' : ''} >서울</option>
					    <option value="031" ${tel1 == '031' ? 'selected' : ''} >경기</option>
					    <option value="032" ${tel1 == '032' ? 'selected' : ''} >인천</option>
					    <option value="041" ${tel1 == '041' ? 'selected' : ''} >충남</option>
					    <option value="042" ${tel1 == '042' ? 'selected' : ''} >대전</option>
					    <option value="043" ${tel1 == '043' ? 'selected' : ''} >충북</option>
			        <option value="051" ${tel1 == '051' ? 'selected' : ''} >부산</option>
			        <option value="052" ${tel1 == '052' ? 'selected' : ''} >울산</option>
			        <option value="061" ${tel1 == '061' ? 'selected' : ''} >전북</option>
			        <option value="062" ${tel1 == '062' ? 'selected' : ''} >광주</option>
					  </select>-
	      </div>
	      <input type="text" name="tel2" value="${fn:split(vo.tel,'-')[1]}" size=4 maxlength=4 class="form-control"/>-
	      <input type="text" name="tel3" value="${fn:split(vo.tel,'-')[2]}" size=4 maxlength=4 class="form-control"/>
	    </div> 
    </div>
    <div class="form-group">
      <label for="address">주소 : </label>
      <input type="hidden" class="form-control" name="address"/>
      <input type="text" name="postcode" value="${fn:split(vo.address, '/')[0] }" id="sample4_postcode" placeholder="우편번호">
			<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" name="roadAddress" id="sample4_roadAddress" value="${fn:split(vo.address, '/')[1] }"  size="50" placeholder="도로명주소">
			<!-- <input type="text" id="sample4_jibunAddress" placeholder="지번주소"> -->
			<span id="guide" style="color:#999;display:none"></span>
			<input type="text" name="detailAddress" id="sample4_detailAddress" value="${fn:split(vo.address, '/')[2] }" size="30" placeholder="상세주소">
			<input type="text" name="extraAddress" id="sample4_extraAddress" value="${fn:split(vo.address, '/')[3] }" placeholder="참고항목">
    </div>

    <button type="button" class="btn btn-secondary" onclick="fCheck()">정보수정</button>
    <button type="button" class="btn btn-secondary" onclick="location.href='${ctp}/';">돌아가기</button>
    <button type="button" class="btn btn-danger" style="float:right" onclick="delCheck()">회원탈퇴</button>
    <input type="hidden" name="mid" value="${sMid}" />
    <input type="hidden" name="email" />
    <input type="hidden" name="tel"/>
    <!-- <input type="hidden" name="address"/>  위에 이미 있으니 생략 -->    
   </form>
   <p><br></p>
	</div>
	<br>
<!-- footer -->
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>