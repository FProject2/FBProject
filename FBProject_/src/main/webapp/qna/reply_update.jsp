<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	color: black;	
}
#qlist .board_list_wrap{
	padding-top: 50px;
	
}

.board_reply .reply {
    padding: 15px;
    border-bottom: 1px solid #000;
    line-height: 160%;
      font-size: 18px;
}

.reply .com_btn button,input{
 margin-top: 30px;
    text-align: center;
    display: inline-block;
    min-width: 80px;
    margin-left:5px;
    padding: 5px;
    border: 1px solid #000;
    border-radius: 2px;
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
	
	 border: 0;
    height: 1px;
       background: #777;
}
.board_replyList .rl hr {
	
	 border: 0;
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

.board_replyList .rl dl dt {

}

.board_replyList .rl dl dd {
    margin-left: 10px;
}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$('#comment').keyup(function () {
		let content=$(this).val();
		$('#counter').html("("+content.length+" / 최대 200자)");
		
		if(content.length > 200){
			alert("최대 200자까지 입력 가능합니다.")
			$(this).val(content.substring(0,200));
			$('#counter').html("(200 / 최대 200자)");
		}
		
	})
	$('#upOk').click(function() {
		let formdata=$('#form').serialize()
		$.ajax({
			type:"post",
			url:"../qna/reply_update_ok.do",
			data:formdata,
			success:function(result)
			{
				opener.location.reload();
				window.close();
			}
			
		})
	})
})

</script>
</head>
<body>
<div id="qlist">
 <div class="container">
  	<div class="board_reply">
      		<div class="reply">
      			<span style="font-size: 15px;"><strong>댓글을 수정해주세요</strong></span>
              		<form method="post" id="form">
	              		<textarea rows="4" id="comment" name="msg"style="width: 100%; margin-bottom: -25px">${msg }</textarea>
	              		<input type=hidden name="rno" value="${rno}">
	              		<span style="color: #aaa; font-size:14px;" id="counter" >(0 / 최대 200자)</span>
		              	<div class="com_btn" style="display: inline; margin-left: 115px;">
		              		<input type="button" style='cursor:pointer; font-size: 12px;' value="등록" id="upOk">
		              		<button type="button" style='cursor:pointer; font-size: 12px;;' onclick="window.close()">취소</button>
		              	</div>
	             	</form>	
		    	
		 
             </div>
		</div>
	</div>
</div>
</body>
</html>