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
	<jsp:include page="../main/header.jsp"/>
	<div id="main">
		<div id="best">
			<tr>
				<c:forEach var="best" items="${best }">
					<td>
						<c:if test="${best.pname != null }">
							<p>${best. }</p>
						</c:if>
					</td>
				</c:forEach>
			</tr>
		</div>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>