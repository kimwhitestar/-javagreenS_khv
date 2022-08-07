<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>

<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>기업고객 고객등급수정목록</title>
	<jsp:include page="/include/bs4.jsp" />
	<style>
	tr:nth-child(even) {
		background-color: GhostWhite;
	}
	.changeGrade {
		display: inline-block;
		background-color: Lavender;
	}
	</style>
	
	<script>
	'use strict';
	let $chkAll;
	let vosLen = ${fn:length(vos)}, updCnt = 0, duplCnt = 0;
	let divHtml = '', updHtml = '';
	let isDistinct = false;

	window.onload = function() {
		console.log( "customPersonGradeUpdateList.onload()" );
		$("#msgBar").html('<font class="text-primary">'+'${msg}'+'</font>');
		for (let i=1; i<=vosLen; i++) {
			divHtml += '<div id="updateList'+ i +'"></div>';
		}
		$("#updateListGroup").html(divHtml);
		$chkAll = $("#allChk");
	}
	
  	//조건조회
	let searchCustomPersonGradeUpdateList = function() {
  		
		updateGradeForm.action = '${ctxPath}/admin/customPersonGradeUpdateList';
		updateGradeForm.submit();

		console.log( "customPersonGradeUpdateList.searchCustomPersonGradeUpdateList()" );
	}
	let $btnFSearch = $( "#fSearch" ); //jquery 이벤트 핸들러를 위한 변수
	$btnFSearch.on( "click", searchCustomPersonGradeUpdateList ); //jquery 이벤트 핸들러 on 적용, 처리핸들링함수 추가
  	
	//수정버튼 - jquery on이벤트 함수 적용
	let updateManyCustomPersonLevel = function() {
		console.log( "customPersonGradeUpdateList.updateManyCustomPersonLevel()" );
		if (0 == updCnt) {
			$("#msgBar").html('<font class="text-danger">고객등급을 수정할 수 없습니다. 수정할 고객등급을 선택해 주세요.</font>');
			return false;
		}
		
		if (confirm('선택한 회원들의 고객등급을 수정합니까?')) {
			updateGradeForm.action = '${ctxPath}/admin/customPersonGradeUpdate';
			updateGradeForm.submit();
		}
	} 
	let $btnFUpdate = $( "#fUpdate" );//jquery 이벤트 핸들러를 위한 변수
	$btnFUpdate.on( "click", updateManyCustomPersonLevel ); //jquery 이벤트 핸들러 on 적용, 처리핸들링함수 추가
	
	//전체체크박스버튼 - jquery on이벤트 함수
	let addAllUpdateHtml = function() {
		console.log( "customPersonGradeUpdateList.addAllUpdateHtml()" );
		
		$chkAll = $("#allChk");
		let isChecked = $chkAll.prop( "checked" );
		$( "input[type=checkbox]" ).each(function(idx) {
			if (0 == idx) {
				if (isChecked) updCnt = 0;
				else updCnt = vosLen;
			}
			if (0 < idx) {
				$( this ).prop( "checked", isChecked );
				console.log('customId='+$("#customId"+idx).val()+' , idx='+idx+' , isChecked='+isChecked);
	 			addUpdateHtml($("#customId"+idx).val(), $("#customGrade"+idx).val(), idx, isChecked, false);
			}
		});
	}
	$chkAll = $("#allChk");//jquery 이벤트 핸들러를 위한 변수
	$chkAll.on( "click", addAllUpdateHtml ); //jquery 이벤트 핸들러 on 적용, 처리핸들링함수 추가
	
	//체크박스버튼 - jquery on이벤트 함수
	let addUpdateHtml = function( customId, customGradeCd, idx, isChecked, isDistinct ) {
		console.log( "customPersonGradeUpdateList.addUpdateHtml()" );
		console.log( "checkbox idx : "+ idx +" , isChecked : "+ isChecked);
		//console.log( vosLen + '/' + customId + '/' + customGradeCd + '/' + idx + '/' + isChecked  + '/' + isDistinct );
		if (isChecked) {
			updHtml = '<input type="text" name="updateCustomId" value="'+customId+'"/><input type="text" name="updateCustomGradeCd" value="'+customGradeCd+'"/>';
			if (! isDistinct) {
	  			if ('' == $("#updateList" + idx).html()) 
	  				updCnt++;
			}
			if (vosLen == updCnt) {
				$chkAll = $("#allChk");
				$chkAll.prop( "checked" , true );
			}
		} else {
			updHtml = '';
			if (! isDistinct) {
	  			if ('' != $("#updateList" + idx).html()) 
					updCnt--;
			}
			if (0 == updCnt || vosLen > updCnt) {
				$chkAll = $("#allChk");
				$chkAll.prop( "checked" , false );
			}
		}
		$("#updateList" + idx).html(updHtml);
//alert(updCnt);	
	}
	$( "input[type=checkbox]" ).on( "click", addUpdateHtml );

	//개별수정
	let updateOnceCustomPersonLevel = function(customId, customGradeCd) {
 		console.log( "customPersonGradeUpdateList.updateOnceCustomPersonLevel()" );
 		$("#updateOnce").html('<input type="hidden" name="onceUpdateCustomId" value="'+customId+'"/><input type="text" name="onceUpdateCustomGradeCd" value="'+customGradeCd+'"/>');
		updateGradeForm.action = '${ctxPath}/admin/customPersonGradeUpdate';
		updateGradeForm.submit();
 	}
	
	//전체고객등급 셀렉트박스선택 후 적용버튼 - jquery on이벤트 함수
	let replaceAllCustomGrade = function(orgAllCustomGrade) {
		console.log( "customPersonGradeUpdateList.replaceAllCustomGrade()" );
		
		let newAllCustomGrade = $("#customGrade").val();//$( this ).val(); 
		let orgCustomGrade = ''; 
		//alert('newAllCustomGrade : ' + newAllCustomGrade);
		if ('' == newAllCustomGrade) { //고객등급:전체
			$( "select" ).each(function(idx) {
	 			if (0 == idx) { //alert('idx=0');
	 				compareCustomGrade('', '', 0);//addClass
				}
				if (0 < idx) { //alert('idx=' + idx);
					orgCustomGrade = $("#orgCustomGrade"+idx).val();
					newAllCustomGrade = orgCustomGrade;
					$( this ).val(orgCustomGrade);
					compareCustomGrade(orgCustomGrade, newAllCustomGrade, idx);//addClass
				}
			});
		} else { //고객등급:선택
			$( "select" ).each(function(idx) {
				
	 			if (0 == idx) { //alert('idx=0');
	 				compareCustomGrade(orgAllCustomGrade, newAllCustomGrade, 0);//addClass
				}
				if (0 < idx) { //alert('idx=' + idx);
					orgCustomGrade = $("#orgCustomGrade"+idx).val();
					$( this ).val(newAllCustomGrade);
					compareCustomGrade(orgCustomGrade, newAllCustomGrade, idx);//addClass
				}
			});
			
		}
	}
	//적용버튼 - jquery on이벤트 함수 적용
	let $btnFChange = $( "#fChange" );//jquery 이벤트 핸들러를 위한 변수
	$btnFChange.on( "click", replaceAllCustomGrade ); //jquery 이벤트 핸들러 on 적용, 처리핸들링함수 추가

  	let oldIdx = 999999999;
  	let compareCustomGrade = function(orgGrade, newGrade, idx) {
  		let $selectedChk;
  		let customGradeId = '', orgCustomGrade = '', newCustomGrade = '';

  		
  		if ( 0 == idx) {
  			$selectedChk = $("#allChk");
  			customGradeId = "customGrade";
  			orgCustomGrade = orgGrade;
  			newCustomGrade = newGrade;
  		} else {
  			$selectedChk = $("#chk"+idx);
  			customGradeId = "customGrade"+idx;
  			orgCustomGrade = orgGrade+'_'+idx;
  			newCustomGrade = newGrade+'_'+idx;
  		}
  		//alert(orgCustomGrade +':'+ newCustomGrade);
  		if (orgCustomGrade == newCustomGrade) { 
  			if (oldIdx == idx) {
  				duplCnt++;//중복카운팅
  				if (1 < duplCnt) isDistinct = true;
  			} else {
  		  		oldIdx = idx;
  		  		duplCnt = 0;
  		  		isDistinct = false;
  			} 
  			//alert(isDistinct);  			
  			$("#"+customGradeId).removeClass( "changeGrade border-primary text-primary font-weight-bold" );
  			$selectedChk.prop( "checked" , false );
  			addUpdateHtml('', '', idx, false, isDistinct);
  		} else {
  			if (oldIdx == idx) {
  				duplCnt++;//중복카운팅
  				if (1 < duplCnt) isDistinct = true;
  			} else {
  		  		oldIdx = idx;
  		  		duplCnt = 0;
  		  		isDistinct = false;
  			}
  			//alert(isDistinct);  
  			$("#"+customGradeId).addClass( "changeGrade border-primary text-primary font-weight-bold" );
  			$selectedChk.prop( "checked" , true );
  			addUpdateHtml($("#customId"+idx).val(), newGrade, idx, true, isDistinct);
  		}
  	}
	</script>
