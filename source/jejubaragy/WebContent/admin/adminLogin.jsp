<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자 로그인 페이지</title>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
	<link href="${conPath }/css/login.css" rel="stylesheet">
	<c:if test="${not empty admin || not empty member }">
		<script>
			location.href="${conPath}/boardBest.do";
		</script>
	</c:if>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
		<div id="login">
			<form action="${conPath }/adminLogin.do" method="post">
				<table>
					<tr>
						<th><label for="aid">ID</label></th>
						<td>
							<input type="text" name="aid" id="aid">
						</td>
						<td id="button" rowspan="2">
							<input type="submit" value="LOGIN">
							
						</td>
					</tr>
					<tr>
						<th><label for="apw">PASSWORD</label></th>
						<td>
							<input type="password" name="apw" id="apw">
						</td>
					</tr>
				</table>
			</form>
		</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>