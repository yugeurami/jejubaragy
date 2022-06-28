<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>제주바라기:회원리스트</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(document).ready(function(){
			$('.nomal').click(function(){
				location.href="${conPath }/memberList.do"
			});
			$('.up').submit(function(){
				var check = confirm('선택한 회원들을 복구하시겠습니까?');
				if(!check){
					return false;
				}
			});
		});
	</script>
	<c:set var="SUCCESS" value="1"/>
	<c:set var="FAIL" value="0"/>
	<c:if test="${upResult eq SUCCESS}">
		<script>
			alert('회원 강등 성공');
		</script>
	</c:if>
	<c:if test="${upResult eq FAIL}">
		<script>
			alert('회원 강등 실패');
		</script>
	</c:if>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="memberStatus">
		<div class="nomal">일반회원</div>
		<div class="unnomal" id="selected">탈퇴/강등회원</div>
	</div>
	<div class="search">
		<form action="${conPath }/memberDownList.do">
			<table>
				<tr>
					<td>
						<select name="search">
							<option value="mid">아이디</option>
							<option value="mname">이름</option>
						</select>
					</td>
					<td>
						<input type="text" name="searchValue">
					</td>
					<td>
						<input type="submit" class="searchBtn">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div class="list">
		<form action="${conPath}/memberUp.do" method="post" class="up">
			<table>
				<tr>
					<td></td>
					<th>이름</th>
					<th>아이디</th>
					<th>가입일</th>
				</tr>
				<c:forEach var="member" items="${memberlist }">
					<tr>
						<td>
							<input type="checkbox" name="members" value="${member.mid }">
							<input type="hidden" name="pageNum" value="${pageNum }">
						</td>
						<td>${member.mname }</td>
						<td>${member.mid }</td>
						<td>${member.mrdate }</td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="5">
						<input type="submit" value="회원복구">
					</td>
				</tr>
			</table>
		</form>
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