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
	#menu {
		margin: 0px auto;
		background-color: #538053;
		border-radius: 30px;
	}
	
	#navbar {
		text-align: center;
		margin-top: 25px;
		margin-left: 90px;
	}
	
	.nav-item {
		margin-left: 20px;
		margin-right: 20px;
	}
	
	.nav-link {
		font-size : 15px;
		color : white;
	}
	
	.card {
		margin-bottom: 50px;
	}
	
	.card-img-top {
		width:100%;
		align-self: center;
		margin-top: 50px;
	}
	
	.card-title {
		color: #505050;
		font-size: 15px;
		width: 100%;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
		text-align: center;
		margin-top: 20px;
		margin-bottom: 0px;
	}
	
	.card-text {
		color: #505050;
		font-size: 14px;
	}
	
	a {
		color: #505050;
	}
	
</style>
</head>
<body>

<div style="height: 100px;"></div>
 
<div class="container">
	<div class="row" id="list">
		<div class="row" id="menu">
			<nav class="navbar bg-light navbar-light">
				<ul class="navbar-nav justify-content-center" id="navbar">
				
				<!-- scvo → shopCategoryVo -->
				<c:forEach var="scvo" items="${scList }">
					<li class="nav-item">
						<a class="nav-link" href="../shop/shop.do?cno=${scvo.cno }&page=${curpage }">${scvo.category_name }</a>
					</li>
				</c:forEach>
				</ul>
			</nav>
		</div>
		
		<!-- 상품 리스트 -->
		<div class="row" style="margin-top: 30px;">
		<c:forEach var="vo" items="${list }">
			<div class="col-md-3">
				<div class="card" style="display: inline;">
					<a href="../shop/shop_detail.do?gno=${vo.gno }"><img src="${vo.goods_image }" class="card-img-top" alt="Card image cap"></a>
						<div class="card-block text-center">
							<p class="card-title"><a href="../shop/shop_detail.do?gno=${vo.gno }"><b>${vo.goods_name }</b></a></p>
							<hr>
							<p class="card-text">소비자가 : <span style="text-decoration: line-through; color: #505050">${vo.dbcprice }원</span>&nbsp;&nbsp;<b style="color:#EB4646">판매가 : ${vo.dbprice }원</b></p>
						</div>
				</div>
			</div>
		</c:forEach>
		</div>
		
		<div style="height: 50px;"></div>
		
		<div class="row text-center">
			  <ul class="pagination">
			    <li class="page-item"><a class="page-link" href="../shop/shop.do?cno=${cno }&page=${curpage>1?curpage-1:curpage }">이전</a></li>
			    <c:forEach var="i" begin="${startPage }" end="${endPage }">
			    	<li class="page-item ${curpage==i?'active':'' }"><a class="page-link" href="../shop/shop.do?cno=${cno }&page=${i }">${i }</a></li>
			    </c:forEach>
			    <li class="page-item"><a class="page-link" href="../shop/shop.do?cno=${cno }&page=${curpage<totalpage?curpage+1:curpage }">다음</a></li>
			  </ul>
		</div>
		
		<div style="height: 80px;"></div>
		
	</div>
</div>

</body>
</html>