<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<head>
	<meta charset="UTF-8">
	<title>판매 차트</title>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
<script>
google.charts.load('current', {'packages':['corechart'] }  );

google.charts.setOnLoadCallback(graph1);
google.charts.setOnLoadCallback(graph2);
google.charts.setOnLoadCallback(graph3);
 
  function graph1(){
  	var data = google.visualization.arrayToDataTable(
  			${strSales}
    );
  	var options = {
  			title: '카테고리 별 판매량'
    };
  	var chart = new google.visualization.PieChart(document.getElementById('piechart'));

    chart.draw(data, options);
  }
  function graph2(){
  	var data = google.visualization.arrayToDataTable(
      	${strSalesPrice}	
    );
  	var options = {
      	title: '상품 별 판매량'
    };
  	var chart = new google.visualization.ColumnChart(document.getElementById('SalesPrice'));

    chart.draw(data, options);
  }
  
  function graph3(){
  	var data = google.visualization.arrayToDataTable(
      	${strSalesDate}	
    );
  	var options = {
      	title: '일 별 판매 그래프'
    };
  	var chart = new google.visualization.ColumnChart(document.getElementById('SalesDate'));

    chart.draw(data, options);
  }
  
</script>

</head>

<body>
<div class="container">
<p><br></p>
	<h2 style="text-align: center">판매 현황</h2>

	<div id="SalesDate" style="width: 900px; height: 500px;"></div>
	<div id="piechart" style="width: 900px; height: 500px;"></div>
	<hr style="border: solid 5px grey"> 
	<div id="SalesPrice" style="width: 900px; height: 500px;"></div>
	<hr style="border: solid 5px grey">
   </div>
</body>
</html>