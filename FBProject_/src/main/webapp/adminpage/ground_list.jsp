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
$(function(){
	$('#searchBtn').click(function(){
		$('#sFrm').submit();
	})
	
	$('#myTable tr').click(function(){
		let x=(document.body.offsetWidth/2)-(750/2)
		let y=(window.screen.height/2)-(570/2)-50
		let gno=$(this).attr('data-gno')
		window.open("../adminpage/groundDetail.do?gno="+gno,"",'width=750, height=570, left='+x+', top='+y)
	})
})
</script>

</head>

<body>
	<div class="container mt-3" style="/* overflow-y: scroll; */height:830px;width:850px">
	  <h4>구장 관리</h4>
	  <div style="height:30px;"></div>
	  <p>구장 리스트</p>
	  <form method="post" action="../adminpage/ground_list.do" id="sFrm">
		  <div>
		  	<input type=search name=search id="search" placeholder="구장명을 입력하세요.." value="${search }">
		  	<input type=button id="searchBtn" value="검색">
		  </div>
	  </form>
	  <table class="table table-hover" style="table-layout: auto;">
	    <thead>
	      <tr>
	        <th></th>
	        <th>구장명</th>
	        <th>주소</th>
	        <th>가격</th>
	      </tr>
	    </thead>
	    <tbody id=myTable>
	      <c:forEach var="vo" items="${list }">
	      	<tr data-gno=${vo.gno }>
	      		<td width=10%><img src="${vo.gimage }" style="width: 60px;height: 45px"></td>
	        	<td>${vo.gname }</td>
	        	<td>${vo.gaddr }</td>
	        	<td>${vo.gprice }</td>
	        </tr>
	      </c:forEach>
	    </tbody>
	  </table>
	</div>
	<div style="text-align: center;width:100%;" class="pagination1">
		<c:if test="${startpage!=1 }">
	  		<a href="../adminpage/ground_list.do?page=${startpage-1 }&search=${search}">&lt;</a>&nbsp;
	  	</c:if>
	  	<c:forEach var="i" begin="${startpage }" end="${endpage }">
	  		<a href="../adminpage/ground_list.do?page=${i }&search=${search}" style="${curpage==i?'font-weight:bold;color:green':'' }">${i }</a>&nbsp;
	  	</c:forEach>
	  	<c:if test="${endpage!=totalpage }">
	  		<a href="../adminpage/ground_list.do?page=${endpage+1 }&search=${search}">&gt;</a>&nbsp;
	  	</c:if>
	</div>
	
</body>
</html>