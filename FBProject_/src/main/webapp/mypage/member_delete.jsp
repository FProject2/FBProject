<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
	$(function(){
		$('#cBtn').click(function(){
			window.close()
		})
		$('#dBtn').click(function(){
			if($('#pwd').val().trim()==""){
				$('#pwd').focus();
				return;
			}
			$.ajax({
				type:'post',
				url:'../mypage/member_delete_pwd_check.do?pwd='+$('#pwd').val(),
				success:function(result){
					
					if(result.trim()=="y"){
						alert("회원 탈퇴 완료")
						opener.location.href = "../main/main.do"
						window.close()
					} else {
						alert("비밀번호가 틀립니다")
						$('#pwd').val("");
						$('#pwd').focus();
					}
					
				}
			})
		})
	})
</script>
<style type="text/css">
.container{
	margin:0 auto;
	width:300px;
	height:150px;
	text-align: center;
}

</style>
</head>
<body>
	<div class=container>
		<h3>회원 탈퇴</h3>
		<div style="height: 20px;"></div>
		<input type=text id=pwd placeholder="비밀번호를 입력하세요"><br>
		<div style="margin-top: 20px;">
			<input type=button value="수정" id="dBtn" style="width:50px;height:30px;">
			<input type=button value="취소" id="cBtn" style="width:50px;height:30px;">
		</div>
	</div>
	
</body>
</html>