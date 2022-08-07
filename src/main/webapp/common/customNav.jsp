<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<jsp:include page="/include/bs4.jsp" />
<script>
	'use strict';
	function logoutCheck(flg) {
		if ('기업' == flg) parent.location.href = "${ctxPath}/customComp/customCompLogout";
		else if ('개인' == flg) parent.location.href = "${ctxPath}/customPerson/customPersonLogout";
	}
	function checkCustomCompDelete() {
		if (confirm('정말 탈퇴하겠습니까?')) {
			if (confirm('탈퇴 후 1개월간은 같은 아이디로 재가입할 수 없습니다.\n탈퇴하겠습니까?')) 
				location.href = '${ctxPath}/customComp/customCompDeletePract';
		}
	}
	function checkCustomPersonDelete() {
		if (confirm('정말 탈퇴하겠습니까?')) {
			if (confirm('탈퇴 후 1개월간은 같은 아이디로 재가입할 수 없습니다.\n탈퇴하겠습니까?')) 
				location.href = '${ctxPath}/customPerson/customPersonDeletePract';
		}
	}
</script>
<body class="bg-dark navbar-dark">
<nav class="navbar navbar-expand-sm">
	<c:if test="${empty sGradeCode || 'O' >= sGradeCode}">
  		<a class="navbar-brand" target="customContent" href="${ctxPath}/customComp/customCompLogin">Home</a>
	</c:if>
	<c:if test="${'P' <= sGradeCode}">
		<a class="navbar-brand" target="customContent" href="${ctxPath}/customPerson/customPersonLogin">Home</a>
	</c:if>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
      <span class="navbar-toggler-icon"></span>
    </button>
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
    <ul class="navbar-nav">
      <li class="nav-item font-weight-bold">
        <div class="dropdown ">
	        <a href="#" class="nav-link dropdown-toggle navbar-brand" data-toggle="dropdown">기업고객</a>
				<c:if test="${empty sGradeCode || 'O' < sGradeCode}">
				    <div class="dropdown-menu bg-dark">
				      <a class="dropdown-item  navbar-brand" target="customContent"  href="${ctxPath}/customComp/customCompLogin">기업고객 로그인</a>
				      <a class="dropdown-item  navbar-brand" target="customContent"  href="${ctxPath}/customComp/customCompEntry">기업고객 회원가입</a>
					</div>
				</c:if>
				<c:if test="${'O' >= sGradeCode}">
				    <div class="dropdown-menu bg-dark">
		 			  <a class="dropdown-item navbar-brand" target="customContent"  onclick='javascript:logoutCheck("기업")'>기업고객 로그아웃</a>
	 			    </div>
				</c:if>
		</div>
      </li>
      <li class="nav-item font-weight-bold">
        <div class="dropdown">
	        <a href="#" class="nav-link dropdown-toggle navbar-brand" data-toggle="dropdown">개인고객</a>
				<c:if test="${empty sGradeCode || 'P' > sGradeCode}">
				    <div class="dropdown-menu bg-dark">
				      <a class="dropdown-item  navbar-brand " target="customContent"  href="${ctxPath}/customPerson/customPersonLogin">개인고객 로그인</a>
				      <a class="dropdown-item  navbar-brand " target="customContent"  href="${ctxPath}/customPerson/customPersonEntry">개인고객 회원가입</a>
					</div>
				</c:if>
				<c:if test="${'P' <= sGradeCode}">
				    <div class="dropdown-menu bg-dark">
			 		  <a class="dropdown-item navbar-brand" target="customContent"  href="${ctxPath}/customPerson/customPersonLogout">개인고객 로그아웃</a>
					</div>
				</c:if>
		</div>
      </li>
	  <c:if test="${'O' >= sGradeCode}">
	      <li class="nav-item font-weight-bold">
	        <a href="#" class="nav-link dropdown-toggle navbar-brand" data-toggle="dropdown">MyPage</a>
	        <div class="dropdown">
			    <div class="dropdown-menu bg-dark">
			      <a class="dropdown-item navbar-brand" target="customContent"  href="${ctxPath}/customComp/customCompMain">기업고객 회원방</a>
			      <a class="dropdown-item navbar-brand" target="customContent"  href="${ctxPath}/customComp/customCompUpdate">고객정보변경</a>
			      <a class="dropdown-item navbar-brand" target="customContent"  href="${ctxPath}/customComp/customCompUpdatePwd">고객비밀번호변경</a>
			      <a class="dropdown-item navbar-brand" target="customContent"  href="${ctxPath}/customComp/qrCode">고객QR코드생성</a>
			      <a class="dropdown-item navbar-brand" target="customContent"  href="${ctxPath}/customComp/customCompMap">고객회사소개 (Map)</a>
			      <a class="dropdown-item navbar-brand" href="javascript:checkCustomCompDelete();">기업고객 회원탈퇴</a>
			    </div>
			</div>
	      </li>
	  </c:if>
	  <c:if test="${'P' <= sGradeCode}">
	      <li class="nav-item font-weight-bold">
	        <a href="#" class="nav-link dropdown-toggle navbar-brand" data-toggle="dropdown">MyPage</a>
	        <div class="dropdown">
			    <div class="dropdown-menu bg-dark">
			      <a class="dropdown-item navbar-brand" target="customContent"  href="${ctxPath}/customPerson/customPersonMain">개인고객 회원방</a>
			      <a class="dropdown-item navbar-brand" target="customContent"  href="${ctxPath}/customPerson/customPersonUpdate">회원정보변경</a>
			      <a class="dropdown-item navbar-brand" target="customContent"  href="${ctxPath}/customPerson/customPersonUpdatePwd">회원비밀번호변경</a>
			      <a class="dropdown-item navbar-brand" target="customContent"  href="${ctxPath}/customPerson/qrCode">회원QR코드생성</a>
			      <a class="dropdown-item navbar-brand" href="javascript:checkCustomPersonDelete();">회원탈퇴</a>
			    </div>
			</div>
	      </li>
	  </c:if>
    </ul>
    <a class="navbar-brand" target="_blank" href="${ctxPath}/admin/adminLogin">관리자페이지</a>
  </div>
</nav>
</body>