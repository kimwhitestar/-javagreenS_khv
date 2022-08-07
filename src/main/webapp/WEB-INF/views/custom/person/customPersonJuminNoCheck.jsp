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
	function setJuminNoToParent() {
		//주민등록번호중복체크flg =yn 후 close()필요
 		opener.window.document.getElementById("juminNo").value = '${juminNo}';
 		opener.window.document.getElementById("gender1").focus();
		window.close();
	}
	
	//주민등록번호 중복 체크
	function checkJuminNo() {
		if ( regexJuminNo() ) {
			childForm.submit();
		}
	}
	
	//주민등록번호 정규식 체크
	function regexJuminNo() {
		const regexJuminNo = /[0-9]{6}-[0-9]{7}/g; //주민등록번호체크(숫자6-숫자7)
		let regexFlag = true;    
		
		//주민등록번호 정규식 체크
		if ( ! $("#juminNo").val().match(regexJuminNo) ) {
			$("#juminNo").addClass("is-invalid");
			$("#juminNoInvalid").addClass("is-invalid");
			$("#juminNoInvalid").text("숫자6자리-숫자7자리로 입력하세요");
			$("#juminNo").focus();
 			regexFlag = false;
		} else {
			$("#juminNo").addClass("is-valid");
			$("#juminNoInvalid").addClass("is-valid");
			$("#juminNoInvalid").text("");
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
			<h2 class="table-card text-dark text-center">주민등록번호 체크</h2>
			<br>
			<c:if test="${'N' == existJuminNoYN}">
				<h5 class="text-center"><font color="blue">${juminNo}</font>주민등록번호는 사용가능합니다</h5>
				<p><input type="button" class="form-control btn-info" value="창닫기" onclick="setJuminNoToParent()"/></p>
			</c:if>
			<c:if test="${empty existJuminNoYN || 'Y' == existJuminNoYN}">
				<c:if test="${empty existJuminNoYN}">
					<h5 class="text-center">주민등록번호를 입력하세요</h5>
				</c:if>
				<c:if test="${'Y' == existJuminNoYN}">
					<h5 class="text-center"><font color="red">${juminNo}</font>는 이미 사용중인 주민등록번호입니다</h5>
				</c:if>
				<form name="childForm" method="post" action="${ctxPath}/customPerson/customPersonJuminNoCheck" class="was-validated" >
			    <div class="form-group" id="juminNoGroup">
						<input type="text" class="form-control" id="juminNo" name="juminNo" placeholder="주민등록번호를 숫자-숫자로 입력하세요." maxlength=14 required autofocus/>
						<div id="juminNoInvalid" class="invalid-feedback">주민등록번호는 필수 입력사항입니다.</div>
			    </div>
					<input type="button" class="form-control btn-info" id="btnSearch" value="주민등록번호 확인" onclick="checkJuminNo()"/>
				</form>
			</c:if>
			</div>
		</div>
	</div>
</div>
</body>
</html>