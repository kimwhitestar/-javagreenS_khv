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
	//자식창 윈도우 onload시에 Document를 메모리로 모두 올리고 작업준비한다.
	$(document).ready(function(){
		$("#lblFindId").html("<h3 class='text-center text-dark'>아 이 디  찾 기</h3>");
	});
	
	function sendId() {
		opener.window.document.loginForm.loginId.value = $("#findoutId").val();
		opener.window.document.loginForm.loginPwd.focus();
		window.close();
	}
	
	function formCheck() {
		if ( ! editForm(regexCheck()) ) return false;
		
		let customName = $("#customName").val();
		let email = $("#email").val();
		let telNo = $("#telNo").val();
		
		let param = {
				customName : customName,
				email : email,
				telNo : telNo
		};
		
		$.ajax({
			type: "post",
			url: "${ctxPath}/customCompLoginIdFindout",
			data: param,
			success: function(loginId) {
				if ('' == loginId) {
					$("#existLoginIdN").html("<h5 class='text-center'><font color='red'>아이디를 찾지 못했습니다.</font></h5>");
				} else {
					$("#existLoginIdN").html('');
					$("#existLoginIdEmpty").html('');
					let resHtml = "<h4 class='text-center'>회원님의 아이디는 <font color='blue'><span id='spanFindoutId'></span></font>입니다</h4>"
						+ "<p class='text-center'><input type='button' class='btn btn-info btn-sm' value='창닫기' onclick='sendId()'/></p>"
						+ "<input type='hidden' name='findoutId' id='findoutId' value='"+id+"'/>";
					$("#existLoginIdY").html(resHtml);
					$("#spanFindoutId").html(loginId);
					$("#findoutId").val(loginId);
				}
			},
			error: function() {
				alert('전송오류~~');
			}
		}); 
	}
	
	//REGEX PATTERN 유효성 체크 : 아이디찾기폼 입력필드의 '영문자, 한글, 숫자, 특수문자, 길이' 체크
	function regexCheck() {
  	const regexCustomName = /[가-힣a-zA-Z]{3,10}([0-9]*|[0-9])/g; //기업명체크(한글or영문에 필요하면 숫자포함 조합 3~20자리)
		const regexEmail = /^[a-zA-Z]{2}[0-9_+-.]*[a-zA-Z]([a-zA-Z0-9_+-.]*){25}$/g;//이메일체크(영문자으로 시작하여 특수기호 _+-. 또는 숫자 또는 문자 조합 3~25자리)
    const regexTel2 = /\d{3,4}$/g; //전화번호2체크(숫자 3~4자리)
		const regexTel3 = /\d{4}$/g; //전화번호3체크(숫자 4자리)
		let regexFlag = true;
  	
		//기업명 정규식 체크
		if ( ! $("#customName").val().match(regexCustomName) ) {
			$("#customName").addClass("is-invalid");
			$("#customNameInvalid").addClass("is-invalid");
			$("#customNameInvalid").text("한글 또는 영문 3자리 이상으로 필요하면 숫자 조합 3~20자리로 입력하세요");
			$("#customName").focus();
 			regexFlag = false;
		} else {
			$("#customName").addClass("is-valid");
			$("#customNameInvalid").addClass("is-valid");
			$("#customNameInvalid").text("");
		}
		//이메일 정규식 체크
		if ( ! $("#email1").val().match(regexEmail) ) {
			$("#email1").addClass("is-invalid");
			$("#email1Invalid").addClass("is-invalid");
			$("#email1Invalid").text("영문자 3자리 이상으로 필요하면 특수기호(_+-.), 숫자, 영문 조합 3~25자리로 입력하세요");
			$("#email1").focus();
 			regexFlag = false;
		} else {
			$("#email1").addClass("is-valid");
			$("#email1Invalid").addClass("is-valid");
			$("#email1Invalid").text("");
		}
		//전화번호 정규식 체크
 		if ('' != $("#tel3").val()) {
			if ( ! $("#tel3").val().match(regexTel3) ) {
				$("#tel3").addClass("is-invalid");
				$("#tel3InValid").addClass("is-invalid");
				$("#tel3InValid").text("숫자 4자리로 입력하세요");
				$("#tel3").focus();
	 			regexFlag = false;
			} else {
 				$("#tel3").addClass("is-valid");
				$("#tel3InValid").addClass("is-valid");
				$("#tel3InValid").text('');
			}
		} 
		//전화번호 정규식 체크
		if ('' != $("#tel2").val()) {
			if ( ! $("#tel2").val().match(regexTel2) ) {
				$("#tel2").addClass("is-invalid");
				$("#tel2InValid").addClass("is-invalid");
				$("#tel2InValid").text("숫자 3자리~4자리로 입력하세요");
				$("#tel2").focus();
	 			regexFlag = false;
			} else {
				$("#tel2").addClass("is-valid");
				$("#tel2InValid").addClass("is-valid");
				$("#tel2InValid").text('');
			}
		}
		
 		return regexFlag;
	}
	
	//회원가입폼 파라미터 편집후 서버로 요청하기
 	function editForm(flag) {
		if (! flag) return false;
		
		//이메일 편집
		$("#email").val($("#email1").val() + '@' + $('#email2').val());

		//전화번호 편집
		let tel2 = $('#telGroup input[name="tel2"]').val();
		let tel3 = $('#telGroup input[name="tel3"]').val();
		if (''!=tel2 && ''!=tel3) {
			$("#telNo").val(
				$('#telGroup select[name="tel1"] option:selected').val() 
				+ '-' + tel2 
				+ '-' + tel3);
		}
		return true;
	}
	</script>
