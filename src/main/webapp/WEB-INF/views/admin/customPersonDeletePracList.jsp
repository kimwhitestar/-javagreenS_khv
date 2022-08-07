<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>개인고객 회원탈퇴신청목록</title>
	<jsp:include page="/include/bs4.jsp" />
	<script>
	'use strict';
	let $chkAll;
	let vosLen = ${fn:length(vos)}, delCnt = 0, disableCnt = 0;
	let divHtml = '', delHtml = '';

	window.onload = function() {
		
		console.log( "customPersonDeletePracList.onload()" );
		for (let i=1; i<=vosLen; i++) {
			divHtml += '<div id="delList'+ i +'">확인용</div>';
			if ('PRAC' == $("#overFlg"+i).val()) disableCnt++;
		}
		$("#delListGroup").html(divHtml);
		if( 0 == (vosLen - disableCnt) ) {
			$chkAll = $("#allChk");
			$chkAll.prop( "disabled", true );
		}
	}
	
	//삭제버튼 - jquery on이벤트 함수 적용
	let deleteManyCustomPersonPrac = function() {
		console.log( "customPersonDeletePracList.deleteManyCustomPersonPrac()" );
		
		if (0 == delCnt) {
			$("#msgBar").html('<font class="text-danger">회원을 삭제할 수 없습니다. 삭제할 회원을 선택해 주세요.</font>');
			return false;
		}
		if (confirm('선택한 회원들을 삭제합니까?')) {
			deletePracForm.action = '${ctxPath}/admin/customPersonDeletePrac';
			deletePracForm.submit();
		}
	} 
	let $btnFDelete = $( "#fDelete" );//jquery 이벤트 핸들러를 위한 변수
	$btnFDelete.on( "click", deleteManyCustomPersonPrac ); //jquery 이벤트 핸들러 on 적용, 처리핸들링함수 추가
	
	//전체체크박스버튼 - jquery on이벤트 함수
	let addAllDelHtml = function() {
		console.log( "customPersonDeletePracList.addAllDelHtml()" );
		
		$chkAll = $("#allChk");
		let isChecked = $chkAll.prop( "checked" );
		$( "input[type=checkbox]" ).each(function(idx) {
			if (0 == idx) {
				if (isChecked) delCnt = 0;
				else delCnt = vosLen;
			}
			if (0 < idx) {
				if ( ! $( this ).prop( "disabled") ) {
					$( this ).prop( "checked", isChecked );
					console.log('customId='+$("#customId"+idx).val()+' , idx='+idx+' , isChecked='+isChecked);
		 			addDelHtml($("#customId"+idx).val(), idx, isChecked);		
				}
			}
		});
	}
	$chkAll = $("#allChk");//jquery 이벤트 핸들러를 위한 변수
	$chkAll.on( "click", addAllDelHtml ); //jquery 이벤트 핸들러 on 적용, 처리핸들링함수 추가
	
	//체크박스버튼 - jquery on이벤트 함수
	let addDelHtml = function( delCustomId, idx, isChecked ) {
		console.log( "customPersonDeletePracList.addDelHtml()" );
		console.log( "checkbox idx : "+ idx +" , isChecked : "+ isChecked);
		if (isChecked) {
			delHtml = '<input type="text" name="delCustomId" value="'+delCustomId+'"/>';
			delCnt++;
			if ((vosLen - disableCnt) == delCnt) {
				$chkAll = $("#allChk");
				$chkAll.prop( "checked" , true );
			}
			
		} else {
			delHtml = '';
			delCnt--;
			if (0 == delCnt || vosLen > delCnt) {
				$chkAll = $("#allChk");
				$chkAll.prop( "checked" , false );
			}
		}
		$("#delList" + idx).html(delHtml);
	}
	$( "input[type=checkbox]" ).on( "click", addDelHtml );
	
	//개별삭제
	function deleteOnceCustomPersonPrac(delCustomId) {
		console.log( "customPersonDeletePracList.deleteOnceCustomPersonPrac()" );
		
		$("#delOnce").html('<input type="hidden" name="onceDelCustomId" value="'+delCustomId+'"/>');
		deletePracForm.action = '${ctxPath}/admin/customPersonDeletePrac';
		deletePracForm.submit();
	}
	
  	//조건조회
	function searchCustomPersonDelPracList() {
		console.log( "customPersonDeletePracList.searchCustomPersonDelPracList()" );
		deletePracForm.action = '${ctxPath}/admin/customPersonDeletePracList';
		deletePracForm.submit();
	}
  	
	</script>