</head>

<body>
  <jsp:include page="/common/admin/header_home.jsp" />
  <jsp:include page="/common/admin/adminNav.jsp" />
  <p><br></p>
  <div class="container">
  	<h3 class="text-center">개인고객 회원등급수정목록</h3>
  	<br><div id="msgBar"></div>
  	<form name="updateGradeForm" method="post">
	  	<div id="foundConditionGroup" class="row m-2"><div class="col"></div><div class="col text-right">
		  		<label for="customGrade" class="text-left">고객등급</label>
		  		<select id="customGrade" name="customGrade" class="text-left form-control-sm" >
	  				<option value="" <c:if test="${empty customGrade}">selected</c:if> class="text-center" >- 전체 -</option>
		  			<c:forEach var="gradeVo" items="${customGradeVos}" >
		  				<option value="${gradeVo.customGradeCd}" <c:if test="${gradeVo.customGradeCd eq customGrade}">selected</c:if> > ${gradeVo.customGradeNm} </option>
		  			</c:forEach>
		  		</select>
		  		&nbsp;
<%-- 		  	<label for="point" class="text-left">포인트</label>
		  		<select id="point" name="point" class="text-left form-control-sm" <c:if test="${'2' == pointFlgVo.delFlag}"> disabled </c:if> >
	  				<c:if test="${empty point}"><option value="" class="text-center" <c:if test="${empty point}">selected</c:if> >- 전체 -</option></c:if>
		  			<c:forEach var="flgVo" items="${pointFlgVo.flagVos}" >
		  				<c:if test="${flgVo.flgCd ne 'NONE'}">
		  					<option value="${flgVo.flgCd}" <c:if test="${flgVo.flgCd eq point}">selected</c:if> > ${flgVo.flgNm} </option>
		  				</c:if>
		  			</c:forEach>
		  		</select> 
