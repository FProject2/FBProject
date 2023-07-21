<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="board_page">
			<ul> 
			   <li><a href="../notice/notice_catepage.do?page=${startpage-1 }&ncno=${ncno}"  class="bt prev page">&lt;</a></li>
			<c:forEach var="i" begin="${startpage }" end="${endpage }">
			<li><a href="../notice/notice_catepage.do?page=${i }&ncno=${ncno}" class="num page">${i }</a></li>
			</c:forEach>
			 <li><a href="../notice/notice_catepage.do?page=${endpage+1 }&ncno=${ncno}" class="bt next page">&gt;</a></li>
			  </ul>
		</div> 
</body>
</html>