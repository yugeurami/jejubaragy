<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="${conPath }/css/map.css" rel="stylesheet">
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=745b8108fc2b2f1d3e2f0adfdee1fdc1"></script>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="main">
		<div id="ccode">
			<c:forEach var="category" items="${categoryList }">
				<form action="spotList.do" method="post">
					<input type="hidden" value="${category.ccode }">
					<c:if test="${ccode eq category.ccode }">
						<input type="button" class="thisCategory" value="${category.cname }">
					</c:if>
					<c:if test="${ccode != category.ccode }">
						<input type="button" class="notThisCategory" value="${category.cname }">
					</c:if>
				</form>
			</c:forEach>
		</div>
		<div id="search">
			<form action="spotList.do">
				<input type="text" name="search">
				<input type="submit">
			</form>
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
				<table>
					<c:forEach var="spot" items="${spotList }">
						<tr>
							<td>
								<img alt="장소사진" class="img" src="${conPath }/spotPhotoUp/${spot.sphoto }">
								<span class="bold">${spot.sname }</span><br>
								<span class="light">${spot.description }</span>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=745b8108fc2b2f1d3e2f0adfdee1fdc1&libraries=services"></script>
		<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(33.379777816446165, 126.54587355630036), // 지도의 중심좌표
		        level: 10 // 지도의 확대 레벨
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
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		</script>
		
		<c:forEach var="dto" items="${spotlist }">
			<script>
			// 주소로 좌표를 검색합니다
				geocoder.addressSearch('${dto.saddress}', function(result, status) {
				
				    // 정상적으로 검색이 완료됐으면 
				     if (status === kakao.maps.services.Status.OK) {
				
				        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
				        // 결과값으로 받은 위치를 마커로 표시합니다
				        var marker = new kakao.maps.Marker({
				            map: map,
				            position: coords
				        });
				
				        // 인포윈도우로 장소에 대한 설명을 표시합니다
				        var infowindow = new kakao.maps.InfoWindow({
				            content: '<div class="info-title" style="width:150px;text-align:center;padding:0;">${dto.sname}(${dto.sid})</div>',
				            removable : true
				        });
				        infowindow.open(map, marker);
				
				        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				        map.setCenter(coords);
				    } 
				});    
			</script>
		</c:forEach>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>