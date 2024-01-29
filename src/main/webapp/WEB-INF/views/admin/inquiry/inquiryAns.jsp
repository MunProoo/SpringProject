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
	<title>1대1문의 답변등록</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
 <style>
  .lineheight{
    line-height: 50px;
  }  
  
  .vtd{
    vertical-align:middle;
  }  

  .textbox{
    width:83%;
    clear:both;
    float:left;
    margin-right:20px;
  }
  
 </style>

<script>
   $(function($){
    $("[id^='btn']").click(function(){
      let idx = $(this).attr('id').replace("btn",""); //idx를 뽑아옴
      var reply = document.getElementById('reply'+idx).value;
      var content = document.getElementById('content'+idx).value;
      var str = "";
      
      if($("#td"+idx).length > 0){
    		$("#replytr"+idx).empty();
    		return false;
    	}
      
      else {
	      str += "<td colspan='6' id='td"+idx+"'>";
	      str += "<form method='post' action='${ctp}/inquiry/answerInput'>";
	  		str += "<div style='display:inline;float:left;margin-left:10px;margin-bottom:10px;width:80%;'>Q : <br/>"+content+"</div>";
	      
				if(reply=='답변대기중'){
	        str += "<div class='textbox'><textarea class='form-control' rows='3' id='ansContent'"+idx+" name='ansContent' required></textarea></div>";
					str += "<input type='hidden' value='"+idx+"' name='idx' id='idx'>"
	        str += "<div style='float:left;width:5%;'><input type='submit' value='답변등록' class='btn btn-info' /></div>";
	        /* str += "</div>"; */     
					str += "</form></td>";
		      
		      $("#replytr"+idx).append(str);
		      return false;
	      }
				else if(reply=='답변완료'){
	      	
	      	 $.ajax({
	         	type : "post",
	         	url : "${ctp}/inquiry/inquiryAns",
	         	data : {
	         			idx : idx
	         	},
	         	success : function(data){
	         		str += "<hr style='clear:both;color:#ccc;'/>";
	         	 	//data.ansContent = data.ansContent.replace(/(\n|\r\n)/g, '<br>');
	         		data.rdate = data.rdate.substring(0,11);
	            //str += "<div style='display:inline;float:left;margin-left:10px;width:100%;'>A : <br/>"+data.ansContent+" <p><br></p>답변완료일 : "+data.rdate+"</div>";
	            str += "<div class='textbox'><textArea rows='3' id='ansContent"+idx+"' style='width:100%;' class='form-control' readonly>"+data.ansContent+"</textArea><br><p>답변일 : "+data.rdate+"</p></div>"
	            str += "<div style='float:left;width:5%;'><input type='button' id='ansBtn"+idx+"' value='답변수정' onClick='ansBtn("+idx+")' class='btn btn-info' /></div>";
				      str += "</form></td>";
 
				      $("#replytr"+idx).append(str);
	         	},
	         	error : function(){
	    				alert("처리 오류");
	    			}
	         });
	      	 return false;
	      }
      }
    })
    
  })
  
  // 맨처음 들어오는 버튼이름 : 답변수정
  
  function ansBtn(idx2){
  	var ansContent = $("#ansContent"+idx2).val();
  	
  	if($("#ansBtn"+idx2).val()== "답변수정"){
  		if($("#ansContent"+idx2).length >0 ){
	  		$("#ansContent"+idx2).attr("readonly",false);
	  		$("#ansBtn"+idx2).attr("value","수정완료");
  		}
  		else{
  			return false;
  		}
  	}
  	else{
  		$("#ansContent"+idx2).attr("readonly",true);
  		$("#ansBtn"+idx2).attr("value","답변수정");
  		$.ajax({
				type : "post",
				url : "${ctp}/inquiry/inquiryAnsUpdate",
				data : {
					inquiryIdx : idx2,
					ansContent : ansContent
				},
				success : function(){
					alert("문의답변이 수정되었습니다.");
					location.reload();
				},
				error : function(){
					alert("처리오류")
				}
			})  		
  	}
	}
  
  
	function flagCheck(){
      var reply = document.myform.reply.value;
      location.href="${ctp}/inquiry/inquiryAns?reply="+reply;
	}  
  
  $(function($){
	  //하나라도 체크 풀을시 전체선택도 해제
  	$("input[name^=deletecheck]").click(function(){
  		if(!$(this).prop('checked')){
  			$('input[name=allCheck]').prop('checked',false);
  		}
  	});
  	
  	// 1:1 문의 삭제
  	$("input[name=deleteInquiry]").click(function(){
  		var ans = confirm("선택한 문의를 삭제하시겠습니까?");
      if(!ans) return false;
      
  		const query = 'input[name^="deletecheck"]:checked';
  		const selectedEls = document.querySelectorAll(query);
  		var idxArr = "";
  		
  		selectedEls.forEach((el) => {
        idxArr += el.value + '/';
      });
  		
  		if(idxArr == ""){
  			alert("삭제하실 문의를 선택하세요");
  		}
  		else{
  			$.ajax({
  				type: "post",
  				url: "${ctp}/inquiry/deleteInquiry",
  				data : {
  					idxArr : idxArr
  				},
  				success : function(){
  					alert("문의내용이 삭제되었습니다.");
  					location.reload();
  				},
  				error : function(){
  					alert("처리 오류!");
  				}
  			});
  		}
  	});
	  
	  
  });
  
  //전체선택
  jQuery(function($){
    $("input[name=allCheck]").click(function() {
        if ($(this).prop('checked')) {
            $("input[name^=deletecheck]").prop('checked', true);
        } else {
            $("input[name^=deletecheck]").prop("checked", false);
        }
    });
});
  </script>
