<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.dropdown {
  position: relative;
  display: inline-block;
}

.dropdown-content {
  display: none;
  position: absolute;
  background-color: #f1f1f1;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
}

.dropdown-content a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
}

.dropdown-content a:hover {background-color: #ddd;}

.dropdown:hover .dropdown-content {display: block;}

.dropdown:hover .dropbtn {background-color: #3e8e41;}
</style>
</head>
<body>
<!-- Start Top Search -->
<div id="header">
<nav class="navbar navbar-default bootsnav navbar-fixed">

	<div class="top-search">
		<div class="container">
		    <div class="input-group">
			    <span class="input-group-addon"><i class="fa fa-search"></i></span>
		        <input type="text" class="form-control" placeholder="Search">
		        <span class="input-group-addon close-search"><i class="fa fa-times"></i></span>
	        </div>
	    </div>
	</div>
 
	<!-- End Top Search -->
	<div class="container"> 
		

	<!-- Start Header Navigation -->
	<div class="navbar-header">
		<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-menu">
			<i class="fa fa-bars"></i>
		</button>
		
		<a class="navbar-brand" href="../main/main.do">
			<img src="../main/assets/images/logo.png" class="logo">
		</a>
	</div>
	<!-- End Header Navigation -->


	<!-- navbar menu -->
	<div class="collapse navbar-collapse" id="navbar-menu">
		<ul class="nav navbar-nav navbar-right">
			<a href="../shop/shop.do"><img src="../main/assets/images/shop_icon.png" style="padding-top: 13px"></a>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li><a href="../main/main.do">구장예약</a></li>
			               
			<li class="dropdown"><a href="#features">게시판</a>
				<ul class="dropdown-content">
					<li><a href="../notice/notice_list.do">공지사항</a></li>
					<li><a href="../qna/list.do">문의하기</a></li>
				</ul>
			</li>
			
			<c:if test="${sessionScope.admin=='n' }">
			<li><a href="../mypage/mypage_info.do">마이페이지</a></li>
			</c:if>
			
			<c:if test="${sessionScope.admin=='y' }">
			<li><a href="../adminpage/adminpage_main.do">관리자페이지</a></li>
			</c:if>
			
			<c:if test="${sessionScope.id==null }">
			<li><a href="../member/login.do">로그인</a></li>
			</c:if>
			
			<c:if test="${sessionScope.id!=null }">
			<li><a href="../member/logout.do">로그아웃</a></li>
			</c:if>
			
			<c:if test="${sessionScope.id!=null }">
			<c:if test="${bCheck==true }">
			<li><a href="../cart/cart.do">장바구니</a></li>
			</c:if>
			</c:if>
			
			<!-- 로그인 안했으면 로그인 창으로 -->
			<c:if test="${sessionScope.id==null }">
			<c:if test="${bCheck==true }">
			<li><a href="../member/login.do">장바구니</a></li>
			</c:if>
			</c:if>
			
		</ul>
	</div><!-- /.navbar-collapse -->
	</div>
	
</nav>
<!-- div id top -->
</div>

</body>
</html>