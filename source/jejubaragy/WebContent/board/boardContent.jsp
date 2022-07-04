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
	<link href="${conPath }/css/contents.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(document).ready(function(){
			$('.btn').click(function(){
				var cid = $(this).attr('id');
				$.ajax({
					url : '${conPath }/commentsModifyView.do',
					type : 'post',
					data : 'cid='+cid,
					dataType : 'html',
					success : function(data){
						$('#ccontent'+cid).html(data);
					}
				});
			});
		});
	</script>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="main">
		<table id="content">
			<tr class="big">
				<td>
					${boardContent.btitle }
					<c:if test="${boardContent.aid != null && boardContent.aid == admin.aid }">
						<input type="button" value="MODIFY" onclick="location.href='${conPath }/boardModifyView.do?bnum=${boardContent.bnum }&pageNum=${param.pageNum }'">
						<input type="button" value="DELETE" onclick="location.href='${conPath }/boardDelete.do?bnum=${boardContent.bnum }&pageNum=${param.pageNum }'">
					</c:if>
					<c:if test="${boardContent.mid != null && boardContent.mid == member.mid }">
						<input type="button" value="MODIFY" onclick="location.href='${conPath }/boardModifyView.do?bnum=${boardContent.bnum }&pageNum=${param.pageNum }'">
						<input type="button" value="DELETE" onclick="location.href='${conPath }/boardDelete.do?bnum=${boardContent.bnum }&pageNum=${param.pageNum }'">
					</c:if>
				</td>
			</tr>
			<tr class="mid">
				<td>${boardContent.bwriter }</td>
			</tr>
			<tr class="small">
				<td>
					HITS | ${boardContent.bhit }
				</td>
			</tr>
			<tr class="small">
				<td>DATE | ${boardContent.brdate }</td>
			</tr>
			<tr class="content">
				<td>${boardContent.bcontent }</td>
			</tr>
		</table>
		<div id="commentsList">
			<form action="${conPath }/commentsWrite.do">
				<input type="hidden" name="bnum" value="${boardContent.bnum }">
				<textarea name="ccontent" rows="2" cols="20"></textarea>
				<input type="submit" value="WRITE">
			</form>
			<div class="comment">
				<c:forEach var="comments" items="${commentsList }">
					<p id="ccontent${comments.cid }">
						<c:if test="${comments.aid != null }">
							<img alt="관리자사진" src="${conPath }/memberPhotoUp/noImage.png">
						</c:if>
						<c:if test="${comments.mid != null }">
							<img alt="회원사진" src="${conPath }/memberPhotoUp/${comments.cphoto }">
						</c:if>
						<div class="text">
							<span class="cwriter">${comments.cwriter }</span>
							<span class="ccontent">${comments.ccontent }</span>
						</div>
						<button onclick="${conPath }/commentsDelete.do?cid=${comments.cid }">DELETE</button>
						<button id="${comments.cid }" class="btn">MODIFY</button>
					<p>
				</c:forEach>
			</div>
		</div>
		<jsp:include page="../main/footer.jsp"/>
	</div>
</body>
</html>