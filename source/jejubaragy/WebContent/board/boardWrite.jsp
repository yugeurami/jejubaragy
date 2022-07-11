<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>제주바라기 : 게시판 글쓰기</title>
	<link href="${conPath }/css/boardWrite.css" rel="stylesheet">
	
	<!-- include libraries(jQuery, bootstrap) -->
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
	<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 

	<!-- include summernote css/js-->
	<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
	<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
	<script>
		$(document).ready(function() {
			$('#summernote').summernote({
				height: 600,
				minHeight: null,
				maxHeight: null,
				lang : 'ko-KR',
				onImageUpload: function(files, editor, welEditable) {
					                sendFile(files[0], editor, welEditable);
					           }
				});
			});
	</script>
	<c:if test="${empty admin && empty member }">
		<script>
			alert('로그인을 해주세요')
			location.href="${conPath }/memberLoginView.do";
		</script>
	</c:if>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="main">
		<div class="main_wrap"> 
			<div id="join">
				<form action="${conPath }/boardWrite.do" method="post" enctype="multipart/form-data">
					<table>
						<tr>
							<th>TITLE</th>
							<td><input type="text" name="btitle" required="required"></td>
						</tr>					
						<%-- <tr>
							<th>ROUTE</th>
							<td>
								<select name="rnum">
									<option></option>
									<c:forEach var="rList" items="${myRouteList }">
										<option value="${rList.rnum }">${rList.rname }</option>
									</c:forEach>
								</select>
							</td>
						</tr> --%>					
						<tr>
							<th colspan="2">
								<textarea id="summernote" name="bcontent" rows="5" cols="32"></textarea>
							</th>
						</tr>
						<tr class="button">
							<td colspan="2">
								<input type="submit" value="WRITE">
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