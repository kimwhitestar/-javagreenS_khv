<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<c:set var="LF" value="\n" scope="page" />
<c:set var="BR" value="<br>" scope="page" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <jsp:include page="${ctxPath}/include/bs4.jsp" />
    <style>
    	th {
    		background-color : #eee;
    	}
    </style>
    <script>
    	'use strict';
    </script>
</head>
<body>
<div class="w3-content w3-padding" style="max-width:100%">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">${vo.title} (분류 : ${vo.part})</h4>
          <button type="button" class="close" onclick="window.close()">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          <hr/>
          - <b>올린이</b> : ${vo.nickName} <br>
          - <b>아이디</b> : ${vo.mid} <br>
          - <b>파일명</b> : ${vo.FName} <br>
          - <b>파일크기</b> : <fmt:formatNumber value="${vo.FSize / 1024}" pattern="#,##0"/> KB <br>
          - <b>올린날짜</b> : ${vo.FDate} <br>
          - <b>다운로드수</b> : ${vo.downNum} <br>
          - <b>자료설명</b> : <br>
          <p>${fn:replace(vo.content, LF, BR)}</p>
			<c:set var="fNames" value="${fn:split(vo.FName,'/')}"/>
			<c:set var="fSNames" value="${fn:split(vo.FSName,'/')}"/>
			<c:forEach var="fSName" items="${fSNames}" varStatus="st">
				${st.count}. ${fSName}<br>
				<c:set var="fSNameLen" value="${fn:length(fSName)}"/>
				<c:set var="ext" value="${fn:substring(fSName, fSNameLen-3, fSNameLen)}"/>
				<c:set var="extUpper" value="${fn:toUpperCase(ext)}"/>
				<c:if test="${'JPG' == extUpper || 'GIF' == extUpper || 'PNG' == extUpper}">
					<img src="${ctxPath}/data/pds/${fSName}" width="500px">
				</c:if>
				<hr/>
			</c:forEach>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" onclick="window.close()">Close</button>
        </div>
        
      </div>
    </div>
</div>
</body>
</html>