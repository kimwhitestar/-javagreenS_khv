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
    	let cnt = 1;
    	
    	function checkForm() {
			let maxSize = 1024 * 1024 * 10;
			let title = $("#title").val();
			let pwd = $("#pwd").val();
			
			if(null == $("#file").val() || "" == $("#file").val().trim()) {
				alert('파일을 선택하세요')
				return false;
			}
			if("" == title.trim()) {
				alert('파일 제목을 입력하세요')
				$("#pwd").focus();
				return false;
			}
			if("" == pwd.trim()) {
				alert('비밀번호를 입력하세요')
				return false;
			}
			let file = '', fName = '';
			let fileSize = 0, ext = '', uExt = '';
			let files = document.getElementById("file").files;
			for (let i=1; i<=files.length; i++) {
				file = files[i];
				fName = file.name;
				
				if (null != fName && '' != fName) {
					ext = fName.substring(fName.lastIndexOf(".")+1);
					uExt = ext.toUpperCase();

		    		if ("JPG" != uExt && "JPEG" != uExt && "GIF" != uExt 
	       				&& "HWP" != uExt && "PDF" != uExt && "DOC" != uExt 
	       				&& "PPT" != uExt && "PPTX" != uExt 
	       				&& "ZIP" != uExt) {
	    				alert('업로드 가능한 파일이 아닙니다');
	        			return false;
	        		} else {
	        			fileSize += file.size;
	        		}
				}
			}
    		if (fileSize > maxSize) {
    			alert('업로드할 파일의 최대용량은 20MB입니다');
    			return false;
    		}
    		else {
    			fileForm.fileSize.value = fileSize;
    			fileForm.submit();
    		}
    	}
    	function fileBoxAppend() {
    		cnt++;
    		let filebox = '';
    		filebox += '	<div id="filebox"'+cnt+' class="form-group">';
    		filebox += '		<input type="file" name="fName" id="fName"'+cnt+' class="form-control-file border" style="width:85%;float:left;" />';
    		filebox += '		<input type="button" value="삭제" onclick="deleteBox('+cnt+')" class="btn btn-danger form-control ml-2" style="width:10%" />';
    		filebox += '	</div>';
    		$("#fileInsert").append(filebox);
    	}
    	function deleteBox(cnt) {
    		$("#filebox"+cnt).remove();
    	}
    </script>
</head>
<body>

<!-- Page content -->
<div class="w3-content w3-padding" style="max-width:100%">
<br>
	<form name="fileForm" method="post" enctype="multipart/form-data">
		<h2>자 료 올 리 기</h2>	
		<div class="form-group">
			<input type="file" id="file" multiple="multiple" class="form-control-file border" accept=".jpg,.gif,.png,.zip,.ppt,.pptx,.hwp,.pdf"/>
		</div>
		<div class="form-group">올린이 : ${sNickName}</div>
		<div class="form-group">
			<label for="title">제목 : </label>
			<input type="text" name="title" id="title" placeholder="자료의 제목을 입력하세요" class="form-control" required>
		</div>
		<div class="form-group">
			<label for="content">내용 : </label>
			<textarea rows="4" name="content" id="content" class="form-control">		
		</div>
		<div class="form-group">
			<label for="part">분류 : </label>
			<select name="part" id="part" class="form-control">
				<option value="학습">학습</option>
				<option value="여행" selected>여행</option>				
				<option value="음식">음식</option>				
				<option value="기타">기타</option>				
			</select>	
		</div>
		<div class="form-group"><label for="openSW">공개여부 : </label>&nbsp;
			<input type="radio" name="openSW1" id="openSW1" value="공개" checked />공개 &nbsp;
			<input type="radio" name="openSW2" id="openSW2" value="비공개" checked />비공개 
		</div>
		<div class="form-group">
			<label for="pwd">비밀번호 : </label>
			<input type="password" name="pwd" id="pwd" class="form-control" placeholder="비밀번호를 입력하시오">
		</div>
		
		<div class="form-group text-center">
			<input type="button" value="자료올리기" onclick="checkForm()" class="btn btn-primary">&nbsp;&nbsp;
			<input type="reset" value="다시쓰기" class="btn btn-info">&nbsp;&nbsp;
			<input type="button" value="돌아가기" onclick="location.href='${ctxPath}/pds/pdsList?pageNo=${pagingVo.pageNo}&pageSize=${pagingVo.pageSize}&division=${pagingVo.division}'" class="btn btn-secondary">
		</div>
		<input type="hidden" name="mid" value="${sMid}" />
		<input type="hidden" name="nickName" value="${sNickName}" />
		<input type="hidden" name="fileSize" />
	</form>
<!-- End page content -->
</div>

<!-- Footer -->
<jsp:include page="/common/footer.jsp" />
</body>
</html>