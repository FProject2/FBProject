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
<script type="text/javascript">
let r=0;
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
	
	$('.rreply').click(function() {
		let no=$(this).attr("data-no");
		$('.rreply').text("답글쓰기");
		$('.rin').hide();
		/*$('.updates').hide(); */
		if(r==0)
		{
			$(this).text("취소");
			$('#r'+no).show();
			r=1;
		}
		else
		{
			$(this).text("답글쓰기");
			$('#r'+no).hide();
			r=0;
		}
		
	})
})


$(function () {
	
	$('.up').click(function () {
		let index=$(this).attr("data-upi");
		let msg=$('#toMsg'+index).text()
		let rno=$('#uRno'+index).val()
		var options = 
			"width=450, height=150, top=300, left=500, resizable=no, status=no, menubar=no, toolbar=no, scrollbars=no";
		window.open("../qna/reply_update.do?msg="+msg+"&rno="+rno, 
				"uPopup",options);	
		
	
		
	})
})

	

</script>
</head>
<body>
<div id="qlist">
	<div class="container">
		<div class="board_wrap">
		  <div class="board_title text-center" style="margin-right: 40px;">
             <img src="img/qna.png">
        </div>
       <br>  
			
			<%-- 글 + 댓글 리스트 --%>
		<div class="board_view_wrap">
		`<%-- 글 출력--%>
			<div class="board_view">
				<div class="title">${vo.subject }</div>
				<div class="info">
					<dl>
						<dt>글쓴이</dt>
						<dd>${vo.name }</dd>
					</dl>
					<dl>
						<dt>작성일</dt>
						<dd>${vo.dbday}</dd>
					</dl>
					<c:if test="${vo.updbday!=null && vo.updbday!=vo.dbday }">
					<dl>
						<dt>수정일</dt>
						<dd>${vo.updbday }</dd>
					</dl>
					</c:if>
					<dl>
						<dt>조회</dt>
						<dd>${vo.hit }</dd>
					</dl>
				</div>
				<div class="cont">${vo.content }</div>
			</div>
			
		<%-- 댓글 출력 --%>
		<br>
		<c:if test="${rcount>0 }">
		<div class="comtitle"><h4><strong>댓글</strong>&nbsp;<img src="img/chat-dots.svg" style="width: 20px;height: 20px;">&nbsp;${rcount }</h4></div>
		</c:if>	  		
		
		<%-- 댓글 등록 후 출력 리스트 --%>
		<c:forEach var="rvo" items="${list }" varStatus="upi">
		
				<c:if test="${rvo.group_tab==0 }">
					<div class="board_replyList" style="padding:30px 20px 0px 20px;background-color: #F5F5F5;  border-radius: 30px;border: 1px solid #d3d3d3;">
				</c:if>
				
				<c:if test="${rvo.group_tab>0 }">
				
					<div class="board_replyList" style="padding:30px 20px 0px 20px; margin-left:${rvo.group_tab*40}px; background-color: #F5F5F5;  border-radius: 30px;border: 1px solid #d3d3d3;">
				</c:if>
				<div class="rl" style="margin-bottom: -40px;margin-top: -10px;">
					<dl> 
						<dt>
						<c:if test="${rvo.group_tab>0 }">
							<img src="img/arrow-return-right.svg">
						</c:if>
							<img src="img/person.svg" style="height: 20px;width: 20px;">
						</dt>
						<dd><c:if test="${rvo.id=='shim'}"><strong>[관리자]&nbsp;</strong></c:if> ${rvo.id }</dd>
					</dl>
					
					
					<dl style="float: right;">
					
						<c:if test="${sessionScope.id==rvo.id }">
							<dt>
								<a style="cursor:pointer;" class="up" data-upi="${upi.index+1 }">수정</a>&nbsp;&nbsp;&nbsp;
								<a href="../qna/reply_delete.do?qno=${vo.no }&rno=${rvo.rno}">삭제</a>&nbsp;&nbsp;&nbsp;
							</dt>
						</c:if>   
					</dl>
				</div>
				<div style="margin-top: 40px;">
					<dl>
						<dt><span id="toMsg${upi.index+1 }">${rvo.msg }</span></dt>
						<input type="hidden" value="${rvo.rno }" id="uRno${upi.index+1 }">
						<br>
						<dd style="font-size: 15px">
							${rvo.dbday } &nbsp;&nbsp;&nbsp; 
							<c:if test="${sessionScope.id!=null }">
								<a style="cursor:pointer;" class="rreply" data-no="${rvo.rno }"><strong>답글쓰기</strong></a>
							</c:if>
						</dd>
					</dl>
				</div>	
			</div>
			
			
		<%-- 댓글 답글 쓰기 눌렀을 시 나오는 창 --%>
			<div class="board_reply" style="margin-bottom: 10px;">
				<div class="reply" style="display:none" class="rin" id="r${rvo.rno }">		
					<div >
						<form method="post" action="../qna/reply_reply_insert.do">
							<textarea rows="4" id="comment" name="msg" placeholder="댓글을 입력해주세요" style="width: 100%; margin-bottom: -25px"></textarea>
							<input type=hidden name="qno" value="${vo.no}">
							<input type=hidden name="rno" value="${rvo.rno}">
							<div class="com_btn" style="display: inline;">
							<div style="margin-top: 20px;">
								<span style="color: #aaa; margin-right: 745px; vertical-align: top;" id="counter" >(0 / 최대 200자)</span>
								<button  type="submit" style="margin-top: 0px">등록</button>
							</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			</c:forEach>
		
		<%-- page바 --%>
			<c:if test="${rcount!=0 }">
				<div class="board_page">
					<ul> 
						<li><a href="../qna/detail.do?page=${startpage-1 }&no=${vo.no}"  class="bt prev">&lt;</a></li>
						<c:forEach var="i" begin="${startpage }" end="${endpage }">
						<li><a href="../qna/detail.do?page=${i }&no=${vo.no}" class="num">${i }</a></li>
						</c:forEach>
						<li><a href="../qna/detail.do?page=${endpage+1 }&no=${vo.no}" class="bt next">&gt;</a></li>
					</ul>
				</div>
			</c:if>

		

			<c:if test="${sessionScope.id!=null }">
			<div class="board_reply">
				<div class="reply" style=" border-bottom: 1px solid #000;">
					<form method="post" action="../qna/reply_insert.do">
					<textarea rows="4" id="comment" name="msg" placeholder="댓글을 입력해주세요" style="width: 100%; margin-bottom: -25px"></textarea>
					<input type=hidden name="qno" value="${vo.no}">
					<div class="com_btn" style="display: inline;">
						<div style="margin-top: 20px;">
							<span style="color: #aaa; margin-right: 745px; vertical-align: top;" id="counter" >(0 / 최대 200자)</span>
							<button  type="submit" style="margin-top: 0px">등록</button>
						</div>				
					</div>
					</form>	
				</div>
			</div>
			</c:if>
		
	
		
			<%--댓글등록 --%>
						
			<div class="bt_wrap">
				<c:if test="${sessionScope.id==vo.id }">
					<a href="../qna/update.do?no=${vo.no }">수정</a>
				</c:if>
					<a href="../qna/list.do" class="on">목록</a>
				<c:if test="${sessionScope.id==vo.id }">
					<a href="../qna/delete.do?no=${vo.no }">삭제</a>
				</c:if>
			</div>
			 
		</div>
	</div>
</div>
</body>
</html>