<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>제주바라기:여행지</title>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
	<link href="${conPath }/css/map.css" rel="stylesheet">
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=745b8108fc2b2f1d3e2f0adfdee1fdc1&libraries=services"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(document).ready(function(){
			var code = '${param.ccode}';
			if(code == 'AT4'){
				$('#AT4').addClass('selected');
			}else if(code == 'CT1'){
				$('#CT1').addClass('selected');
			}else if(code == 'AD5'){
				$('#AD5').addClass('selected');
			}else if(code == 'FD6'){
				$('#FD6').addClass('selected');
			}else if(code == 'CE7'){
				$('#CE7').addClass('selected');
			}else{
				$('#ALL').addClass('selected');
			}
			$('.detail').click( function (){
				$('.detail').removeClass("selected");
				var sid = $(this).attr('id');
				$('#'+sid).addClass("selected");
		    	$('#list').animate({scrollTop : $('#'+sid).offset().top}, 500);
			});
			
		});
	</script>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="main">
		<div id="code">
			<ul>
				<li><a href="${conPath }/spotList.do" id="ALL">ALL</a></li>
				<li><a href="${conPath }/spotList.do?ccode=AT4" id="AT4">ATTRACTION</a></li>
				<li><a href="${conPath }/spotList.do?ccode=CT1" id="CT1">CULTURAL FACILITIES</a></li>
				<li><a href="${conPath }/spotList.do?ccode=AD5" id="AD5">ACCOMMODATION</a></li>
				<li><a href="${conPath }/spotList.do?ccode=FD6" id="FD6">RESTAURANT</a></li>
				<li><a href="${conPath }/spotList.do?ccode=CE7" id="CE7">CAFE</a></li>
			</ul>
		</div>
		<div class="main_wrap">
			<div class="wrap">
				<div class="map_wrap">
				    <div id="map"></div> 
				    
				    <!-- 지도 확대, 축소 컨트롤 div 입니다 -->
				    <div class="custom_zoomcontrol radius_border"> 
				        <span onclick="zoomIn()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_plus.png" alt="확대"></span>  
				        <span onclick="zoomOut()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_minus.png" alt="축소"></span>
				    </div>
				</div>
			</div>
			<div id="spotlist">
				<div id="search">
					<form action="spotList.do" method="post">
						<input type="hidden" name="ccode" value="${ccode }">
						<input type="text" name="search" value="${search }">
						<input type="submit" value=" ">
					</form>
				</div>
				<div id="list">
					<c:forEach var="spot" items="${spotList }">
						<div id="${spot.sid }" class="detail">
							<img alt="장소사진" class="img" src="${conPath }/spotPhotoUp/${spot.sphoto }">
							<span class="bold">${spot.sname }</span>
							<span class="light">${spot.description }</span>
						</div>
					</c:forEach>
				</div>
			</div>
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=745b8108fc2b2f1d3e2f0adfdee1fdc1&libraries=services"></script>
		<script>
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			    mapOption = {
			        center: new kakao.maps.LatLng(33.379777816446165, 126.54587355630036), // 지도의 중심좌표
			        level: 9 // 지도의 확대 레벨
			    };  
			
			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption); 
			
			// 지도 확대, 축소 컨트롤에서 확대 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
			function zoomIn() {
			    map.setLevel(map.getLevel() - 1);
			}
		
			// 지도 확대, 축소 컨트롤에서 축소 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
			function zoomOut() {
			    map.setLevel(map.getLevel() + 1);
			}
			
			var center = map.getCenter();
			
			kakao.maps.event.addListener(map, 'dragend', function(){
				
				var eventCenter = map.getCenter();
				
				//서쪽 최대 좌표
				var minLat = 33.056182808098555;
				//동쪽 최대좌표
				var maxLat = 33.61594912826407;
				//남쪽 최대 좌표
				var minLng = 126.07345860682933;
				//북쪽 최대좌표
				var maxLng = 127.08920821955245;
				
				if(	minLat > eventCenter.getLat() || 
					eventCenter.getLat() > maxLat ||
					minLng > eventCenter.getLng() ||
					eventCenter.getLng() > maxLng){
						map.setCenter(center);
				}
			});
		</script>
		<c:forEach var="spot" items="${spotList }">
			<script>
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();
			
			// 주소로 좌표를 검색합니다
				geocoder.addressSearch('${spot.saddress }', function(result, status) {
				
				    // 정상적으로 검색이 완료됐으면 
				     if (status === kakao.maps.services.Status.OK) {
				
				        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
						// 마커 이미지 변경하기
				        var imageSrc = '${conPath }/img/지도마커.png', // 마커이미지의 주소입니다    
  							imageSize = new kakao.maps.Size(40, 40), // 마커이미지의 크기입니다
   							imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
   						var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
   							
				        // 결과값으로 받은 위치를 마커로 표시합니다
   						var marker = new kakao.maps.Marker({
					        map: map,
					        position: coords,
					        image: markerImage
				        });
   							
   						marker.setTitle('${spot.sid }', coords);
   						
				
   					    kakao.maps.event.addListener(marker, 'click', function() {
   					    	$('.detail').removeClass("selected");
   					    	var sid = this.getTitle();
   							$('#'+sid).addClass("selected");
   					    	$('#list').animate({scrollTop : $('#'+sid).offset().top}, 500);
   					    });
				     }
				}); 
			</script>
		</c:forEach>
		<script>
			
		</script>
		</div>
		<jsp:include page="../main/footer.jsp"/>
	</div>
</body>
</html>