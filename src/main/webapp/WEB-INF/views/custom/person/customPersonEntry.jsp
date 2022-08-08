<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<c:set var="security" value="<%= new com.spring.javagreenS_khv.common.SecurityUtil() %>" />
<fmt:formatDate var="now" value="<%= new java.util.Date() %>" pattern="yyyy-MM-dd"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>customPersonEntry.jsp</title>
  	<jsp:include page="/include/bs4.jsp" />
	<!-- daum웹사이트에서 제공하는 주소 script open 예제소스 -->
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="${ctxPath}/js/post.js"></script>
	<!-- ckeditor 글자편집기 -->
    <script src="${ctxPath}/ckeditor/ckeditor.js"></script>
	<style>
	</style>
	<script>
	'use strict';
	
	//아이디 중복 체크
	function idCheck() {
		let url = '${ctxPath}/customPerson/customPersonLoginIdCheck';
		let childWin = window.open(url,"idCheckWin","width=580px,height=300px");
		
		// Jquery방식으로, 자식창에서 윈도우 로딩시에 Document를 메모리로 모두 올리고 작업준비한다.
		childWin.onload = function() {
			//자식창에 id값 셋팅
			childWin.document.getElementById("loginId").value = $("#loginId").val();
		}
	}
	
	//주민등록번호 중복 체크 
	function juminNoCheck() {
		let url = '${ctxPath}/customPerson/customPersonJuminNoCheck';
		let childWin = window.open(url,"juminNoCheckWin","width=580px,height=300px");
		
		// Jquery방식으로, 자식창에서 윈도우 로딩시에 Document를 메모리로 모두 올리고 작업준비한다.
		childWin.onload = function() {
			//자식창에 주민등록번호 값 셋팅
			childWin.document.getElementById("juminNo").value = $("#juminNo").val();
		}
	}
	
	//이메일 중복 체크 
	function emailCheck() {
		let url = '${ctxPath}/customPerson/customPersonEmailCheck';
		let childWin = window.open(url,"emailCheckWin","width=580px,height=300px");
		
		// Jquery방식으로, 자식창에서 윈도우 로딩시에 Document를 메모리로 모두 올리고 작업준비한다.
		childWin.onload = function() {
			//자식창에 이메일 값 셋팅
			childWin.document.getElementById("email1").value = $("#email1").val();
			childWin.document.getElementById("email2").value = $("#email2").val();
			childWin.document.getElementById("txtEmail2").value = $("#txtEmail2").val();
		}
	}

	//회원가입폼 체크
	function checkEntryForm() {
 		if ( editForm(regexCheck()) ) {
			entryForm.submit();
 		}
 	}

	//DB에 저장될 각각의 필드길이 체크
 	function regexCheck() {
		const regexLoginId = /^[a-zA-Z]+[0-9_+-.]*[a-zA-Z_+-.]*[0-9]([a-zA-Z0-9_+-.]*)$/g; //아이디체크(영문자1자리이상, 숫자나 특수기호 조합 2~20자리)
    	const regexLoginPwd = /([a-zA-Z][0-9][@#$%&!?^~*+-_.]|[0-9][a-zA-Z][@#$%&!?^~*+-_.]|[@#$%&!?^~*+-_.][a-zA-Z][0-9]|[@#$%&!?^~*+-_.][0-9][a-zA-Z])/g;//비밀번호체크(영문자,숫자,특수기호 @#$%&!?^~*+-_. 조합 3~20자리)
  		const regexCustomName = /[가-힣a-zA-Z]{3,10}([0-9]*)/g; //이름체크(한글or영문에 필요하면 숫자포함 조합 3~20자리)
		const regexTxtJob = /[가-힣a-zA-Z]{1,100}/g; //직업명체크(한글 또는 영문 1~100자리)
    	const regexDetailAddress = /[a-zA-Z0-9가-힣#-. ]{1,50}/g; //상세주소체크(한글or영문에 필요하면 숫자 또는 특수문자( .-#) 1~50자리)
		const regexEmail1 = /^[a-zA-Z]{2}[0-9_+-.]*[a-zA-Z]([a-zA-Z0-9_+-.]*)$/g;//이메일체크(영문자으로 시작하여 특수기호 _+-. 또는 숫자 또는 문자 조합 3~25자리)
		const regexTxtEmail2 = /[a-zA-Z][0-9]*[_+-.][a-zA-Z0-9]([_+-.][a-zA-Z]|[a-zA-Z])/g;//도메인체크(domain deep 2이상, 영문자와 특수기호 _+-. 또는 숫자 또는 문자 조합 3~25자리)
		const regexJuminNo = /[0-9]{6}-[0-9]{7}/g; //주민등록번호체크(숫자6-숫자7)
		const regexTel2 = /\d{3,4}$/g; //전화번호2체크(숫자 3~4자리)
		const regexTel3 = /\d{4}$/g; //전화번호3체크(숫자 4자리)
	  	const regexHp2 = /\d{4}$/g; //휴대폰번호2체크(숫자 4자리)
		const regexHp3 = /\d{4}$/g; //휴대폰번호3체크(숫자 4자리)
		const regexMemo = /[a-zA-Z0-9가-힣]([ ]*|[@#$%^&!?]|[~()<>_*+-=]|[,.:;\/])/gm; //메모 체크(숫자,문자,특수문자체크(~!?@#$%^&*()<>_+=-,.:;/ ) 조합 500자리)
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
 		}
		//비밀번호 정규식 체크
		if ( ! $("#loginPwd").val().match(regexLoginPwd) ) {
			$("#loginPwd").addClass("is-invalid");
			$("#loginPwdInvalid").addClass("is-invalid");
			$("#loginPwdInvalid").text("영문자, 숫자, 특수기호(~!?@#$%^&*_+-.) 조합 3~20자리로 입력하세요");
 			$("#loginPwd").focus();
 			regexFlag = false;
		} else {
			$("#loginPwd").addClass("is-valid");
			$("#loginPwdInvalid").addClass("is-valid");
 			$("#loginPwdInvalid").text("");
		}
		//이름 정규식 체크
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
		//직업 정규식 체크
		if ( ! $("#txtJob").val().match(regexTxtJob) ) {
			$("#txtJob").addClass("is-invalid");
			$("#txtJobInvalid").addClass("is-invalid");
			$("#txtJobInvalid").text("한글 또는 영문 1~100자리로 입력하세요");
			$("#txtJob").focus();
 			regexFlag = false;
		} else {
			$("#txtJob").addClass("is-valid");
			$("#txtJobInvalid").addClass("is-valid");
			$("#txtJobInvalid").text("");
		}
		//우편번호 공란 체크
		if ( '' == $('#addressGroup input[name="postcode"]').val()
			&& '' != $('#addressGroup input[name="detailAddress"]').val() ) {
			$('#addressGroup input[name="detailAddress"]').addClass("is-invalid");
			$("#detailAddressInvalid").addClass("is-invalid");
			$("#detailAddressInvalid").text("주소는 우편번호찾기로 검색 후 입력하세요");
			$('#addressGroup input[name="detailAddress"]').focus();
 			regexFlag = false;
		} else {
			$('#addressGroup input[name="detailAddress"]').addClass("is-valid");
			$("#detailAddressInvalid").addClass("is-valid");
			$("#detailAddressInvalid").text("");
		}
		//상세주소 정규식 체크
 		if ( '' != $('#addressGroup input[name="postcode"]').val() 
 			&& '' != $('#addressGroup input[name="detailAddress"]').val() ) {
			if ( ! $('#addressGroup input[name="detailAddress"]').val().match(regexDetailAddress) ) {
				$('#addressGroup input[name="detailAddress"]').addClass("is-invalid");
				$("#detailAddressInvalid").addClass("is-invalid");
				$("#detailAddressInvalid").text("한글 또는 영문에 필요하면 숫자, 특수문자( .-#) 포함하여 1~50자리로 입력하세요");
				$('#addressGroup input[name="detailAddress"]').focus();
	 			regexFlag = false;
			} else {
				$('#addressGroup input[name="detailAddress"]').addClass("is-valid");
				$("#detailAddressInvalid").addClass("is-valid");
				$("#detailAddressInvalid").text("");
			}
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
		}
		//이메일 도메인 정규식 체크
		let options = entryForm.email2.options;
	  	if(options[0].selected == true) {//도메인 셀렉트박스에서 '-직접입력-' 선택의 경우
	  		if (entryForm.txtEmail2.value == '' ) {//도메인 직접입력 텍스트박스가 공란의 경우
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
		//주민등록번호 정규식 체크
		if ( ! $("#juminNo").val().match(regexJuminNo) ) {
			$("#juminNo").addClass("is-invalid");
			$("#juminNoInvalid").addClass("is-invalid");
			$("#juminNoInvalid").text("숫자-숫자로 입력하세요");
			$("#juminNo").focus();
				regexFlag = false;
		} else {
			$("#juminNo").addClass("is-valid");
			$("#juminNoInvalid").addClass("is-valid");
			$("#juminNoInvalid").text("");
		}
		//전화번호 정규식 체크
 		if ('' != $("#tel3").val()) {
			if ( ! $("#tel3").val().match(regexTel3) ) {
				$("#tel3").addClass("is-invalid");
				$("#tel3Invalid").addClass("is-invalid");
				$("#tel3Invalid").text("숫자 4자리로 입력하세요");
				$("#tel3").focus();
	 			regexFlag = false;
			} else {
 				$("#tel3").addClass("is-valid");
				$("#tel3Invalid").addClass("is-valid");
				$("#tel3Invalid").text('');
			}
		} 
		//전화번호 정규식 체크
		if ('' != $("#tel2").val()) {
			if ( ! $("#tel2").val().match(regexTel2) ) {
				$("#tel2").addClass("is-invalid");
				$("#tel2Invalid").addClass("is-invalid");
				$("#tel2Invalid").text("숫자 3자리~4자리로 입력하세요");
				$("#tel2").focus();
	 			regexFlag = false;
			} else {
				$("#tel2").addClass("is-valid");
				$("#tel2Invalid").addClass("is-valid");
				$("#tel2Invalid").text('');
			}
		}
		//휴대폰번호 정규식 체크
		if ('' != $("#hp3").val()) {
			if ( ! $("#hp3").val().match(regexHp3) ) {
				$("#hp3").addClass("is-invalid");
				$("#hp3Invalid").addClass("is-invalid");
				$("#hp3Invalid").text("숫자 4자리로 입력하세요");
				$("#hp3").focus();
	 			regexFlag = false;
			} else {
 				$("#hp3").addClass("is-valid");
				$("#hp3Invalid").addClass("is-valid");
				$("#hp3Invalid").text('');
			}
		} 
		//휴대폰번호 정규식 체크
		if ('' != $("#hp2").val()) {
			if ( ! $("#hp2").val().match(regexHp2) ) {
				$("#hp2").addClass("is-invalid");
				$("#hp2Invalid").addClass("is-invalid");
				$("#hp2Invalid").text("숫자 4자리로 입력하세요");
				$("#hp2").focus();
	 			regexFlag = false;
			} else {
				$("#hp2").addClass("is-valid");
				$("#hp2Invalid").addClass("is-valid");
				$("#hp2Invalid").text('');
			}
		}		
		
		return regexFlag;
	}
	
	//회원가입폼 파라미터 편집후 서버로 요청하기
 	function editForm(flag) {
		if (! flag) return false;
		
		//비밀번호 암호화
		setEncryptPwd($("#loginPwd").val());
		
		//우편번호 설정
		$("#validatingPostcode").val($('#addressGroup input[name="postcode"]').val());
		
		//직업 편집
		if ('기타' == $("#job").val() && '' != $("#txtJob").val()) {
			$("#txtJob").val('기타:' + $("#txtJob").val());
		}
		
		//이메일 편집
		if ('-' == $('#emailGroup select[name="email2"] option:selected').val()) {
			$("#email").val($("#email1").val() + '@' + $('#txtEmail2').val());
		} else {
			$("#email").val($("#email1").val() + '@' + $('#emailGroup select[name="email2"] option:selected').val());
		}

		//전화번호 편집
		let tel2 = $('#telGroup input[name="tel2"]').val();
		let tel3 = $('#telGroup input[name="tel3"]').val();
		if (''!=tel2 && ''!=tel3) {//필수항목이 아니므로, 편집전 공백체크
			$("#telNo").val(
				$('#telGroup select[name="tel1"] option:selected').val() 
				+ '-' + tel2 
				+ '-' + tel3);
		}
		
		//휴대폰번호 편집
		let hp2 = $('#hpGroup input[name="hp2"]').val();
		let hp3 = $('#hpGroup input[name="hp3"]').val();
		if (''!=hp2 && ''!=hp3) {
			$("#hpNo").val(
				$('#hpGroup select[name="hp1"] option:selected').val() 
				+ '-' + hp2 
				+ '-' + hp3);
		}
		
		//취미 
    	let arrHobby = [];
		$('#hobbyGroup input[name="hobby"]:checked').each(function(idx, item){
			arrHobby.push($(item).val());
    	});
		$("#checkedHobbies").val(arrHobby.join('/'));
		
		return true;
	}
	
	//비밀번호 암호화
	function setEncryptPwd(loginPwd) {
		$("#encryptPwd").val('${security.encryptSHA256(loginPwd)}');
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
<body class="jumbotron"  >
<div class="container" style="padding:30px">
  <form name="entryForm" method="post" action="${ctxPath}/customPerson/customPersonEntry" class="was-validated">
    <h2 class="text-center">개 인 고 객 회 원 가 입</h2>
    <br/>
    <div class="form-group">
		<label for="loginId">아이디 : &nbsp; &nbsp;<input type="button" value="아이디 중복체크" class="btn btn-success" onclick="idCheck()"/></label>
		<input type="text" class="form-control" id="loginId" name="loginId" placeholder="아이디를 입력하세요." maxlength=20 required autofocus/>
		<div id="loginIdInvalid" class="invalid-feedback">아이디는 필수 입력사항입니다.</div>
    </div>
    <div class="form-group">
		<label for="loginPwd">비밀번호 :</label>
		<input type="password" class="form-control" id="loginPwd" name="loginPwd" placeholder="비밀번호를 입력하세요." maxlength=20 required />
		<div id="loginPwdInvalid" class="invalid-feedback">비밀번호는 필수 입력사항입니다.</div>
		<input type="hidden" class="form-control" name="encryptPwd" id="encryptPwd" />
    </div>
    <div class="form-group">
			<label for="name">이름 :</label>
			<input type="text" class="form-control" id="customName" name="customName" placeholder="이름을 입력하세요." maxlength=20 required />
			<div id="customNameInvalid" class="invalid-feedback">이름은 필수 입력사항입니다.</div>
    </div>
    <div class="form-group">
			<label for="customKindCode">고객구분코드 :</label>
			<select id="customKindCode" name="customKindCode" class="custom-select">
 				<c:forEach var="kindVo" items="${customKindList}" >
					<option value="${kindVo.customKindCode}" >${kindVo.customKindName}</option>
				</c:forEach>
				<option value="2" selected>개인고객</option>
			</select>
		</div>
    <div class="form-group" id="jobGroup">
			<label for="job">직업 : </label>
			<div class="input-group ">
					<select class="form-control" id="job" name="job" onchange='changeSel(this,document.getElementById("txtJob"))'>
						<option value="기타" selected>기타</option>
						<option value="자영업">자영업</option>
						<option value="법조인">법조인</option>
						<option value="세무인">세무인</option>
						<option value="의사">의사</option>
						<option value="군인">군인</option>
						<option value="공무원">공무원</option>
						<option value="회사원">회사원</option>
						<option value="학생">학생</option>
					</select>
					&nbsp;&nbsp;
					<input type="text" class="form-control" id="txtJob" name="txtJob" maxlength=15 onclick='changeTxt(document.getElementById("job"))' />
					<div id="txtJobInvalid" class="invalid-feedback"></div>
			</div>
    </div>
    <div class="form-group" id="addressGroup">
			<label for="address">주소 : </label>
			<div class="input-group">
				<div class="input-group">
					<input type="text" class="input-group-prepend text-center" id="sample6_postcode" name="postcode" size="10" placeholder="우편번호"  disabled>&nbsp;
					<input type="button" class="btn btn-success" id="btnPostCode" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">&nbsp;
					<input type="text" class="form-control" id="sample6_address" name="roadAddress" placeholder="도로명주소">&nbsp;
					<input type="text" class="form-control" id="sample6_extraAddress" name="extraAddress" placeholder="지번주소">	
				</div>
				<div class="input-group">
					<input type="text" class="form-control mt-2" id="sample6_detailAddress" name="detailAddress" placeholder="상세주소" >
					<div id="detailAddressInvalid" class="invalid-feedback"></div>
				</div>
			</div>
			<input type="hidden" id="validatingPostcode" name="validatingPostcode">
    </div>
    <div class="form-group" id="emailGroup">
			<label for="email1">Email address : &nbsp; &nbsp;<input type="button" value="이메일 중복체크" class="btn btn-success" onclick="emailCheck()"/></label>
			<div class="input-group mb-3">
				<input type="text" class="form-control" id="email1" name="email1" placeholder="Email을 입력하세요." maxlength=25 required />
				<font size="5pt" class="text-center text-success"><b>@</b></font>
				<div class="input-group-append" >
					<select name="email2" class="custom-select" onchange='changeSel(this,entryForm.txtEmail2)'>
						<option value="-" selected> - 직접입력 - </option>
						<option value="naver.com" >naver.com</option>
						<option value="hanmail.net">hanmail.net</option>
						<option value="hotmail.com">hotmail.com</option>
						<option value="gmail.com">gmail.com</option>
						<option value="nate.com">nate.com</option>
						<option value="yahoo.com">yahoo.com</option>
					</select>
				</div>
				&nbsp;&nbsp;
				<input type="text" class="form-control" id="txtEmail2" name="txtEmail2" maxlength=25 onclick='changeTxt(entryForm.email2)' />
				<div id="email1Invalid" class="invalid-feedback">이메일은 필수 입력사항입니다.</div>
				<div id="txtEmail2Invalid" class="invalid-feedback"></div>
				<input type="hidden" class="form-control" id="email" name="email" />
			</div>
		</div>
    <div class="form-group" id="juminNoGroup">
    	<label for="juminNo">주민등록번호 : &nbsp; &nbsp;<input type="button" value="주민등록번호 중복체크" class="btn btn-success" onclick="juminNoCheck()"/></label>
			<input type="text" class="form-control" id="juminNo" name="juminNo" maxlength=14 placeholder="주민등록번호를 하이폰(-) 포함하여 입력하세요." required/>
			<div id="juminNoInvalid" class="invalid-feedback">주민등록번호는 필수 입력사항입니다.</div>
    </div>
    <div class="form-group" id="genderGroup">
			<div class="form-check-inline">
				<label class="form-check-label"> 성별 :&nbsp; &nbsp;
					<input type="radio" class="form-check-input" id="gender1" name="gender" value="M" checked>남자
				</label>
			</div>
			<div class="form-check-inline">
				<label class="form-check-label">
					<input type="radio" class="form-check-input" id="gender2" name="gender" value="W">여자
				</label>
			</div>
    </div>
    <div class="form-group">
    	<label for="birthDate">생일 :</label>
			<input type="date" id="birthDate" name="birthDate" value="${now}" class="form-control"/>
    </div>
    <div class="form-group" id="telGroup">
			<label >전화번호 :</label> &nbsp;&nbsp;
			<div class="input-group">
				<div class="input-group-prepend">
					<select id="tel1" name="tel1" class="custom-select">
						<option value="02" selected>02</option>
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
				_<div><input type="text" id="tel2" name="tel2" size=4 maxlength=4 class="form-control"/></div>
				_<div><input type="text" id="tel3" name="tel3" size=4 maxlength=4 class="form-control"/></div>
	 			<div id="blank" class="is-invalid"></div>
	  		<div id="tel2Invalid" class="invalid-feedback"></div>
	 	 		<div id="tel3Invalid" class="invalid-feedback"></div> 
	 			<input type="hidden" id="telNo" name="telNo" maxlength=13 class="form-control">
			</div> 
    </div>
    <div class="form-group" id="hpGroup">
			<label >휴대전화 :</label> &nbsp;&nbsp;
			<div class="input-group">
				<div class="input-group-prepend">
					<select id="hp1" name="hp1" class="custom-select">
						<option value="010" selected>010</option>
						<option value="011">011</option>
						<option value="016">016</option>
						<option value="019">019</option>
						<option value="070">070</option>
					</select>
				</div>
				_<div><input type="text" id="hp2" name="hp2" size=4 maxlength=4 class="form-control" required /></div>
				_<div><input type="text" id="hp3" name="hp3" size=4 maxlength=4 class="form-control" required /></div>
	 			<div id="blank" class="is-invalid"></div>
	  		<div id="hp2Invalid" class="invalid-feedback">휴대전화의 가운데 자리는 필수 입력사항입니다.</div>
	 	 		<div id="hp3Invalid" class="invalid-feedback">휴대전화의 마지막 자리는 필수 입력사항입니다.</div> 
	 			<input type="hidden" id="hpNo" name="hpNo" maxlength=13 class="form-control">
			</div> 
    </div>
    <div class="form-group" id="hobbyGroup">
			<label>취미 : </label> &nbsp; &nbsp;
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="공예" name="hobby"/>공예
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="그림감상" name="hobby"/>그림감상
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="조립" name="hobby"/>조립
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="쇼핑" name="hobby"/>쇼핑
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="여행" name="hobby"/>여행
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="요리" name="hobby"/>요리
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="애완동물기르기" name="hobby"/>애완동물기르기
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="기타" name="hobby" checked/>기타
			  </label>
			</div>
			<input type="hidden" id="checkedHobbies" name="checkedHobbies" />
    </div>
<%--    <div class="form-group">
	    <label for="CKEDITOR">메모 : </label>
	    <textarea rows="5" class="form-control" id="CKEDITOR" name="memo" placeholder="메모를 입력하세요" maxlength=500 ></textarea>
	    <script>
	    	<!-- ckeditor글자편집기로 작성한 내용을 사진과 함께 upload할 때 Ajax로 사진upload처리 -->
	    	CKEDITOR.replace("memo", {
	    		height:120, /*px쓰면 안뜸*/
	    		filebrowserUploadUrl : "${ctxPath}/customPerson/imageUpload", //사진 1장
	    		uploadUrl : "${ctxPath}/customPerson/imageUpload" //사진 여러장 드래그
	    	});
	    </script>
	    <div id="CKEDITORInvalid" class="invalid-feedback"></div>
    </div>
 --%>    
    <div class="form-group text-center">
	    <input type="button" class="btn btn-success" id="entry" value="회원가입" onclick="checkEntryForm()" />
	    <input type="reset" class="btn btn-success"  value="다시작성"/>&nbsp;
	    <input type="button" class="btn btn-success" value="돌아가기" onclick="location.href='${ctxPath}/customPerson/customPersonLogin';"/><br>
		</div>
  </form>
  <p><br/></p>
</div>
<br/>
<jsp:include page="/common/footer.jsp" />
</body>
</html>