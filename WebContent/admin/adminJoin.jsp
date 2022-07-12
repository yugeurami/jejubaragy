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
	<link href="${conPath }/css/join.css" rel="stylesheet">
	<c:set var="master" value="admin"/>
	<c:if test="${admin.aid != master }">
		<script>
			location.href="${conPath}/main.do";
		</script>
	</c:if>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(document).ready(function(){
			$('#idChk').click(function(){
				var aid = $('#aid').val();
				$('#idCheckResult').removeClass();
				$('#idCheckResult').html();
				if(aid){
					$.ajax({
						url : '${conPath}/adminIdCheck.do',
						data : 'aid='+aid,
						type : 'get',
						dataType : 'html',
						success : function(data){
							$('#idCheckResult').html(data);							
							var idCheckResult = $('#idCheckResult').text().trim();
							if(idCheckResult == '중복된 ID입니다'){
								$('#idCheckResult').addClass('red');
							}else if(idCheckResult == 'ID 중복 확인 완료'){
								$('#idCheckResult').addClass('blue');
							}
						}
					});
				}
			});
			$('#apw, #pwChk').keyup(function(){
				$('#pwCheckResult').removeClass();
				var apw = $('#apw').val();
				var pwChk = $('#pwChk').val();
				if(apw == pwChk){
					$('#pwCheckResult').text('비밀번호 일치');
					$('#pwCheckResult').addClass('blue')
				} else{
					$('#pwCheckResult').text('비밀번호 불일치');				
					$('#pwCheckResult').addClass('red');
				}
			});
			$('form').submit(function(){
				var idCheckResult = $('#idCheckResult').text().trim();
				var pwCheckResult = $('#pwCheckResult').text().trim();
				if(idCheckResult == '중복된 ID입니다'){
					alert('사용가능한 ID로 가입하세요');
					return false;
				}else if(pwCheckResult == '비밀번호 불일치'){
					alert('비밀번호가 일치하지 않습니다');
					return false;
				}else{
					true;
				}
			});
		});
	</script>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div class="Join">
		<form action="${conPath }/adminJoin.do" method="post">
			<table>
				<tr>
					<th><label for="aid">아이디</label></th>
					<td>
						<input type="text" name="aid" id="aid" required="required">
						<input type="button" id="idChk" value="아이디 중복확인">
					</td>
				</tr>
				<tr class="check">
					<td> </td>
					<td><div id="idCheckResult"> &nbsp; </div></td>
				</tr>
				<tr>
					<th><label for="apw">비밀번호</label></th>
					<td>
						<input type="password" name="apw" id="apw" required="required">
					</td>
				</tr>
				<tr>
					<th><label for="pwchk">비밀번호 확인</label></th>
					<td>
						<input type="password" name="pwChk" id="pwChk" required="required">
					</td>
				</tr>
				<tr class="check">
					<td></td>
					<td><div id="pwCheckResult"> &nbsp; </div></td>
				</tr>
				<tr>
					<th><label for="aname">이름</label></th>
					<td>
						<input type="text" name="aname" id="aname" required="required">
					</td>
				</tr>
				<tr class="button">
					<td colspan="2">
						<input type="submit" value="관리자 등록">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>