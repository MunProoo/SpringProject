<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>productList</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
</head>

<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br></p>
	<div class="container" >
	  <hr/>
	  <c:set var="mainName" value="(${categoryMainName})"/>
	  <h3 style="text-align: center">상 품 ${mainName } 리 스 트</h3>
	  <hr/>
  <c:set var="cnt" value="0"/>
  <div class="row mt-3">
    <c:forEach var="vo" items="${vos}">
      <div class="col-md-4">
        <div style="text-align:center">
          <a href="${ctp}/product/productContent?idx=${vo.idx}">
            <img src="${ctp}/product/${vo.FSName}" width="200px" height="180px"/>
            	<p><font size="2">${vo.productName}</font></p>
            	<p><font size="2">${vo.detail}</font></p>
            	<p><font size="2" color="orange"><fmt:formatNumber value="${vo.mainPrice}" pattern="#,###"/>원</font></p>	
          </a>
        </div>
      </div>
<%--       <c:set var="cnt" value="${cnt+1}"/>
      <c:if test="${cnt%3 == 0}">

      </c:if> --%>
    </c:forEach>
    <div class="container" style="text-align: center">
      <c:if test="${fn:length(vos) == 0}"><h3>제품 준비 중입니다.</h3></c:if>
    </div>
  </div>
  <br/>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>