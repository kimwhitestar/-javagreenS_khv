<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>기업고객 통계</title>
  <jsp:include page="/include/bs4.jsp" />
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <script>
  	'use strict';
	window.onload = function() {
		$.ajax({
			type: 		"post",
			url: 		"${ctxPath}/admin/customCompStats",
			success:	function(statsCompArr) {
 				drawPieChart(listToArrayOfPieAndArea(statsCompArr[0], '년도'), '기업고객 년별 가입회원 통계', "piechart_3d_0");
  				drawPieChart(listToArrayOfPieAndArea(statsCompArr[1], '고객구분'), '기업고객 고객구분별 가입회원 통계', "piechart_3d_1");
				drawPieChart(listToArrayOfPieAndArea(statsCompArr[2], '고객등급'), '기업고객 고객등급별 가입회원 통계', "piechart_3d_2");
 				drawPieChart(listToArrayOfPieAndArea(statsCompArr[3], '년도'), '기업고객 년월별 삭제회원 통계', "piechart_3d_3");
				drawPieChart(listToArrayOfPieAndArea(statsCompArr[4], '고객구분'), '기업고객 고객구분별 삭제회원 통계', "piechart_3d_4");
				drawPieChart(listToArrayOfPieAndArea(statsCompArr[5], '고객등급'), '기업고객 고객등급별 삭제회원 통계', "piechart_3d_5");
 				drawAreaChart(listToArrayOfPieAndArea(statsCompArr[6], '가입삭제구분'), '기업고객 고객구분별 가입회원 통계', '고객구분별', "areachart_6");
 				drawAreaChart(listToArrayOfPieAndArea(statsCompArr[7], '가입삭제등급'), '기업고객 고객등급별 가입회원 통계', '고객등급별', "areachart_7");
  			},
			error:		function() {
				alert('요청 오류~~');
			}
		});
	}
    google.charts.load('current', {'packages':['corechart', 'gantt']});
    
	google.charts.setOnLoadCallback(drawAreaChart);
    function drawAreaChart(voArr, title, division, chartId) {
      let data = google.visualization.arrayToDataTable(voArr);
      let options = {
        title: title,
        hAxis: {title: division,  titleTextStyle: {color: '#333'}},
        vAxis: {minValue: 0}
      };
      let chart = new google.visualization.AreaChart(document.getElementById(chartId));
      chart.draw(data, options);
    }
    
	
    
    google.charts.setOnLoadCallback(drawPieChart);
    function drawPieChart(voArr, title, chartId) {
      let data = google.visualization.arrayToDataTable(voArr);
      let options = {
    	title: title,
        is3D: true
	  };
      let chart = new google.visualization.PieChart(document.getElementById(chartId));
      chart.draw(data, options);
    }
    
 	let listToArrayOfPieAndArea = function(list, division) {
		let voArr = [list.length];
		
	    if ('고객구분' == division) {
		    voArr[0] = [ '고객구분', '수' ];
		    
			for (let i=0; i<list.length; i++) {
				let vo = list[i];
				voArr[i+1] = [vo.customKindNm, vo.cnt];
			}
			
	    } else if ('고객등급' == division) {
		    voArr[0] = [ '고객등급', '수' ];
		    
			for (let i=0; i<list.length; i++) {
				let vo = list[i];
				voArr[i+1] = [vo.gradeName, vo.cnt];
			}
			
	    } else if ('년도' == division) {
		    voArr[0] = [ '년도', '수' ];
		    
			for (let i=0; i<list.length; i++) {
				let vo = list[i];
				voArr[i+1] = [vo.yyyy, vo.cnt];
			}
			
	    } else if ('가입삭제구분' == division) {
		    voArr[0] = [ '고객구분명', '회원가입', '회원삭제' ];
		    
			for (let i=0; i<list.length; i++) {
				let vo = list[i];
				voArr[i+1] = [vo.customKindNm, vo.entryCnt, vo.deleteCnt];
			}
			
	    } else if ('가입삭제등급' == division) {
		    
	    	voArr[0] = [ '고객등급명', '회원가입', '회원삭제' ];
		    
			for (let i=0; i<list.length; i++) {
				let vo = list[i];
				voArr[i+1] = [vo.gradeName, vo.entryCnt, vo.deleteCnt];
			}
			
	    }
		return voArr;
	}   	
  
  </script>
  <style>
  .dashImg {
    height: 358px;
    background: #ddd;
  }
  </style>
</head>

<body>

  <jsp:include page="/common/admin/header_home.jsp" />
  <jsp:include page="/common/admin/adminNav.jsp" />

  <p><br></p>
  <div class="container">
  	<h3 class="ml-4">기업고객 통계</h3>
	<hr class="ml-4 mr-4 d-sm-1">
  	<div class="row m-2 text-center">
  		<div class="col">
  			<div class="dashImg">
  				<div id="piechart_3d_0" style="width:300px; height:340px" class="table table-noborder ml-3 pt-3"></div>
  			</div>
			<br>
  			<div class="dashImg">
				<div id="piechart_3d_3" style="width:300px; height:340px" class="table table-noborder ml-3 pt-3"></div>
  			</div>
  		</div>
  		<div class="col">
  			<div class="dashImg">
			  	<div id="piechart_3d_1" style="width:300px; height:340px" class="table table-noborder ml-3 pt-3"></div>
  			</div>
			<br>
  			<div class="dashImg">
  			
				<div id="piechart_3d_4" style="width:300px; height:340px" class="table table-noborder ml-3 pt-3"></div>
 			</div>
  		</div>
  		<div class="col">
  			<div class="dashImg">
  			
			  	<div id="piechart_3d_2" style="width:300px; height:340px" class="table table-noborder ml-3 pt-3"></div>
  			</div>
			<br>
  			<div class="dashImg">
				<div id="piechart_3d_5" style="width:300px; height:340px" class="table table-noborder ml-3 pt-3"></div>
 			</div>
  		</div>
	</div>	  	
  	<div class="row m-2 mt-4 text-center">
  	
  		<div class="col">
  			<div class="dashImg">
			  	<div id="areachart_6" style="width:478px; height:340px" class="table table-noborder ml-3 pt-3"></div>
  			</div>
  		</div>
  		<div class="col">
  			<div class="dashImg">
			  	<div id="areachart_7" style="width:478px; height:340px" class="table table-noborder ml-3 pt-3"></div>
  			</div>
  		</div>
	</div>	  	
	
  
  

   
   
   
   
  
  </div> 
  <jsp:include page="/common/admin/footer.jsp"/>
</body>
</html>