</head>

<body>
<p><br></p>
	<div class="container">
		<h2 style="text-align: center">1:1 문의 답변등록</h2>
		
  <div style="display:inline;float:left;margin-bottom:10px;">
    <input type="button" class="btn btn-info" name="deleteInquiry" value="선택한 문의삭제" />
  </div>  
  <div style="float:right;">
  <form name="myform" class="form-inline">
    <span>답변상태</span>&nbsp;&nbsp;&nbsp;
    <select name="reply" onchange="flagCheck()" class="form-control">
      <option value="전체" <c:if test="${reply=='전체'}">selected </c:if>>전체</option>
      <option value="답변완료" <c:if test="${reply=='답변완료'}">selected </c:if>>답변완료</option>
      <option value="답변대기중" <c:if test="${reply=='답변대기중'}">selected </c:if>>답변대기중</option>
    </select>
  </form>
  </div>
  <p><br/></p>


  <!-- 상품문의목록 -->
  <div style="margin-top:30px;">
    <table class="table table-hover">
      <thead>
        <tr align="center">
          <th><label for="allCheck" style="cursor:pointer">전체&nbsp;<input type="checkbox" name="allCheck" id="allCheck" /></label></th>
<!--           <th>번호</th> -->
          <th>닉네임</th>
          <th>문의 유형</th>
          <th>문의 제목</th>
          <th>작성일</th>
          <th>답변 상태</th>
        </tr>
      </thead>
      <tbody>
      	<c:forEach var="inquiryVo" items="${inquiryVos}" varStatus="cnt">
        	<tr align="center">
	          <td class="vtd"><span class="lineheight"><input type="checkbox" value="${inquiryVo.idx}" name="deletecheck" id="deletecheck" /></span></td>
	          <!-- <td class="vtd"><span class="lineheight">13</span></td> -->
	          <td class="vtd"><span class="lineheight">${inquiryVo.nickName}</span></td>
	          <td class="vtd"><span class="lineheight">${inquiryVo.category}</span></td>
	          <td class="vtd"><span class="lineheight">${inquiryVo.title}</span></td>
	          <td class="vtd"><span class="lineheight">${fn:substring(inquiryVo.iDate,0,10)}</span></td>
	          <td>
	          	<div style="padding:5px;">
	          		<button class="btn btn-warning btn-sm" id="btn${inquiryVo.idx}">${inquiryVo.status}</button>
	          	</div>
	          </td>
        	</tr>
        <tr id="replytr${inquiryVo.idx}">
        </tr>
        	<c:set var="content" value="${fn:replace(inquiryVo.content ,crcn ,br)}" />
          <input type="hidden" id="content${inquiryVo.idx}" value="${fn:escapeXml(content)}" /><!-- <c:out value="${inquiryVo.content}" /> -->
          <input type="hidden" id="reply${inquiryVo.idx}" value="${inquiryVo.status}"/>
      </c:forEach>
      </tbody>
    </table>
  </div>
  
	</div>
</body>
</html>