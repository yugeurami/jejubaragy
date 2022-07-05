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
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link href="${conPath }/css/routelist.css" rel="stylesheet">
	<script>
		$(document).ready(function(){

		});
	</script>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="main">
		<div id="main_wrap">
			<span class="title">MY TRAVEL ROUTE</span>
			<div id="route_scroll">
				<c:forEach var="route" items="${myRouteList }">
					<div class="one_route" onclick="location.href='${conPath }/routeContent.do?rnum=${route.rnum }'">
						<span class="rname">${route.rname }</span><br>
						<span class="date">${route.rstartdate } ~ ${route.renddate }</span><br>
					</div>
				</c:forEach>
			</div>
		</div>
		<jsp:include page="../main/footer.jsp"/>
	</div>
</body>
</html>