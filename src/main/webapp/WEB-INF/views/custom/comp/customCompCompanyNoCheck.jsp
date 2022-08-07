<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title></title>
  <%@ include file="/include/bs4.jsp" %>
  <style></style>
  <script>
	'use strict';

	//부모창에 사업자등록번호 값 셋팅
	function setCompanyNoToParent() {
		//사업자등록번호중복체크flg =yn 후 close()필요
 		opener.window.document.getElementById("companyNo").value = '${companyNo}';
 		opener.window.document.getElementById("customKindCode").focus();
		window.close();
	}
	
	//사업자등록번호 중복 체크
	function checkCompanyNo() {
		//사업자등록번호 정규식 체크
		if ( regexCompanyNo() ) {
			childForm.submit();
		}
	}
	
	//사업자등록번호 정규식 체크
	function regexCompanyNo() {
		const regexCompanyNo = /[0-9]{3}-[0-9]{2}-[0-9]{5}/g; //사업자등록번호체크(숫자3자리-숫자2자리-숫자5자리)
		let regexFlag = true;    
		
		//사업자등록번호 정규식 체크
		if ( ! $("#companyNo").val().match(regexCompanyNo) ) {
			$("#companyNo").addClass("is-invalid");
			$("#companyNoInvalid").addClass("is-invalid");
			$("#companyNoInvalid").text("숫자3자리-숫자2자리-숫자5자리로 입력하세요");
			$("#companyNo").focus();
 			regexFlag = false;
		} else {
			$("#companyNo").addClass("is-valid");
			$("#companyNoInvalid").addClass("is-valid");
			$("#companyNoInvalid").text("");
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
			<h2 class="table-card text-dark text-center">사업자등록번호 체크</h2>
			<br>
			<c:if test="${'N' == existCompanyNoYN}">
				<h5 class="text-center"><font color="blue">${companyNo}</font>사업자등록번호는 사용가능합니다</h5>
				<p><input type="button" class="form-control btn-info" value="창닫기" onclick="setCompanyNoToParent()"/></p>
			</c:if>
			<c:if test="${empty existCompanyNoYN || 'Y' == existCompanyNoYN}">
				<c:if test="${empty existCompanyNoYN}">
					<h5 class="text-center">사업자등록번호를 입력하세요</h5>
				</c:if>
				<c:if test="${'Y' == existCompanyNoYN}">
					<h5 class="text-center"><font color="red">${companyNo}</font>는 이미 사용중인 사업자등록번호입니다</h5>
				</c:if>
				<form name="childForm" method="post" action="${ctxPath}/customComp/customCompCompanyNoCheck" class="was-validated" >
			    <div class="form-group" id="companyNoGroup">
						<input type="text" class="form-control" id="companyNo" name="companyNo" placeholder="사업자등록번호를 숫자-숫자-숫자로 입력하세요." maxlength=20 required autofocus/>
						<div id="companyNoInvalid" class="invalid-feedback">사업자등록번호는 필수 입력사항입니다.</div>
			    </div>
					<input type="button" class="form-control btn-info" id="btnSearch" value="사업자등록번호 확인" onclick="checkCompanyNo()"/>
				</form>
			</c:if>
			</div>
		</div>
	</div>
</div>
</body>
</html>