--%>
		  		&nbsp;<input type="button" id="fSearch" value="조회" class="btn btn-primary" onclick="searchCustomPersonGradeUpdateList()" /> 
		  		&nbsp;<input type="button" id="fChange" value="적용" class="btn btn-primary" onclick="replaceAllCustomGrade('${customGrade}')" />
		  		&nbsp;<input type="button" id="fUpdate" value="수정" class="btn btn-primary" onclick="updateManyCustomPersonLevel()" />
	  	</div></div>
	  	<table class="table table-bordered text-center m-0">
	  		<tr class="text-white bg-info">
	  			<th><input type="checkbox" id="allChk" class="custom-control form-check-input ml-1 mr-0" style="width:50px" onclick="addAllUpdateHtml()" ></th>
	  			<th>고객ID</th>
	  			<th>고객명</th>
	  			<th>고객구분</th>
	  			<th>고객등급</th>
	  			<th>로그인ID</th>
	  			<th>포인트</th>
	  			<th>총방문수</th>
	  			<th>방문수</th>
	  			<th>가입일</th>
	  			<th>개별수정</th>
	  		</tr>
	  		<c:if test="${empty vos}">
	  			<tr><td colspan="10"><font color="text-dark"><b>검색된 자료가 존재하지 않습니다</b></font></td></tr>
	  		</c:if>
	  		<c:if test="${! empty vos}">
 				<c:forEach var="vo" items="${vos}" begin="0" step="1" varStatus="st">
					
					<tr>
		  				<td><input type="checkbox" id="chk${st.count}" class="custom-control form-check-input ml-1 mr-0" style="width:50px" onclick="addUpdateHtml('${vo.customId}', $('#customGrade${st.count}').val(), '${st.count}', this.checked, false)" /></td>
						<td>${vo.customId}<input type="hidden" id="customId${st.count}" value="${vo.customId}"/></td>
						<td>${vo.customName}</td>
						<td>${vo.customKindName}</td>
						<td>
					  		<select id="customGrade${st.count}" name="customGrade${st.count}" class="text-left form-control-sm" onchange="compareCustomGrade('${vo.customGrade}', this.value, '${st.count}')">
					  			<c:forEach var="gradeVo" items="${customGradeVos}" >
					  				<option value="${gradeVo.customGradeCd}" <c:if test="${gradeVo.customGradeCd eq vo.customGrade}">selected</c:if> > ${gradeVo.customGradeNm} </option>
					  			</c:forEach>
					  		</select>
					  		<input type="hidden" id="orgCustomGrade${st.count}" value="${vo.customGrade}" />
						</td>
						<td>${vo.loginId}</td>
						<td><fmt:formatNumber value="${vo.point}" pattern="#,##0" /></td>
						<td>${vo.visitCnt}</td>
						<td>${vo.todayCnt}</td>
						<td>${fn:substring(vo.createDate2, 0, 10)}</td>
						<td><input type="button" value="수정" class="btn btn-primary btn-sm" onclick="javascript:updateOnceCustomPersonLevel('${vo.customId}', $('#customGrade${st.count}').val())" /></td>
					</tr>
				</c:forEach>
	  		</c:if>
	  	</table>
		<div id="updateListGroup"></div>
		<div id="updateOnce"></div>
   	</form>
  </div>
  <p><br></p>




  <jsp:include page="/common/admin/footer.jsp"/>

  </body>
</html>