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
			$('.idChk').click(function(){
				var aid = $('.aid').val();
				$.ajax({
					url : '${conPath}/AdminIdCheck.do',
					data : 'aid='+aid,
					type : 'get',
					dataType : 'html',
					success : function(data){
						$('#idCheckResult').html(data);							
					}
				});
			});
		});
		$('.apw, .pwChk').keyup(function(){
			var mpw = $('.apw').val();
			var mpwChk = $('.pwChk').val();
			if(mpw == mpwChk){
				$('.pwCheckResult').text('비밀번호 일치');
			} else{
				$('.pwCheckResult').text('비밀번호 불일치');				
				$('.pwCheckResult').css('color', 'red')
			}
		});
	</script>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div class="contents">
		<table>
			<tr>
				<th><label for="aid">아이디</label></th>
				<td>
					<input type="text" name="aid" id="aid">
					<input type="button" id="idChk" value="아이디 중복확인">
				</td>
			</tr>
			<tr class="check">
				<td></td>
				<td><div id="idCheckResult"></div></td>
			</tr>
			<tr>
				<th><label for="apw">비밀번호</label></th>
				<td>
					<input type="password" name="apw" id="apw">
				</td>
			</tr>
			<tr>
				<th><label for="pwchk">비밀번호 확인</label></th>
				<td>
					<input type="password" name="pwChk" id="pwchk">
				</td>
			</tr>
			<tr class="check">
				<td></td>
				<td><div id="pwCheckResult"></div></td>
			</tr>
			<tr>
				<th><label for="aname">이름</label></th>
				<td>
					<input type="text" name="aname" id="aname">
				</td>
			</tr>
		</table>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>