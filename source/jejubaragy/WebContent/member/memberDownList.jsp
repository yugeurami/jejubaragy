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
	<link href="${conPath }/css/memberlist.css" rel="stylesheet">
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
			alert('회원 복구 성공');
		</script>
	</c:if>
	<c:if test="${upResult eq FAIL}">
		<script>
			alert('회원 복구 실패');
		</script>
	</c:if>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="main">
		<div class="search">
			<ul id="memberStatus">
				<li class="nomal">NOMAL</li>
				<li class="unnomal" id="selected">WITHDRAWAL</li>
			</ul>
		</div>
		<div id="main_wrap">
			<form action="${conPath }/memberList.do" class="search">
				<table>
					<tr>
						<td class="select_box">
							<select name="search">
								<option value="mid">ID</option>
								<option value="mname">NAME</option>
							</select>
						</td>
						<td class="search_text">
							<input type="text" name="searchValue">
						</td>
						<td class="btn">
							<input type="submit" class="searchBtn" value="SEARCH">
						</td>
					</tr>
				</table>
			</form>
			<div class="list">
				<form action="${conPath}/memberUp.do" method="post" class="up">
					<table>
					<caption>MEMBER LIST</caption>
						<tr>
							<td class="check"></td>
							<th>NAME</th>
							<th>ID</th>
							<th>SUBSCRIPTION DATE</th>
						</tr>
						<c:forEach var="member" items="${memberlist }">
							<tr>
								<td class="check">
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
								<input type="submit" value="RESTORATION">
							</td>
						</tr>
					</table>
				</form>
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