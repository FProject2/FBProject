<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		#myTable span:hover{
			cursor: pointer;
			font-weight: bold;
		}
</style>
</head>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script>
$(function(){
  $("#search").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable tr").filter(function() {
      $(this).toggle($(this).find("td:eq(0)").text().toLowerCase().indexOf(value) > -1)
    });
  });
  
  $('.subject').click(function(){
	  let no=$(this).attr("data-no")
	  
	  location.href="../qna/detail.do?no="+no
  })
});

</script>
</head>
<body>
	<div class="container mt-3" style="overflow-y: scroll;height:800px;width:850px">
	  <h4>내 게시글</h4>
	  <div style="height:30px;"></div>
	  <p>문의하기</p><div><input type=search id="search" placeholder="제목을 입력하세요.."></div>
	  <table class="table table-hover" style="table-layout: auto;">
	    <thead>
	      <tr>
	        <th>제목</th>
	        <th>내용</th>
	        <th>작성날짜</th>
	        <th>답변갯수</th>
	      </tr>
	    </thead>
	    <tbody id=myTable>
	      <c:forEach var="vo" items="${list }">
		      <tr>
	        	<td><span class=subject data-no="${vo.no }">${vo.subject }</span></td>
	        	<td>${vo.content }</td>
	        	<td>${vo.dbday }</td>
	        	<td>${vo.rCount }</td>
		      </tr>
	      </c:forEach>
	    </tbody>
	  </table>
	</div>
</body>
</html>