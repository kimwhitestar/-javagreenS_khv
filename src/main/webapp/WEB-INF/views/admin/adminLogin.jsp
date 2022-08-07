<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<c:set var="security" value="<%= new com.spring.javagreenS_khv.common.SecurityUtil() %>" />
<%-- <c:set var="bcrypt" value="<%= new org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder() %>" /> --%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>adminLogin.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <style>
  </style>
  <script>
  	'use strict';
	//비밀번호 암호화
	function setEncryptPwd() {
		let loginPwd = $("#loginPwd").val();
		$("#encryptPwd").val('${security.encryptSHA256(loginPwd)}');
		<%-- $("#encryptPwd").val('${bcrypt.encode(loginPwd)}'); --%>
	}
  </script>
</head>
<body>
  <jsp:include page="/common/admin/header_home.jsp" />
  <jsp:include page="/common/admin/adminNav.jsp" />

  <p><br><br><br><br><br><br><br></p>
  <div class="container">
  <form name="myForm" method="post">
  	<table class="table table-bordered text-center">
  	  <tr>
  	    <td colspan="2"><h3>관 리 자 로 그 인</h3></td>
  	  </tr>
  	  <tr>
  	  	<th class="bg-info text-white">아이디</th>
  	  	<td><input type="text" id="loginId" name="loginId" value="${sLoginId}" autofocus class="form-control"/></td>
  	  </tr>
  	  <tr>
  	  	<th class="bg-info text-white">비밀번호</th>
  	  	<td><input type="password" id="loginPwd" name="loginPwd" class="form-control" onblur="setEncryptPwd()"/><input type="hidden" id="encryptPwd" name="encryptPwd" class="form-control"/></td>
  	  </tr>
  	  <tr>
  	    <td colspan="2">
  	      <button type="submit" class="btn btn-primary" >관리자 로그인</button> &nbsp;&nbsp;
  	      <button type="reset" class="btn btn-primary">다시입력</button> &nbsp;&nbsp;
  	    </td>
  	  </tr>
  	</table>
  </form>
  </div>
  <p><br><br><br><br><br><br><br></p>
<jsp:include page="/common/admin/footer.jsp"/>
</body>
</html>