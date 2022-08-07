<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title></title>
  <jsp:include page="/include/bs4.jsp" />
  <style></style>
  <script>
	'use strict';
	function setIdToParent() {
		//아이디중복체크flg =yn 후 close()필요
		opener.window.document.entryForm.loginId.value = '${loginId}';
		opener.window.document.entryForm.loginPwd.focus();
		window.close();
	}
	
	//아이디 중복 체크
	function checkId() {
		if ( regexCheckId() ) {
			childForm.submit();
		}
	}
	
	//아이디 정규식 체크
	function regexCheckId() {
		const regexLoginId = /^[a-zA-Z]+[0-9_+-.]*[a-zA-Z_+-.]*[0-9]([a-zA-Z0-9_+-.]*)$/g; //아이디체크(영문자1자리이상, 숫자나 특수기호 조합 2~20자리)
		let regexFlag = true;    
		
 		//회원아이디 정규식 체크
		if ( ! $("#loginId").val().match(regexLoginId) ) {
 			$("#loginId").addClass("is-invalid");
 			$("#loginIdInvalid").addClass("is-invalid");
 			$("#loginIdInvalid").text("영문자로 시작하여 숫자1자리 이상 포함하는 영문,숫자,특수기호(_+-.)의 조합 2~20자리로 입력하세요");
 			$("#loginId").focus();
 			regexFlag = false;
 		} else {
 			$("#loginId").addClass("is-valid");
 			$("#loginIdInvalid").addClass("is-valid");
 			$("#loginIdInvalid").text("");
 			$("#btnSearch").focus();
 		}
 		
  	return regexFlag;
  }
  </script>
</head>
<body>
<p><br></p>
<div class="container">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="container p-3 border bg-light">
			<h2 class="table-card text-dark text-center">아이디 체크</h2>
			<br>
			<c:if test="${'N' == existLoginIdYN}">
				<h5 class="text-center"><font color="blue">${loginId}</font>아이디는 사용가능합니다</h5>
				<p><input type="button" class="form-control btn-info" value="창닫기" onclick="setIdToParent()"/></p>
			</c:if>
			<c:if test="${empty existLoginIdYN || 'Y' == existLoginIdYN}">
				<c:if test="${empty existLoginIdYN}">
					<h5 class="text-center">아이디를 입력하세요</h5>
				</c:if>
				<c:if test="${'Y' == existLoginIdYN}">
					<h5 class="text-center"><font color="red">${loginId}</font>는 이미 사용중인 아이디입니다</h5>
				</c:if>
				<form name="childForm" method="post" action="${ctxPath}/customPerson/customPersonLoginIdCheck" class="was-validated" >
			    <div class="form-group" id="loginIdGroup">
						<input type="text" class="form-control" id="loginId" name="loginId" placeholder="아이디를 입력하세요." maxlength=20 required autofocus/>
						<div id="loginIdInvalid" class="invalid-feedback">아이디는 필수 입력사항입니다.</div>
			    </div>
					<input type="button" class="form-control btn-info" id="btnSearch" value="아이디 확인" onclick="checkId()"/>
				</form>
			</c:if>
			</div>
		</div>
	</div>
</div>
</body>
</html>