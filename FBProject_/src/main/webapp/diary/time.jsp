<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
$(function(){
	
	$('.times').click(function(){
		let time=$(this).text();
		$('#gt').show();
		$('#ground_t').text(time);
		
        $.ajax({
            type: 'post',
            url: '../reserve/reserve.do',
            success: function(response) {
                $('#resBtn').prop('disabled', false);
            }
        });

	})

})
</script>
</head>
<body>
  <c:forEach var="time" items="${list }">
    <span class="btn btn-xs btn-danger times" style="background-color:#538053; border:none">${time }</span>
  </c:forEach>
</body>
</html>