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
			$('.modify').click(function(){
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
			$('.reply').click(function(){
				$('#reply_div').hide();
				var cid = $(this).attr('id');
				$('.reply'+cid).toggle();
			});
		});
	</script>
	<c:set var="SUCCESS" value="1"/>
	<c:set var="FAIL" value="0"/>
	<c:if test="${commentsWriteResult eq SUCCESS}">
		<script>
			location.href="${conPath}/boardContent.do";
		</script>
	</c:if>
	<c:if test="${commentsWriteResult eq FAIL}">
		<script>
			alert('댓글 작성 실패');
			location.href="${conPath}/boardContent.do";
		</script>
	</c:if>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="main">
		<div id="main_wrap">
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
				<tr class="small brdate">
					<td>DATE | ${boardContent.brdate }</td>
				</tr>
				<tr class="mid">
					<td>${boardContent.bwriter }</td>
				</tr>
				<tr class="content">
					<td>${boardContent.bcontent }</td>
				</tr>
			</table>
			<div id="commentsList">
				<div class="comment">
					<c:forEach var="comments" items="${commentsList }">
						<div id="ccontent${comments.cid }" class="one">
							<c:if test="${comments.cindent > 0 }">
								<c:forEach begin="0" end="${comments.cindent }" step="1">
									<p>┕</p>
								</c:forEach>
							</c:if>
							<c:if test="${comments.aid != null }">
								<img alt="관리자사진" src="${conPath }/memberPhotoUp/noImage.png">
							</c:if>
							<c:if test="${comments.mid != null }">
								<img alt="회원사진" src="${conPath }/memberPhotoUp/${comments.cphoto }">
							</c:if>
							<div class="text">
								<span class="cwriter">${comments.cwriter }</span><br>
								<span class="ccontent">${comments.ccontent }</span>
							</div>
							<c:if test="${not empty member || not empty admin }">
								<button id="${comments.cid }" class="reply">REPLY</button>
							</c:if>
							<c:if test="${not empty admin }">
								<button class="delete" onclick="${conPath }/commentsDelete.do?cid=${comments.cid }">DELETE</button>
								<c:if test="${comments.aid != null && comments.aid == admin.aid }">
									<button id="${comments.cid }" class="modify">MODIFY</button>
								</c:if>
							</c:if>
							<c:if test="${comments.mid != null && comments.mid == member.mid }">
								<button id="${comments.cid }" class="modify">MODIFY</button>
								<button class="delete" onclick="${conPath }/commentsDelete.do?cid=${comments.cid }">DELETE</button>
							</c:if>
							<div class="reply${comments.cid }" id="reply_div" hidden="hidden">
								<form action="${conPath }/commentsReply.do" method="post" id="reply_form">
									<input type="hidden" name="bnum" value="${comment.bnum }">
									<input type="hidden" name="cid" value="${comment.cid }">
									<textarea rows="2" cols="20" name="ccontent">${comment.ccontent }</textarea>
									<input type="submit" value="REPLY">
								</form>
							</div>
						</div>
					</c:forEach>
				</div>
				<c:if test="${not empty admin || not empty member }">
					<form action="${conPath }/commentsWrite.do" method="post" class="write">
						<input type="hidden" name="bnum" value="${boardContent.bnum }">
						<textarea name="ccontent" rows="2" cols="20"></textarea>
						<input type="submit" value="WRITE">
					</form>
				</c:if>
			</div>
		</div>
		<jsp:include page="../main/footer.jsp"/>
	</div>
</body>
</html>