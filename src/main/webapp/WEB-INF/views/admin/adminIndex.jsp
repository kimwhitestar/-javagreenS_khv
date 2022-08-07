<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>javagreenS_khv 물류정보시스템 관리자 홈화면</title>
  <jsp:include page="/include/bs4.jsp" />
  <style>
  .dashimg {
    height: 300px;
    background: #ddd;
  }
  .date {
  	width: 120px;
  }
  </style>
</head>
<body>

<jsp:include page="/common/admin/header_home.jsp" />
<jsp:include page="/common/admin/adminNav.jsp" />
<div class="container" style="margin-top:30px">
	<div class="row">
		<div class="col-sm-4">
			<h3 class="p-2 text-left">기업고객 최근접속회원</h3>
			<h6 class="text-left">최근에 접속한 회원 명단</h6>
			<div class="dashimg">
				<table class="table table-bordered text-center m-0">
					<tr class="text-white w3-blue-grey">
						<th>아이디</th>
						<th>고객명</th>
						<th class="date">날짜</th>
					</tr>
 					<c:forEach var="vo" items="${compRecentlyLoginVoList}">
						<tr>
							<td>${vo.loginId}</td>
							<td>${fn:substring(vo.customNameShort, 0, 6)}..</td>
							<td>${fn:substring(vo.loginDate, 0, 10)}</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<hr class="d-sm-none">
			<h3 class="text-left p-2">개인고객 최근접속회원</h3>
			<h6 class="text-left">최근에 접속한 회원 명단</h6>
			<div class="dashimg">
				<table class="table table-bordered text-center m-0">
					<tr class="text-white w3-blue-grey">
						<th>아이디</th>
						<th>고객명</th>
						<th class="date">날짜</th>
					</tr>
 					<c:forEach var="vo" items="${personRecentlyLoginVoList}">
						<tr>
							<td>${vo.loginId}</td>
							<td>${fn:substring(vo.customName, 0, 6)}..</td>
							<td>${fn:substring(vo.loginDate, 0, 10)}</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<hr class="d-sm-none">
		</div>
	    <div class="col-sm-4">
			<h3 class="p-2 text-left">기업고객 신규가입회원</h3>
			<h6 class="text-left">최근에 가입한 회원 명단</h6>
			<div class="dashimg">
				<table class="table table-bordered text-center m-0">
					<tr class="text-white w3-blue-grey">
						<th>아이디</th>
						<th>고객명</th>
						<th class="date">날짜</th>
					</tr>
 					<c:forEach var="vo" items="${compRecentlyEntryVoList}">
						<tr>
							<td>${vo.loginId}</td>
							<td>${fn:substring(vo.customNameShort, 0, 6)}..</td>
							<td>${fn:substring(vo.createDate, 0, 10)}</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<hr class="d-sm-none">
			<h3 class="text-left p-2">개인고객 신규가입회원</h3>
			<h6 class="text-left">최근에 가입한 회원 명단</h6>
			<div class="dashimg">
				<table class="table table-bordered text-center m-0">
					<tr class="text-white w3-blue-grey">
						<th>아이디</th>
						<th>고객명</th>
						<th class="date">날짜</th>
					</tr>
 					<c:forEach var="vo" items="${personRecentlyEntryVoList}">
						<tr>
							<td>${vo.loginId}</td>
							<td>${fn:substring(vo.customName, 0, 6)}..</td>
							<td>${fn:substring(vo.createDate, 0, 10)}</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	    <div class="col-sm-4">
			<h3 class="p-2 text-left">기업고객 탈퇴회원</h3>
			<h6 class="text-left">최근에 탈퇴한 회원 명단</h6>
			<div class="dashimg">
				<table class="table table-bordered text-center m-0">
					<tr class="text-white w3-blue-grey">
						<th>아이디</th>
						<th>고객명</th>
						<th class="date">날짜</th>
					</tr>
 					<c:forEach var="vo" items="${compPracDeleteVoList}">
						<tr>
							<td>${vo.loginId}</td>
							<td>${fn:substring(vo.customNameShort, 0, 6)}..</td>
							<td>${fn:substring(vo.deleteDate, 0, 10)}</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<hr class="d-sm-none">
			<h3 class="text-left p-2">개인고객 탈퇴회원</h3>
			<h6 class="text-left">최근에 탈퇴한 회원 명단</h6>
			<div class="dashimg">
				<table class="table table-bordered text-center m-0">
					<tr class="text-white w3-blue-grey">
						<th>아이디</th>
						<th>고객명</th>
						<th class="date">날짜</th>
					</tr>
 					<c:forEach var="vo" items="${personPracDeleteVoList}">
						<tr>
							<td>${vo.loginId}</td>
							<td>${fn:substring(vo.customName, 0, 6)}..</td>
							<td>${fn:substring(vo.deleteDate, 0, 10)}</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
</div>
<br><br>
<jsp:include page="/common/admin/footer.jsp" />
</body>
</html>