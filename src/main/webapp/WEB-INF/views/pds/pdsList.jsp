<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <jsp:include page="${ctxPath}/include/bs4.jsp" />
    <style></style>
    <script>
    	'use strict';
    	
    	//부분자료 검색처리
    	function partCheck() {
    		let part = partForm.part;
    		location.href = "${ctxPath}/pds/pdsList?part="+part;
    	}
    	
    	//다운로드 수 증가처리
    	function checkDownNum(idx) {
    		$.ajax({
    			type 	: "post",
    			url		: "${ctxPath}/pds/pdsDownNum",
    			data	: {idx : idx},
    			success : function() {
    					location.reload();
    			},
    			error	: function() {
    				alert("전송오류");
    			}
    		});
    	}
    	
    	//파일 상세화면
    	function newWindow(idx) {
    		let url = "${ctxPath}/pds/pdsDetail?idx="+idx;
    		window.open(url,"pdsDetail","width=1000px,height=800px");
    	}
    	
    	//동적폼 이용한 비밀번호BOX 표시
    	function pdsDelCheckOpen(idx) {
    		$(".styleDeletePwd").slideUp(300);
    		$(".styleBtnOpen").show();
    		$(".styleBtnClose").hide();
    		
    		let str = '';
    		str += '<div id="deletePwd'+idx+'" class="text-center p-2 styleDeletePwd">';
    		str += '현자료의 비밀번호를 입력하세요 : ';
    		str += '<input type="password" name="pwd" id="pwd'+idx+'" />&nbsp;';
    		str += '<input type="button" value="비밀번호확인" onclick="pwdCheck('+idx+')" />';
    		str += '</div>';
    		
    		$("#btnOpen"+idx).hide();
    		$("#btnClose"+idx).show();
    		$("#divDelete"+idx).slideDown(300);
       		$("#divDelete"+idx).html(str);
       	}
    	
    	//동적폼 이용한 비밀번호BOX 닫기
    	function pdsDelCheckClose(idx) {
    		$("#btnOpen"+idx).show();
    		$("#btnClose"+idx).hide();
    		$("#divDelete"+idx).slideUp(300);
    	}
    	
    	function pwdCheck(idx) {
    		let pwd = $("#pwd"+idx).val();
    		if ("" == pwd.trim()) {
    			alert("비밀번호를 입력하세요!");
    			$("#pwd"+idx).focus();
    			return false;
    		}
    		
    		$.ajax({
    			type : "post",
    			url : "${ctxPath}/pds/pdsPwdCheck",
    			data : {
    				idx : idx,
    				pwd : pwd
    			},
    			success : function(res) {
    				if ("1" != res) {
    					alert("비밀번호가 틀립니다");
    					$("#pwd"+idx).focus();
    				} else {
    					alert("삭제됬습니다");
    					location.reload();
    				}
    			},
    			error : function() {
					alert("전송오류~~");
    			}
    		});
    	}
    	
    	//파일 삭제 처리하기
    	function checkPdsDel(idx, fSName) {
    		if (!confirm("파일을 삭제하시겠습니까?")) return false;
    		
    		let query = {	idx : idx,
    						fSName : fSName,
    						pwd : pwd	};
    		$.ajax({
    			type : "post",
    			url		: "${ctxPath}/pds/pdsDelete",
    			data	: query,
    			success	: function(res) {
    				if ('pdsDeleteOk' == res) {
    					alert('삭제됬습니다');
    				} else if ('pdsDeleteNo' == res) {
    					alert('삭제 실패~~');
    				} else if ('pwdNo' == res) {
    					alert('비밀번호가 틀립니다');
    				}
    			},
    			error	: function() {
    				alert('전송 오류~~');//sql exception과 무관
    			}
    		});
    	}
    	
    	function changePage(pageNo) {
    		$("#pageNo").val(pageNo);
    		boardForm.action = "${ctxPath}/pds/pdsList?part=${pagingVo.part}&pageNo=${pagingVo.pageNo}";
    		boardForm.submit();
    	}

    </script>
</head>
<body>

