<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

* {
    margin: 0;
    padding: 0;
}


ul, li {
    list-style: none;
}

a {
    text-decoration: none;
    color: inherit;
}

.board_wrap {
    width: 1000px;
    margin: 100px auto;
}


.bt_wrap {
    margin-top: 30px;
    text-align: center;
    font-size: 0;
    
}

.bt_wrap a {
    display: inline-block;
    min-width: 80px;
    margin-left: 10px;
    padding: 10px;
    border: 1px solid #000;
    border-radius: 2px;
    font-size: 15px;
}

.bt_wrap a:first-child {
    margin-left: 0;
}

.bt_wrap a.on {
    background: #000;
    color: #fff;
     font-size: 15px;
}

.board_list {
    width: 100%;
    border-top: 2px solid #000;
}

.board_list > div {
    border-bottom: 1px solid #ddd;
    font-size: 0;
}

.board_list > div.top {
    border-bottom: 1px solid #999;
}

.board_list > div:last-child {
    border-bottom: 1px solid #000;
}

.board_list > div > div {
    display: inline-block;
    padding: 15px 0;
    text-align: center;
    font-size: 1.4rem;
}

.board_list > div.top > div {
    font-weight: 600;
     font-size: 15px;
}

.board_list .num {
    width: 10%;
     font-size: 15px;
}

.board_list .title {
    width: 60%;
    text-align: left;
     font-size: 15px;
}

.board_list .top .title {
    text-align: center;
     font-size: 15px;
}

.board_list .writer {
    width: 10%;
     font-size: 15px;
}

.board_list .date {
    width: 10%;
     font-size: 15px;
}

.board_list .count {
    width: 10%;
     font-size: 15px;
}

.board_page {
    margin-top: 30px;
    text-align: center;
    font-size: 0;
      display: flex;
  justify-content: center;
}

.board_page a {
    display: inline-block;
    width: 32px;
    height: 32px;
    box-sizing: border-box;
    vertical-align: middle;
    border: 1px solid #ddd;
    border-left: 0;
    line-height: 100%;
    
    
}

.board_page a.bt {
    padding-top: 10px;
    font-size: 15px;
    letter-spacing: -1px;
}

.board_page ul li a.num {
    padding-top: 9px;
    font-size: 15px;
    
}

.board_page ul li a.num.on {
    border-color: #000;
    background: #000;
    color: #fff;
    
   
}

.board_page a:first-child {
    border-left: 1px solid #ddd;
}

#qlist .container{
   padding-top: 50px;
   color: black;   
}
#qlist .board_list_wrap{
   padding-top: 50px;
   
   
}

#qlist .board_page ul{
   list-style:none;
}

#qlist .board_page ul li{
   float: left;
   
}

</style>
</head>
<body>
<div id="qlist">
<div class="container">
    <div class="board_wrap" style="margin: 100px;">
        <div class="board_title text-center" style="margin-right: 40px;">
             <img src="img/qna.png">
        </div>
       <br>  
        <div class="board_list_wrap" style="margin-top: -10px;">
            <div class="board_list">
                <div class="top">
                    <div class="num">번호</div>
                    <div class="title">제목</div>
                    <div class="writer">글쓴이</div>
                    <div class="date">작성일</div>
                    <div class="count">조회</div>
                </div>
                <c:set var="i" value="${count }"></c:set>
                <c:forEach var="vo" items="${list }">
                <div>
                    <div class="num">${ i}</div>
                    <c:if test="${vo.secret==null }">
                    <div class="title"><a href="../qna/detail.do?no=${vo.no }">${vo.subject }</a>&nbsp;&nbsp;
                    <c:if test="${today==vo.dbday }"><sup style="color: red;">new</sup></c:if></div>
                    </c:if>
                     <c:if test="${vo.secret=='y' }">
                    <div class="title"><sup><img src="img/secret.png" style="width:15px;height:16px;"></sup>
                     <c:if test="${sessionScope.id==vo.id }">
                     <a href="../qna/detail.do?no=${vo.no }">${vo.subject }</a>
                     </c:if>
                     <c:if test="${sessionScope.id!=vo.id || sessionScope.admin=='y' }">
                     <span>&nbsp;&nbsp;비밀글입니다.</span>
                     </c:if>
                     </div>
                    </c:if>
                    <div class="writer">${vo.name }</div>
                    <div class="date">${vo.dbday}</div>
                    <div class="count">${vo.hit }</div>
                </div>
                <c:set var="i" value="${i-1 }"></c:set>
               </c:forEach>
            </div>
            <div class="board_page">
              <ul> 
                   <li><a href="../qna/list.do?page=${startpage-1 }"  class="bt prev">&lt;</a></li>
                <c:forEach var="i" begin="${startpage }" end="${endpage }">
                   <li><a href="../qna/list.do?page=${i }" class="num">${i }</a></li>
                </c:forEach>
                   <li><a href="../qna/list.do?page=${endpage+1 }" class="bt next">&gt;</a></li>
              </ul>
            </div> 
            <br>
            <c:if test="${sessionScope.id!=null }">
            <div class="bt_wrap">
                <a href="../qna/insert.do" class="on">글쓰기</a>
            </div>
            </c:if>
        </div>
    </div>
    </div>
    </div>
</body>
</html> 