<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style type="text/css">
	#mypage a {
		color: black;
		font-weight: bold;
		font-size: 15px;
	}
	#mypage a:hover{
		color:gray;
	}
	#mypage li:hover{
		color: black;
	}
	#mypage .table td {
		word-break:break-all;
	}
	#mypage .pagination1 a{
		color:green;
		font-size: 20px;
		font-weight:normal;
	}
</style>
</head>
<body>
	<div style="height:100px;"></div>
	<div id=mypage style="margin: 0 auto; width:1150px;height:100vh;">
		<div class="col-md-3" style="background-color: #F5F5F5;border-radius: 10px;height:100vh">
            <div class="widget_item widget_service sm-m-top-50">
                <ul class="m-top-20">
                	<li style="text-align: center;"><h4><b>마이페이지</b></h4></li>
                    <li class="m-top-30">
                    	<a href="../mypage/mypage_info.do">&gt;&nbsp;&nbsp;내 정보
                    </a>
                    <hr style="border:0;height:1px;background-color: gray;"></li>
                    
                    <li><sup style="font-weight: bold;font-size: 0.8rem">구장 정보</sup></li>
                    <li class="m-top-10">
                    	<a href="../mypage/reserve_list.do">&gt;&nbsp;&nbsp;예약 페이지</a><br>
                    </li>
                    <li class="m-top-20">
                    	<a href="../mypage/review_list.do">&gt;&nbsp;&nbsp;리뷰 페이지</a><br>
                    <hr style="border:0;height:1px;background-color: gray;"></li>
                    
                    <li><sup style="font-weight: bold;font-size: 0.8rem">쇼핑몰 정보</sup></li>
                    <li class="m-top-20">
                    	<a href="../mypage/order_list.do">&gt;&nbsp;&nbsp;주문 내역</a><br>
                    <hr style="border:0;height:1px;background-color: gray;"></li>
                    
                    <li><sup style="font-weight: bold;font-size: 0.8rem">게시판 정보</sup></li>
                    <li class="m-top-20">
                    	<a href="../mypage/mypage_boardlist.do">&gt;&nbsp;&nbsp;내 게시물</a><br>
                    <hr style="border:0;height:1px;background-color: gray;"></li>
                </ul>
            </div><!-- End off widget item -->
        </div><!-- End off col-md-3 -->
		<div class="col-md-9">
			<jsp:include page="${mypage_jsp }"></jsp:include>
		</div>
	</div>
</body>
</html>