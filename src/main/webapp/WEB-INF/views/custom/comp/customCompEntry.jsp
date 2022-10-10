<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<c:set var="security" value="<%= new com.spring.javagreenS_khv.common.SecurityUtil() %>" />
<%-- <c:set var="bcrypt" value="<%= new org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder() %>" /> --%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>customCompEntry.jsp</title>
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
	let customImgFileName = '';
	
	$(document).ready(function(){
		console.log( "customCompEntry.ready()" );
		//error style class 적용
		//regexStyleCheck();
	});
	
 	function regexCheck() {
		//비밀번호체크(영문자,숫자,특수기호 @#$%&!?^~*+-_. 조합 3~20자리)
		const regexPwd = /([a-zA-Z][0-9][@#$%&!?^~*+-_.]|[0-9][a-zA-Z][@#$%&!?^~*+-_.]|[@#$%&!?^~*+-_.][a-zA-Z][0-9]|[@#$%&!?^~*+-_.][0-9][a-zA-Z])/g;
		let regexFlg = true;
		//비밀번호 정규식 체크
		if ( $("#loginPwd").val().match(regexPwd) ) {
			$("#loginPwd").addClass("is-valid");
			$("#loginPwdInvalid").addClass("is-valid");
 			$("#loginPwdInvalid").text('');
		} else {
			$("#loginPwd").addClass("is-invalid");
			$("#loginPwdInvalid").addClass("is-invalid");
			$("#loginPwdInvalid").text('영문자, 숫자, 특수기호(~!?@#$%^&*_+-.) 조합 3~20자리로 입력하세요');
 			$("#loginPwd").focus();
 			regexFlg = false;
		}
		return regexFlg;
	}
	
	//회원가입폼 파라미터 편집후 서버로 요청하기
 	function editForm() {
		//비밀번호 암호화
		setEncryptPwd($("#loginPwd").val());
		
		//우편번호 설정
		$("#validatingPostcode").val($('#addressGroup input[name="postcode"]').val());
		
 		//사무실 편집
		if ('기타' == $("#office").val() && '' != $("#txtOffice").val().trim()) {
			$("#txtOffice").val('기타:' + $("#txtOffice").val());
		}
		
		//이메일 편집
		if ( '-' == $('#emailGroup select[name="email2"] option:selected').val()
			&& '' != $("#email1").val().trim() 
			&& '' != $("#txtEmail2").val().trim() ) {
			$("#email").val($("#email1").val().trim() + '@' + $('#txtEmail2').val().trim());
		} else {
			$("#email").val($("#email1").val().trim() + '@' + $('#emailGroup select[name="email2"] option:selected').val());
		}

		//전화번호 편집
		if ( '' != $('#tel2').val().trim() && '' != $('#tel3').val().trim()) {
			$("#telNo").val(
				$('#telGroup select[name="tel1"] option:selected').val() 
				+ '-' + $('#tel2').val().trim() 
				+ '-' + $('#tel3').val().trim());
		}
		
		//휴대폰번호 편집
		if ( '' != $('#hp2').val().trim() && '' != $('#hp3').val().trim()) {
			$("#hpNo").val(
				$('#hpGroup select[name="hp1"] option:selected').val() 
				+ '-' + $('#hp2').val().trim() 
				+ '-' + $('#hp3').val().trim());
		}
		return true;
	}
 
	//회원가입폼 체크
	let checkEntryForm = function() {

/* 		alert('[checkEntryForm] ' + $("#customImgFileName").val());	
		alert('[checkEntryForm] ' + $('.custom-file input[name="customImgFileName"]').val());
*/		if ( regexCheck() ) {
			if ( editForm() ) {
				entryForm.submit();
			}
		}
	}
	let $btnEntry = $( "#entry" );//jquery 이벤트 핸들러를 위한 변수
	$btnEntry.on( "click", checkEntryForm ); //jquery 이벤트 핸들러 on 적용, 처리핸들링함수 추가
	
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
 	
	//비밀번호 암호화
	function setEncryptPwd(loginPwd) {
		$("#encryptPwd").val('${security.encryptSHA256(loginPwd)}');
	}
	
	//아이디 중복 체크
	function idCheck() {
		let url = '${ctxPath}/customComp/customCompLoginIdCheck';
		let childWin = window.open(url,"idCheckWin","width=580px,height=300px"); 
		
		// Jquery방식으로, 자식창에서 윈도우 로딩시에 Document를 메모리로 모두 올리고 작업준비한다.
		childWin.onload = function() {
			//자식창에 id값 셋팅
			childWin.document.getElementById("loginId").value = $("#loginId").val();
		}
	}
	
	//사업자등록번호 중복 체크 
	function companyNoCheck() {
		let url = '${ctxPath}/customComp/customCompCompanyNoCheck';
		let childWin = window.open(url,"companyNoCheckWin","width=580px,height=300px");

		// Jquery방식으로, 자식창에서 윈도우 로딩시에 Document를 메모리로 모두 올리고 작업준비한다.
		childWin.onload = function() {
			//자식창에 사업자등록번호 값 셋팅
			childWin.document.getElementById("companyNo").value = $("#companyNo").val();
		}
	}
	
	//이메일 중복 체크
	function emailCheck() {
		let url = '${ctxPath}/customComp/customCompEmailCheck';
		let childWin = window.open(url,"emailCheckWin","width=580px,height=300px");

		// Jquery방식으로, 자식창에서 윈도우 로딩시에 Document를 메모리로 모두 올리고 작업준비한다.
		childWin.onload = function() {
			//자식창에 이메일 값 셋팅
			childWin.document.getElementById("email1").value = $("#email1").val();
			childWin.document.getElementById("email2").value = $("#email2").val();
			childWin.document.getElementById("txtEmail2").value = $("#txtEmail2").val();
		}
	}
</script>
</head>
<body class="jumbotron" >
<div class="container" style="padding:30px">
  <form name="entryForm" method="post" action="${ctxPath}/customComp/customCompEntry" class="was-validated" enctype="multipart/form-data">
    <h2 class="text-center">기 업 고 객 회 원 가 입</h2>
    <br/>
    <div class="form-group">
			<label for="loginId">아이디 : &nbsp; &nbsp;<input type="button" value="아이디 중복체크" class="btn btn-info" onclick="idCheck()"/></label>
			<input type="text" class="form-control <%--${errMsgVo.loginId.fieldCss}--%>" id="loginId" name="loginId" value="${compEntryVo.loginId}" placeholder="아이디를 입력하세요." maxlength=20 required autofocus/>
			<div id="loginIdInvalid" class="invalid-feedback <%--${errMsgVo.loginId.invalidCss}--%>"><%--아이디는 필수 입력사항입니다... ${errMsgVo.loginId.messageTxt}--%></div>
    </div>
    <div class="form-group">
			<label for="loginPwd">비밀번호 : </label>
			<input type="password" class="form-control" id="loginPwd" name="loginPwd"  value="${compEntryVo.loginPwd}" placeholder="비밀번호를 입력하세요." maxlength=20 required />
			<div id="loginPwdInvalid" class="invalid-feedback">비밀번호는 필수 입력사항입니다.</div>
			<input type="hidden" class="form-control" name="encryptPwd" id="encryptPwd" />
    </div>
    <div class="form-group">
			<label for="customName">기업명 : </label>
			<input type="text" class="form-control" id="customName" name="customName"  value="${compEntryVo.customName}" placeholder="기업명을 입력하세요." maxlength=20 required />
			<div id="customNameInvalid" class="invalid-feedback">기업명은 필수 입력사항입니다.</div>
    </div>
    <div class="form-group">
			<label for="customNameShort">기업명(단축명칭) : &nbsp; &nbsp;</label>
			<input type="text" class="form-control" id="customNameShort" name="customNameShort"  value="${compEntryVo.customNameShort}" placeholder="기업명(단축명칭)을 입력하세요." maxlength=20 required />
			<div id="customNameShortInvalid" class="invalid-feedback">기업명(단축명칭)은 필수 입력사항입니다.</div>
    </div>
    <div class="form-group">
    	<label for="estblDate">창립일 :</label>
			<fmt:formatDate var="now" value="<%= new java.util.Date() %>" pattern="yyyy-MM-dd"/>
			<input type="date" id="estblDate" name="estblDate" value="${empty compEntryVo.estblDate ? now : compEntryVo.estblDate }" class="form-control"/>
    </div>
    <div class="form-group" id="companyNoGroup">
    	<label for="companyNo">사업자등록번호 : &nbsp; &nbsp;<input type="button" value="사업자등록번호 중복체크" class="btn btn-info" onclick="companyNoCheck()"/></label>
			<input type="text" class="form-control" id="companyNo" name="companyNo" value="${compEntryVo.companyNo}" placeholder="사업자등록번호를 하이폰(-) 포함하여 입력하세요." maxlength=20 required/>
			<div id="companyNoInvalid" class="invalid-feedback">사업자등록번호는 필수 입력사항입니다.</div>
    </div>
    <div class="form-group">
			<label for="customKindCode">기업구분코드 :</label>
			<select id="customKindCode" name="customKindCode" class="custom-select">
 				<c:forEach var="kindVo" items="${customKindList}" >
					<option value="${kindVo.customKindCode}" <c:if test='${compEntryVo.customKindCode eq kindVo.customKindCode}'>selected</c:if> > ${kindVo.customKindName} </option>
				</c:forEach>
				<option value="1" <c:if test='${ "1" eq compEntryVo.customKindCode}'>selected</c:if> >일반법인업체</option>
			</select>
		</div>
    <div class="form-group" id="officeGroup">
			<label for="office">사무실명 : </label>
			<div class="input-group ">
					<select class="form-control" id="office" name="office" onchange='changeSel(this,document.getElementById("txtOffice"))'>
						<option value="기타"   <c:if test='${"기타" eq compEntryVo.office}'>selected</c:if> >기타</option>
						<option value="물류과" <c:if test='${"물류과" eq compEntryVo.office}'>selected</c:if> >물류과</option>
						<option value="Ware Housing" <c:if test='${"Ware Housing" eq compEntryVo.office}'>selected</c:if> >Ware Housing</option>
						<option value="입고과" <c:if test='${"입고과" eq compEntryVo.office}'>selected</c:if> >입고과</option>
						<option value="출고과" <c:if test='${"출고과" eq compEntryVo.office}'>selected</c:if> >출고과</option>
						<option value="운수과/운송과" <c:if test='${"운수과/운송과" eq compEntryVo.office}'>selected</c:if> >운수과/운송과</option>
						<option value="비서실" <c:if test='${"비서실" eq compEntryVo.office}'>selected</c:if> >비서실</option>
						<option value="기획실" <c:if test='${"기획실" eq compEntryVo.office}'>selected</c:if> >기획실</option>
						<option value="홍보과" <c:if test='${"홍보과" eq compEntryVo.office}'>selected</c:if> >홍보과</option>
						<option value="경리과" <c:if test='${"경리과" eq compEntryVo.office}'>selected</c:if> >경리과</option>
						<option value="회계과" <c:if test='${"회계과" eq compEntryVo.office}'>selected</c:if> >회계과</option>
						<option value="총무과" <c:if test='${"총무과" eq compEntryVo.office}'>selected</c:if> >총무과</option>
					</select>
					&nbsp;&nbsp;
					<input type="text" class="form-control" id="txtOffice" name="txtOffice" value="${compEntryVo.txtOffice}" maxlength=15 onclick='changeTxt(document.getElementById("office"))' />
					<div id="txtOfficeInvalid" class="invalid-feedback"></div>
			</div>
    </div>
    <div class="form-group" id="addressGroup">
			<label for="address">주소 : </label>
			<div class="input-group">
				<div class="input-group">
					<input type="text" class="input-group-prepend text-center" id="sample6_postcode" name="postcode" size="10"  value="${compEntryVo.validatingPostcode}" placeholder="우편번호"  disabled>&nbsp;
					<input type="button" class="btn btn-info" id="btnPostCode" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">&nbsp;
					<input type="text" class="form-control" id="sample6_address" name="roadAddress"  value="${compEntryVo.roadAddress}" placeholder="도로명주소">&nbsp;
					<input type="text" class="form-control" id="sample6_extraAddress" name="extraAddress"  value="${compEntryVo.extraAddress}" placeholder="지번주소">	
				</div>
				<div class="input-group">
					<input type="text" class="form-control mt-2" id="sample6_detailAddress" name="detailAddress"  value="${compEntryVo.detailAddress}" placeholder="상세주소" >
					<div id="detailAddressInvalid" class="invalid-feedback"></div>
				</div>
			</div>
			<input type="hidden" id="validatingPostcode" name="validatingPostcode">
    </div>
    <div class="form-group" id="emailGroup">
			<label for="email1">Email address : &nbsp; &nbsp;<input type="button" value="이메일 중복체크" class="btn btn-info" onclick="emailCheck()"/></label>
			<div class="input-group">
				<input type="text" class="form-control" id="email1" name="email1" value="${compEntryVo.email1}" placeholder="Email을 입력하세요." maxlength=25 required />
				<font size="5pt" class="text-center text-info"><b>@</b></font>
				<div class="input-group-append" >
					<select id="email2" name="email2" class="custom-select" onchange='changeSel(this,entryForm.txtEmail2)'>
						<option value="-" > - 직접입력 - </option>
						<option value="naver.com"   <c:if test='${"naver.com" eq compEntryVo.email2}'>selected</c:if> >naver.com</option>
						<option value="hanmail.net" <c:if test='${"hanmail.net" eq compEntryVo.email2}'>selected</c:if> >hanmail.net</option>
						<option value="hotmail.com" <c:if test='${"hotmail.com" eq compEntryVo.email2}'>selected</c:if> >hotmail.com</option>
						<option value="gmail.com"   <c:if test='${"gmail.com" eq compEntryVo.email2}'>selected</c:if> >gmail.com</option>
						<option value="nate.com"    <c:if test='${"nate.com" eq compEntryVo.email2}'>selected</c:if> >nate.com</option>
						<option value="yahoo.com"   <c:if test='${"yahoo.com" eq compEntryVo.email2}'>selected</c:if> >yahoo.com</option>
					</select>
				</div>
				&nbsp;&nbsp;
				<input type="text" class="form-control" id="txtEmail2" name="txtEmail2" value="${compEntryVo.txtEmail2}" maxlength=25 onclick='changeTxt(entryForm.email2)' />
				<div id="email1Invalid" class="invalid-feedback">이메일은 필수 입력사항입니다.</div>
				<div id="txtEmail2Invalid" class="invalid-feedback"></div>
			</div>
			<input type="hidden" class="form-control" id="email" name="email" />
	</div>
    <div class="form-group" id="telGroup">
			<label >전화번호 :</label> &nbsp;&nbsp;
			<div class="input-group">
				<div class="input-group-prepend">
					<select id="tel1" name="tel1" class="custom-select" >
						<option value="02"  <c:if test='${"02" eq compEntryVo.tel1}'>selected</c:if> >02</option>
						<option value="031" <c:if test='${"031" eq compEntryVo.tel1}'>selected</c:if> >031</option>
						<option value="032" <c:if test='${"032" eq compEntryVo.tel1}'>selected</c:if> >032</option>
						<option value="041" <c:if test='${"041" eq compEntryVo.tel1}'>selected</c:if> >041</option>
						<option value="042" <c:if test='${"042" eq compEntryVo.tel1}'>selected</c:if> >042</option>
						<option value="043" <c:if test='${"043" eq compEntryVo.tel1}'>selected</c:if> >043</option>
						<option value="051" <c:if test='${"051" eq compEntryVo.tel1}'>selected</c:if> >051</option>
						<option value="052" <c:if test='${"052" eq compEntryVo.tel1}'>selected</c:if> >052</option>
						<option value="061" <c:if test='${"061" eq compEntryVo.tel1}'>selected</c:if> >061</option>
						<option value="062" <c:if test='${"062" eq compEntryVo.tel1}'>selected</c:if> >062</option>
					</select>
				</div>
				_<div><input type="text" id="tel2" name="tel2" value="${compEntryVo.tel2}" size=4 maxlength=4 class="form-control" required /></div>
				_<div><input type="text" id="tel3" name="tel3" value="${compEntryVo.tel3}" size=4 maxlength=4 class="form-control" required /></div>
	 			<div id="blankTel" class="is-invalid"></div>
	  			<div id="tel2Invalid" class="invalid-feedback">전화번호의 가운데 자리는 필수 입력사항입니다.</div>
	  			<div id="tel3Invalid" class="invalid-feedback">전화번호의 마지막 자리는 필수 입력사항입니다.</div> 
			</div> 
 			<input type="hidden" id="telNo" name="telNo" maxlength=13 class="form-control">
    </div>
    <div class="form-group" id="hpGroup">
			<label >휴대전화 :</label> &nbsp;&nbsp;
			<div class="input-group">
				<div class="input-group-prepend">
					<select id="hp1" name="hp1" class="custom-select">
						<option value="010" <c:if test='${"010" eq compEntryVo.hp1}'>selected</c:if> >010</option>
						<option value="011" <c:if test='${"011" eq compEntryVo.hp1}'>selected</c:if> >011</option>
						<option value="016" <c:if test='${"016" eq compEntryVo.hp1}'>selected</c:if> >016</option>
						<option value="019" <c:if test='${"019" eq compEntryVo.hp1}'>selected</c:if> >019</option>
						<option value="070" <c:if test='${"070" eq compEntryVo.hp1}'>selected</c:if> >070</option>
					</select>
				</div>
				_<div><input type="text" id="hp2" name="hp2" value="${compEntryVo.hp2}" size=4 maxlength=4 class="form-control" /></div>
				_<div><input type="text" id="hp3" name="hp3" value="${compEntryVo.hp3}" size=4 maxlength=4 class="form-control" /></div>
	 			<div id="blankHp" class="is-invalid"></div>
	  			<div id="hp2Invalid" class="invalid-feedback"></div>
	 	 		<div id="hp3Invalid" class="invalid-feedback"></div> 
			</div> 
 			<input type="hidden" id="hpNo" name="hpNo" maxlength=13 class="form-control">
    	</div>
<%-- <div class="form-group">
	    <label for="CKEDITOR">회사소개 : </label>
	    <textarea rows="5" class="form-control" id="CKEDITOR" name="memo"  value="${compEntryVo.memo}" placeholder="메모를 입력하세요" maxlength=500 ></textarea>
	    <script>
	    	<!-- ckeditor글자편집기로 작성한 내용을 사진과 함께 upload할 때 Ajax로 사진upload처리 -->
	    	CKEDITOR.replace("memo", {
	    		height:120, /*px쓰면 안뜸*/
	    		filebrowserUploadUrl : "${ctxPath}/customComp/imageUpload", //사진 1장
	    		uploadUrl : "${ctxPath}/customComp/imageUpload" //사진 여러장 드래그
	    	});
	    </script>
	    <div id="CKEDITORInvalid" class="invalid-feedback"></div>
	</div>
--%>

	<div class="form-group">
      프로필 사진(파일용량:2MByte이내) :
	  <div id="rt"><img id="rt_image" class="m-10" style="width:100%;border-radius:15px;"></div>
 	  <div class="input-group mb-3 input-group-lg">
			<div class="custom-file" >
				<label class="custom-file-label text-info" for="customImgFileName">기업 소개 사진을 추가해주세요</label>
				<input type="file" id="customImgFileName" name="fName" accept=".jpg,.gif,.png,.jpeg" class="custom-file-input border p-0 mt-2" style="width:80%; width:80px" required />
				<div id="customImgFileNameInvalid" class="invalid-feedback"></div>
			</div>
			<input type="hidden" id="photo" name="photo" />
	  </div>
    </div>
    <br>
    <div class="form-group text-center">
	    <input type="button" class="btn btn-info" id="entry" value="회원가입" onclick="checkEntryForm()" />
	    <input type="reset" class="btn btn-info"  value="다시작성"/>&nbsp;
	    <input type="button" class="btn btn-info" value="돌아가기" onclick="location.href='${ctxPath}/customComp/customCompLogin';"/><br>
	</div>
  </form>
</div>
<script>
	'use strict';
	//이미지 미리보기
 	let rt_imageChange = function(input) {
		let reader = new FileReader();
		reader.onload = function (e) {
			$('#rt_image').attr('src', e.target.result);
		}
		reader.readAsDataURL(input[0].files[0]);
	}
	// Add the following code if you want the name of the file appear on select
	$(".custom-file-input").on("change", function() {
		let fileName = $(this).val().split("\\").pop();
		$(this).siblings(".custom-file-label").addClass("selected").html(fileName);
		console.log( "fileName = " + fileName );//사진명.png
		
		//고객사진보관
		if ('' == fileName) {
			$("#photo").val('noimage.jpg');
		} else {
	    	// 사진 업로드 체크
			let fName = fileName;
	    	let ext = fName.substring(fName.lastIndexOf(".")+1);	// 파일 확장자 발췌
	    	let uExt = ext.toUpperCase();		// 확장자를 대문자로 변환
	    	let maxSize = 1024 * 1024 * 2; 	// 업로드할 회원사진의 용량은 2MByte까지로 제한한다.

			$("#photo").val(fName);
			console.log( "#photo = " + $("#photo").val() );
			let fileSize = $("#customImgFileName")[0].files[0].size;
			let fileNameTmp = $("#customImgFileName")[0].files[0].name;//nobody.jpeg
			let fileTypeTmp = $("#customImgFileName")[0].files[0].type;//img/jpeg
			
  			if(uExt != "JPG" && uExt != "JPEG" && uExt != "GIF" && uExt != "PNG") {
  				alert("업로드 가능한 파일은 'JPG/JPEG/GIF/PNG'파일 입니다.");
  				return false;
  			}
  			if(fName.indexOf(" ") != -1) {
  				alert("업로드 파일명에 공백을 포함할 수 없습니다.");
  				return false;
  			}
  			if (maxSize < fileSize) {
				alert('업로드 파일의 크기는 2MByte를 초과할 수 없습니다.');
				$("#customImgFileName").focus();
  				return false;
			}
			rt_imageChange($(this));
		}
	});
</script>  
<p><br/></p>
<br/>







	<jsp:include page="/common/footer.jsp" />
</body>
</html>