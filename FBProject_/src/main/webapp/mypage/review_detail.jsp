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
  	})
  </script>
 
</head>
<body>
	<div class="container">
		<div class=row>
			<h2 style="text-align: center;">${vo.gname } 정보</h2>
			<div style="height:30px;"></div>
			<form method="post" id="frm">
				<table class="table table-bordered">
					<tr>
						<th colspan=2 rowspan=4 width=40%><img src="${vo.gimage }" style="width:300px;height: 170px;"></th>
						
						<th width=30% colspan=2>구장명</th>
						<td width=30% colspan=2>${vo.gname }</td>
					</tr>
					<tr>
						<th colspan=2>예약날짜</th>
						<td colspan=2>${vo.rdate }</td>
					</tr>
					<tr>
						<th colspan=2>등록날짜</th>
						<td colspan=2>${vo.dbday }</td>
					</tr>
					<tr>
						<th width=10%>평점</th>
						<td>${vo.score }</td>
						<th width=10%>가격</th>
						<td>${vo.gprice }</td>
					</tr>
					<tr>
						<th colspan=6 style="text-align: center">리뷰 내용</th>
					</tr>
					<tr>
						<td colspan=6>${vo.content }</td>
					</tr>
					
				</table>
				<div class="text-right">
					<input type="button" id="cancelBtn" value="닫기">
				</div>
			</form>
		</div>
	</div>
</body>
</html>