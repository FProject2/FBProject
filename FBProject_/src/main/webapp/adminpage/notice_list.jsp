<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
      $(this).toggle($(this).find("td:eq(0)").text().toLowerCase().indexOf(value) > -1)
    });
    
  });
  
  $('.fix').change(function(){
	  let fix=$(this).val()
	  let nno=$(this).attr("data-nno")
	  location.href="../adminpage/fixChange.do?fix="+fix+"&nno="+nno
  })

  $('.delBtn').click(function(){
	  let nno=$(this).attr("data-nno")

	  location.href="../adminpage/noticeDelete.do?nno="+nno
  })
  
  $('.subject').click(function(){
	  let nno=$(this).attr("data-nno")
	  
	  location.href="../notice/notice_detail.do?nno="+nno;
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
		#myTable span:hover{
			cursor: pointer;
			font-weight: bold;
		}
		
</style>
</head>
<body>
	<div class="container mt-3" style="overflow-y: scroll;;height:800px;width:850px">
	  <h4>공지사항</h4>
	  <div style="height:30px;"></div>
	  <p>공지사항</p><div><input type=search id="search" placeholder="제목을 입력하세요.." style="width: 200px;"></div>   
	  <table class="table table-hover" style="table-layout: auto;">
	    <thead>
	      <tr>
	        <th>제목</th>
	        <th>내용</th>
	        <th>등록일</th>
	        <th>조회수</th>
	        <th>고정</th>
	        <th></th>
	      </tr>
	    </thead>
	    <tbody id=myTable>
	    	<c:forEach var="vo" items="${list }">
	    		<tr class="item">
			        <td><span class="subject" data-nno="${vo.nno }">${vo.subject }</span></td>
			        <td>${vo.content }</td>
			        <td>${vo.regdate }</td>
			        <td>${vo.hit }</td>
			        <td>
			        	<select class="fix" data-nno="${vo.nno }">
			        		<option value="0" ${vo.fix==0?'selected':'' }>N</option>
			        		<option value="1" ${vo.fix==1?'selected':'' }>Y</option>
			        	</select>
			        </td>
			        <td><input type="button" class="delBtn" data-nno="${vo.nno }" value="삭제"></td>
			    </tr>
	    	</c:forEach>
	    </tbody>
	  </table>
	</div>
	
</body>
</html>