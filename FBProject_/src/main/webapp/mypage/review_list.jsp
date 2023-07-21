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
  
  	$('.item').click(function(){
	  	let x=(document.body.offsetWidth/2)-(750/2)
		let y=(window.screen.height/2)-(450/2)-50
		let rvno=$(this).attr('data-rvno')
		window.open("../mypage/reviewDetail.do?rvno="+rvno,"",'width=750, height=450, left='+x+', top='+y+',scrollbar=yes')
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
	  <h4>내 리뷰</h4>
	  <div style="height:30px;"></div>
	  <p>리뷰 리스트</p><div><input type=search id="search" placeholder="구장 이름을 입력하세요.." style="width: 200px;"></div>   
	  <table class="table table-hover" style="table-layout: auto;">
	    <thead>
	      <tr>
	        <th></th>
	        <th>구장 이름</th>
	        <th>리뷰내용</th>
	        <th>평점</th>
	        <th>등록날짜</th>
	      </tr>
	    </thead>
	    <tbody id=myTable>
	    	<c:forEach var="vo" items="${list }">
	    		<tr class="item" data-rvno="${vo.rvno }">
			        <td width=10%><img src="${vo.gimage }" width=60px height=40px></td>
			        <td>${vo.gname }</td>
			        <td>${vo.content }</td>
			        <td>${vo.score }</td>
			        <td>${vo.dbday }</td>
			    </tr>
	    	</c:forEach>
	    </tbody>
	  </table>
	</div>
	
</body>
</html>