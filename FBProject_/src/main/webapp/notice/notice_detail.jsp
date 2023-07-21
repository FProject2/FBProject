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

.board_title {
    margin-bottom: 30px;
}

.board_title strong {
    font-size: 3rem;
    color: black;
}

.board_title p {
    margin-top: 5px;
    font-size: 1.4rem;
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
}

.board_list .num {
    width: 10%;
}

.board_list .title {
    width: 60%;
    text-align: left;
}

.board_list .top .title {
    text-align: center;
}

.board_list .writer {
    width: 10%;
}

.board_list .date {
    width: 10%;
}

.board_list .count {
    width: 10%;
}


.board_view {
    width: 100%;
    border-top: 2px solid #000;
}

.board_view .title {
    padding: 20px 15px;
    border-bottom: 1px dashed #ddd;
      font-size: 25px;
}

.board_view .info {
    padding: 15px;
    border-bottom: 1px solid #999;
    font-size: 0;
   
}

.board_view .info dl {
    position: relative;
    display: inline-block;
    padding: 0 20px;
  
}

.board_view .info dl:first-child {
    padding-left: 0;
}

.board_view .info dl::before {
    content: "";
    position: absolute;
    top: 1px;
    left: 0;
    display: block;
    width: 1px;
    height: 13px;
    background: #ddd;
}

.board_view .info dl:first-child::before {
    display: none;
}

.board_view .info dl dt,
.board_view .info dl dd {
    display: inline-block;
      font-size: 15px;
}

.board_view .info dl dt {

}

.board_view .info dl dd {
    margin-left: 10px;
    color: #777;
}

.board_view .cont {
    padding: 15px;
    border-bottom: 1px solid #000;
    line-height: 160%;
      font-size: 18px;
}

#qlist .container{
	padding-top: 50px;
	color: black;	
}
#qlist .board_list_wrap{
	padding-top: 50px;
	
}

.board_reply .reply {
    padding: 15px;
     border-bottom: 1px solid #d3d3d3;
    line-height: 160%;
      font-size: 18px;
}

.reply button {
 margin-top: 30px;
    text-align: center;
    font-size: 0;
    display: inline-block;
    min-width: 80px;
    margin-left: 10px;
    padding: 10px;
    border: 1px solid #000;
    border-radius: 2px;
  	font-size: 15px;
  	    background: #000;
    color: #fff;
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

hr {
    height: 1px;
       background: #777;
}
#qlist .board_page ul{
	list-style:none;
}

#qlist .board_page ul li{
	float: left;
	
}
.board_replyList .rl {
    font-size: 0;
   
   
}

.board_replyList .rl dl {
    position: relative;
    display: inline-block;
    padding: 0 20px;
  
}

.board_replyList .rl dl:first-child {
    padding-left: 0;
}

.board_replyList .rl dl::before {
    content: "";
    position: absolute;
    top: 1px;
    left: 0;
    display: block;
    width: 1px;
    height: 13px;
    background: #ddd;
}

.board_replyList .rl dl:first-child::before {
    display: none;
}

.board_replyList .rl dl dt,
.board_replyList .rl dl dd {
    display: inline-block;
      font-size: 15px;
}

.board_replyList .rl dl dt a{

}

.board_replyList .rl dl dd {
    margin-left: 10px;
}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>

</head>
<body>
<div id="qlist">
	<div class="container">
 		<div class="board_wrap">
			 <div class="board_title text-center">
            <img src="img/notice.png" style="width:1260px;height: 300px;margin-right: 300px;margin-top: 100px;">
       </div>
			<div class="board_view_wrap">
				<div class="board_view">
					<div class="title">${vo.subject }</div>
					<input type=hidden name=nno value="${vo.nno }" id="nno">
			<div class="info">
				<dl>
					<dt>글쓴이</dt>
					<dd>${vo.id }</dd>
				</dl>
				<dl>
					<dt>작성일</dt>
					<dd>${vo.dbday}</dd>
				</dl>
				<dl>
					<dt>조회</dt>
					<dd>${vo.hit }</dd>
				</dl>
			</div>
			<div class="cont">${vo.content }</div>
				</div>
				<div class="bt_wrap">
				<c:if test="${sessionScope.id==vo.id }">
				<a href="../notice/notice_update.do?nno=${vo.nno }">수정</a>
				</c:if>
				<a href="../notice/notice_list.do" class="on">목록</a>
				<c:if test="${sessionScope.id==vo.id }">
				<a href="../notice/notice_delete.do?nno=${vo.nno }">삭제</a>
				</c:if>
			</div> 
		</div>
	</div>
</div>
</body>
</html>