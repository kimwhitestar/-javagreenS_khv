<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<c:set var="qrCodePath" value="D:/JavaGreen/springframework/works/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/javagreenS_khv/resources/data/qrCode" />
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv=“Content-Type” content=“text/html; charset=UTF-8”>
  <title>qrCode.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script>
    'use strict';
    
<%--  	fetch("requestUrlToFile",
		{
		    method: "GET",
		    headers: {
		        "authorization": "jwt"
		    }
		})
	    .then(checkStatus)
	    .then(function(res){
	        return res.blob();
	    })
	    .then(function(data){
	        let filename =  "PdfName-" + new Date().getTime() + ".pdf";
	        let blob = new Blob([data], { type: 'application/pdf' });
	        alert('안되는걸까');
	        download(blob, filename);
	    });
	
	function download(blob, filename) {
		alert('test');
	  //first we need to prepend BOM for the UTF-8 text types
	  if (/^\s*(?:text\/\S*|application\/xml|\S*\/\S*\+xml)\s*;.*charset\s*=\s*utf-8/i.test(blob.type)) {
	    blob = new Blob([String.fromCharCode(0xFEFF), blob], {type: blob.type});
	  }
	  //than we need to declare all variable to check which download we need to use
	  let donwload_url = window.URL || window.webkitURL || window
	      ,blob_url = download_url.createObjectURL(blob)
	      ,download_link = document.createElementNS("http://www.w3.org/1999/xhtml", "a")
	      ,use_download_link = "download" in download_link
	      ,click = function(node){ let event = new MouseEvent("click"); node.dispatchEvent(event); }
	      ,is_opera = (!!view.opr && !!opr.addons) || !!view.opera || navigator.userAgent.indexOf(' OPR/') >= 0
	      ,is_chrome = !!view.chrome && !!view.chrome.webstore
	      ,is_safari = Object.prototype.toString.call(view.HTMLElement).indexOf('Constructor') > 0 || !is_chrome && !is_opera && view.webkitAudioContext !== undefined
	      ,is_chrome_ios =/CriOS\/[\d]+/.test(navigator.userAgent)
	      ,forceable_type = "application/octet-stream"
	      ,type = blob.type
	      ,forced_download = type === forceable_type;
	  //now we can start checking which download we use
	  if (typeof window === "undefined" || typeof window.navigator !== "undefined" && /MSIE [1-9]\./.test(window.navigator.userAgent)) {
	      return; //IE <10 is not supported
	  } else if (typeof navigator !== "undefined" && navigator.msSaveOrOpenBlob) {
	      window.navigator.msSaveOrOpenBlob(blob, filename);
	  } else if(use_download_link) {
	      download_link.href = blob_url;
	      download_link.download = filename;
	      click(save_link);
	  } else if((is_chrome_ios || (forced_download && is_safari)) && window.FileReader){
	      let reader = new FileReader();
	      reader.onloadend = function(){
	          let url = is_chrome_ios ? reader.result : reader.result.replace(/^data:[^;]*;/, 'data:attachment/file;');
	          let openWindow = window.open(url, "_blank");
	          if(!openWindow) window.location.href = url;
	      }
	  } else {
	      if(force){
	          window.location.href = blob_url;
	      } else { 
	          let openWindow = window.open(blob_url, "_blank");
	          if(!openWindow) window.location.href = url;
	      }
	  }
	}	 
--%>

    let qrCreate = function() {
    	$.ajax({
  			url  : "${ctxPath}/customComp/qrCreate",
  			type : "post",
  			data : {
  				extention : 'png',
  				qrCodeStartNobodyOrMoveUrls : 'customCompQrStart' 
  			},
  			success : function(data) {
				alert("qr코드 생성완료 : "+data);
				$("#qrCodeView").show();
				$("#qrView").html(qrCodePath + '/' +data+ '.png')
				let qrCodeImgName = "${ctxPath}/data/qrCode/" + data + ".png";
	  			let qrImage = '<img src="'+qrCodeImgName+'"/>'; 
				$("#qrImage").html(qrImage);
			},
			errors : function() {
				alert('전송 오류~~');				
			}
		});
	}
	let $btnFCreate = $( "#fCreate" );//jquery 이벤트 핸들러를 위한 변수
	$btnFCreate.on( "click", qrCreate ); //jquery 이벤트 핸들러 on 적용, 처리핸들링함수 추가
	
	
	let loginQrCode = function() {
		myForm.action= "${ctxPath}/customComp/loginQrCode";
		myForm.submit();
	}
	let $btnFLogin = $( "#fLogin" );//jquery 이벤트 핸들러를 위한 변수
	$btnFLogin.on( "click", loginQrCode ); //jquery 이벤트 핸들러 on 적용, 처리핸들링함수 추가

	</script>
</head>
<body>
<p><br></p>
<div class="container">
  <form name="myForm" method="post">
	  <h2>QR코드 생성하기</h2>
	  <hr/>
 	  <div id="qrCreateGroup" class="input-group mb-3 input-group-lg">
			<div class="custom-file">
				<label class="custom-file-label text-info" for="customDir">QR코드 저장할 폴더를 선택해주세요( 사용자폴더만 가능합니다, 다운로드폴더, 사진폴더 등 )</label>
				<input type='file' id="customDir" name="customDir" class="custom-file-input border p-0 mt-2" style="width:80%; width:80px" webkitdirectory /><%--출처: https://hianna.tistory.com/347 [어제 오늘 내일:티스토리]--%>
			</div>
			<input type="button" id="fCreate" value="QR생성" onclick="qrCreate()" class="btn btn-primary btn-lg"/>
	  </div>

	  <hr/>
	  <div id="qrCodeView" style="display:none">
	    <h3>생성된 QR코드 확인하기</h3>
	    <div>
			- 생성된 qr코드명 : <span id="qrView"></span>
			<br>
			<span id="qrImage"></span>
		</div>
	  </div>
	<hr/>
	<p><br></p>
	<h2>QR코드 로그인</h2>
	<hr/>
 	  <div id="qrLoginGroup" class="input-group mb-3 input-group-lg">
			<div class="custom-file">
				<label class="custom-file-label text-info" id="customImgFileNameLbl" for="customImgFileName">QR코드 사진을 선택해주세요</label>
				<input type="file" id="customImgFileName" name="customImgFileName" class="custom-file-input border p-0 mt-2" style="width:80%; width:80px"/>
			</div>
   			<input type="button" id="fLogin" value="QR로그인" onclick="loginQrCode()" class="btn btn-primary btn-lg"/>
	  </div>
  </form>
  
  
  
<script>
	'use strict';
	// Add the following code if you want the name of the file appear on select
	$('#qrLoginGroup input[name="customImgFileName"]').on("change", function() {
		let fileName = $(this).val().split("\\").pop();
		$(this).siblings(".custom-file-label").addClass("selected").html(fileName);
	});
	$('#qrLoginGroup input[name="customDir"]').on("change", function() {
		let fileName = $("#customDir")[0].files[0].webkitRelativePath;//webkitRelativePath로 받은 빈디렉토리에서 자동생성된 화일은 무조건 .ini 확장자를 갖는 화일을 같이 갖고 있다
		let dirName = fileName.substring(0, fileName.indexOf('.'));     //"${fn:substring(fileName, 0, fn:indexOf(fileName, '.'))}";
		$(this).siblings(".custom-file-label").addClass("selected").html(dirName + "webkitRelativePath는 디렉토리명이 바껴서 저장이 안됩니다");
	});
</script>
  
</div>
<p><br></p><p><br></p><p><br></p>
<jsp:include page="/common/footer.jsp" />
</body>
</html>