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
	<c:if test="${not empty admin || empty member }">
		<script>
			location.href="${conPath}/boardBest.do";
		</script>
	</c:if>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
	<link href="${conPath }/css/join.css" rel="stylesheet">	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(document).ready(function(){
			$('#newmpw, #pwChk').keyup(function(){
				$('#pwCheckResult').removeClass();
				var newmpw = $('#newmpw').val();
				var pwChk = $('#pwChk').val();
				if(newmpw == pwChk){
					$('#pwCheckResult').text('비밀번호 일치');
					$('#pwCheckResult').addClass('blue')
				} else{
					$('#pwCheckResult').text('비밀번호 불일치');				
					$('#pwCheckResult').addClass('red');
				}
			});
			$('form').submit(function(){
				var oldmpw = $('#oldmpw').val();
				if( ${member.mpw } != oldmpw){
					alert('비밀번호가 일치하지 않습니다');
					$('#oldmpw').val('');
					$('#oldmpw').focus();
					return false;
				}
				var pwCheckResult = $('#pwCheckResult').text().trim();
				if(pwCheckResult == '비밀번호 불일치'){
					alert('비밀번호가 일치하지 않습니다');
					return false;
				}
			});
			$('#down').click(function(){
				var check = confirm('정말 탈퇴하시겠습니까?');
				if(check){
					location.href="${conPath}/memberDelete.do";
				}
			});
		});
	</script>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="main">
		<div id="main_wrap">
			<div id="join">
				<form action="${conPath }/memberModify.do" method="post" enctype="multipart/form-data">
					<table>
						<tr>
							<th><label for="mname">NAME</label></th>
							<td>
								<input type="text" name="mname" id="mname" value="${member.mname }" required="required">
							</td>
						</tr>
						<tr>
							<th>ID</th>
							<td>
								<input type="text" name="mid" readonly="readonly" value="${member.mid }">
							</td>
						</tr>
						<tr>
							<th><label for="oldmpw">PASSWORD</label></th>
							<td>
								<input type="password" name="oldmpw" id="oldmpw" required="required">
							</td>
						</tr>
						<tr>
							<th><label for="newmpw">NEW PASSWORD</label></th>
							<td>
								<input type="password" name="newmpw" id="newmpw">
							</td>
						</tr>
						<tr>
							<th><label for="pwchk">PASSWORD CHECK</label></th>
							<td>
								<input type="password" name="pwChk" id="pwChk">
							</td>
						</tr>
						<tr class="check">
							<td></td>
							<td><div id="pwCheckResult"> &nbsp; </div></td>
						</tr>
						<tr>
							<th>PROFILE PHOTO</th>
							<td>
								<img alt="회원사진" src="${conPath }/memberPhotoUp/${member.mphoto }">
								<input type="file" name="mphoto">
							</td>
						</tr>
						<tr class="button">
							<td colspan="2">
								<input type="submit" value="SUBMIT">
								<input type="button" value="WITHDRAWAL" onclick="location.href='${conPath }/memberDelete.do'">
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<jsp:include page="../main/footer.jsp"/>
	</div>
</body>
</html>