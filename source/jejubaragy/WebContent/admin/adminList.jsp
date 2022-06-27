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
			$('.delete').click(function(){
				var check = confirm('정말 삭제하시겠습니까?')
				if(check){
					location.href="${conPath}/adminDelete.do";
				}
			});
			$('.join').click(function(){
				location.href="${conPath}/adminJoinView.do";
			});
		});
	</script>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div class="contents">
		<form method="post">
			<table>
				<tr>
					<th>이름</th>
					<th>아이디</th>
					<th>비밀번호</th>
				</tr>
				<c:forEach var="admin" items="${adminlist }">
					<tr>
						<td>${admin.aname }</td>
						<td>${admin.aid }</td>
						<td>
							${admin.apw }
							<input type="hidden" value="${admin.aid }">
							<input type="hidden" value="${pageNum }">
							<input type="button" id="delete" value="삭제">
						</td>
					</tr>
				</c:forEach>
			</table>
		</form>
		<div class="reg">
			<input type="button" class="join" value="관리자 등록">
		</div>
		<div class="paging">
			<c:if test="${startPage > BLOCKSIZE }">
				<a href="${conPath }/adminList.do?pageNum=${startPage-1 }">[ 이전 ]</a>
			</c:if>
			<c:forEach var="i" begin="${startPage }" end="${endPage }">
				<c:if test="${i eq pageNum }">
					[ <b>${i }</b> ]
				</c:if>
				<c:if test="${i != pageNum }">
					<a href="${conPath }/adminList.do?pageNum=${i}">[ ${i } ]</a>
				</c:if>
			</c:forEach>
			<c:if test="${ endPage < pageCnt }">
				<a href="${conPath }/adminList.do?pageNum=${endPage + 1 }">[ 다음 ]</a>
			</c:if>
		</div>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>