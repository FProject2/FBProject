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
  	table tr td input{
  		width: 100%
  	}
  </style>
  <script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
  <script type="text/javascript">
  	$(function(){
  		$('#cancelBtn').click(function(){
  			window.close()
  		})
  		$('#deleteBtn').click(function(){
  			$.ajax({
  				url:"../adminpage/groundDelete.do",
  				type:'post',
  				data:{"gno":${vo.gno}},
  				success:function(result){
  					alert("삭제 되었습니다")
  					opener.location.reload();
  	  		        window.close();
  				}
  			})
  		})
  		
  		$('#modifyBtn').click(function(){
  			let formData=$('#frm').serialize();
  			
  			$.ajax({
  				url:"../adminpage/groundModify.do",
  				type:"post",
  				data:formData,
  				success:function(response){
  					alert("수정 되었습니다")
  					opener.location.reload();
  	  		        window.close();
  				}
  				
  			})
  		});
  	})
  </script>
 
</head>
<body>
	<div class="container">
		<div class=row>
			<h2 style="text-align: center;">${vo.gname } 정보</h2>
			<div style="height:30px;"></div>
			<form method="post" id="frm">
				<input type=hidden name=gno value="${vo.gno }">
				<table class="table table-bordered">
					<tr>
						<th colspan=2 rowspan=3 width=40%><img src="${vo.gimage }" style="width:300px;height: 200px;"></th>
						
						<th width=20%>구장명</th>
						<td width=40%><input type=text name=gname value="${vo.gname }"></td>
					</tr>
					<tr>
						<th>주소</th>
						<td><input type=text name=gaddr value="${vo.gaddr }"></td>
					</tr>
					<tr>
						<th>가격</th>
						<td><input type=text name=gprice value="${vo.gprice }"></td>
					</tr>
					<tr>
						<th colspan=4 style="text-align: center">설명</th>
					</tr>
					<tr>
						<td colspan=4><textarea style="width: 100%" rows=6 name=gnotice>${vo.gnotice }</textarea></td>
					</tr>
					
				</table>
				<div class="text-right">
					<input type="button" id="modifyBtn" value="수정">
					<input type="button" id="deleteBtn" value="삭제">
					<input type="button" id="cancelBtn" value="취소">
				</div>
			</form>
		</div>
	</div>
</body>
</html>