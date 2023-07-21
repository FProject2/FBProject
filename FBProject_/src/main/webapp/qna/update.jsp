<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<head>
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

.bt_wrap input {
    display: inline-block;
    min-width: 80px;
    margin-left: 10px;
    padding: 10px;
    border: 1px solid #000;
    border-radius: 2px;
    font-size: 15px;
    
}

.bt_wrap input:first-child {
    margin-left: 0;
}

.bt_wrap input.on {
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



.board_write {
    border-top: 2px solid #000;
}

.board_write .title,
.board_write .info {
    padding: 15px;
}

.board_write .info {
    border-top: 1px dashed #ddd;
    border-bottom: 1px solid #000;
    font-size: 0;
}

.board_write .title dl {
    font-size: 0;
}

.board_write .info dl {
    display: inline-block;
    width: 50%;
    vertical-align: middle;
}

.board_write .title dt,
.board_write .title dd{
 	display: inline-block;
    vertical-align: middle;
    font-size: 20px;
}

.board_write .info dt,
.board_write .info dd {
    display: inline-block;
    vertical-align: middle;
    font-size: 15px;
}

.board_write .title dt,
.board_write .info dt {
    width: 100px;
}

.board_write .title dd {
    width: calc(100% - 100px);
}

.board_write .title input[type="text"],
.board_write .info input[type="text"],
.board_write .info input[type="password"] {
    padding: 10px;
    box-sizing: border-box;
}

.board_write .title input[type="text"] {
    width: 80%;
}

.board_write .cont {
    border-bottom: 1px solid #000;
}

.board_write .cont textarea {
    display: block;
    width: 100%;
    height: 300px;
    padding: 15px;
    box-sizing: border-box;
    border: 0;
    resize: vertical;
    font-size: 20px;
}

#qlist .container{
	padding-top: 50px;
	color: black;	
}
#qlist .board_list_wrap{
	padding-top: 50px;
	
}

</style>
</head>
</head>
<body>
<div id="qlist">
<div class="container">
 <div class="board_wrap">
         <div class="board_title text-center" style="margin-right: 40px;">
             <img src="img/qna.png">
        </div>
       <br>  
        <form method="post" action="../qna/update_ok.do">
        <div class="board_write_wrap">
            <div class="board_write">
                <div class="title">
                    <dl>
                        <dt>제목</dt>
                        <dd><input type="text" name="subject" value="${vo.subject }" ></dd>
                        <input type=hidden name=no value="${vo.no }">
                    </dl>
                </div>
                <div class="info">
                    <dl>
                        <dt>글쓴이</dt>
                        <dd><input type="text" name="name" value="${vo.name }"></dd>
                    </dl>
                    <dl>
						<dt>작성일</dt>
                        <dd>${vo.dbday}<c:if test="${vo.updbday!=null && vo.updbday!=vo.dbday }">&nbsp;(${vo.updbday }) </c:if></dd>
                    </dl>
                </div>
                <div class="cont">
                    <textarea name="content">${vo.content }</textarea>
                </div>
            </div>
            <div class="bt_wrap">
                <input type=submit value="완료" class="on">
                <input type=button value=취소 onclick="javascript:history.back()">
            </div>
        </div>
        </form>
    </div>
    </div>
    </div>
</body>
</html>