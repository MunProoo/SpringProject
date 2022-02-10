<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>adMemberList</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
</head>
<script>
	// 아이디로 회원 검색
	function midSearch(){
		var mid = adminForm.mid.value;
		if(mid == ""){
			alert("아이디를 입력하세요");
			adminForm.mid.focus();
		}
		else{
			location.href="${ctp}/admin/adMemberList?mid="+mid;
		}
	}
	
	// 회원 등급별 검색
	function levelSearch(){
		var level = adminForm.level.value;
		location.href="${ctp}/admin/adMemberList?level="+level;
	}
	
	// 회원등급 변경
	function levelChange(obj){
		var ans = confirm('회원등급을 변경하시겠습니까?');
		if (!ans){
			location.reload();
			return false;
		}
		else{
			var str = $(obj).val();
			var query = {
					idx : str.substring(1),
					level : str.substring(0,1)
			}
			
			$.ajax({
				type : "post",
				url : "${ctp}/admin/adMemberLevel",
				data : query,
				error : function(){
					alert("처리 오류");
				}
			});
		}
	}
	
	// 회원 탈퇴처리 (정보삭제)
	function memberDelete(idx){
		var ans = confirm('탈퇴처리 하시겠습니까?');
		if(!ans) return false;
		
		$.ajax({
			type : "post",
			url : "${ctp}/admin/adMemberDelete",
			data : {
				idx : idx
			},
			success : function(){
				alert("탈퇴처리 되었습니다.");
			},
			error : function(){
				alert("처리오류");
			}
		})
	}

</script>

<body>
<p><br></p>
	<div class="container">
		<form name="adminForm">      
	  <table class="table table-borderless m-0">
	    <tr>
	      <td colspan="2">
	        <c:choose>
	          <c:when test="${level==99}"><c:set var="title" value="전체"/></c:when>
	          <c:when test="${level==1}"><c:set var="title" value="정"/></c:when>
	          <c:when test="${level==2}"><c:set var="title" value="우수"/></c:when>
	          <c:when test="${level==3}"><c:set var="title" value="특별"/></c:when>
	        </c:choose>
	        <c:if test="${!empty mid}"><c:set var="title" value="${mid}"/></c:if>
	        <h2 style="text-align:center;"><font color="blue">${title} 회원</font> 리스트 (총 : <font color="red">${totRecCnt}</font>건)</h2>
	      </td>
	    </tr>
	    <tr>
	      <td style="text-align:left">
	        <input type="text" name="mid" value="${mid}" placeholder="검색할아이디입력"/>
	        <input type="button" value="개별검색" onclick="midSearch()"/>
	        <input type="button" value="전체보기" onclick="location.href='${ctp}/admin/adMemberList';" class="btn btn-secondary btn-sm"/>
	      </td>
	      <td style="text-align:right">회원등급  
	        <select name="level" onchange="levelSearch()">
	          <option value="99" <c:if test="${level==99}">selected</c:if>>전체회원</option>
	          <option value="1" <c:if test="${level==1}">selected</c:if>>정회원</option>
	          <option value="2" <c:if test="${level==2}">selected</c:if>>우수회원</option>
	          <option value="3" <c:if test="${level==3}">selected</c:if>>특별회원</option>
	          <option value="0" <c:if test="${level==0}">selected</c:if>>관리자</option>
	        </select>
	      </td>
	    </tr>
	  </table>
  </form>
  <table class="table table-hover">
    <tr class="table-dark text-dark text-center">
      <th>번호</th>
      <th>아이디</th>
      <th>별명</th>
      <th>성명</th>
      <th>성별</th>
      <th>등급</th>
      <th>탈퇴유무</th>
    </tr>
    <c:forEach var="vo" items="${vos}">
    	<tr class="text-center">
    	  <td>${curScrStrarNo}</td>
    	  <td><a href="${ctp}/admin/adMemberInfo?idx=${vo.idx}">${vo.mid}</a></td>
    	  <td>${vo.nickName}</td>
    	  <td>
    	    ${vo.name}
    	  </td>
    	  <td>${vo.gender}</td>
    	  <td>
  	      <select name="level" onchange="levelChange(this)">
  	        <option value="1${vo.idx}" <c:if test="${vo.level==1}">selected</c:if>>정회원</option>
  	        <option value="2${vo.idx}" <c:if test="${vo.level==2}">selected</c:if>>우수회원</option>
  	        <option value="3${vo.idx}" <c:if test="${vo.level==3}">selected</c:if>>특별회원</option>
  	        <option value="0${vo.idx}" <c:if test="${vo.level==0}">selected</c:if>>관리자</option>
  	      </select>
    	  </td>
    	  <td>
    	    <c:if test="${vo.userDel=='OK'}"><a href="javascript:memberDelete(${vo.idx})"><font color=red>탈퇴신청</font></a></c:if>
    	    <c:if test="${vo.userDel!='OK'}">활동중</c:if>
    	  </td>
    	</tr>
    	<c:set var="curScrStrarNo" value="${curScrStrarNo - 1}"/>
    </c:forEach>
  </table>
  <br/>
  
<!-- 페이징처리 시작 -->
<c:if test="${totPage == 0}"><p style="text-align:center"><font color="red"><b>자료가 없습니다.</b></font></p></c:if>
<c:if test="${totPage != 0}">
	<div style="text-align:center">
	  <c:if test="${pag != 1}"><a href="${ctp}/admin/adMemberList?pag=1&level=${level}">◁◁</a></c:if> &nbsp;&nbsp;
	  <c:if test="${pag > 1}"><a href="${ctp}/admin/adMemberList?pag=${pag-1}&level=${level}">◀</a></c:if>
	  &nbsp;&nbsp; ${pag}Page / ${totPage}pages &nbsp;&nbsp;
	  <c:if test="${pag < totPage}"><a href="${ctp}/admin/adMemberList?pag=${pag+1}&level=${level}">▶</a></c:if> &nbsp;&nbsp;
	  <c:if test="${pag != totPage}"><a href="${ctp}/admin/adMemberList?pag=${totPage}&level=${level}">▷▷</a></c:if>
	</div>
</c:if>
<!-- 페이징처리 끝 -->
		
	</div>
</body>
</html>