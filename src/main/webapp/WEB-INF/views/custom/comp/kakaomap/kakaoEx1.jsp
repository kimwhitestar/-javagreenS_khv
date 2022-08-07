<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
	<jsp:include page="/include/bs4.jsp"/>
    <title>KakaoEx1.jsp</title>
    <style></style>
    <script>
   	//위도latitude, 경도longitude, 장소명 저장
   	function addressCheck(latitude, longitude) {
   		var mapaddress = document.myForm.mapaddress.value;
    	if (mapaddress == "") {
    		alert("선택한 지점의 장소명을 입력하세요.");
    		document.myForm.mapaddress.focus();
    		return false;
    	}
   		//alert('위도 : '+latitude+' 경도 : '+longitude+' 장소명 : ' + mapaddress);
   		
   		var query = {
			mapaddress : mapaddress,
			latitude : latitude,
			longitude : longitude
   		}
   		
   		$.ajax({
   			type	: "post",
   			url		: "${ctxPath}/customComp/kakaoEx1",
   			data	: query,
   			success : function(res) {
   				if ('1' == res) {
   					alert('선택한 지점이 등록됬습니다');
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
	<h2>클릭한 위치에 마커 표시</h2>
	<hr/>
	
<!-- 지도를 표시할 div 입니다 -->
<div id="map" style="width:100%;height:500px;"></div>
<p><b>지도를 클릭해 주세요</b></p>
<form name="myForm">
	<div id="clickPoint"></div>
</form>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d8f3f7e2264be9f8d127deb69568488d"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = { 
//center: new kakao.maps.LatLng(36.635094996846895, 127.4595267180685), // 지도의 중심좌표
//level: 2 // 지도의 확대 레벨
    center: new kakao.maps.LatLng(36.6348, 127.45), // 지도의 중심좌표
    level: 1 // 지도의 확대 레벨
};

// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption); 

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
    message += '&nbsp; <input type="button" value="처음위치로복귀" onclick="location.reload();"/><br/>';
    message += '<p>선택한 지점의 장소명 : <input type="text" name="mapaddress"/> &nbsp;';
    message += '<input type="button" value="장소저장" onclick="addressCheck('+latlng.getLat()+','+latlng.getLng()+')"/>';
       
    //var resultDiv = document.getElementById('clickLatlng'); 
    //resultDiv.innerHTML = message;
    document.getElementById("clickPoint").innerHTML = message;
});
</script>
<hr/>
		<jsp:include page="kakaomenu.jsp"/>
		
    </div>
	<jsp:include page="/common/footer.jsp"/>
</body>
</html>