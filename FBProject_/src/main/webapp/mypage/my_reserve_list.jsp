<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script>
$(document).ready(function(){
  $("#search").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable tr").filter(function() {
      $(this).toggle($(this).find("td:eq(1)").text().toLowerCase().indexOf(value) > -1)
    });
    
  });
  
  	$('.reviewBtn').click(function(){
	  	let x=(document.body.offsetWidth/2)-(450/2)
		let y=(window.screen.height/2)-(600/2)-50
		let rno=$(this).attr('data-rno')
		window.open("../mypage/reviewWrite.do?rno="+rno,"",'width=450, height=600, left='+x+', top='+y+',scrollbar=yes')
  	})

});
</script>
<style type="text/css">

		.container::-webkit-scrollbar {
		    width: 10px;
		}
		.container::-webkit-scrollbar-thumb {
		    background-color: rgb(180, 180, 180);
		    border-radius: 10px;
		}
		.container::-webkit-scrollbar-track {
		    background-color: white;
		}
		
</style>
</head>
<body>
	<div class="container mt-3" style="overflow-y: scroll;;height:800px;width:850px">
	  <h4>예약 현황</h4>
	  <div style="height:30px;"></div>
	  <p>예약 현황</p><div><input type=search id="search" placeholder="구장 이름을 입력하세요.." style="width: 200px;"></div>   
	  <table class="table table-hover" style="table-layout: auto;">
	    <thead>
	      <tr>
	        <th></th>
	        <th>구장 이름</th>
	        <th>예약날짜</th>
	        <th>시간</th>
	        <th>가격</th>
	        <th>상태</th>
	        <th></th>
	      </tr>
	    </thead>
	    <tbody id=myTable>
	    	<c:forEach var="vo" items="${list }">
	    		<tr>
			        <td width=10%><img src="${vo.gimage }" width=60px height=40px></td>
			        <td>${vo.gname }</td>
			        <td>${vo.rdate }</td>
			        <td>${vo.time }</td>
			        <td>${vo.price }</td>
			        <c:if test="${vo.rstate=='예약승인'&& vo.rdate<now}">
			        	<td><span>이용완료</span></td>
			        </c:if>
			        <c:if test="${!(vo.rstate=='예약승인'&& vo.rdate<now) }">
			        	<td style="color:${vo.rstate=='예약승인'?'blue':vo.rstate=='예약취소'?'red':'black'}">${vo.rstate }</td>
		        	</c:if>
			        <td width=10%>
			        	<c:if test="${vo.rstate=='예약승인' && vo.rdate<now}">
			        		<c:if test="${vo.review_ok=='y' }">
			        			작성완료
			        		</c:if>
			        		<c:if test="${vo.review_ok=='n' }">
			        			<input type=button class=reviewBtn data-rno="${vo.rno }" value="리뷰작성" style="height:30px;background-color: #3CB371;border: none;border-radius: 5px;color: white;">
			        		</c:if>
			        	</c:if>
			        </td>
			    </tr>
	    	</c:forEach>
	    </tbody>
	  </table>
	</div>
	
</body>
</html>