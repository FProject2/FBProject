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
	<c:forEach var="rvo" items="${list }">
	              		<div class="board_replyList" style="margin-top: 30px">
              		 <hr>
              			   <div class="rl" style="margin-bottom: -40px;margin-top: -10px;" >
			                    <dl>
			                        <dt>글쓴이</dt>
			                        <dd>${rvo.id }</dd>
			                    </dl>
			                    <dl>
			                        <dt>작성일</dt>
			                        <dd>${rvo.dbday }</dd>
			                    </dl>
			                    <dl>
			                       <dt> <a>수정</a>&nbsp;&nbsp;&nbsp;<a>삭제</a></dt>
			                    </dl>
             			   </div>
              				<div>
	              				<hr>
									${rvo.msg }
	              				<hr>
              				</div>
              		</div>
     	</c:forEach>
</body>
</html>