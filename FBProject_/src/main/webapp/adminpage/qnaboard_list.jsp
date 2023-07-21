<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
  textarea {
    overflow: hidden;
    resize: none;
  }
  
 	#myTable span:hover{
		cursor: pointer;
		font-weight: bold;
	}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script>
$(function(){
	$('#searchBtn').click(function(){
		$('#sFrm').submit();
	})
	
	function adjustTextareaHeight(textarea) {
	  textarea.style.height = 'auto'; // 기본 높이로 초기화합니다.
	  textarea.style.height = textarea.scrollHeight + 'px'; // 스크롤 높이로 조정합니다.
	}
	
	window.addEventListener('DOMContentLoaded', function() {
	  var textareas = document.querySelectorAll('textarea');
	
	  textareas.forEach(function(textarea) {
	    adjustTextareaHeight(textarea); // 페이지 로드 시 각 textarea의 높이를 조정합니다.
	
	    textarea.addEventListener('input', function() {
	      adjustTextareaHeight(textarea); // textarea 내용이 변경될 때마다 높이를 조정합니다.
	    });
	  });
	});
	
	let i=0
	$('.rBtn').click(function(){
		if(i==0){
			let index=$(this).attr("data-i")
			$('#rplace'+index).show()
			$(this).val("▲")
			$('textarea').css("height","45px")
			i=1
		} else {
			let index=$(this).attr("data-i")
			$('#rplace'+index).hide()
			$(this).val("▼")
			i=0
		}
	})
	
	$('.insertBtn').click(function(){
		let index=$(this).attr("data-i")
		$('#rFrm'+index).submit()
	})
	
	$('.subject').click(function(){
		let no=$(this).attr("data-no")
		location.href="../qna/detail.do?no="+no
	})
})
</script>

</head>

<body>
	<div class="container mt-3" style="/* overflow-y: scroll; */height:750px;width:850px">
	  <h4>문의하기</h4>
	  <div style="height:30px;"></div>
	  <p>문의글 리스트</p>
	  <form method="post" action="../adminpage/qnaboard_list.do" id="sFrm">
		  <div>
		  	<input type=search name=search id="search" placeholder="제목을 입력하세요.." value="${search }">
		  	<input type=button id="searchBtn" value="검색">
		  </div>
	  </form>
	  
	  <table class="table table-hover" style="table-layout: auto;">
	    <thead>
	      <tr>
	        <th>제목</th>
	        <th>작성날짜</th>
	        <th>아이디</th>
	        <th>이름</th>
	        <th>상태</th>
	        <th></th>
	      </tr>
	    </thead>
	    <c:forEach var="vo" items="${list }" varStatus="i">
	    <tbody id=myTable>
	      
	      	<tr data-gno=${vo.no }>
	        	<td><span class=subject data-no="${vo.no }">${vo.subject }</span></td>
	        	<td>${vo.dbday }</td>
	        	<td>${vo.id }</td>
	        	<td>${vo.name }</td>
	        	<c:if test="${vo.rCount==0 }">
	        		<td><span style="color: red">답변대기</span></td>
	        	</c:if>
	        	<c:if test="${vo.rCount!=0 }">
	        		<td><span style="color: blue">답변완료</span></td>
	        	</c:if>
	        	<td><input type=button value="▼" data-i="${i.index+1 }" class="rBtn" style="background: none;border: none;">
	        </tr>
	        
	        <tr>
	        	<td colspan=6 style="padding: 0">
	        		<table class="table table-hover" id="rplace${i.index+1 }" style="display: none;">
	        			<tr>
				        	<th width=10%>내용</th>
				        	<td colspan=4>${vo.content }</td>
				        </tr>
				        <tr>
				        	<td colspan=5>
				        		<form method=post id="rFrm${i.index+1 }" action="../adminpage/qnaboard_reply.do">
					        		<textarea style="width:90%;float: left;" name="reply"></textarea>
					        		<input type=hidden value="${vo.no }" name=qno>
					        		<input type=hidden value=${search } name=search>
					        		<input type=hidden value=${curpage } name=page>
					        		<input type=button value=답변등록 style="float: left;height:45px;width:10%" class="insertBtn" data-i="${i.index+1 }">
				        		</form>
				        	</td>
				        </tr>
	        		</table>
	        	</td>
	        </tr>
	        
	    </tbody>
	    </c:forEach>
  	</table>
	
	</div>
	<div style="text-align: center;width:100%;" class="pagination1">
		<c:if test="${startpage!=1 }">
	  		<a href="../adminpage/qnaboard_list.do?page=${startpage-1 }&search=${search}">&lt;</a>&nbsp;
	  	</c:if>
	  	<c:if test="${totalpage!=1 }">
		  	<c:forEach var="i" begin="${startpage }" end="${endpage }">
		  		<a href="../adminpage/qnaboard_list.do?page=${i }&search=${search}" style="${curpage==i?'font-weight:bold;color:green':'' }">${i }</a>&nbsp;
		  	</c:forEach>
	  	</c:if>
	  	<c:if test="${endpage!=totalpage }">
	  		<a href="../adminpage/qnaboard_list.do?page=${endpage+1 }&search=${search}">&gt;</a>&nbsp;
	  	</c:if>
	</div>
	
</body>
</html>