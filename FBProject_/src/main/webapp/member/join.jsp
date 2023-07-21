<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Football-Play! 회원가입</title>
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
<style type="text/css">
	#joincont .row {
		margin: 0px auto;
		height: 140vh;
		padding-top: 130px;
		
	}
	#login {
		margin: 0px auto;
		width: 500px;
		background-color: #DCDCDC;
		border-radius: 30px;
		padding: 50px;
	}
	
	#idCheckBtn, #postBtn {
		margin-top: 5px;
	}
	
</style>
<script src="../main/assets/js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
$(function(){
	
	$('#idCheckBtn').click(function(){
		let x=(document.body.offsetWidth/2)-(500/2)
		let y=(window.screen.height/2)-(300/2)
		window.open("../member/idcheck.do","",'width=500, height=300, left='+x+', top='+y)
	})
	
	// 유효성 검사
	let name = $('#name').val();
	let id = $('#id').val();
	let nickname = $('#nickname').val();
	let pwd = $('#pwd').val();
	let email = $('#email').val();
	let post = $('#post').val();
	let phone = $('#phone').val();
	
	$('#joinBtn').click(function(){
		
		if(name.trim()=="")
		{
			$('#name').focus();
			return;
		}
		if(id.trim()=="")
		{
			$('#id').focus();
			return;
		}
		if(nickname.trim()=="")
		{
			$('#nickname').focus();
			return;
		}
		if(pwd.trim()=="")
		{
			$('#pwd').focus();
			return;
		}
		if(email.trim()=="")
		{
			$('#email').focus();
			return;
		}
		if(post.trim()=="")
		{
			$('#post').focus();
			return;
		}
		if(phone.trim()=="")
		{
			alert("모든 정보를 입력해주세요!");
			$('#phone').focus();
			return;
		}
		
		$('#joinFrm').submit();
		
	})
	
})
</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('post').value = data.zonecode;
                document.getElementById("addr1").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("addr2").focus();
            }
        }).open();
    }
</script>
</head>
<body>

	<div class="container py-4" id=joincont>
		<div class="row">
		
		<div class="form-group" id="login">
		<form method=post action="../member/join_ok.do" name="joinFrm" id="joinFrm">
				<div class="form-group">
					<label class="form-label mt-4 text-left">이름</label>
					<input type="text" class="form-control" name=name id=name>
				</div>
			
				<div class="form-group">
					<label class="form-label mt-4 text-left">아이디</label>
					<input type="text" class="form-control" name=id id=id readonly>
					<div class="text-right">
					<input type=button value="아이디 중복체크" class="btn btn-sm btn-danger text-right" id="idCheckBtn">
					</div>
				</div>
				
				<div class="form-group" style="margin-top: -20px">
					<label class="form-label mt-4 text-left">닉네임</label>
					<input type="text" class="form-control" name=nickname id=nickname>
				</div>
				
				<div class="form-group">
					<label class="form-label mt-4 text-left">비밀번호</label>
					<input type="password" class="form-control" name=pwd id=pwd>
				</div>
				
				<div class="form-group">
					<label class="form-label mt-4 text-left">이메일</label>
					<input type=text name=email id=email size=55 class="input-sm form-control" placeholder="name@example.com">
				</div>
				
				<div class="form-group">
					<label class="form-label mt-4 text-left" style="margin-right: 10px;">성별</label>
					<input type=radio name=sex value="남" checked>남자
	  				<input type=radio name=sex value="여">여자
				</div>
				
				<div class="form-group">
					<label class="form-label mt-4 text-left">전화번호</label>
	  				<input type=text name=phone id=phone size=55 class="input-sm form-control" placeholder="-를 포함해서 입력하세요.">
				</div>
				
				<div class="form-group">
					<label class="form-label mt-4 text-left">우편번호</label>
					<input type=text name=post id=post size=10 class="input-sm form-control">
					<div class="text-right">
	  				<input type=button value="우편번호검색" class="btn btn-sm btn-danger" id=postBtn onclick="sample6_execDaumPostcode()">
	  				</div>
				</div>
				
				<div class="form-group" style="margin-top: -20px">
					<label class="form-label mt-4 text-left">주소</label>
					<input type=text name=addr1 id=addr1 size=55 class="input-sm form-control" readonly>
				</div>
				
				<div class="form-group">
					<label class="form-label mt-4 text-left">상세주소</label>
					<input type=text name=addr2 id=addr2 size=55 class="input-sm form-control">
				</div>
				
				<div class="form-group" style="margin-bottom: 30px;">
					<label class="form-label mt-4 text-left">생년월일</label>
					<input type="date" name=birthday id=birthday class="form-control">
				</div>
				
				<div class="d-grip gap-2 text-center">
					<button class="btn btn-danger btn-lg" id="joinBtn">회원가입</button>
					<input type=button class="btn btn-default btn-lg" value="취소" onclick="javascript:history.back()">
				</div>
		</form>
		</div>

		</div>
	</div>

</body>
</html>