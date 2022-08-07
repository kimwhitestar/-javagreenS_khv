<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
	<jsp:include page="/include/bs4.jsp"/>
    <title>KakaoEx2.jsp</title>
    <style></style>
    <script>
   	//위도latitude, 경도longitude, 장소명 저장
 	var	latitude = '${vo.latitude}';
	var	longitude = '${vo.longitude}';
	var	mapaddress = '${mapaddress}';
   	function addressSearch() {
   		mapaddress = document.getElementById("mapaddress").value;
   		if ('' == mapaddress) {
   			alert('검색할 지점의 장소명을 선택하세요.');
   			return false;
   		}
   		//alert('위도 : '+latitude+' 경도 : '+longitude+' 장소명 : ' + mapaddress);
		location.href = "${ctxPath}/customComp/kakaoEx2?mapaddress="+mapaddress;
   	}
   	function addressDelete() {
   		mapaddress = document.getElementById("mapaddress").value;
   		if ('' == mapaddress) {
   			alert('검색할 지점의 장소명을 선택하세요.');
   			return false;
   		}
		if (!confirm('선택하신 지역명을 DB에서 삭제합니까?')) return false;
		$.ajax({
			type : "post",
			url : "${ctxPath}/customComp/kakaoEx2Delete",
			data : {mapaddress : mapaddress},
			success : function() {
				alert('DB에 저장된 지역명이 삭제됬습니다');
				location.href = '${ctxPath}/customComp/kakaoEx2';
			},
			error : function() {
				alert('전송오류!');
			}
		});
   	}
    </script>
</head>
<body>
    <p><br></p>
    <div class="container">
	<h2>저장된 지명으로 검색</h2>
	<hr/>
	<div class="m-2">
		<form name="myForm" method="post">
			<div>
				<font size="4"><b>저장된 지명으로 검색</b></font>
				<select name="mapaddress" id="mapaddress">
					<option value="">지명선택</option>
					<c:forEach var="vo" items="${vos}">
						<option value="${vo.mapaddress}" <c:if test="${vo.mapaddress == mapaddress}">selected</c:if> > ${vo.mapaddress}</option>
					</c:forEach>
				</select>
				<input type="button" value="지역검색" onclick="addressSearch()"/>
				<input type="button" value="지역명DB에서삭제" onclick="addressDelete()"/>
			</div>
		</form>
	</div>



<!-- 지도를 표시할 div 입니다 -->
<div id="map" style="width:100%;height:500px;"></div>
<p><b>지도를 클릭해 주세요</b></p>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d8f3f7e2264be9f8d127deb69568488d&libraries=services,clusterer,drawing"></script>
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


//장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places(); 

// 키워드로 장소를 검색합니다
ps.keywordSearch(mapaddress, placesSearchCB); 

// 키워드 검색 완료 시 호출되는 콜백함수 입니다
function placesSearchCB (data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        var bounds = new kakao.maps.LatLngBounds();

/*         for (var i=0; i<data.length; i++) {
            displayMarker(data[i]);    
            bounds.extend(new kakao.maps.LatLng(latitude, longitude));
        }
 */        
        displayMarker(data[0]);
        bounds.extend(new kakao.maps.LatLng(latitude, longitude));
        

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.setBounds(bounds);
    } 
}

// 지도에 마커를 표시하는 함수입니다
function displayMarker(place) {
    
    // 마커를 생성하고 지도에 표시합니다
    var marker = new kakao.maps.Marker({
        map: map,
        position: new kakao.maps.LatLng(latitude, longitude) 
    });

    // 마커에 클릭이벤트를 등록합니다
    kakao.maps.event.addListener(marker, 'click', function() {
        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
        infowindow.open(map, marker);
    });
}
</script>
<hr/>
		<jsp:include page="kakaomenu.jsp"/>
		
    </div>
	<jsp:include page="/common/footer.jsp"/>
</body>
</html>