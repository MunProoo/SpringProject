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

<link rel="stylesheet" href="https://paged.kr/theme/paged/skin/member/basic/style.css?v2">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memJoin.jsp</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
 <!-- 아래는 다음 주소 API를 활용한 우편번호검색 -->
 <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
 <script src="${ctp}/js/woo.js"></script>
 <script>
 	var idCheckOn = 0;
 	var idValid = 0;
 	var nickCheckOn = 0;
 	var pwdValid = 0;
 	
 	//아이디 중복체크
 	function idCheck() {
 		var mid = $("#mid").val();
 		if(idValid == 0){ alert("아이디 형식에 맞게 입력하세요.");
 			return false;
 		}
 		else if(mid==""){ alert("아이디를 입력하세요");
 			myform.mid.focus();
 			return false;
 		}
 		else {
 			$.ajax({
 				type : "post",
 				url : "${ctp}/member/idCheck",
 				data : {mid : mid},
 				success : function(data){
 					if(data == "1"){
 						alert("이미 사용중인 아이디입니다.");
 						$('#mid').focus();
 					}
 					else{
 						alert('사용 가능한 아이디입니다.');
 						idCheckOn = 1;
 						myform.pwd.focus();
 					}
 				},
 				error : function(){
 					alert("전송 오류");
 				}
 			});
 		}
 	}
 	
 	//아이디 정규식 체크
 	function idFunc(){
 		var mid = myform.mid.value;
 			
 		if(isId(mid)){
 			document.getElementById("idValid").innerHTML=" ";
 			idValid = 1;
 		}
 		else{
 			idValid = 0;
 			document.getElementById("idValid").innerHTML="아이디를 형식에 맞게 입력하세요.";
 			return false;
 		}	
 	}
 	
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
 		let pwd = myform.pwd.value;
 		let pwdConfirm = myform.pwdConfirm.value;
 		
 		if(!(pwdConfirm == pwd)){
 			document.getElementById("pwdConfirmDemo").innerHTML="비밀번호가 일치하지 않습니다.";
 			myform.pwdConfirm.value = "";
 		}
 		else{
 			document.getElementById("pwdConfirmDemo").innerHTML="비밀번호가 일치합니다.^^";
 		}
 	}
 	
 	// 아이디를 다시 입력했을 시 중복체크를 다시 해야함
 	function idReset() {
  		idCheckOn = 0;
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
						myform.name.focus();
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
  	var mid = myform.mid.value;
  	var pwd = myform.pwd.value;
  	var nickName = myform.nickName.value;
  	var name = myform.name.value;
  	var tel = myform.tel1.value + "-" + myform.tel2.value + "-" + myform.tel3.value;
  	var agree1 = myform.agree11;
  	var agree2 = myform.agree21;
  	
  	var regExpEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; // 이메일 체크
  	
  	if(mid == "") {
  		alert("아이디를 입력하세요");
  		myform.mid.focus();
  	}
  	else if(pwd == "") {
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
  	else if(!agree1.checked){
  		alert("회원가입약관의 내용에 동의하셔야 회원가입 하실 수 있습니다.");
  	}
  	else if(!agree2.checked){
  		alert("개인정보처리방침안내의 내용에 동의하셔야 회원가입 하실 수 있습니다.");
  	}
  	else {
  		if(idCheckOn == 1 && nickCheckOn == 1 && idValid == 1 && pwdValid == 1) {
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
  			if(idCheckOn == 0) {
  				alert("아이디 중복체크버튼을 눌러주세요!");
  			}
  			else if(nickCheckOn == 0){
  				alert("닉네임 중복체크버튼을 눌러주세요!");
  			}
  			else if(idValid == 0){
  				alert("아이디 형식을 맞춰주세요!");
  			}
  			else {
  				alert("비밀번호 형식을 맞춰주세요!");
  			}
  		}
  	}
  }
  
  // ---------------------정규식--------------------------
  
 	// 아이디 정규식
 	function isId(mid) {
 		var regExp = /^[a-z]+[a-z0-9]{3,11}$/g;
 	 
 		return regExp.test(mid); // 성립하면 true반환
 	}
  
 	// 비밀번호 정규식
 	function isPassword(pwd){
 		var regExp = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,12}$/;
 		
 		return regExp.test(pwd);
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
		<form name="myform" id="fregister" method="post" >
    <h2>회 원 가 입 ( <font color="red">*</font> 표시는 필수 입력칸 입니다.)</h2>
    <br/>
    <div class="form-group">
      <label for="mid"><font color="red">*</font>아이디 : &nbsp; &nbsp;<input type="button" value="아이디 중복체크" class="btn btn-secondary" onclick="idCheck()"/></label>
      <input type="text" class="form-control" id="mid" onkeyup="idReset()" placeholder="영문자로 시작하는 영문자 혹은 숫자 4~12자" maxlength="12" name="mid" onchange="idFunc()" required autofocus/>
      <p id="idValid" class="text-danger"></p>
    </div>
    <div class="form-group">
      <label for="pwd"><font color="red">*</font>비밀번호 :</label>
      <input type="password" class="form-control" id="pwd" placeholder="영문,숫자,특수문자 1개를 포함한 8~12자" name="pwd" maxlength="12" onchange="pwdFunc()" required/>
      <p id="pwdValid" class="text-danger"></p>
    </div>
    <div class="form-group">
      <label for="pwdConfirm"><font color="red">*</font>비밀번호확인 :</label>
      <input type="password" class="form-control" id="pwdConfirm" placeholder="비밀번호를 한번 더 입력해주세요" name="pwdConfirm" maxlength="12" onchange="pwdConfirmCheck()" required/>
      <p id="pwdConfirmDemo" class="text-danger"></p>
    </div>
    <div class="form-group">
      <label for="nickName"><font color="red">*</font>닉네임 : &nbsp; &nbsp;<input type="button" value="닉네임 중복체크" class="btn btn-secondary" onclick="nickCheck()"/></label>
      <input type="text" class="form-control" id="nickName" onkeyup="nickReset()"  placeholder="별명을 입력하세요." name="nickName" required/>
    </div>
    <div class="form-group">
      <label for="name"><font color="red">*</font>성명 :</label>
      <input type="text" class="form-control" id="name" placeholder="성명을 입력하세요." name="name" required/>
    </div>
    <div class="form-group">
      <label for="email"><font color="red">*</font>Email address: </label>
				<div class="input-group mb-3">
				  <input type="text" class="form-control" placeholder="Email" id="email1" name="email1" required/>
				  <div class="input-group-append">
				    <select name="email2" class="custom-select">
					    <option value="naver.com" selected>naver.com</option>
					    <option value="hanmail.net">hanmail.net</option>
					    <option value="hotmail.com">hotmail.com</option>
					    <option value="gmail.com">gmail.com</option>
					    <option value="nate.com">nate.com</option>
					    <option value="yahoo.com">yahoo.com</option>
					  </select>
				  </div>
				</div>
	  </div>
	  <hr>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">성별 :</span> &nbsp; &nbsp;
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="gender" value="남자" checked>남자
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="gender" value="여자">여자
			  </label>
			</div>
    </div>
    <div class="form-group">
      <label for="birthday">생년월일</label>
			<input type="date" name="birthday" value="<%=sToday%>" class="form-control"/>
    </div>
    <div class="form-group">
      <div class="input-group mb-3">
	      <div class="input-group-prepend">
	        <span class="input-group-text">전화번호 :</span> &nbsp;&nbsp;
			      <select name="tel1" class="custom-select">
					    <option value="010" selected>010</option>
					    <option value="02">서울</option>
					    <option value="031">경기</option>
					    <option value="032">인천</option>
					    <option value="041">충남</option>
					    <option value="042">대전</option>
					    <option value="043">충북</option>
			        <option value="051">부산</option>
			        <option value="052">울산</option>
			        <option value="061">전북</option>
			        <option value="062">광주</option>
					  </select>
	      </div> &nbsp;&nbsp; - &nbsp;&nbsp;
	      <input type="text" name="tel2" size=4 maxlength=4 class="form-control"/>&nbsp;&nbsp; - &nbsp;&nbsp;
	      <input type="text" name="tel3" size=4 maxlength=4 class="form-control"/>
	    </div> 
    </div>
    <div class="form-group">
      <label for="address">주소 : </label>
      <input type="hidden" class="form-control" name="address"/>
      <input type="text" name="postcode" id="sample4_postcode" placeholder="우편번호">
			<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" name="roadAddress" id="sample4_roadAddress" size="50" placeholder="도로명주소">
			<!-- <input type="text" id="sample4_jibunAddress" placeholder="지번주소"> -->
			<span id="guide" style="color:#999;display:none"></span>
			<input type="text" name="detailAddress" id="sample4_detailAddress" size="30" placeholder="상세주소">
			<input type="text" name="extraAddress" id="sample4_extraAddress" placeholder="참고항목">
    </div>
    
    <p>회원가입약관 및 개인정보처리방침안내의 내용에 동의하셔야 회원가입 하실 수 있습니다.</p>
    <div id="fregister_chkall">
        <label><b>전체선택</b> <input type="checkbox" name="chk_all"  value="1"  id="chk_all"></label>    
    </div>
    <section id="fregister_term">
        <h2><i class="fa fa-check" aria-hidden="true"></i> 회원가입약관</h2>
        <textarea readonly>■ 제 1조 (목적) 
이 약관은 전기통신 사업법 및 동 법 시행령에 의하여 웹사이팅(이하 &#034;회사&#034; 라 합니다.)이 제공하는 인터넷 홈페이지 서비스 'MIBER'(이하 &#034;서비스&#034; 라 합니다.)의 이용조건 및 절차에 관한 사항, 회사와 이용자의 권리와 의무 및 책임사항을 규정함을 목적으로 합니다.
 

■ 제 2조 (약관의 효력과 개정) 
1. 이 약관은 전기통신사업법 제 31 조, 동 법 시행규칙 제 21조의 2에 따라 공시절차를 거친 후 홈페이지를 통하여 이를 공지하거나 전자우편 기타의 방법으로 이용자에게 통지함으로써 효력을 발생합니다.
2. 회사는 본 약관을 사전 고지 없이 개정할 수 있으며, 개정된 약관은 제9조에 정한 방법으로 공지합니다. 회원은 개정된 약관에 동의하지 아니하는 경우 본인의 회원등록을 취소(회원탈퇴)할 수 있으며, 계속 사용의 경우는 약관 개정에 대한 동의로 간주됩니다. 개정된 약관은 공지와 동시에 그 효력이 발생됩니다.
  

■ 제 3조 (약관이외의 준칙) 
이 약관에 명시되어 있지 않은 사항은 전기통신 기본법, 전기통신 사업법, 기타 관련법령의 규정에 따릅니다.
 
■ 제 4조 (용어의 정의) 
이 약관에서 사용하는 용어의 정의는 다음과 같습니다.
1. 회원 : 서비스에 개인정보를 제공하여 회원등록을 한 자로서, 서비스의 정보를 지속적으로 제공받으며, 이용할 수 있는 자를 말합니다. 
2. 이용자 : 본 약관에 따라 회사가 제공하는 서비스를 받는 회원 및 비회원을 말합니다.
3. 아이디 (ID) : 회원 식별과 회원의 서비스 이용을 위하여 회원이 선정하고 회사가 승인하는 문자와 숫자의 조합을 말합니다.  
4. 비밀번호 : 회원이 통신상의 자신의 비밀을 보호하기 위해 선정한 문자와 숫자의 조합을 말합니다.  
5. 전자우편 (E-mail) : 인터넷을 통한 우편입니다.  
6. 해지 : 회사 또는 회원이 서비스 이용 이후 그 이용계약을 종료 시키는 의사표시를 말합니다.  
7. 홈페이지 : 회사가 이용자에게 서비스를 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 이용자가 열람 및 이용할 수 있도록 설정한 가상의 서비스 공간을 말합니다.
  

■ 제 5조 (서비스의 제공 및 변경)
1. 회사가 제공하는 서비스는 다음과 같습니다.
	① 회사에 대한 홍보 내용
	② 회사가 판매하는 제품 안내
	③ 기타 회사가 제공하는 각종 정보
	④ 고객 상담 서비스
	⑤ 회원 이용 서비스
2. 회사는 필요한 경우 서비스의 내용을 추가 또는 변경하여 제공할 수 있습니다.
  

■ 제 6조 (서비스의 중단) 
1. 회사는 컴퓨터 등 정보통신설비의 보수점검/교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있습니다.
2. 제 1항에 의한 서비스 중단의 경우에는 제 9조에 정한 방법으로 이용자에게 통지합니다.
3. 회사는 제1항의 사유로 서비스의 제공이 일시적으로 중단됨으로 인하여 이용자 또는 제3자가 입은 손해에 대하여 배상하지 아니합니다. 단, 회사에 고의 또는 중과실이 있는 경우에는 그러하지 아니합니다.
  

■ 제 7조 (회원가입) 
1. 이용자는 회사가 정한 가입양식에 따라 회원정보를 기입한 후 이 약관에 동의한다는 의사표시를 함으로서 회원가입을 신청합니다.
2. 이용자는 반드시 실명으로 회원가입을 하여야 하며, 1개의 실명에 대해 1건의 회원가입신청을 할 수 있습니다.
3. 회사는 제 1항과 같이 회원으로 가입할 것을 신청한 이용자 중 다음 각 호에 해당하지 않는 한 회원으로 등록합니다.
	① 이름이 실명이 아닌 경우
	② 등록 내용에 허위, 기재누락, 오기가 있는 경우
	③ 타인의 명의를 사용하여 신청한 경우
	④ 가입신청자가 이 약관 제 8조 3항에 의하여 이전에 회원자격을 상실한 적이 있는 경우(단, 제 8조 3항에 의한 회원자격 상실 후 3년이 경과한 자로서 회사의 회원 재가입 승낙을 얻은 경우는 예외로 합니다.)
	⑤ 만 14세 미만의 아동
	⑥ 기타 회원으로 회사 소정의 이용신청요건을 충족하지 못하는 경우
4. 회원가입계약의 성립시기는 회사의 승낙이 이용자에게 도달한 시점으로 합니다.
5. 회원은 제 10조 1항에 의한 등록사항에 변경이 있는 경우 회원정보변경 항목을 통해 직접 변경사항을 수정, 등록하여야 합니다.
  

■ 제 8조 (회원탈퇴 및 자격 상실 등)
1. 회원은 언제든지 회원의 탈퇴를 홈페이지에 요청할 수 있으며, 홈페이지는 즉시 이에 응합니다.
2. 회원이 다음 각 호의 사유에 해당하는 경우, 회사는 회원자격을 제한 및 정지시킬 수 있습니다.
	① 가입 신청 시에 허위 내용을 등록한 경우 
	② 타인의 서비스 이용을 방해하거나 그 정보를 도용하는 등 서비스 운영질서를 위협하는 경우
	③ 서비스를 이용하여 법령과 이 약관이 금지하거나, 공서양속에 반하는 행위를 하는 경우
	④ 제 13조 에 명기된 회원의 의무사항을 준수하지 못할 경우
3. 회사가 회원자격을 제한/정지시킨 후, 동일한 행위가 2회 이상 반복되거나 30일 이내에 그 사유가 시정되지 아니하는 경우 회사는 회원자격을 상실 시킬 수 있습니다.
4. 회사가 회원자격을 상실 시키는 경우 회원에게 이를 통지하고 탈퇴를 처리합니다. 이 경우 회원에게 이를 통지하고, 탈퇴 전에 소명할 기회를 부여합니다.
 
 
■ 제 9조 (이용자에 대한 통지) 
1. 회사가 이용자에 대한 통지를 하는 경우, 이용자가 서비스에 제출한 전자우편 주소로 할 수 있습니다.
2. 회사가 불특정 다수 이용자에 대한 통지의 경우 1주일 이상 서비스 게시판에 게시함으로써 개별 통지에 갈음할 수 있습니다.
 
 
■ 제 10조 (개인 정보 보호) 
1. 회사는 이용자 정보 수집 시 회사측이 필요한 최소한의 정보를 수집합니다.
다음 사항을 필수사항으로 하며 그 외 사항은 선택사항으로 합니다.
	① 성명
	② 희망 ID
	③ 비밀번호
	④ E-mail
	⑤ 전화번호
	⑥ 이메일 구독 여부
2. 회사가 이용자의 개인식별이 가능한 개인정보를 수집하는 때에는 반드시 당해 이용자의 동의를 받습니다.
3. 제공된 개인정보는 당해 이용자의 동의 없이 제 3자에게 제공할 수 없으며, 이에 대한 모든 책임은 회사가 집니다. 다만 다음의 경우에는 예외로 합니다.
	① 회사는 관련법령 및 회사의 개인정보취급방침에 따라 회원의 개인정보를 수집 및 관리합니다.
	② 회원은 회사가 정하는 바에 따라 서비스 이용에 필요한 정보(개인정보 포함)를 사실에 부합하게 제공할 의무가 있으며, 허위의 사실을 기재하거나 타인명의를 도용하여 서비스를 신청한 경우 서비스 이용이 중단되거나 이용계약이 해지될 수 있습니다.
	③ 회사는 관련법률 규정에 의거 수사상 목적 등으로 국가기관의 요구가 있거나 방송통신위원회 및 한국인터넷진흥원 등의 요청이 있는 경우 관련 정보를 법률이 규정하는 범위 내에서 개인정보 등을 제공할 수 있습니다.
4. 이용자는 언제든지 회사가 가지고 있는 자신의 개인정보에 대해 열람 및 오류정정을 할 수 있습니다.
5. 회사로부터 개인정보를 제공받은 제 3자는 개인정보를 제공받은 목적을 달성한 때에는 당해 개인정보를 지체 없이 파기합니다.
 
 
■ 제 11조 (회사의 의무) 
1. 회사는 이 약관에서 정한 바에 따라 계속적, 안정적으로 서비스를 제공할 수 있도록 최선의 노력을 다하여야만 합니다.
2. 회사는 서비스에 관련된 설비를 항상 운용할 수 있는 상태로 유지/보수하고, 장애가 발생하는 경우 지체 없이 이를 수리/복구할 수 있도록 최선의 노력을 다하여야 합니다.
3. 회사는 이용자가 안전하게 서비스를 이용할 수 있도록 이용자의 개인정보보호를 위한 보안시스템을 갖추어야 합니다.
4. 회사는 이용자가 원하지 않는 영리목적의 광고성 전자우편을 발송하지 않습니다.
 
 
■ 제 12조 (회원의 ID 및 비밀번호에 대한 의무)
1. 회원에게 부여된 아이디(ID)와 비밀번호의 관리책임은 회원에게 있으며 관리 소홀, 부정사용에 의하여 발생하는 모든 결과에 대한 책임은 회원에게 있습니다.
 
2. 회원이 자신의 ID 및 비밀번호를 도난 당하거나 제 3자가 사용하고 있음을 인지한 경우에는 바로 회사에 통보하고 회사의 안내가 있는 경우에는 그에 따라야 합니다.
 
 
■ 제 13조 (회원의 의무) 
1. 회원은 관계법령, 본 약관의 규정, 이용안내 및 주의사항 등 회사가 통지하는 사항을 준수하여야 하며, 기타 회사의 업무에 방해되는 행위를 하여서는 안됩니다.
2. 회원은 회사의 사전승낙 없이 서비스를 이용하여 어떠한 영리행위도 할 수 없습니다.
3. 회원은 서비스를 이용하여 얻은 정보를 회사의 사전승낙 없이 복사, 복제, 변경, 번역, 출판/방송 기타의 방법으로 사용하거나 이를 타인에게 제공할 수 없습니다.
4. 회원은 자기 신상정보의 변경사항 발생시 즉각 변경하여야 합니다. 회원정보를 수정하지 않아 발생하는 모든 결과에 대한 책임은 회원에게 있습니다.
5. 회원은 서비스 이용과 관련하여 다음 각 호의 행위를 하지 않아야 하며, 다음 행위를 함으로 발생하는 모든 결과에 대한 책임은 회원에게 있습니다.
	① 다른 회원의 아이디(ID)를 부정하게 사용하는 행위
	② 다른 회원의 E-mail 주소를 취득하여 스팸메일을 발송하는 행위
	③ 범죄행위를 목적으로 하거나 기타 범죄행위와 관련된 행위
	④ 선량한 풍속, 기타 사회질서를 해하는 행위
	⑤ 회사 및 타인의 명예를 훼손하거나 모욕하는 행위
	⑥ 회사 및 타인의 지적재산권 등의 권리를 침해하는 행위
	⑦ 해킹행위 또는 컴퓨터 바이러스의 유포행위
	⑧ 타인의 의사에 반하여 광고성 정보 등 일정한 내용을 지속적으로 전송하는 행위
	⑨ 서비스의 안정적인 운영에 지장을 주거나 줄 우려가 있는 일체의 행위
	⑩ 회사가 제공하는 서비스의 내용을 변경하는 행위
	⑪ 기타 관계법령에 위배되는 행위
 

■ 제 14조 (게시물 삭제) 
1. 회사는 이용자가 게시하거나 등록하는 서비스내의 게시물이 제 13조의 규정에 위반되거나, 다음 각 호에 해당한다고 판단되는 경우 사전통지 없이 게시물을 삭제할 수 있습니다.
	① 다른 이용자 또는 제 3자를 비방하거나 중상모략으로 명예를 손상시키는 내용
	② 공공질서 또는 미풍양속에 위반되는 내용
	③ 범죄적 행위에 결부된다고 인정되는 내용
	④ 제 3자의 저작권 등 기타 권리를 침해하는 내용
	⑤ 서비스의 안정적인 운영에 지장을 주거나 줄 우려가 있는 내용
	⑥ 근거나 확인절차 없이 회사를 비난하거나 유언비어를 유포한 내용용
	⑦ 기타 관계법령에 의거하여 위반된다고 판단되는 내용
단, 독자게시판의 경우 다음과 같이 예외를 둔다.
용량이 큰 데이터의 경우 업로드 된 게시물의 수를 제한하며 그 수를 넘을 때에는 서버의 원활한 운영을 위해 가장 오래된 게시물부터 삭제할 수 있다.
2. 회사는 이용자가 게시하거나 등록하는 서비스내의 게시물이 제 13조의 규정에 위반되거나 동 조 제1항 각 호에 해당한다고 판단되는 정보를 링크하고 있을 경우 사전통지 없이 게시물을 삭제할 수 있습니다.
 
 
■ 제 15조 (게시물에 대한 권리 / 의무) 
게시물에 대한 저작권을 포함한 모든 권리 및 책임은 이를 게시한 이용자에게 있습니다.
 

■ 제 16조 (연결 &#034;홈페이지&#034;와 피연결 &#034;홈페이지&#034;간의 관계)
1. 상위 &#034;홈페이지&#034;와 하위 &#034;홈페이지&#034;가 하이퍼 링크(예:하이퍼 링크의 대상에는 문자, 그림 및 동화상 등이 포함됨) 방식 등으로 연결된 경우, 전자를 연결 &#034;홈페이지&#034;라고 하고 후자를 피연결 &#034;홈페이지(웹사이트)&#034;라고 합니다.
2. 연결 &#034;홈페이지&#034;는 피연결 &#034;홈페이지&#034;가 독자적으로 제공하는 재화ㆍ용역에 의하여 이용자와 행하는 거래에 대해서 보증책임을 지지 않습니다.
 
 
■ 제 17조 (저작권의 귀속 및 이용제한)
1. 회사가 작성한 저작물에 대한 저작권 및 기타 지적재산권은 회사에 귀속합니다.
2. 이용자는 서비스를 이용함으로써 얻은 정보를 회사의 사전승낙 없이 복제, 송신, 출판, 배포, 방송, 기타 방법에 의하여 영리목적으로 이용하거나 제 3자에게 이용하게 하여서는 안됩니다.
 
 
■ 제 18조 (양도금지) 
회원이 서비스의 이용권한, 기타 이용 계약상 지위를 타인에게 양도, 증여할 수 없으며, 이를 담보로 제공할 수 없습니다.
 

■ 제 19조 (손해배상) 
회사는 무료로 제공되는 서비스와 관련하여 이용자에게 어떠한 손해가 발생하더라도 동 손해가 회사의 중대한 과실에 의한 경우를 제외하고 이에 대하여 책임을 부여하지 아니합니다.
 

■ 제 20조 (면책 / 배상) 
1. 회사는 이용자가 서비스에 게재한 정보, 자료, 사실의 정확성, 신뢰성 등 그 내용에 관하여는 어떠한 책임을 부담하지 아니하고, 이용자는 자신의 책임아래 서비스를 이용하며, 서비스를 이용하여 게시 또는 전송한 자료 등에 관하여 손해가 발생하거나 자료의 취사선택, 기타 서비스 이용과 관련하여 어떠한 불이익이 발생하더라도 이에 대한 모든 책임은 이용자에게 있습니다.
2. 회사는 제 13조의 규정에 위반하여 이용자간 또는 이용자와 제 3자간에 서비스를 매개로 한 물품거래 등과 관련하여 어떠한 책임도 부담하지 아니하고, 이용자가 서비스의 이용과 관련하여 기대하는 이익에 관하여 책임을 부담하지 않습니다.
3. 이용자가 제 13조, 기타 이 약관의 규정을 위반함으로 인하여 회사가 이용자 또는 제 3자에 대하여 책임을 부담하게 되고, 이로써 회사에게 손해가 발생하게 되는 경우, 이 약관을 위반한 이용자는 회사에게 발생하는 모든 손해를 배상하여야 하며, 동 손해로부터 회사를 면책시켜야 합니다.
 
 
■ 제 21조 (분쟁의 해결) 
1. 회사와 이용자는 서비스와 관련하여 발생한 분쟁을 원만하게 해결하기 위하여 필요한 모든 노력을 하여야 합니다.
2. 제 1항의 규정에도 불구하고, 동 분쟁으로 인하여 소송이 제기될 경우 동 소송은 서울지방법원을 관할로 합니다.
3. 동 소송에는 대한민국 법을 적용합니다.

 
부칙 
(시행일) 이 약관은 2018년 2월 26일부터 시행됩니다.
2012 년 6 월 15일부터 시행되던 종래 약관은 본 약관으로 대체됩니다.</textarea>
        <fieldset class="fregister_agree">
            <label for="agree11">회원가입약관의 내용에 동의합니다.</label>
            <input type="checkbox" name="agree" id="agree11">
        </fieldset>
    </section>

    <section id="fregister_private">
        <h2><i class="fa fa-check" aria-hidden="true"></i> 개인정보처리방침안내</h2>
        <div>
            <table>
                <caption>개인정보처리방침안내</caption>
                <thead>
                <tr>
                    <th>목적</th>
                    <th>항목</th>
                    <th>보유기간</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>이용자 식별 및 본인여부 확인</td>
                    <td>아이디, 이름, 비밀번호</td>
                    <td>회원 탈퇴 시까지</td>
                </tr>
                <tr>
                    <td>고객서비스 이용에 관한 통지,<br>CS대응을 위한 이용자 식별</td>
                    <td>연락처 (이메일, 휴대전화번호)</td>
                    <td>회원 탈퇴 시까지</td>
                </tr>
                </tbody>
            </table>
        </div>

        <fieldset class="fregister_agree">
            <label for="agree21">개인정보처리방침안내의 내용에 동의합니다.</label>
            <input type="checkbox" name="agree2" id="agree21">
        </fieldset>
    </section>
		
		<div class="container" style="text-align: center">
	    <button type="button" class="btn-lg btn-secondary" onclick="fCheck()">회원가입</button>
	    <button type="reset" class="btn-lg btn-outline-secondary">다시작성</button>
	    <button type="button" class="btn-lg btn-outline-secondary" onclick="location.href='${ctp}/';">돌아가기</button>
	    <input type="hidden" name="email"/>
	    <input type="hidden" name="tel"/>
	    <!-- <input type="hidden" name="address"/>  위에 이미 있으니 생략 -->    
    </div>
   </form>
   
    <script>
    jQuery(function($){
        // 모두선택
        $("input[name=chk_all]").click(function() {
            if ($(this).prop('checked')) {
                $("input[name^=agree]").prop('checked', true);
            } else {
                $("input[name^=agree]").prop("checked", false);
            }
        });
    });

    </script>
   <p><br></p>
	</div>
	<br>
<!-- footer -->
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>