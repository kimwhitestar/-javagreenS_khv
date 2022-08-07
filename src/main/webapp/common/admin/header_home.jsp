<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<jsp:include page="/include/bs4.jsp" />

<header class="w3-display-container w3-content w3-wide" style="max-width:100%;max-height:30%" >
  <img class="w3-image" src="${ctxPath}/images/w3images/architect.jpg" alt="Architecture" style="width:100%;height:250px">
  <div class="w3-display-middle w3-margin-top w3-center">
    <h1 class="w3-xxlarge w3-text-white"><span class="w3-padding w3-black w3-opacity-min"><b>javagreenS_khv</b></span> <span class="w3-hide-small">SPRING 물류정보시스템 관리자 화면</span></h1>
  </div>
</header>