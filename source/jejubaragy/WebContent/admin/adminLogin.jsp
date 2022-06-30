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
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
		<div class="login">
			<form action="${conPath }/adminLogin.do" method="post">
				<table>
					<tr>
						<th><label for="aid">아이디</label></th>
						<td>
							<input type="text" name="aid" id="aid">
						</td>
					</tr>
					<tr>
						<th><label for="apw">비밀번호</label></th>
						<td>
							<input type="password" name="apw" id="apw">
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="submit" value="로그인">
						</td>
					</tr>
				</table>
			</form>
		</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>