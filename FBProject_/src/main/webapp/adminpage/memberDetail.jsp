<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <style type="text/css">
  	.row{
  		margin:0 auto;
  		width:700px;
  	}
  </style>
  <script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
  <script type="text/javascript">
  	$(function(){
  		$('#cancelBtn').click(function(){
  			window.close()
  		})
  		
  		$('#modifyBtn').click(function(){
  			let formData=$('#frm').serialize();
  			
  			$.ajax({
  				url:"../adminpage/memberDetail_modify.do",
  				type:"post",
  				data:formData,
  				success:function(response){
  					opener.location.reload();
  	  		        window.close();
  				}
  				
  			})
  		})
  		
  		$('#deleteBtn').click(function(){
  			alert('${vo.id}')
  			$.ajax({
  				url:"../adminpage/memberDelete.do",
  				type:"post",
  				data:{"id":'${vo.id}'},
  				success:function(response){
  					opener.location.reload();
  	  		        window.close();
  				}
  			}) 
  		})
  	})
  </script>
</head>
<body>
	<div class="container">
		<div class=row>
			<h2 style="text-align: center;">${vo.name }님의 정보</h2>
			<div style="height:30px;"></div>
			<form method="post" id="frm">
				<table class="table table-bordered">
					<tr>
						<th>아이디</th>
						<td>${vo.id }
						<input type=hidden name=id value="${vo.id }"></td>
						<th>이메일</th>
						<td><input type=text name=email value="${vo.email }"></td>
					</tr>
					<tr>
						<th>이름</th>
						<td><input type=text name=name value="${vo.name }"></td>
						<th>닉네임</th>
						<td><input type=text name=nickname value="${vo.nickname }"></td>
					</tr>
					<tr>
						<th>성별</th>
						<td>
							<select name=sex>
								<option value="남" ${vo.sex=="남"?"selected":"" }>남</option>
								<option value="여" ${vo.sex=="여"?"selected":"" }>여</option>
							</select>
						</td>
						<th>생일</th>
						<td><input type=text name=birthday value="${vo.birthday }"></td>
					</tr>
					<tr>
						<th>휴대폰</th>
						<td><input type=text name=phone value="${vo.phone }"></td>
						<th>가입날짜</th>
						<td>${vo.signdate }
							<input type=hidden name=signdate value="${vo.signdate }">
						</td>
						
					</tr>
					<tr>
						<th>우편번호</th>
						<td><input type=text name=post value="${vo.post }"></td>
						<th>주소</th>
						<td><input type=text name=addr1 value="${vo.addr1 }"></td>
					</tr>
					<tr>
						<th>상세주소</th>
						<td><input type=text name=addr2 value="${vo.addr2 }"></td>
						<th>관리자</th>
						<td><select name=admin>
							<option value=y ${vo.admin=="y"?"selected":"" }>y</option>
							<option value=n ${vo.admin=="n"?"selected":"" }>n</option>
						</select></td>
					</tr>
				</table>
				<div class="text-right">
					<input type="button" id="modifyBtn" value="수정">
					<input type="button" id="deleteBtn" value="탈퇴">
					<input type="button" id="cancelBtn" value="취소">
				</div>
			</form>
		</div>
	</div>
</body>
</html>