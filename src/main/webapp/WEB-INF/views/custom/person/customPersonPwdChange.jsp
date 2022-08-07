<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>customPersonPwdChange.jsp</title>
  	<jsp:include page="/include/bs4.jsp" />
    <style></style>
    <script>
    	'use strict';
    	function fCheck() {
    		changPwdForm.submit();
    	}
    </script>
</head>
<body>
111111<c:out value="${existLoginIdYN}"/>
<div class="container">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="container p-3 border">
				<c:if test="${'Y' == changedPwdYN}">
					<p>비밀번호를 수정했습니다</p>
					<p><input type="button" value="창닫기" onclick="javascript:window.close();"/></p>
				</c:if>
				<c:if test="${empty changedPwdYN || 'N' == changedPwdYN}">
					<form name="changPwdForm" method="post" action="${ctxPath}/customPersonPwdChangeOk.mbr" class="was-validated">
						<h2>비 밀 번 호  재 설 정</h2>
						<c:choose>
							<c:when test="${!empty existLoginIdYN && 'N' == existLoginIdYN}"><p>ID가 존재하지않습니다</p></c:when>
							<c:when test="${!empty existEmailYN && 'N' == existEmailYN}"><p>Email이 존재하지않습니다</p></c:when>
							<c:when test="${!empty existShaEmailYN && 'N' == existShaEmailYN}"><p>Email로 전송한 본인확인 암호화문자가 확인되지않습니다</p></c:when>
							<c:when test="${!empty validPwdYN && 'N' == validPwdYN}"><p>New비밀번호와 Re비밀번호가 같지않습니다</p></c:when>
							<c:otherwise></c:otherwise>
						</c:choose>
						<div class="form-group">
							<label for="id">아이디 : </label>
							<input type="text" class="form-control" name="id" placeholder="아이디를 입력하세요." required autofocus/>
							<div class="valid-feedback"></div>
							<div class="invalid-feedback">아이디는 필수 입력사항입니다.</div>
						</div>
						<div class="form-group">
							<label for="email">이메일 : </label>
							<input type="text" class="form-control" name="email" placeholder="이메일을 입력하세요." required />
							<div class="invalid-feedback">이메일은 필수 입력사항입니다.</div>
							<button type="button" class="btn btn-secondary btn-sm" onclick="">이메일 확인</button> &nbsp;
						</div>
						<div class="form-group">
							<label for="shaEmail">이메일 확인 문자 : </label>
							<input type="text" class="form-control" name="shaEmail" placeholder="이메일 확인문자를 입력하세요." required />
							<div class="invalid-feedback">이메일 확인문자는 필수 입력사항입니다.</div>
						</div>
						<div class="form-group">
							<label for="newPwd">새비밀번호 : </label>
							<input type="text" class="form-control" name="newPwd" placeholder="새비밀번호를 입력하세요." required />
							<div class="invalid-feedback">새비밀번호는 필수 입력사항입니다.</div>
							<input type="hidden" class="form-control" name="shaNewPwd" />
						</div>
						<div class="form-group">
							<label for="rePwd">새비밀번호 확인 : </label>
							<input type="text" class="form-control" name="rePwd" placeholder="새비밀번호를 다시 입력하세요." required />
							<div class="invalid-feedback">새비밀번호 확인은 필수 입력사항입니다.</div>
							<input type="hidden" class="form-control" name="shaRePwd" />
						</div>
						<div class="form-group">
							<button type="button" class="btn btn-secondary btn-sm" onclick="fCheck()">비밀번호 찾기</button> &nbsp;
							<button type="reset" class="btn btn-secondary btn-sm">다시작성</button> &nbsp;
							<button type="button" class="btn btn-secondary btn-sm" onclick="location.href='${ctxPath}/customPersonLogin.mbr';">돌아가기</button> &nbsp;
						</div>
					</form>
				</c:if>
			</div>
		</div>
	</div>
</div>
</body>
</html>