<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>제주바라기:관리자리스트</title>
	<c:set var="master" value="admin"/>
	<c:if test="${admin.aid != master }">
		<script>
			alert('권한이 없습니다');
			location.href="${conPath}/main.do";
		</script>
	</c:if>
	<link href="${conPath }/css/adminlist.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(document).ready(function(){
			
			$('#delete').click(function(){
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
	<c:set var="SUCCESS" value="1"/>
	<c:set var="FAIL" value="0"/>
	<c:if test="${joinResult eq FAIL}">
		<script>
			alert('관리자 등록 실패');
			location.href="${conPath}/adminJoinView.do";
		</script>
	</c:if>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="main">
		<div id="main_wrap">
			<div class="list">
				<form method="post">
					<table>
						<caption>ADMIN LIST</caption>
						<tr>
							<th>NAME</th>
							<th>ID</th>
							<th>PASSWORD</th>
							<td></td>
						</tr>
						<c:forEach var="admins" items="${adminlist }">
							<tr>
								<td>${admins.aname }</td>
								<td>${admins.aid }</td>
								<td>
									${admins.apw }
								</td>
								<td>
									<input type="hidden" value="${admins.aid }">
									<input type="hidden" value="${pageNum }">
									<c:if test="${admins.aid != master}">
										<input type="button" id="delete" value="DELETE">
									</c:if>
									<c:if test="${admins.aid eq master}">
										<span>MASTER</span>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</table>
				</form>
				<div class="reg">
					<input type="button" class="join" value="ADMIN REGISTER">
				</div>
				<div class="paging">
					<c:if test="${startPage > BLOCKSIZE }">
						<a href="${conPath }/adminList.do?pageNum=${startPage-1 }">[ PRE ]</a>
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
						<a href="${conPath }/adminList.do?pageNum=${endPage + 1 }">[ NEXT ]</a>
					</c:if>
				</div>
			</div>
		</div>
		<jsp:include page="../main/footer.jsp"/>
	</div>
</body>
</html>