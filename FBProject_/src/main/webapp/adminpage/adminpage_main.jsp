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
	.table{
		width:850px;
	}
</style>
</head>
<body>
	<div style="height:100px;"></div>
	<div id=mypage style="margin: 0 auto; width:1150px;height:100vh;">
		<div class="col-md-3" style="background-color: #F5F5F5;border-radius: 10px;height:100vh">
            <div class="widget_item widget_service sm-m-top-50">
                <ul class="m-top-20">
                	<li style="text-align: center;"><h4><b>관리자페이지</b></h4></li>
                    <li class="m-top-30"><a href="../adminpage/adminpage_main.do">&gt;&nbsp;&nbsp;회원 관리</a>
                    <hr style="border:0;height:1px;background-color: gray;"></li>
                    
                    <li><sup style="font-weight: bold;font-size: 0.8rem">구장 정보</sup></li>
                    <li class="m-top-10">
                    <a href="../adminpage/ground_list.do">&gt;&nbsp;&nbsp;구장 리스트</a><br>
                    </li>
                    <li class="m-top-20">
                    <a href="../adminpage/reserve_info.do">&gt;&nbsp;&nbsp;예약 현황</a><br>
                    <hr style="border:0;height:1px;background-color: gray;"></li>
                    
                    <li><sup style="font-weight: bold;font-size: 0.8rem">쇼핑몰 정보</sup></li>
                    <li class="m-top-10">
                    <a href="../adminpage/goods_list.do">&gt;&nbsp;&nbsp;물품 관리</a><br>
                    </li>
                    <li class="m-top-20">
                    <a href="../adminpage/order_list.do">&gt;&nbsp;&nbsp;주문 관리</a><br>
                    <hr style="border:0;height:1px;background-color: gray;"></li>
                    
                    <li><sup style="font-weight: bold;font-size: 0.8rem">게시판 정보</sup></li>
                    <li class="m-top-10">
                    <a href="../adminpage/notice_list.do">&gt;&nbsp;&nbsp;공지사항</a><br>
                    </li>
                    <li class="m-top-20">
                    <a href="../adminpage/qnaboard_list.do">&gt;&nbsp;&nbsp;문의하기</a><br>
                    <hr style="border:0;height:1px;background-color: gray;"></li>
                </ul>
            </div><!-- End off widget item -->
        </div><!-- End off col-md-3 -->
		<div class="col-md-9">
			<jsp:include page="${admin_jsp }"></jsp:include>
		</div>
			  
	</div>
</body>
</html>