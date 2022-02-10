<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>오시는길</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
<style type="text/css">
	.mapss{
		display: flex;
		justify-content: center;
	}
</style>
</head>

<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br></p>
		<h2 style="text-align: center">MUSINSA 오시는 길</h2>
		<div class="container mapss" >
		<p><br></p>
				<!-- * 카카오맵 - 지도퍼가기 -->
		<!-- 1. 지도 노드 -->
		<div id="daumRoughmapContainer1644047085576" class="root_daum_roughmap root_daum_roughmap_landing"></div>
		
		<!--
			2. 설치 스크립트
			* 지도 퍼가기 서비스를 2개 이상 넣을 경우, 설치 스크립트는 하나만 삽입합니다.
		-->
		<script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
		
		<!-- 3. 실행 스크립트 -->
		<script charset="UTF-8">
			new daum.roughmap.Lander({
				"timestamp" : "1644047085576",
				"key" : "29zwo",
				"mapWidth" : "700",
				"mapHeight" : "500"
			}).render();
		</script>
	</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>