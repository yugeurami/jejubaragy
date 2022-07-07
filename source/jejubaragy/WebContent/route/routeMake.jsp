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
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(document).ready(function(){
			$('form').submit(function(){
				var start = $('input[name="rstartdate"]').val();
				var end = $('input[name="renddate"]').val();
				if(start > end){
					alert('날짜가 이상해요');
					return false;
				}
			});
		});
	</script>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="main">
		<div id="main_wrap">
			<div id="route_form">
				<form action="routeMake.do" method="post">
					<table>
						<tr class="title">
							<th>TITLE</th>
							<td>
								<input type="text" name="rname" required="required">
							</td>
						</tr>
						<tr class="date">
							<th>DATE</th>
							<td>
								<input type="text" class="datepicker" name="rstartdate" required="required">
								~
								<input type="text" class="datepicker" name="renddate" required="required">
							</td>
						</tr>
						<tr class="private">
							<td colspan="2">
								<input type="radio" name="rprivate" value="1" checked ="checked"/>PUBLIC
								<input type="radio" name="rprivate" value="0" />PRIVATE
							</td>
						</tr>
						<tr class="button">
							<td colspan="2">
								<input type="submit" value="MAKE">
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<jsp:include page="../main/footer.jsp"/>
	</div>
	<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
  	<script>
	  $( function() {
	    $( ".datepicker" ).datepicker({
	    	dateFormat : 'yy-mm-dd',
	      	changeMonth: true,
	      	monthNamesShort : ['1월', '2월', '3월', '4월','5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	      	changeYear: true,
	      	yearSuffix : '년', // "2020년 3월"
	    	showOtherMonths : true, // 다른 월 일수도 볼 수 있게
	    	dayNamesMin:['일','월','화','수','목','금','토'],
			minDate : '-100y', //현재 날짜로부터 100년 이전까지 표시
			yearRange : 'c-100:2022' // 셀렉트 박스에 보여줄 년도
	    });
	  });
  	</script>
</body>
</html>