<!-- Page content -->
<div class="w3-content w3-padding" style="max-width:100%">
<br>
	<h2 class="text-center">자 료 실 리 스 트(${pagingVo.part})</h2>
	<br>
	<table class="table table-borderless text-center">
		<tr>
			<td class="text-left" style="width:30%">
				<form name="partForm" >
					<select name="part" onchange="partCheck()" class="form-control">
						<option value="전체" ${pagingVo.part=='전체' ? selected : ''}>전체</option>
						<option value="학습" ${pagingVo.part=='학습' ? selected : ''}>학습</option>
						<option value="여행" ${pagingVo.part=='여행' ? selected : ''}>여행</option>
						<option value="음식" ${pagingVo.part=='음식' ? selected : ''}>음식</option>
						<option value="기타" ${pagingVo.part=='기타' ? selected : ''}>기타</option>
					</select>
				</form>
			</td>
			<td class="text-right" style="width:65%"><a href='${ctxPath}/pds/pdsInput' class="btn btn-outline-success">자료올리기</a></td>
		</tr>
	</table>
	<table class="table table-hover table-borderless text-center">
		<tr class="table-dark text-dark">
			<th>번호</th>
			<th>자료제목</th>
			<th>올린이</th>
			<th>올린날짜</th>
			<th>분류</th>
			<th>파일명(사이즈)</th>
			<th>다운수</th>
			<th>비고</th>
		</tr>
		<c:set var="curScrStartNo" value="${pagingVo.curScrStartNo}"/>
		<input type="hidden" id="idx" name="idx" />
		<c:forEach var="vo" items="${vos}">
		  <tr>
			<td><c:out value="${curScrStartNo}"/></td>
			<td>
				<c:if test="${'공개' == vo.openSW || sMid == vo.mid || 0 == sLevel}">
					<a href="javascript:newWindow(${vo.idx});">
						${vo.title}
					</a>
				</c:if>
				<c:if test="${'공개' != vo.openSW || sMid != vo.mid || 0 != sLevel}">
					${vo.title}
				</c:if>
			</td>
			<td>${vo.nickName}</td>
			<td>
				${fn:substring(vo.FDate, 0, 10)}
			</td>
			<td>${vo.part}</td>
			<td>
				<c:if test="${'공개' == vo.openSW || sMid == vo.mid || 0 == sLevel}">
					<%--${vo.FSName}--%>
					<c:set var="fNames" value="${fn:split(vo.FName,'/')}"/>
					<c:set var="fSNames" value="${fn:split(vo.FSName,'/')}"/>
					<c:forEach var="fName" items="${fNames}" varStatus="st">
						<a href="${ctxPath}/pds/${fNames[st.index]}" download="${fName}" onclick="checkDownNum(${vo.idx})">${fName}</a><br>
					</c:forEach>
					<br>(<fmt:formatNumber value="${vo.FSize / 1024}" pattern="#,##0"/> KB)
				</c:if>
				<c:if test="${'공개' != vo.openSW && sMid != vo.mid && 0 != sLevel}">
					비공개
				</c:if>
			</td>
			<td>${vo.downNum}</td>
			<td>
				<c:if test="${sMid == vo.mid || 0 == sLevel}">
					<a href="${ctxPath}/pds/pdsCompress?idx=${vo.idx}&fName=${vo.fName}&fSName=${vo.fSName}&title=${vo.title}" class="btn btn-danger btn-sm" >압축다운로드</a> 
					<a href="javascript:pdsDelCheckOpen(${vo.idx})" id="btnOpen${vo.idx}" class="btn btn-danger btn-sm styleBtnOpen" >삭제</a> 
					<a href="javascript:pdsDelCheckClose(${vo.idx})" id="btnClose${vo.idx}" class="btn btn-prime btn-sm styleBtnClose" display="none">닫기</a> 
				</c:if>
			</td>
		  </tr>
		  <tr><td colspan="8" class="p-1"><div id="divDelete${vo.idx}"></div></td></tr>
		  <c:set var="curScrStartNo" value="${pagingVo.curScrStartNo-1}"/>
		</c:forEach>
	</table>
	
	<!-- 블럭페이징 처리 시작 -->
	<div class="text-center">
		<div class="pagination justify-content-center">
		<c:if test="${pagingVo.pageNo > 1}">
			<li class="page-item"><a href="javascript:changePage(1)" title='first' class="page-link text-secondary" >첫페이지</a></li>
		</c:if>
		<c:if test="${pagingVo.curBlock > 0}">
			<li class="page-item"><a href="javascript:changePage('${(pagingVo.curBlock-1)*pagingVo.blockSize+1}')" title='prevBlock' class="page-link text-secondary" >이전블록</a>
		</c:if>
			<c:forEach var="i" begin="${(pagingVo.curBlock*pagingVo.blockSize)+1}" end="${(pagingVo.curBlock*pagingVo.blockSize)+pagingVo.blockSize}">
		      <c:if test="${i <= pagingVo.totPage && i == pagingVo.pageNo}">
		        <li class="page-item active"><a href="javascript:changePage('${i}')" class="page-link text-light bg-secondary border-secondary" >${i}</a>
		      </c:if>
		      <c:if test="${i <= pagingVo.totPage && i != pagingVo.pageNo}">
		        <li class="page-item"><a href="javascript:changePage('${i}')" class="page-link text-secondary" >${i}</a>
		      </c:if>
		    </c:forEach>
		<c:if test="${pagingVo.curBlock < pagingVo.lastBlock}">
			<li class="page-item"><a href="javascript:changePage('${(pagingVo.curBlock+1)*pagingVo.blockSize+1}')" title='nextBlock' class="page-link text-secondary" >다음블록</a>
		</c:if>
		<c:if test="${pagingVo.pageNo != pagingVo.totPage}">
		<li class="page-item"><a href="javascript:changePage('${pagingVo.totPage}')" title='last' class="page-link text-secondary" >마지막페이지</a>
		</c:if>
		</div>
	</div>
	<!-- 블럭페이징 처리 끝 -->
	<br>

<!-- End page content -->
</div>

<!-- Footer -->
<jsp:include page="/common/footer.jsp" />
</body>
</html>