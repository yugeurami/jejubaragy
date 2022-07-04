<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
</head>
<body>
	<form action="${conPath }/commentsModify.do">
		<input type="hidden" name="bnum" value="${comment.bnum }">
		<input type="hidden" name="cid" value="${comment.cid }">
		<textarea rows="2" cols="20" name="ccontent">${comment.ccontent}</textarea>
		<input type="submit" value="SUBMIT">
	</form>
</body>
</html>