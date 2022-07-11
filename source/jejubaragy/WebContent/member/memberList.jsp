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
	<link href="${conPath }/css/memberlist.css" rel="stylesheet">
	<script>
		$(document).ready(function(){
			$('.unnomal').click(function(){
				location.href="${conPath }/memberDownList.do"
			});
			$('.down').submit(function(){
				var check = confirm('선택한 회원들을 강등하시겠습니까?');
				if(!check){
					return false;
				}
			});
		});
	</script>
	<c:set var="SUCCESS" value="1"/>
	<c:set var="FAIL" value="0"/>
	<c:if test="${deleteResult eq SUCCESS}">
		<script>
			alert('회원 강등 성공');
		</script>
	</c:if>
	<c:if test="${deleteResult eq FAIL}">
		<script>
			alert('회원 강등 실패');
		</script>
	</c:if>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="main">
		<div class="search">
			<ul id="memberStatus">
				<li class="nomal" id="selected">NOMAL</li>
				<li class="unnomal">WITHDRAWAL</li>
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
				<form action="${conPath}/memberDown.do" method="post" class="down">
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
					</table>
				<div class="reg">
					<input type="submit" class="join" value="DOWN">
				</div>
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