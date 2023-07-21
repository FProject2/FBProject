<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Football-Play 아이디/비밀번호 찾기</title>

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400&display=swap" rel="stylesheet">

<link rel="icon" type="image/png" href="../main/favicon.png">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<style type="text/css">
* {
	font-family: 'Noto Sans KR', sans-serif;
}

.nav-pills {
    --bs-nav-pills-border-radius: var(--bs-border-radius);
    --bs-nav-pills-link-active-color: #fff;
    --bs-nav-pills-link-active-bg: #538053;
}

.nav-pills .nav-link.active, .nav-pills .show>.nav-link {
    color: var(--bs-nav-pills-link-active-color);
    background-color: #538053;
}

.nav {
    --bs-nav-link-padding-x: 1rem;
    --bs-nav-link-padding-y: 0.5rem;
    --bs-nav-link-font-weight: ;
    --bs-nav-link-color: #538053;
    --bs-nav-link-hover-color: #538053;
    --bs-nav-link-disabled-color: var(--bs-secondary-color);
    display: flex;
    flex-wrap: wrap;
    padding-left: 0;
    margin-bottom: 0;
    list-style: none;
}

#id, #pwd {
	text-align: center;
	font-size : 14px;
}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
$(function() {
	$('#idBtn').click(function() {
		let email = $('#email').val();
		if(email.trim()=="")
		{
			$('#email').focus();
			return;
		}
		
		$.ajax({
			type : 'post',
			url : '../member/idFind_ok.do',
			data : {"email":email},
			success:function(result){
				let res = result.trim();
				if(res==='NO')
				{
					$('#id').html('<span style="color:#d9534f">존재하지 않는 이메일입니다.</span>')
				}
				else {
					$('#id').html('<span style="color:black">'+res+'</span>')
				}
			}
		})
	})
	
	$('#pwdBtn').click(function() {
		let name = $('#name').val();
		if(name.trim()==="")
		{
			$('#name').focus();
			return;
		}
		
		let email = $('#email2').val();
		if(email.trim()==="")
		{
			$('#email2').focus();
			return;
		}
		
		$.ajax({
			type:'post',
			url:'../member/pwdFind_ok.do',
			data:{"name":name, "email":email},
			success:function(result)
			{
				let res = result.trim();
				if(res==='NO')
				{
					$('#pwd').html('<span style="color:#d9534f">이름이나 이메일이 존재하지 않습니다.</span>')
				}
				else {
					$('#pwd').html('<span style="color:black">'+res+'</span>')
				}
			}
		})
	})
})
</script>

</head>
<body>

<div class="container mt-3">

  <!-- Nav pills -->
  <ul class="nav nav-pills" role="tablist" style="margin: 20px 0px 10px 0px;">
    <li class="nav-item">
      <a class="nav-link active" data-bs-toggle="pill" href="#home">아이디 찾기</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" data-bs-toggle="pill" href="#menu1">비밀번호 찾기</a>
    </li>
  </ul>

  <!-- Tab panes -->
	<div class="tab-content">
		<div id="home" class="container tab-pane active"><br>
			<table class="table">
				<tr>
					<td class="text-center">
						이메일 : <input type=text id="email" class="input-sm">
					</td>
				</tr>
				<tr>
					<td class="text-center">
						<input type=button class="btn btn-sm btn-outline-success" value="검색" id="idBtn">
					</td>
				</tr>
			</table>
			<span id="id"></span>
		</div>
		
		<div id="menu1" class="container tab-pane"><br>
			<table class="table">
				<tr>
					<td class="text-center">
						이름 : <input type=text id="name" class="input-sm">
					</td>
				</tr>
				<tr>
					<td class="text-center">
						이메일 : <input type=text id="email2" class="input-sm">
					</td>
				</tr>
				<tr>
					<td class="text-center">
						<input type=button class="btn btn-sm btn-outline-success" value="검색" id="pwdBtn">
					</td>
				</tr>
			</table>
			<span id="pwd"></span>
		</div>
	</div>
</div>


<!-- <div id="tabs">
	<ul>
		<li><a href="#tabs-1">아이디 찾기</a></li>
		<li><a href="#tabs-2">비밀번호 찾기</a></li>
	</ul>
	
	<div id="tabs-1">
		<table class="table">
			<tr>
				<td class="text-center">
					이메일 : <input type=text id="email" class="input-sm">
				</td>
			</tr>
			<tr>
				<td class="text-center">
					<input type=button class="btn btn-sm btn-default" value="검색" id="idBtn">
				</td>
			</tr>
			<tr>
				<td class="text-center">
					<h4 id="id"></h4>
				</td>
			</tr>
		</table>
	</div>
	
	<div id="tabs-2">
		<table class="table">
			<tr>
				<td class="text-center">
					이름 : <input type=text id="name" class="input-sm">
				</td>
			</tr>
			<tr>
				<td class="text-center">
					이메일 : <input type=text id="email2" class="input-sm">
				</td>
			</tr>
			<tr>
				<td class="text-center">
					<input type=button class="btn btn-sm btn-default" value="검색" id="pwdBtn">
				</td>
			</tr>
			<tr>
				<td class="text-center">
					<h4 id="pwd"></h4>
				</td>
			</tr>
		</table>
	</div>
	
	
</div> -->
</body>
</html>