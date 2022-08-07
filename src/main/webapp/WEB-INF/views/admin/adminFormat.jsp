<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title></title>
  <jsp:include page="/include/bs4.jsp" />
  <style>
  </style>
  <script>
  'use strict';
	//윈도우 로딩시에 본문의 내용을 메모리로 모두 올리고 작업준비한다.
	window.onload = function() {
		let $btnFDelete = $( "#fDelete" );
		 
		function handler1() {
		  console.log( "handler1" );
		  $btnFDelete.off( "click", handler2 );
		}
		 
		function handler2() {
		  console.log( "handler2" );
		  document.getElementById("test").innerHTML = "<b>삭제</b>";
		}
		 
		$btnFDelete.on( "click", handler1 );
		$btnFDelete.on( "click", handler2 );

		// 버튼 처리 형식 : 변수명.리스너('이벤트', function(){});
		//let fDelete = document.getElementById("fDelete");
		/* fDelete.addEventListener('click', function(){
          document.getElementById("test").innerHTML = "<b>삭제</b>";
      }); */
	}
  </script>
</head>
<body>
  <jsp:include page="/common/admin/header_home.jsp" />
  <jsp:include page="/common/admin/adminNav.jsp" />

  <p><br></p>
  <div class="container">

  </div>
<div id="test">
</div>
<jsp:include page="/common/admin/footer.jsp"/>
</body>
</html>