<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Football-Play 로그인</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="image/png" href="../main/favicon.png">

<link rel="stylesheet" href="../main/assets/css/slick/slick.css"> 
<link rel="stylesheet" href="../main/assets/css/slick/slick-theme.css">
<link rel="stylesheet" href="../main/assets/css/animate.css">
<link rel="stylesheet" href="../main/assets/css/iconfont.css">
<link rel="stylesheet" href="../main/assets/css/font-awesome.min.css">
<link rel="stylesheet" href="../main/assets/css/bootstrap.css">
<link rel="stylesheet" href="../main/assets/css/magnific-popup.css">
<link rel="stylesheet" href="../main/assets/css/bootsnav.css">
<!--Theme custom css -->
<link rel="stylesheet" href="../main/assets/css/style.css">
<!--<link rel="stylesheet" href="assets/css/colors/maron.css">-->
<!--Theme Responsive css-->
<link rel="stylesheet" href="../main/assets/css/responsive.css" />
<script src="../main/assets/js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
	$(function() {
		$('#logAlert').hide();
		$('#logBtn').click(function() {
			let id=$('#id').val();
			if(id.trim()=="")
			{
				$('#logAlert').text("아이디를 입력하세요!");
				$('#logAlert').show();
				$('#id').focus;
				return;
			}
			
			let pwd = $('#pwd').val();
			if(pwd.trim()==""){
				$('#logAlert').text("비밀번호를 입력하세요!");
				$('#logAlert').show();
				$('#pwd').focus;
				return;
			}
			
			$.ajax({
				type:'post',
				url:'../member/login_ok.do',
				data:{"id":id, "pwd":pwd},
				success:function(result){
					let res = result.trim();
					if(res==='NOID'){
						$('#logAlert').text("존재하지 않는 아이디입니다!")
						$('#logAlert').show();
						$('#id').val("");
						$('#pwd').val("");
						$('#id').focus();
					}
					else if(res==='NOPWD'){
						$('#logAlert').text("비밀번호가 틀렸습니다!")
						$('#logAlert').show();
						$('#pwd').val("");
						$('#pwd').focus();
					}
					else {
						location.href="../main/main.do"
					}
				}
			})
			
		})
		
		$('#ipFind').click(function() {
			let x=(document.body.offsetWidth/2)-(500/2)
			let y=(window.screen.height/2)-(250/2)
			window.open("../member/ipFind.do","",'width=420, height=300, left='+x+', top='+y)
		})
		
	})
</script>

<style type="text/css">
	#logincont .row {
		margin: 0px auto;
		height: 80vh;
		padding-top: 200px;
	}
	
	#login {
		margin: 0px auto;
		width: 500px;
		background-color: #DCDCDC;
		border-radius: 30px;
		padding: 50px;
	}
	
	#join, #logAlert {
		color: #d9534f;
	}
	
	#ipFind {
		color: #797979;
	}
	
	#join:hover, #ipFind:hover {
		text-decoration: underline;
	}
</style>
</head>
<body>

	<div class="container" id=logincont>
		<div class="row">
		
		<div class="form-group" id="login">
			
				<div class="form-group">
					<label class="form-label mt-4 text-left">아이디</label>
					<input type="text" class="form-control" name=id id=id>
				</div>
				
				<div class="form-group">
					<label class="form-label mt-4 text-left">비밀번호</label>
					<input type="password" class="form-control" name=pwd id=pwd>
				</div>
				
				<div class="form-group">
					<span id="logAlert" style="display: none;"></span>
				</div>

				<div class="d-grip gap-2 text-center" style="margin-top: 10px;">
					<button class="btn btn-danger btn-lg" id="logBtn">로그인</button>
				</div>
				
				<div class="form-group text-center" style="margin-top: 20px;">
					<label class="form-label" style="display: block;"><a href="#" id="ipFind">아이디 / 비밀번호 찾기</a></label>
					<label class="form-label">아직 회원이 아니시라면? <a href="../member/join.do" id="join">회원가입</a></label>
				</div>
				
		</div>

		</div>
	</div>
	
</body>
</html>