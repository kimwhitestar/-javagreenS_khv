<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>기업고객 회사소개</title>
  	<jsp:include page="/include/bs4.jsp" />
    <style></style>
    <script>
	//윈도우 onload
	$(document).ready(function(){
		parent.customLeft.location.reload(true);
		//$("#address").val('${address}');
		//addressSearch();
	});
	
	var address = '';<%--'${address}'--%>
	function addressSearch() {
		address = document.getElementById("address").value;
		if(address == "") {
			alert("회사 주소를 조회하세요");
			return false;
		}
		location.href = "${ctxPath}/customComp/customCompMap?address="+address;
	}
	
   	//위도latitude, 경도longitude, 장소명 저장
   	function addressCheck(latitude, longitude) {
   		var mapaddress = document.myForm.mapaddress.value;
    	if (mapaddress == "") {
    		alert("회사 주소를 입력하세요");
    		document.myForm.mapaddress.focus();
    		return false;
    	}
   		alert('위도 : '+latitude+' 경도 : '+longitude+' 장소명 : ' + mapaddress);
   		
   		var query = {
			mapaddress : mapaddress,
			latitude : latitude,
			longitude : longitude
   		};
   		
   		$.ajax({
   			type	: "post",
   			url		: "${ctxPath}/customComp/kakaoEx1",
   			data	: query,
   			success : function(res) {
   				if ('1' == res) {
   					alert('선택한 지점이 등록됬습니다');
					location.reload();
   				} else {
   					alert('이미 같은 지점이 있습니다. 이름을 변경해서 다시 등록하세요');
   				}
   			},
   			error	: function() {
   				alert('전송오류');
   			}
   		});
   	}
	</script>
</head>
<body>
	<p><br></p>
	<div class="container">
	<h2>기 업 고 객   회 사 소 개</h2>
	<hr/>
	<br>
	
	<form name="myForm">
		<div class="input-group mb-3" >
			<div class="input-group-prepend"><span class="input-group-text pl-4 pr-0" style="width:150px;height:50px"><h4>도로명 주소</h4></span></div>
			<input type="text" name="address" id="address" value="${address}" class="form-control custom-control custom-control-label" style="height:50px" autofocus onkeypress="if(event.keyCode==13){addressSearch();}" />
			<div class="input-group-append btn-group btn-group-lg">
				<input type="button" value="조회" onclick="addressSearch()" class="btn btn-primary text-light" style="width:130px;height:50px"/>
			</div>
		</div>
		<p>
		<b>검색할 주소 : </b>
			&nbsp;&nbsp;&nbsp;<span class="text-info"><b> (바른 예) 서울특별시 구로구 경인로67나길 </b></span>
			&nbsp;&nbsp;&nbsp;<span class="text-danger"><b> (틀린 예) 서울특별시 구로구 경인로67나길 52 </b></span>
		</p>
		<div id="map" style="width:100%;height:500px;"></div>
		<p>
		    <span class="text-danger"><b>주소 검색 후 회사위치에 마우스 클릭으로 마크해주세요</b></span>
		</p>
			
		<div id="clickPoint"></div>
	</form>
		
	<hr/>
<%-- 	<jsp:include page="kakaomenu.jsp"/> --%>
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4bdca9fd1682feca5a5acff3304e1e35&libraries=services"></script>
	<script>
		// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});
	
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(36.6348, 127.45), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };
		
		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places(); 
		// 키워드로 장소를 검색합니다
		ps.keywordSearch('${address}', placesSearchCB); 
		// 키워드 검색 완료 시 호출되는 콜백함수 입니다
		function placesSearchCB (data, status, pagination) {
		    if (status === kakao.maps.services.Status.OK) {
		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		        // LatLngBounds 객체에 좌표를 추가합니다
		        var bounds = new kakao.maps.LatLngBounds();
						
		        for (var i=0; i<data.length; i++) {
		            //displayMarker(data[i]);    
		            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
		        }       
		        
		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		        map.setBounds(bounds);
		    }
		    alert('Map에서 회사위치에 마우스 클릭으로 마크해주세요');
		}
		// 지도에 마커를 표시하는 함수입니다
		function displayMarker(place) {
		    
		    // 마커를 생성하고 지도에 표시합니다
		    var marker = new kakao.maps.Marker({
		        map: map,
		        position: new kakao.maps.LatLng(place.y, place.x) 
		    });
		    // 마커에 클릭이벤트를 등록합니다
		    kakao.maps.event.addListener(marker, 'click', function() {
		        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
		        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
		        infowindow.open(map, marker);
		    });
		}
	</script>
	
	<script>
		//지도를 클릭한 위치에 표출할 마커입니다
		var marker = new kakao.maps.Marker({ 
		    // 지도 중심좌표에 마커를 생성합니다 
		    position: map.getCenter() 
		}); 
		// 지도에 마커를 표시합니다
		marker.setMap(map);
		// 지도에 클릭 이벤트를 등록합니다
		// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
		    
		    // 클릭한 위도, 경도 정보를 가져옵니다 
		    var latlng = mouseEvent.latLng; 
		    
		    // 마커 위치를 클릭한 위치로 옮깁니다
		    marker.setPosition(latlng);
		    
		    var message = '클릭한 위치의 위도는 <font color="red">' + latlng.getLat() + '</font> 이고, ';
		    message += '경도는 <font color="red">' + latlng.getLng() + '</font> 입니다';
		    message += '&nbsp; <input type="button" value="처음위치로복귀" class="btn btn-primary text-light" style="width:130px;height:50px" onclick="location.reload();"/><br/>';
		    message += '<p>Map도로명 주소 : <input type="text" name="mapaddress"/> &nbsp;';
		    message += '<input type="button" value="위도/경도 저장" class="btn btn-primary text-light" style="width:130px;height:50px" onclick="addressCheck('+latlng.getLat()+','+latlng.getLng()+')"/>';
		       
		    //var resultDiv = document.getElementById('clickLatlng'); 
		    //resultDiv.innerHTML = message;
		    document.getElementById("clickPoint").innerHTML = message;
		});
	</script>
	<hr/>
</div>
<p><br></p>
<jsp:include page="/common/footer.jsp" />
</body>
</html>