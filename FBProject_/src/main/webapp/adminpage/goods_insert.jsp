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
  		width:300px;
  	}
  	.addBtn, .delBtn{
  		border: 1px solid black;
  		border-radius: 15px;
  	}
  	#stockWrap input{
  		width: 100%;
  	}

  </style>
  <script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
  <script type="text/javascript">
  	$(function(){
  		$('#cancelBtn').click(function(){
  			window.close()
  		})

  		
  		$('#addBtn').click(function(){
  			$('#stockWrap').append("<tr>"
				+"	<td class=text-center width=45%>"
				+"	<input type=text name=size>"
				+"</td>"
				+"<td class=text-center width=45%>"
				+"	<input type=text name=stock>"
				+"</td>"
				+"<td class=text-center width=10%>"
				+"	<input type=button value=- class=delBtn>"
				+"</td>"
				+"</tr>")
  		})
  		
  		$(document).on('click', '.delBtn', function(){
			$(this).parents("tr").remove()
		})
		
		$('#insertBtn').click(function(){
			
		})
		}

  	})
  </script>
 
</head>
<body>
	<div class="container">
		<div class=row>
			<h2 style="text-align: center;">상품 등록</h2>
			<div style="height:30px;"></div>
			<form method="post" id="frm" enctype="multipart/form-data">
				<table class="table table-bordered">
					<tr>
						<th>카테고리</th>
						<td><input type=text></td>
					</tr>
					<tr>
						<th>상품명</th>
						<td><input type=text></td>
					</tr>
					<tr>
						<th>소비자가</th>
						<td><input type=text style="width: 80px;"></td>
					</tr>
					<tr>
						<th>판매가</th>
						<td><input type=text style="width: 80px;"></td>
					</tr>
					<tr>
						<th style="vertical-align: middle;">이미지</th>
						<td style="vertical-align: middle;">
							<input type="file" id=chooseFile name="chooseFile" accept="image/*" onchange="loadFile(this)" style="display: none;">
							<img src="img/default.png" style="width: 80px;height: 80px">
							<label for="chooseFile">
								<img src="img/imgUpload.png" style="width: 35px;height: 35px;">
							</label>
						</td>
					</tr>
					<tr>
						<th>브랜드</th>
						<td><input type=text style="width: 80px;"></td>
					</tr>
					<tr>
						<th>원산지</th>
						<td><input type=text style="width: 80px;"></td>
					</tr>
				</table>
				
				<table class="table table-bordered">
					<tr>
						<th class=text-center width=45%>사이즈</th>
						<th class=text-center width=45%>재고</th>
						<td class=text-center width=10%>
							<input type=button value="+" class="addBtn" id="addBtn">
						</td>
					</tr>
					<tbody id="stockWrap">
						<tr>
							<td class=text-center width=45%>
								<input type=text name=size>
							</td>
							<td class=text-center width=45%>
								<input type=text name=stock>
							</td>
							<td class=text-center width=10%>
								<input type=button value=- class=delBtn>
							</td>
						</tr>
					</tbody>
				</table>

				<div class="text-right" style="margin-top:20px;margin-bottom: 20px;">
					<input type="button" id="insertBtn" value="등록">
					<input type="button" id="cancelBtn" value="취소">
				</div>
			</form>
		</div>
	</div>
</body>
</html>