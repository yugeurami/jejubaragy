<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 로그인 페이지</title>
	<c:if test="${not empty admin || not empty member }">
		<script>
			location.href="${conPath}/main.do";
		</script>
	</c:if>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
		<div class="login">
			<form action="${conPath }/memberLogin.do" method="post">
				<table>
					<tr>
						<th><label for="mid">아이디</label></th>
						<td>
							<input type="text" name="mid" id="mid" value="${mid }">
						</td>
					</tr>
					<tr>
						<th><label for="mpw">비밀번호</label></th>
						<td>
							<input type="password" name="mpw" id="mpw">
						</td>
					</tr>
					<tr>
						<td class="join"><a href="${conPath }/memberJoinView.do">회원가입</a></td>
						<td>
							<input type="submit" value="로그인">
						</td>
					</tr>
				</table>
			</form>
		</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>