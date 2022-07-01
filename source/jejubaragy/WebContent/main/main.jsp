<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>제주바라기</title>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;&display=swap" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(document).ready(function(){
			
		});
	</script>
	<c:set var="FAIL" value="0"/>
	<c:if test="${adminLoginResulte eq FAIL}">
		<script>
			alert('로그인 실패');
			location.href="${conPath}/adminLoginView.do";
		</script>
	</c:if>
	<c:if test="${memberLoginResulte eq FAIL}">
		<script>
			alert('로그인 실패');
			location.href="${conPath}/memberLoginView.do";
		</script>
	</c:if>
	<c:if test="${memberModifyResulte eq FAIL}">
		<script>
			alert('정보 수정 실패');
			location.href="${conPath}/memberModifyView.do";
		</script>
	</c:if>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="main">
		<div id="best_wrap">
			<div class="best">
				<c:forEach var="best" items="${best }">
					<img alt="베스트글사진" src="${conPath }/boardPhotoUP/${best.mainphoto }">
					<p class="btitle">${best.btitle }</p>
				</c:forEach>
			</div>
		</div>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>