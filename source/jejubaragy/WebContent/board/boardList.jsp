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
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(document).ready(function(){

		});
	</script>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="main">
		<table>
			<caption>자유 게시판</caption>
			<c:if test="${boardList.size() eq 0 }">
				<tr><td colspan="5">등록된 글이 없습니다</td></tr>
			</c:if>
			<c:if test="${boardList.size() != null }">
				<c:forEach var="board" items="${boardList }">
					<tr onclick="location.href='${conPath }/boardContent.do?bid=${board.bid}&pageNum=${pageNum }'">
						<td>
							<img alt="대표사진" src="${conPath }/boardPhotoUp/${board.bmainphoto"><br>
							<span class="title">${board.btitle }</span><br>
							<span class="writer">${board.bwriter }</span>
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		<div class="paging">
			<c:if test="${startPage > BLOCKSIZE }">
				<a href="${conPath }/boardList.do?pageNum=${startPage-1 }">[ 이전 ]</a>
			</c:if>
			<c:forEach var="i" begin="${startPage }" end="${endPage }">
				<c:if test="${i eq pageNum }">
					[ <b>${i }</b> ]
				</c:if>
				<c:if test="${i != pageNum }">
					<a href="${conPath }/boardList.do?pageNum=${i}">[ ${i } ]</a>
				</c:if>
			</c:forEach>
			<c:if test="${ endPage < pageCnt }">
				<a href="${conPath }/boardList.do?pageNum=${endPage + 1 }">[ 다음 ]</a>
			</c:if>
		</div>
		<jsp:include page="../main/footer.jsp"/>
	</div>
</body>
</html>