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
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;&display=swap" rel="stylesheet">
	<link href="${conPath }/css/footer.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<footer>
		<ul>
			<li>서울시 XX구 XX로 000 XXX빌딩 5F | TEL : 02-999-9999 | FAX : 02-999-9999 
				<c:if test="${empty member && empty admin }">
				| <a href="${conPath }/adminLoginView.do">관리자 모드</a>
				</c:if>
			</li>
			<li>웹페이지 마스터 : 김유진 | 문의 메일 : jejubaragy@gmail.com</li>
			<li>Copyright © 제주바라기 All rights reserved.</li>
		</ul>
	</footer>
</body>
</html>