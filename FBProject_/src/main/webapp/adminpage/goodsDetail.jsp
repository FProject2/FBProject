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
  		width:700px;
  	}
  	table tr td input{
  		width: 100%
  	}
  	.addBtn, .delBtn{
  		border: 1px solid black;
  		border-radius: 15px;
  	}
  </style>
  <script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
  <script type="text/javascript">
  	$(function(){
  		let count
  		$('#cancelBtn').click(function(){
  			window.close()
  		})
  		$('#deleteBtn').click(function(){
  			$.ajax({
  				url:"../adminpage/goodsDelete.do",
  				type:'post',
  				data:{"gno":${vo.gno}},
  				success:function(result){
  					alert("삭제 되었습니다")
  					opener.location.reload();
  	  		        window.close();
  				}
  			})
  		})
  		
  		$(document).on('click', '#modifyBtn', function(){
  			$('#stockWrap tr').each(function(index){
				$(this).find("input:eq(0)").attr('name', 'size'+(index+1))
				$(this).find("input:eq(1)").attr('name', 'stock'+(index+1))
			})
			count=$('#stockWrap tr').length
  			let formData=$('#frm').serialize()
  			$.ajax({
  				url:"../adminpage/goodsDetail_modify.do?count="+count,
  				type:"post",
  				data:formData,
  				success:function(response){
  					alert("수정 되었습니다")
  					opener.location.reload();
  	  		        window.close();
  				}
  			})
  		});
  		
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
		
		
  	})
  </script>
 
</head>
<body>
	<div class="container">
		<div class=row>
			<h2 style="text-align: center;">${vo.goods_name } 정보</h2>
			<div style="height:30px;"></div>
			<form method="post" id="frm">
				<input type=hidden name=gno value="${vo.gno }">
				<table class="table table-bordered">
					<tr>
						<th colspan=2 rowspan=5 width=40%><img src="${vo.goods_image }" style="width: 300px;height: 280px;"></th>
						
						<th width=20%>상품명</th>
						<td width=40%><input type=text name=name value="${vo.goods_name }"></td>
					</tr>
					<tr>
						<th>브랜드</th>
						<td><input type=text name=brand value="${vo.brand }"></td>
					</tr>
					<tr>
						<th>원산지</th>
						<td><input type=text name=origin value="${vo.origin }"></td>
					</tr>
					<tr>
						<th>소비자가</th>
						<td><input type=text name=cprice value="${vo.cprice }"></td>
					</tr>
					<tr>
						<th>판매가</th>
						<td><input type=text name=price value="${vo.price }"></td>
					</tr>
				</table>
				<table class="table table-bordered" style="width: 300px; margin:0 auto">
					<tr>
						<th class=text-center width=45%>사이즈</th>
						<th class=text-center width=45%>재고</th>
						<td class=text-center width=10%>
							<input type=button value="+" class="addBtn" id="addBtn">
						</td>
					</tr>
					<tbody id="stockWrap">
						<c:forEach var="svo" items="${slist }">
							<tr>
								<td class=text-center width=45%>
									<input type=text name=size value=${svo.gsize }>
								</td>
								<td class=text-center width=45%>
									<input type=text name=stock value=${svo.stock }>
								</td>
								<td class=text-center width=10%>
									<input type=button value="-" class="delBtn">
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

				<div class="text-right" style="margin-top:20px;margin-bottom: 20px;">
					<input type="button" id="modifyBtn" value="수정">
					<input type="button" id="deleteBtn" value="삭제">
					<input type="button" id="cancelBtn" value="취소">
				</div>
			</form>
		</div>
	</div>
</body>
</html>