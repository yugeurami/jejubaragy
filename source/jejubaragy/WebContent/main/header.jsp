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
	<link href="${conPath }/css/header.css" rel="stylesheet">
</head>
<body>
	<header>
		<div id="logo">
			<div class="logoImg">
				<a href="${conPath }/boardBest.do">
					<img alt="로고" src="${conPath }/img/로고.png">
				</a>
			</div>
			<c:if test="${not empty member }">
				<div class="name">${member.mname }</div>
			</c:if>
			<c:if test="${not empty admin }">
				<div class="name">ADMIN MODE</div>
			</c:if>
		</div>
		<div id="top_nav">
			<ul class="right">
				<c:if test="${empty member && empty admin }">
					<li><a href="${conPath }/memberJoinView.do">JOIN US</a></li>
					<li><a href="${conPath }/memberLoginView.do">LOGIN</a></li>
				</c:if>
				<c:if test="${not empty member }">
					<li><a href="${conPath }/logout.do">LOGOUT</a></li>
					<li><a href="${conPath }/memberModifyView.do">MODIFY</a></li>
				</c:if>
				<c:if test="${not empty admin }">
					<li><a href="${conPath }/logout.do">LOGOUT</a></li>
				</c:if>
			</ul>
		</div>
		<div id="bottom_nav">
			<ul>
				<c:if test="${not empty admin }">
					<li><a href="${conPath }/adminList.do">ADMIN LIST</a></li>						
					<li><a href="${conPath }/memberList.do">MEMBER LIST</a></li>
				</c:if>
				<c:if test="${empty admin }">
					<li><a href="${conPath }/routeMakeView.do">PLANING</a></li>
					<li><a href="${conPath }/myRouteList.do">MY TRAVLE</a></li>
				</c:if>
				<li><a href="${conPath }/spotList.do">TRAVEL SPOT</a></li>
				<li><a href="${conPath }/routeList.do">TRAVEL ROUTE</a></li>
				<li><a href="${conPath }/boardList.do">BOARD</a></li>
			</ul>
		</div>
	</header>
</body>
</html>