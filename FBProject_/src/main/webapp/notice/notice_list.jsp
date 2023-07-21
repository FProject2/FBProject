<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

 /* .board_title {
    margin-bottom: 30px;
    
}

.board_title strong {
    font-size: 3rem;
     color: black;
}

.board_title p {
    margin-top: 5px;
    font-size: 1.4rem;
    color: black;
}
  */
.bt_wrap {
    margin-top: 5px;
    text-align: center;
    font-size: 1px;                        
    font-weight: bold;  
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
    color: #000
}

.bt_wrap a.on {
    background: white;
    color: blak;
     font-size: 15px;
}

.bt_wrap a.on:hover {            
        color: white;                   
        background-color: black;    
          border:2px solid black;   
}

.board_list {
    width: 100%;
    border-top: 2px solid black;
    color: black;   
}

.board_list > div {
    font-size: 0;
}

.board_list > div.top {
    border-bottom: 1px solid black;
}

.board_list > div:last-child {
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
     border-bottom: 1px solid #A9A9A9;
}

.board_list .num {
    width: 10%;
     font-size: 15px;
      border-bottom: 1px solid #A9A9A9;
}



.board_list .title {
    width: 60%;
    text-align: left;
     font-size: 15px;
     border-bottom: 1px solid #A9A9A9;
}

.board_list .top .title {
    text-align: center;
     font-size: 15px;
     border-bottom: 1px solid #A9A9A9;
}

.board_list .writer {
    width: 10%;
     font-size: 15px;
     border-bottom: 1px solid #A9A9A9;
}

.board_list .date {
    width: 10%;
     font-size: 15px;
     border-bottom: 1px solid #A9A9A9;
}

.board_list .count {
    width: 10%;
     font-size: 15px;
     border-bottom: 1px solid #A9A9A9;
}

.board_page {
    text-align: center;
    font-size: 0;
      display: flex;
  justify-content: center;
  font-weight: bold;
  color: black;
}

.board_page li a {
    display: inline-block;
    width: 32px;
    height: 32px;
    box-sizing: border-box;
    vertical-align: middle;
    border: 1px solid black;
    border-left: 0;
    line-height: 100%;
    background-color: white;
    
    
    
}

.board_page a.bt {
    font-size: 15px;
    letter-spacing: -1px;
      border:1px solid black;  
      padding: 13px 19px 20px 13px;
}

.board_page ul li a.num {
    padding: 13px 19px 20px 13px;
    font-size: 15px;
     border:1px solid black;   
}

.board_page ul li a.num.on {
    border-color: #000;
    background: #000;
    color: #fff;
     border:1px solid black;   
   
}

.board_page a:first-child {
    border-left: 1px solid black;
      
}

.board_page ul li a.num.on:hover {            
        color: black;                   
        background-color: white;    
          border:1px solid black;   
}

.board_page ul li a:hover {            
        color: black;                   
        background-color: white;    
          border:2px solid black;   
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
 #topMenu {          
        height: 30px; 
        width: 1100px; 
       margin-left: 100px;
}
#topMenu ul li {                      
        list-style: none;         
        color: black;            
        background-color: white;  
        float: left;               
        line-height: 30px;         
        vertical-align: middle;   
        text-align: center;    
        border:1px solid black;   
}
#topMenu .menuLink {                              
        text-decoration:none;                     
        color: black;                            
        display: block;                         
        width: 250px;
        height: 40px;                          
        font-size: 18px;                        
        font-weight: bold;  
      padding-top: 5px;        
}
#topMenu .menuLink:hover {            
        color: white;                   
        background-color: black;    
          border:2px solid black;   
}

.search {
  position: relative;
  width: 350px;
}

input {
  width: 100%;
  border: 2px solid blak;
  border-radius: 8px;
  padding: 10px 12px;
  font-size: 14px;
}

#qlist img {
  position : absolute;
  width: 17px;
  top: 10px;
  right: 12px;
  margin: 0;
}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
$(function () {
   
   $.ajax({
      type:"post",
      url:"../notice/notice_catelist.do",
      success:function(result)
      {
         $('#catelist').html(result)
      }
      
   })
   
   $(".menuLink").click(function() {
      let cate=$(this).attr("data-cate")
      $.ajax({
         type:"post",
         url:"../notice/notice_catelist.do",
         data:{"ncno":cate},
         success:function(result)
         {
            $('#catelist').html(result)
         }
      })
      $("#find").click(function() {
         let fd=$('#fd').val()
         $.ajax({
            type:"post",
            url:"../notice/notice_catelist.do",
            data:{"fd":fd,"ncno":cate},
            success:function(result)
            {
               $('#catelist').html(result)
            }
         })
      }) 
      
   })
   
   $("#find").click(function() {
      let fd=$('#fd').val()
      $.ajax({
         type:"post",
         url:"../notice/notice_catelist.do",
         data:{"fd":fd},
         success:function(result)
         {
            $('#catelist').html(result)
         }
      })
   }) 
})   
 
</script>
</head>
<body>
<div id="qlist">
<div class="container" style="margin-bottom: 20px">
    <div class="board_wrap" style="margin: 100px;">
       <div class="board_title text-center">
            <img src="img/notice.png" style="width:1260px;height: 300px;margin-right: 300px;margin-top: 100px;">
       </div>
          <div style="margin-top: 380px;">
         <nav id="topMenu">
            <ul>
               <li><a class="menuLink">전체</a></li>
               <li><a class="menuLink" data-cate="1">공지사항</a></li>
               <li><a class="menuLink" data-cate="2">이벤트</a></li>
            </ul>
         </nav>
      </div>
      <c:if test="${sessionScope.admin=='y' }">
       <div class="bt_wrap" style="float: left; margin-left: 40px;">
               <a href="../notice/notice_insert.do" class="on">글쓰기</a>
           </div>
        </c:if>
           <br>
       <div class="board_list_wrap">
           <div class="board_list">
               <div class="top">
                   <div class="num" style="color:black;">번호</div>
                   <div class="title" style="color:black;">제목</div>
                   <div class="writer" style="color:black;">관리자</div>
                   <div class="date" style="color:black;">작성일</div>
                   <div class="count" style="color:black;">조회</div>
               </div>
                 <div id="catelist">
                    <!-- notice_catgory_list.jsp -->
                 </div>
           </div>
           <br>
              <div class="search" style="margin-left: 650px; margin-top: -65px;">
           <input type="text" placeholder="검색어 입력" id="fd">
           <img src="img/search.png" id="find">
      </div>
      </div>
</div>
</div>
</div> 
</body>
</html>