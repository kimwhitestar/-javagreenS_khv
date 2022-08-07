<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>customPersonMain.jsp</title>
  	<jsp:include page="/include/bs4.jsp" />
    <style></style>
    <script>
    	'use strict';
    	//윈도우 onload
    	$(document).ready(function(){
    		parent.customLeft.location.reload(true);
    	});
    </script>
</head>
<body class="jumbotron"  background="${ctxPath}/images/bgimg.gif" >
<p><br></p>
<div class="container">
	<h2>개 인 회 원 전 용 방</h2>
	<hr/>
	<p><font color="blue">${sCustomName}</font> 님 로그인 중입니다.</p>
	<p>현재 <font color="red">${sGradeName}</font> 입니다</p>
	<p>누적 포인트 : <font color="blue">${sPoint}</font> 점</p>
	<p>최종 접속일 : <font color="blue">${fn:substring(sLoginDate, 0, 19)}</font> </p>
	<p>총 방문횟수 : <font color="blue">${sVCnt}</font> 회</p>
	<p>오늘 방문횟수 : <font color="blue">${sTodayVCnt}</font> 회</p>
</div>
<br><br><br><br><br><br><br><br><br><br><br><br><br>
<jsp:include page="/common/footer.jsp" />
</body>
</html>