</head>
<body>
  <jsp:include page="/common/admin/header_home.jsp" />
  <jsp:include page="/common/admin/adminNav.jsp" />
  <p><br></p>
  
  <div class="container">
  	<h3 class="text-center">개인고객 회원탈퇴신청목록</h3>
  	<br>
  	<div id="msgBar"></div>
  	<form name="deletePracForm" method="post">
	  	<div id="foundConditionGroup" class="row m-2"><div class="col"></div><div class="col text-right">
	  		<label for="overFlg" class="text-left">30일 경과 여부</label>
	  		<select id="overFlg" name="overFlg" class="text-left form-control-sm" <c:if test="${'2' == delOverFlgVo.delFlag}"> disabled </c:if> >
	  			<c:forEach var="flgVo" items="${delOverFlgVo.flagVos}" >
	  				<option value="${flgVo.flgCd}" <c:if test="${overFlg eq flgVo.flgCd}">selected</c:if> > ${ flgVo.flgNm} </option>
	  			</c:forEach>
	  		</select>
	  		&nbsp;<input type="button" id="fSearch" value="조회" class="btn btn-primary" onclick="searchCustomPersonDelPracList()"/> 
	  		&nbsp;<input type="button" id="fDelete" value="삭제" class="btn btn-danger" onclick="deleteManyCustomPersonPrac()"/>
	  	</div></div>
	  	<table class="table table-bordered text-center m-0">
	  		<tr class="text-white bg-info">
	  			<th><input type="checkbox" id="allChk" class="custom-control form-check-input ml-1 mr-0" style="width:50px" onclick="addAllDelHtml()" ></th>
				<th>로그인ID</th>
	  			<th>고객ID</th>
	  			<th>고객명</th>
	  			<th>생년월일</th>
	  			<th>탈퇴 경과일</th>
	  			<th>탈퇴 경과</th>
	  			<th>탈퇴일시</th>
	  			<th>탈퇴자</th>
	  			<th>회원삭제</th>
	  		</tr>
	  		<c:if test="${empty vos}">
	  			<tr><td colspan="10"><font color="text-dark"><b>검색된 자료가 존재하지 않습니다</b></font></td></tr>
	  		</c:if>
	  		<c:if test="${! empty vos}">
 				<c:forEach var="vo" items="${vos}" begin="0" step="1" varStatus="st">
					<tr>
		  				<td><input type="checkbox" class="custom-control form-check-input ml-1 mr-0" style="width:50px" onclick="addDelHtml('${vo.customId}', '${st.count}', this.checked)" <c:if test="${'PRAC' eq vo.overFlg}">disabled</c:if> /></td>
						<td>${vo.loginId}</td>
						<td>${vo.customId}<input type="hidden" id="customId${st.count}" value="${vo.customId}"/></td>
						<td>${vo.customName}</td>
						<td>${vo.birthDate}</td>
						<td>${vo.overDaysUserDel}</td>
						<td>${vo.overFlg}<input type="hidden" id="overFlg${st.count}" value="${vo.overFlg}"/></td>
						<td>${vo.deleteDate}</td>
						<td>${vo.deleteUser}</td>
						<td><input type="button" value="삭제" <c:if test="${'OVER' eq vo.overFlg}"> class="btn btn-danger btn-sm" </c:if> <c:if test="${'PRAC' eq vo.overFlg}"> class="btn btn-secondary btn-sm" </c:if> onclick="deleteOnceCustomPersonPrac('${vo.customId}')" <c:if test="${'PRAC' eq vo.overFlg}">disabled</c:if> /></td>
					</tr>
				</c:forEach>
	  		</c:if>
	  	</table>
		<div id="delListGroup"></div>
		<div id="delOnce"></div>
   	</form>
  </div>
  <p><br></p>
  <jsp:include page="/common/admin/footer.jsp"/>
  </body>
</html>