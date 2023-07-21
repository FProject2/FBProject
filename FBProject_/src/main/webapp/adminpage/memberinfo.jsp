<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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

<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script>
$(function(){
  $("#search").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable tr").filter(function() {
      $(this).toggle($(this).find("td:eq(1)").text().toLowerCase().indexOf(value) > -1)
    });
  });
  
  $("#myTable tr").click(function(){
		let x=(document.body.offsetWidth/2)-(750/2)
		let y=(window.screen.height/2)-(500/2)-50
		let id=$(this).attr('data-id')
		window.open("../adminpage/memberDetail.do?id="+id,"",'width=750, height=500, left='+x+', top='+y)
  })
});
</script>

<body>
	<div class="container mt-3" style="overflow-y: scroll;height:800px;width:850px">
	  <h4>회원 관리</h4>
	  <div style="height:30px;"></div>
	  <p>회원 정보</p><div><input type=search id="search" placeholder="이름을 입력하세요.."></div>
	  <table class="table table-hover" style="table-layout: auto;">
	    <thead>
	      <tr>
	        <th>ID</th>
	        <th>이름</th>
	        <th>닉네임</th>
	        <th>성별</th>
	        <th>휴대폰</th>
	        <th>가입한 날짜</th>
	      </tr>
	    </thead>
	    <tbody id=myTable>
	      <c:forEach var="vo" items="${list }">
		      <tr data-id="${vo.id }">
		        <td>${vo.id }</td>
		        <td>${vo.name }</td>
		        <td>${vo.nickname }</td>
		        <td>${vo.sex }</td>
		        <td>${vo.phone }</td>
		        <td>${vo.signdate }</td>
		      </tr>
	      </c:forEach>
	      
	    </tbody>
	  </table>
	</div>
	<!-- <div style="text-align: center;width:100%;" class="pagination1">
	  	<a href="#">&lt;</a>&nbsp;
	  	<a href="#">1</a>&nbsp;
	  	<a href="#">&gt;</a>&nbsp;
	</div> -->
</body>
</html>