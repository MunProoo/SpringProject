<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% pageContext.setAttribute("crcn", "\r\n"); //space,enter
   pageContext.setAttribute("br", "<br/>"); //br tag
%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>1대1문의</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
<style>
	 .cursor{
      cursor:pointer;
    }
</style>

<script>
   $(function($){
    $("[id^='title']").click(function(){
      idx = $(this).attr('id').replace("title",""); //idx를 뽑아옴
      var status = document.getElementById('status'+idx).value;
      var content = document.getElementById('content'+idx).value;
      var str = "";
      
    	if($("#td"+idx).length > 0){
    		$("#replytr"+idx).empty();
    		return false;
    	}
    	else{
        if(status=='답변대기중'){
          alert("곧 답변드리겠습니다.\n조금만 기다려주세요!");
        } 
	      str += "<td colspan='6' id='td"+idx+"'>Q : <br>";
	  		str += "<div class='textbox'><textArea rows='3' id='inqContent"+idx+"' style='width:100%;' class='form-control' readonly>"+content+"</textArea></div>";
				if(status=='답변완료'){
	      	 $.ajax({
	         	type : "post",
	         	url : "${ctp}/inquiry/inquiryAns",
	         	data : {
	         			idx : idx
	         	},
	         	success : function(data){
	         		str += "<hr style='clear:both;color:#ccc;'/>";
	         		data.ansContent = data.ansContent.replace(/(\n|\r\n)/g, '<br>');
	            str += "<div style='display:inline;float:left;margin-left:10px;width:100%;'>A : <br/>"+data.ansContent+"</div>";
	            data.rdate = data.rdate.substring(0,11);
	            str += "<div style='display:inline;float:right;margin-right:10px;margin-top:5px;test-align:right;'>답변등록일 : "+data.rdate+"</div>";
	            /* str += "</div>"; */     
				      str += "</td>";
				      $("#replytr"+idx).append(str);
	         	},
	         	error : function(){
	    				alert("처리 오류");
	    			}
	         });
	      }
				else{
					str += "</td>";
					$("#replytr"+idx).append(str);
				}
      }
    })
  })
  
  function inquiryUpdate(idx){
		var content = $("#inqContent"+idx).val();
		if($("#status"+idx).val()=="답변완료"){
			alert("답변이 완료된 문의는 수정하실 수 없습니다.");
			return false;
		}
		
  	if($("#inquiryUpdate"+idx).val()=="수정"){
  		if($("#inqContent"+idx).length >0 ){
				$("#inqContent"+idx).attr("readonly",false); 	 
	  		$("#inquiryUpdate"+idx).attr("value","완료");
  		}
  		else return false;
  	}
  	else{
  		$("#inqContent"+idx).attr("readonly",true); 	 
  		$("#inquiryUpdate"+idx).attr("value","수정");
			$.ajax({
				type : "post",
				url : "${ctp}/inquiry/inquiryUpdate",
				data : {
					idx : idx,
					content : content
				},
				success : function(){
					alert("문의내용이 수정되었습니다.");
					location.reload();
				},
				error : function(){
					alert("처리오류")
				}
			})  		
  	}
   }
   
   function inquiryDelete(idx){
  	 var ans = confirm("이 문의를 삭제하시겠습니까?");
  	 if(!ans) return false;
  	 
  	 if($("#status"+idx).val()=="답변완료"){
  		 alert("답변이 완료된 문의는 삭제하실 수 없습니다.");
  		 return false;
  	 }
  	 else{
  		 $.ajax({
  			 type : "post",
  			 url : "${ctp}/inquiry/deleteInquiry",
  			 data : {
  				 idxArr : idx
  			 },
  			 success : function(){
  				 alert("문의가 삭제되었습니다.")	;
  				 location.reload();
  			 },
  			 error : function(){
  				 alert("처리오류");
  			 }
  		 })
  	 }
  	 
   }
</script>
</head>

<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br></p>
	<div class="container">
		<div style="text-align:center;margin-bottom:20px;"><h2> 1 : 1 문의 목록</h2></div>
		<div style="text-align:right;">
     	<input type="button" value="문의하기" onClick="location.href='${ctp}/inquiry/inquiryInput'" class="btn btn-success"/>
    </div>
  <div style="border:1px solid #ccc;padding:20px;width:70%;margin:0 auto;">
    <table class="table table-bordered tb">
    <thead class="thead-light">
      <tr class="center">
        <th width="15%;">문의유형</th>
        <th>문의제목</th>
        <th width="15%;">진행상태</th>
        <th width="15%;">문의등록일</th>
        <th width="15%;">수정</th>
        <th width="15%;">삭제</th>
      </tr>
    </thead>
    <c:forEach var="vo" items="${vos}">
	    <tbody>
	      <tr class="center">
	        <td>${vo.category }</td>
	        <td style="text-align:left;" class="cursor">
	        	<p id="title${vo.idx}">${vo.title}
	        		<c:if test="${vo.diffTime <= 24}">
								<img src="${ctp}/images/new.gif" />
							</c:if> 
						</p>
					</td>
	        <td>${vo.status}</td>
	        <td>
						<c:if test="${vo.diffTime <= 24}">${fn:substring(vo.iDate,11,19)}</c:if>
						<c:if test="${vo.diffTime >  24}">${fn:substring(vo.iDate,0,10)}</c:if>
					</td>
					<td>
						<input type="button" value="수정" id="inquiryUpdate${vo.idx}" class="btn btn-info" onClick="inquiryUpdate(${vo.idx})">
					</td>
					<td>
						<input type="button" value="삭제" class="btn btn-danger" onClick="inquiryDelete(${vo.idx})">
					</td>
	      </tr>
	      <tr id="con">
	      </tr>
	    </tbody>
      <input type="hidden" id="status${vo.idx}" value="${vo.status}" />
      <input type="hidden" id="content${vo.idx}" value="${fn:escapeXml(vo.content)}" />
      <tr id="replytr${vo.idx}"></tr>
    </c:forEach>
    </table> 
   
  </div>
	</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>