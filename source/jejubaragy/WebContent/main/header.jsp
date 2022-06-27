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
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(document).ready(function(){

		});
	</script>
</head>
<body>
	<header>
		<nav>
			<ul class="right">
				<li class="logo"><img alt="로고" src=""></li>
				<li><a href="travleSpotList.do">여행지</a></li>
				<c:if test="${not empty member }">
					<li>여행일정 만들기</li>
				</c:if>
			</ul>
			<ul class="left">
				<c:if test="${empty member && empty admin }">
					<li class="join">회원가입</li>
					<li class="login">로그인</li>
				</c:if>
				<c:if test="${not empty member }">
					<li class="logout">로그아웃</li>
					<li class="modify">회원정보수정</li>
					<li class="mypage">${member.mname }님</li>
				</c:if>
				<c:if test="${not empty admin }">
					<li class="logout">관리자모드 끝내기</li>
					<li>관리자님</li>
				</c:if>
			</ul>
		</nav>
		<div class="img">
			<img alt="메인이미지" src="">
		</div>
	</header>
</body>
</html>