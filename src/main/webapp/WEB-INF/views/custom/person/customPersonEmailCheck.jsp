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
	function setEmailToParent() {
alert('${email2}' + '${txtEmail2}');		
 		opener.window.document.getElementById("email1").value = '${email1}';
 		opener.window.document.getElementById("email2").value = '${email2}';
 		opener.window.document.getElementById("txtEmail2").value = '${txtEmail2}';
 		opener.window.document.getElementById("juminNo").focus();
		window.close();
	}
	
	//이메일 정규식 체크
	function regexCheckEmail() {
		const regexEmail1 = /^[a-zA-Z]{2}[0-9_+-.]*[a-zA-Z]([a-zA-Z0-9_+-.]*){25}$/g;//이메일체크(영문자으로 시작하여 특수기호 _+-. 또는 숫자 또는 문자 조합 3~25자리)
		const regexTxtEmail2 = /[a-zA-Z][0-9]*[_+-.][a-zA-Z0-9]([_+-.][a-zA-Z]|[a-zA-Z])/g;//도메인체크(domain deep 2이상, 영문자와 특수기호 _+-. 또는 숫자 또는 문자 조합 3~25자리)
		let regexFlag = true;
		
		//이메일 도메인 정규식 체크
		let options = childForm.email2.options;
  	if(options[0].selected == true) {//도메인 셀렉트박스에서 '-직접입력-' 선택의 경우
  		if (childForm.txtEmail2.value == '' ) {//도메인 직접입력 텍스트박스가 공란의 경우
				$("#txtEmail2").addClass("is-invalid");
				$("#txtEmail2Invalid").addClass("is-invalid");
				$("#txtEmail2Invalid").text("해당하는 이메일 도메인명이 없으면 직접입력하세요");
				$("#txtEmail2").focus();
				regexFlag = false;
  		} else {//도메인 직접입력 텍스트박스에 입력한 경우
				if ( ! $("#txtEmail2").val().match(regexTxtEmail2) ) {//도메인값 REGEX 유효성 체크
					$("#txtEmail2").addClass("is-invalid");
					$("#txtEmail2Invalid").addClass("is-invalid");
					$("#txtEmail2Invalid").text("도메인명은 영문자와 특수기호(_+-.), 숫자, 영문 조합 3~25자리까지 입력가능합니다");
					$("#txtEmail2").focus();
		 			regexFlag = false;
				} else {
					$("#txtEmail2").addClass("is-valid");
					$("#txtEmail2Invalid").addClass("is-valid");
					$("#txtEmail2Invalid").text("");
				}
  		}
  	}	else {//도메인 셀렉트박스에서 선택한 경우
			$("#txtEmail2").addClass("is-valid");
			$("#txtEmail2Invalid").addClass("is-valid");
			$("#txtEmail2Invalid").text("");
  	}
  	
		//이메일 정규식 체크
		if ( ! $("#email1").val().match(regexEmail1) ) {
			$("#email1").addClass("is-invalid");
			$("#email1Invalid").addClass("is-invalid");
			$("#email1Invalid").text("이메일명은 영문자 3자리 이상으로 필요하면 특수기호(_+-.), 숫자, 영문 조합 3~25자리로 입력하세요");
			$("#email1").focus();
			regexFlag = false;
		} else {
			$("#email1").addClass("is-valid");
			$("#email1Invalid").addClass("is-valid");
			$("#email1Invalid").text("");
			$("#btnSearch").focus();
		}

  	return regexFlag;
  }
	
	//이메일 편집
	function editEmail(flag) {
		if (! flag) return false;
		
		if(childForm.email2.options[0].selected == true) {
			if ( $("#txtEmail2").val() != '' ) {
    		$("#email").val($("#email1").val() + '@' + $('#txtEmail2').val());
    		return true;
			}
		} else {
  		$("#email").val($("#email1").val() + '@' + $('#emailGroup select[name="email2"] option:selected').val());
  		return true;
		}
		
		return false;
	}
	
	//중복 이메일 체크
	function checkEmail() {
		if ( editEmail( regexCheckEmail() ) ) {
			childForm.submit();
		}
	}
	
 	function changeSel(selObj, txtObj)	{
    	let options = selObj.options;
    	if(options[0].selected == true && txtObj.value == '' ) {
    		txtObj.focus();
    	} else {
    		options[0].selected = false;
    		txtObj.value = '';
    	}
 	}
 	
 	function changeTxt(selObj)	{
    	let options = selObj.options;
    	for (let i=0; i<options.length; i++) {
    		options[i].selected = false;
    	}
    	options[0].selected = true; 
 	}
  </script>
</head>
<body>
<p><br></p>
<div class="container">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="container p-3 border bg-light">
			<h2 class="table-card text-dark text-center">이메일 중복 체크</h2>
			<br>
			<c:if test="${'N' == existEmailYN}">
				<h5 class="text-center"><font color="blue">${email}</font>이메일은 사용가능합니다</h5>
				<p><input type="button" class="form-control btn-info" value="창닫기" onclick="setEmailToParent()"/></p>
			</c:if>
			<c:if test="${empty existEmailYN || 'Y' == existEmailYN}">
				<c:if test="${empty existEmailYN}">
					<h5 class="text-center">이메일를 입력하세요</h5>
				</c:if>
				<c:if test="${'Y' == existEmailYN}">
					<h5 class="text-center"><font color="red">${email}</font>은<br>이미 사용중인 이메일입니다</h5>
				</c:if>
				<form name="childForm" method="post" action="${ctxPath}/customPerson/customPersonEmailCheck" class="was-validated" >
			    <div class="form-group" id="emailGroup">
						<div class="input-group">
							<input type="text" class="form-control" id="email1" name="email1" placeholder="Email을 입력하세요." maxlength=25 required autofocus />
							<font size="5pt" class="text-center text-success"><b>@</b></font>
							<div class="input-group-append" >
								<select id="email2" name="email2" class="custom-select" onchange='changeSel(this,childForm.txtEmail2)'>
									<option value="-" selected> - 직접입력 - </option>
									<option value="naver.com">naver.com</option>
									<option value="hanmail.net">hanmail.net</option>
									<option value="hotmail.com">hotmail.com</option>
									<option value="gmail.com">gmail.com</option>
									<option value="nate.com">nate.com</option>
									<option value="yahoo.com">yahoo.com</option>
								</select>
							</div>
							&nbsp;&nbsp;
							<input type="text" class="form-control" id="txtEmail2" name="txtEmail2" maxlength=25 onclick='changeTxt(childForm.email2)' />
							<div id="email1Invalid" class="invalid-feedback">이메일은 필수 입력사항입니다.</div>
							<div id="txtEmail2Invalid" class="invalid-feedback"></div>
							<input type="hidden" id="email" name="email" />
						</div>
					</div>
					<input type="button" class="form-control btn-info" id="btnSearch" value="이메일 확인" onclick="checkEmail()"/>
				</form>
			</c:if>
			</div>
		</div>
	</div>
</div>
</body>
</html>