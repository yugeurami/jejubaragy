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
	<link href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap" rel="stylesheet">
	<link href="${conPath }/css/header.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(document).ready(function(){
			$('#down').click(function(){
				var check = confirm('정말 탈퇴하시겠습니까?');
				if(check){
					location.href="${conPath}/memberDown.do";
				}
			});
		});
	</script>
</head>
<body>
	<c:set var="master" value="admin"></c:set>
	<header>
		<div id="nav">
			<ul class="left">
				<li>
					<div class="logo">제주바라기</div>
				</li>
				<li><a href="${conPath }/spotSearch.do">여행지</a></li>
				<c:if test="${not empty member }">
					<li><a href="${conPath }/routeMakeView.do">여행 계획하기</a></li>
					<li><a href="${conPath }/myRouteList.do">내 여행</a></li>
				</c:if>
				<c:if test="${not empty admin }">
					<li><a href="${conPath }/memberList.do">회원 목록</a></li>
					<c:if test="${admin.aid eq master }">
						<li><a href="${conPath }/adminList.do">관리자 목록</a></li>						
					</c:if>
				</c:if>
			</ul>
			<ul class="right">
				<c:if test="${empty member && empty admin }">
					<li><a href="${conPath }/memberLoginView.do">로그인</a></li>
					<li><a href="${conPath }/memberJoinView.do">회원가입</a></li>
				</c:if>
				<c:if test="${not empty member }">
					<li><a href="${conPath }/memberDelete.do">회원탈퇴</a></li>
					<li><a href="${conPath }/logout.do">로그아웃</a></li>
					<li><a href="${conPath }/memberModifyView.do">회원정보수정</a></li>
					<li><span>${member.mname }님</span></li>
					<li><img alt="회원사진" src="${conPath }/memberPhotoUp/${member.mphoto }"></li>
				</c:if>
				<c:if test="${not empty admin }">
					<li><a href="${conPath }/logout.do">관리자모드 끝내기</a></li>
					<li><span>${admin.aname } 관리자님</span></li>
				</c:if>
			</ul>
		</div>
	</header>
</body>
</html>