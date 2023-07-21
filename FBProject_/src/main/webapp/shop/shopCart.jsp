<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Football-Play 온라인 스토어</title>
<link rel="icon" type="image/png" href="../main/favicon.png">
<style type="text/css">
	.row {
		margin: 0px auto;
	}
	
	.shopping-cart {
		padding: 30px;
	}
	
	form {
		display: inline;
	}
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery.js" ></script>
<script type="text/javascript">

</script>
</head>
<body>

<div style="height: 150px;"></div>
	
<div class="container">
	<div class="row">
		<div class="shopping-cart">
			<h3 style="margin-bottom: 10px;">장바구니</h3>
			<table class="table">
				<tr class="success">
					<th width=20%></th>
					<th width=40% class="text-center">상품명</th>
					<th width=10% class="text-center">가격</th>
					<th width=10% class="text-center">수량</th>
					<th width=10% class="text-center">Total</th>
					<th width=10%></th>
				</tr>
				
				<c:forEach var="vo" items="${list }">
				
				<tr>
					<td width=20% class="text-center">
						<img src="${vo.goods_poster }" style="width: 80px; height: 80px;">
					</td>
					<td width=40% style="vertical-align: middle;">${vo.goods_name }</td>
					<td width=10% class="text-center" style="vertical-align: middle;">${vo.price }</td>
					<td width=10% class="text-center" style="vertical-align: middle;">${vo.amount }</td>
					<td width=10% class="text-center" style="vertical-align: middle;">${vo.tprice }</td>
					<td width=10% class="text-center" style="vertical-align: middle;">
						<form method="post" action="../cart/cartOrder.do">
							<input type=submit class="btn btn-sm btn-default" value="구매" id="buyBtn">
							<input type=hidden name="gno" value="${vo.gno }">
							<input type=hidden name="price" value="${vo.tprice }" id="totalprice">
							<input type=hidden name="amount" value="${vo.amount }" id="amount">
						</form>
						<a href="../cart/cartDelete.do?ono=${vo.ono }" class="btn btn-sm btn-default">삭제</a>
					</td>
				</tr>
				
				</c:forEach>
			</table>
			
		</div>
		
		<div style="height: 80px;"></div>
	</div>
</div>
</body>
</html>