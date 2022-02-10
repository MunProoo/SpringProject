<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>adContent</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
</head>

<body>
<p><br></p>
	<div class="container">
		<h2 style="text-align: center; color:#f725e2">관리자메뉴 메인화면</h2>
	  <hr/>
	  <table class="table table-hover table-striped table-bordered">
	  	<tr style="text-align: center">
	  		<th colspan="2">Musinsa 현황판(빠른이동)</th>
	  	</tr>
	  	<tr>
	  		<th>총 회원수</th>
	  		<td><a href="${ctp}/admin/adMemberList"><font color="red"><b>${totRecCnt}</b></font> 명</a></td>
	  	</tr>
	  	<tr>
	  		<th>새로운 가입자</th>
	  		<td><a href="${ctp}/admin/adMemberList?level=1"><font color="red"><b>${newMember}</b></font> 건</a></td>
	  	</tr>
	  	<tr>
	  		<th>탈퇴 신청중인 회원</th>
	  		<td><a href="${ctp}/admin/adMemberList?userDel=OK"><font color="red"><b>${delMembers}</b></font> 명 </a> </td>
	  	</tr>
	  	<tr>
	  		<th>답변을 기다리는 문의글</th>
	  		<td><a href="${ctp}/inquiry/inquiryAns?reply=답변대기중"><font color="red"><b>${newInquiry}</b></font> 건</a></td>
	  	</tr>
	  	<tr>
	  		<th>총 상품수</th>	  
	  		<td><a href="${ctp}/product/productDelete"><font color="red"><b>${products}</b></font> 개</a></td>		
	  	</tr>
	  	<tr>
	  		<th>총 주문건수</th>
	  		<td><a href="${ctp}/product/orderManagement"><font color="red"><b>${orderCnt }</b></font> 건</a></td>
	  	</tr>
	  	<tr>
			<th>총 매출액</th>	  		
	  		<td><a href="${ctp}/admin/chart"><font color="red"><b><fmt:formatNumber value='${sales}'/></b></font> 원 &nbsp;<br></a></td>
	  	</tr>
	  </table>
	  <hr/>
	</div>
</body>
</html>