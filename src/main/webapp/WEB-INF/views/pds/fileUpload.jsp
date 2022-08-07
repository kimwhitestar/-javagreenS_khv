<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>fileUpload.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script>
  'use strict';
  
  </script>
</head>
<body>

<!-- Page content -->
<div class="w3-content w3-padding" style="max-width:100%">
<br>
  <h2>File Upload 연습</h2>
  <form name="myForm" method="post" enctype="multipart/form-data">
  	<p>파일명 : <input type="file" name="fName" id="fName" class="form-control-file border" accept=".jpg,.jpeg,.gif,.png,.zip" /></p>
	<p>
		<input type="submit" value="File Upload" class="btn btn-secondary">
	</p>  	
  </form>
<!-- End page content -->
</div>

<!-- Footer -->
<jsp:include page="/common/footer.jsp" />
</body>
</html>