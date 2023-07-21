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
		margin:0px auto;
		width:450px;
		background-color: #DCDCDC;
		border-radius: 30px;
		padding: 30px;
	}
	
	.container{
		margin-top: 20px;
	}
	
	.form, .resFrm {
		text-align: center;
	}
	
	.form-label {
		font-size: 18px;
	}
	
</style>

<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
	$(function(){
		$('#okBtn').hide();
		$('#checkBtn').click(function(){
			let id=$('#id').val();
			if(id.trim()==""){
				$('#id').focus();
				return;
			}
			
			//데이터를 전송해서 결과값을 가지고 온다
			$.ajax({
				type:'post',
				url:'../member/idcheck_ok.do',
				data:{"id":id},
				success:function(result){ //result(실행결과 읽기) => callback
					//alert("result"+result)
					let count=Number(result.trim());
					if(count==0){
						$('#okBtn').show();
						$('#res').html(
							'<span style="color:#0000CD">'
							+id+'는(은) 사용 가능한 아이디입니다!</span>'
						)
						//$('#id').prop('disabled', true);
					} else {
						$('#okBtn').hide();
						$('#res').html(
							'<span style="color:#d9534f">'
							+id+'는(은) 이미 사용중인 아이디입니다!</span>'
						)
						$('#id').val("")
						$('#id').focus()
					}
				}
			})
		})
		$('#okBtn').click(function(){
			opener.joinFrm.id.value=$('#id').val()
			window.close()
			/* parent.Shadowbox.close(); */
		})
	})
</script>
</head>

<body>
	<div class=container>
		<div class=row>
			
			<label class="form-label mt-4 text-left">아이디 중복 검사</label>
			
			<div class="form inline" style="margin: 10px 0px 20px 0px;">
				
				<input type=text class="input-sm" name=id id=id placeholder="아이디를 입력하세요.">
				<input type=button class="btn btn-sm btn-danger" id=checkBtn value="중복체크">
			</div>
			
			<div class="resFrm">
				<span style="text-align: center" id="res"></span>
				
				<div class="resBtn">
					<input type=button value="사용하기" id="okBtn" class="btn btn-sm btn-danger" style="width: 100px; margin-top: 10px;">
				</div>
			</div>
			
		</div>
	</div>
</body>
</html>