<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<div class="container">
	<p>
		<a href="${ctxPath}/customComp/kakaoEx1" class="btn btn-primary">마커표시/DB저장</a>&nbsp;
		<a href="${ctxPath}/customComp/kakaoEx2" class="btn btn-primary">DB저장된 지명검색/삭제</a>&nbsp;
		<a href="${ctxPath}/customComp/kakaoEx3" class="btn btn-primary">지명검색</a>&nbsp;
		<a href="${ctxPath}/customComp/kakaoEx4" class="btn btn-primary">카테고리별 장소검색(DB)</a>
	</p>
</div>