</head>
<body>
<div class="container">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="container p-3 border">
				<div id="lblFindId"></div>
				<div id="existLoginIdN"></div>
				<div id="existLoginIdY"></div>
				<div id="existLoginIdEmpty">
					<form name="findIdForm" method="post" class="was-validated">
						<p class="text-success">가입한 기업명, 이메일, 전화번호를 입력해 주세요</p>
						<div class="form-group">
							<label for="customName">기업명 : </label>
							<input type="text" class="form-control" name="customName" id="customName" placeholder="기업명을 입력하세요." required />
							<div id="customNameInvalid" class="invalid-feedback">기업명은 필수 입력사항입니다.</div>
						</div>
				    <div class="form-group" id="emailGroup">
							<label for="email1">Email address :</label>
							<div class="input-group mb-3">
								<input type="text" class="form-control" id="email1" name="email1" placeholder="Email을 입력하세요." maxlength=25 required />
								<font size="5pt" class="text-center text-info"><b>@</b></font>
								<div class="input-group-append" >
									<select id="email2" name="email2" class="custom-select">
										<c:forEach var="domain" items="${emailDomain}" >
											<option value="${domain}" > ${domain} </option>
										</c:forEach>
									</select>
								</div>
								<div id="email1Invalid" class="invalid-feedback">이메일은 필수 입력사항입니다.</div>
								<input type="hidden" class="form-control" id="email" name="email" />
							</div>
						</div>
				    <div class="form-group" id="telGroup">
							<label>전화번호 :</label> &nbsp;&nbsp;
							<div class="input-group">
								<div class="input-group-prepend">
									<select id="tel1" name="tel1" class="custom-select">
										<option value="02">02</option>
										<option value="031">031</option>
										<option value="032">032</option>
										<option value="041">041</option>
										<option value="042">042</option>
										<option value="043">043</option>
										<option value="051">051</option>
										<option value="052">052</option>
										<option value="061">061</option>
										<option value="062">062</option>
									</select>
								</div>
								_<div><input type="text" id="tel2" name="tel2" size=4 maxlength=4 class="form-control" required /></div>
								_<div><input type="text" id="tel3" name="tel3" size=4 maxlength=4 class="form-control" required /></div>
					 			<div id="blank" class="is-invalid"></div>
					  		<div id="tel2InValid" class="invalid-feedback">전화번호의 가운데 자리는 필수 입력사항입니다.</div>
					 	 		<div id="tel3InValid" class="invalid-feedback">전화번호의 마지막 자리는 필수 입력사항입니다.</div> 
					 			<input type="hidden" id="telNo" name="telNo" maxlength=13 class="form-control">
							</div> 
				    </div>
						<div class="form-group text-center">
							<button type="button" class="btn btn-info btn-sm" onclick="formCheck()">아이디 찾기</button> &nbsp;
							<button type="reset" class="btn btn-info btn-sm">다시작성</button> &nbsp;
							<button type="button" class="btn btn-info btn-sm" onclick="location.href='${ctxPath}/customCompLogin.cmbr';">돌아가기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>