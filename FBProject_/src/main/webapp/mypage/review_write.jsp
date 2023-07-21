<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <style type="text/css">
  	.row{
  		margin:0 auto;
  		width:400px;
  	}
  	table tr td input{
  		width: 100%
  	}
  	.addBtn, .delBtn{
  		border: 1px solid black;
  		border-radius: 15px;
  	}
  	.rating .rate_radio {
	    position: relative;
	    display: inline-block;
	    z-index: 20;
	    opacity: 0.001;
	    width: 60px;
	    height: 60px;
	    background-color: #fff;
	    cursor: pointer;
	    vertical-align: top;
	    display: none;
	}
	.rating .rate_radio + label {
	    position: relative;
	    display: inline-block;
	    margin-left: -4px;
	    z-index: 10;
	    width: 60px;
	    height: 60px;
	    background-image: url('img/starrate.png');
	    background-repeat: no-repeat;
	    background-size: 60px 60px;
	    cursor: pointer;
	    background-color: #f0f0f0;
	}
	.rating .rate_radio:checked + label {
	    background-color: yellow;
	}
  textarea {
    overflow: hidden;
    resize: none;
  }
  </style>
  <script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
  <script type="text/javascript">
	  let rank=0;
	
		 //별점 마킹 모듈 프로토타입으로 생성
		  function Rating(){};
		  Rating.prototype.rate = 0;
		  Rating.prototype.setRate = function(newrate){
		      //별점 마킹 - 클릭한 별 이하 모든 별 체크 처리
		      this.rate = newrate;
		      let items = document.querySelectorAll('.rate_radio');
		      items.forEach(function(item, idx){
		          if(idx < newrate){
		              item.checked = true;
		          }else{
		              item.checked = false;
		          }
		      });
		  }
		  let rating = new Rating();//별점 인스턴스 생성
	  
		  document.addEventListener('DOMContentLoaded', function(){
			    //별점선택 이벤트 리스너
			    document.querySelector('.rating').addEventListener('click',function(e){
			        let elem = e.target;
			        if(elem.classList.contains('rate_radio')){
			            rating.setRate(parseInt(elem.value));
			            rank=parseInt(elem.value)
			        }
			    })
		  });
		
	$(function(){
		//textarea 조정
		function adjustTextareaHeight(textarea) {
		  textarea.style.height = '90px'; // 기본 높이로 초기화합니다.
		  textarea.style.height = textarea.scrollHeight + 'px'; // 스크롤 높이로 조정합니다.
		}
		
		window.addEventListener('DOMContentLoaded', function() {
		  var textareas = document.querySelectorAll('textarea');
		
		  textareas.forEach(function(textarea) {
		    adjustTextareaHeight(textarea); // 페이지 로드 시 각 textarea의 높이를 조정합니다.
		
		    textarea.addEventListener('input', function() {
		      adjustTextareaHeight(textarea); // textarea 내용이 변경될 때마다 높이를 조정합니다.
		    });
		  });
		});
		
		$('#cancelBtn').click(function(){
			window.close()
		})
		
		$(document).on('click','#insertBtn', function(){
			let content=$('#content').val()
			if(rank==0){
				alert("별점을 선택해주세요")
				return;
			}
			if(content.trim()==""){
				$('#content').focus()
				return;
			}
			
			$.ajax({
				type:'post',
				url:'../mypage/reviewInsert.do',
				data:{
					"content":content,
					"rank":rank, 
					"rdate":'${vo.rdate}',
					"id":'${vo.id}',
					"gno":'${vo.gno}',
					"rno":'${vo.rno}'
				},
				success:function(result){
					alert("리뷰가 등록되었습니다")
					opener.location.reload();
  	  		        window.close();
				}
			})
		})
	})
	  
  </script>
 
</head>
<body>
	<div class="container" style="margin-top: 13px;">
		<div class=row>
			<h4 style="text-align: center;margin-bottom: 0;font-size: 1.4em;"><b>리뷰 작성</b></h4><hr style="margin-top: 20px;margin-bottom: 20px;">
			<form method="post" id="frm">
				<div class=row style="text-align: center;vertical-align: middle;">
					<div style="width: 20%;float: left;">
						<img src="${vo.gimage }" style="width: 70px;height: 70px; border: 1px solid gray;">
					</div>
					<div style="width: 70%;float: left;text-align: left;font-size: 14px;padding-top: 10px;line-height: 25px; margin-left: 10px;">
						<span style="font-weight: bold;font-size: 1.1em">${vo.gname }</span><br>
						<span style="color: gray;">${vo.gaddr }</span>
					</div>
				</div>
				
				<div style="height: 10px;background-color: #F5F5F5;margin-top: 20px;margin-bottom: 20px;"></div>
					
				<div class="review_rating">
		            <div class="warning_msg" style="text-align: center;margin-bottom: 20px;font-size: 18px;font-weight: bold;">구장은 어떠셨나요?</div>
		            <div class="rating" style="text-align: center;">
		                <!-- 해당 별점을 클릭하면 해당 별과 그 왼쪽의 모든 별의 체크박스에 checked 적용 -->
		                <input type="checkbox" name="rating" id="rating1" value="1" class="rate_radio" title="1점">
		                <label for="rating1"></label>
		                <input type="checkbox" name="rating" id="rating2" value="2" class="rate_radio" title="2점">
		                <label for="rating2"></label>
		                <input type="checkbox" name="rating" id="rating3" value="3" class="rate_radio" title="3점" >
		                <label for="rating3"></label>
		                <input type="checkbox" name="rating" id="rating4" value="4" class="rate_radio" title="4점">
		                <label for="rating4"></label>
		                <input type="checkbox" name="rating" id="rating5" value="5" class="rate_radio" title="5점">
		                <label for="rating5"></label>
		            </div>
		        </div>
		        
				<div style="height: 10px;background-color: #F5F5F5;margin-top: 20px;margin-bottom: 20px;"></div>
				
				<div style="text-align: center;margin-bottom: 20px;font-size: 18px;font-weight: bold;">이용 후기를 남겨주세요</div>
				<textarea style="width: 100%" id="content"></textarea>				
				
				<div class="text-center" style="margin-top:10px;margin-bottom: 20px;">
					<input type="button" id="insertBtn" value="등록" style="width: 49%;height:40px;border: 1px solid gray;background-color: green;color: white;font-weight: bold;">
					<input type="button" id="cancelBtn" value="취소" style="width: 49%;height:40px;border: 1px solid gray;background-color: white;font-weight: bold;">
				</div>
			</form>
		</div>
	</div>
</body>
</html>