<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
      <c:set var="i" value="${count }"></c:set>
      <c:forEach var="nvo" items="${list }">
         
          <div class="num" ${nvo.fix==1?'style="background-color:#f5f5f5;"':'style="background-color: white"' }>
             <c:if test="${nvo.fix==0 }">${ i}</c:if>
             <c:if test="${nvo.fix==1 }"><strong>※</strong></c:if>
          </div>
          <div class="title" ${nvo.fix==1?'style="background-color: #f5f5f5;font-weight:bold;color:#A52A2A"':'style="background-color: white"' }>
             <a href="../notice/notice_detail.do?nno=${nvo.nno }">
                <c:if test="${nvo.ncno==1 }"><strong>[공지]</strong></c:if><c:if test="${nvo.ncno==2 }"><strong>[이벤트]</strong></c:if>&nbsp;&nbsp; ${nvo.subject }
             </a>
          </div>
          <div class="writer" ${nvo.fix==1?'style="background-color:#f5f5f5"':'style="background-color: white"' }>${nvo.id }</div>
          <div class="date" ${nvo.fix==1?'style="background-color:#f5f5f5"':'style="background-color: white"' }>${nvo.dbday}</div>
          <div class="count" ${nvo.fix==1?'style="background-color: #f5f5f5"':'style="background-color: white"' }>${nvo.hit }</div>
      <c:set var="i" value="${i-1 }"></c:set>
      </c:forEach>
      <div class="board_page" style="  width:100%;border-top:1px solid black;">
         <ul style="padding-left: 420px;"> 
            <li><a href="../notice/notice_catelist.do?page=${startpage-1 }&ncno=${ncno}"  class="bt prev page">&lt;</a></li>
         <c:forEach var="i" begin="${startpage }" end="${endpage }">
         <li><a href="../notice/notice_catelist.do?page=${i }&ncno=${ncno}" class="num page">${i }</a></li>
         </c:forEach>
          <li><a href="../notice/notice_catelist.do?page=${endpage+1 }&ncno=${ncno}" class="bt next page">&gt;</a></li>
           </ul>
      </div>
</body>
</html>