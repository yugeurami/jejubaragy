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
	<link href="${conPath }/css/list.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(document).ready(function(){

		});
	</script>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="main">
		<table id="list">
			<caption>TRAVEL BOARD</caption>
			<c:if test="${boardList.size() eq 0 }">
				<tr><td colspan="2">등록된 글이 없습니다</td></tr>
			</c:if>
			<c:if test="${boardList.size() != null }">
				<tr>
					<c:set var="cnt" value="0"/>
					<c:forEach var="board" items="${boardList }">
						<c:set var="cnt" value="${cnt+1 }"/>
						<td onclick="location.href='${conPath }/boardContent.do?bnum=${board.bnum }&pageNum=${pageNum }'">
							<div class="trs">
								<c:if test="${board.bmainphoto != null }">
									<img alt="대표사진" src="${conPath }/boardPhotoUp/${board.bmainphoto }"><br>
								</c:if>
								<c:if test="${board.bmainphoto == null }">
									<img alt="대표사진" src="${conPath }/boardPhotoUp/noImg.jpg">
								</c:if>
								<div class="info">
									<span class="title">${board.btitle }</span><br>
									<span class="writer">${board.bwriter }</span><br>
									<span class="bhit">VIEW | ${board.bhit }</span><br>
									<span class="rdate">${board.brdate }</span>
								</div>
							</div>
						</td>
					<c:if test="${cnt % 4 == 0 }">
						</tr>
						<tr>
					</c:if>
				</c:forEach>
				</tr>
			</c:if>
			<c:if test="${not empty admin || not empty member }">
				<tr>
					<td colspan="2">
						<input type="button" value="WRITE" onclick="location.href='${conPath}/boardWriteView.do?pageNum=${pageNum }'">
					</td>
				</tr>
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