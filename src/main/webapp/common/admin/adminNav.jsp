<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<script>
	'use strict';
</script>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <c:if test="${'0' == sLevel && '관리자' == sLevelName}">
	<a class="navbar-brand" href="${ctxPath}/admin/adminIndex">Home</a>
	<div class="collapse navbar-collapse">
	  <ul class="navbar-nav">
	    <li class="nav-item font-weight-bold">
	      <div class="dropdown">
	      	<a href="#" class="nav-link dropdown-toggle navbar-brand" data-toggle="dropdown">기업회원관리</a>
		    <div class="dropdown-menu bg-dark">
				<a class="dropdown-item  navbar-brand" href="${ctxPath}/admin/customCompStats">기업회원통계</a>
				<a class="dropdown-item  navbar-brand" href="${ctxPath}/admin/customCompDeletePracList">기업회원탈퇴목록</a>
				<a class="dropdown-item  navbar-brand" href="${ctxPath}/admin/customCompGradeUpdateList">기업회원등급수정목록</a>
			</div>
		  </div>
	 	</li>
	    <li class="nav-item font-weight-bold">
	      <div class="dropdown">
	      	<a href="#" class="nav-link dropdown-toggle navbar-brand" data-toggle="dropdown">개인회원관리</a>
		    <div class="dropdown-menu bg-dark">
				<a class="dropdown-item  navbar-brand" href="${ctxPath}/admin/customPersonStats">개인회원통계</a>
				<a class="dropdown-item  navbar-brand" href="${ctxPath}/admin/customPersonDeletePracList">개인회원탈퇴목록</a>
				<a class="dropdown-item  navbar-brand" href="${ctxPath}/admin/customPersonGradeUpdateList">개인회원등급수정목록</a>
			</div>
		  </div>
	 	</li>
	    <li class="nav-item font-weight-bold">
	      <div class="dropdown">
	      	<a href="#" class="nav-link dropdown-toggle navbar-brand" data-toggle="dropdown">Pds관리</a>
		    <div class="dropdown-menu bg-dark">
				<a class="dropdown-item  navbar-brand" href="${ctxPath}/admin/">Pds설정</a>
				<a class="dropdown-item  navbar-brand" href="${ctxPath}/admin/">회원게시판통계설정</a>
			</div>
		  </div>
	 	</li>
	  </ul>
	</div>  
	<a class="navbar-brand" href="${ctxPath}/admin/adminLogout">관리자 로그아웃</a>
  </c:if>
  <c:if test="${empty sLevel || empty sLevelName || '0' != sLevel || '관리자' != sLevelName}">
	<a class="navbar-brand" href="${ctxPath}/admin/adminLogin">관리자 로그인</a>
  </c:if>
</nav>