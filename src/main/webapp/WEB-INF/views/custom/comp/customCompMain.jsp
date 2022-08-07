<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>customCompMain.jsp</title>
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
<body class="jumbotron"  background="${ctxPath}/images/bgimg.gif">
<p><br></p>
<div class="container">
	<h2>기 업 회 원 전 용 방</h2>
	<hr/>
	<table>
		<tr>
			<td width="50%">
				<div class="Light card" style="width:100%">
					  <div class="card-body" style="height:650px">
						    <h4 class="card-title"><span class="text-primary">${sCustomName}</span> 님 로그인 중입니다.</h4>
							<p class="card-text">현재 <span class="text-primary">${sGradeName}</span> 입니다</p>
							<p class="card-text">누적 포인트 : <span class="text-primary">${sPoint}</span> 점</p>
							<p class="card-text">최종 접속일 : <span class="text-primary">${fn:substring(sLoginDate, 0, 19)}</span> </p>
							<p class="card-text">총 방문횟수 : <span class="text-primary">${sVCnt}</span> 회</p>
							<p class="card-text">오늘 방문횟수 : <span class="text-primary">${sTodayVCnt}</span> 회</p>
					  </div>
				</div>
			</td>
			<td width="50%">
				<div class="Light card" style="width:100%">
					  <img class="card-img-bottom" src="${ctxPath}/custom/${photo}" alt="${sCustomName}님 프로필사진입니다" style="height:650px" />
				</div>
			</td>
		</tr>
	</table>
 </div>
<br><br><br><br><br><br><br><br><br><br><br><br><br>
<jsp:include page="/common/footer.jsp" />
</body>
</html>