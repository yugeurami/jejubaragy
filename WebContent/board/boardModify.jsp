<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>제주바라기 : 글 수정</title>
	<link href="${conPath }/css/boardWrite.css" rel="stylesheet">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
	<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
	
	<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
	<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
	<c:if test="${empty admin && empty member }">
		<script>
			location.href="${conPath }/main.do";
		</script>
	</c:if>
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
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="main">
		<div class="main_wrap">
			<div id="join">
				<form action="${conPath }/boardModify.do" method="post" enctype="multipart/form-data">
					<table>
						<tr>
							<th>TITLE</th>
							<td><input type="text" name="btitle" required="required" value="${boardContent.btitle }"></td>
						</tr>					
						<%-- <tr>
							<th>ROUTE</th>
							<td>
								<select name="rnum" size="5">
									<option></option>
									<c:forEach var="rList" items="${routeList }">
										<c:if test="${boardContent.rnum == rList.rnum }">
											<option value="${rList.rnum }" selected="selected" >${rList.rname }</option>
										</c:if>
										<c:if test="${boardContent.rnum != rList.rnum }">
											<option value="${rList.rnum }">${rList.rname }</option>
										</c:if>
									</c:forEach>
								</select>
							</td>
						</tr> --%>					
						<tr>
							<td colspan="2"><textarea id="summernote" name="bcontent" >${boardContent.bcontent }</textarea></td>
						</tr>
						<tr class="button">
							<td colspan="2">
								<input type="text" hidden="hidden" value="${boardContent.bcontent }" name="oldbcontent">
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