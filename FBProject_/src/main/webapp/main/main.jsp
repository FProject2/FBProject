<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.hello_slid img{
			border-radius: 30px;
		}
	#reserve .reserve td {
		padding-top : 15px;
	    padding-bottom: 20px;
	}
	#reserve .reserve .time, #reserve .reserve .content, #reserve .reserve .state{
		font-size: 20px;
		vertical-align:middle;
		color: black;
		font-family: 'Noto Sans KR', sans-serif;
	}
	#reserve .content{
		line-height: 17px;
	}
	#reserve .button-align{
		text-align: center;
		font-size: 15px;
		vertical-align:middle;
	}
	#reserve .top-space{
		max-height: 400px;
		overflow: auto;
		margin-top: 10px;
	}
	#reserve .top-space::-webkit-scrollbar {
	    width: 10px;
	}
	#reserve .top-space::-webkit-scrollbar-thumb {
	    background-color: rgb(180, 180, 180);
	    border-radius: 10px;
	}
	#reserve .top-space::-webkit-scrollbar-track {
	    background-color: #F5F5F5;
	}
	#reserve .state .btn-design{
		border-radius:5px;
		font-size: 13px;
		background-color:rgb(64,128,96);
		color:white;
	}
       		
</style>

<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
$(function() {
	$.ajax({
		type:'post',
		url:'../reserve/reserve_list.do',
		data:{"area":"서울"},
		success:function(result){
			$('#top-space').html(result);
		}
	})
	
	$('.area').click(function(){
		let area=$(this).text();
		$('#searchbar').val("")
		$.ajax({
			type:'post',
			url:'../reserve/reserve_list.do',
			data:{"area":area},
			success:function(result){
				$('#top-space').html(result);
			}
		});
	})
	
 	$('#search').click(function(){
		let search=$('#searchbar').val();
		let area=$('#area').val()
		$.ajax({
			type:'post',
			url:'../reserve/reserve_list.do',
			data:{"search":search, "area":area},
			success:function(result) {
				$('#top-space').html(result);
			}
		})
	})
})

</script>

</head>
<body>

<section id="home" class="home bg-black fix">
	<div class="overlay"></div>

	<div class="container" style="margin-top: 10px;">
		<div class="row">
			<div class="main_home text-center col-md-12 hello_slid">
			
				<c:forEach var="i" begin="1" end="3">
				<div class="slid_item">
					<div class="home_text ">
						<img src="../main/assets/images/${i }.jpg" style="width:1920px;height:500px;object-fit: cover;" class="homeslide">
					</div>
				</div>
				</c:forEach>  
			
			</div>
		</div>
	</div>
</section>

            <!--Business Section-->
            <section id="business" class="business bg-grey roomy-70" style="min-height: 600px;">
            <!-- reserve-start -->
	        	<div class="container"  style="text-align: center;" id="reserve">
	                <div class="head_title text-center fix" name="reserveTitle">
	                    <h2 class="text-uppercase">구장 예약</h2>
	                    <h5>지역을 선택하고 구장을 예약하세요</h5>
	                </div>
	                <div class=text-left>
						<li class="dropdown" style="margin-right: 20px;"><span class="btn btn-sm btn-default"
						style="border-radius: 5px;font-size: 13px;background-color: rgb(64,128,96);color: white;">지역 선택</span>
							<ul class="dropdown-content" style="overflow-y: scroll; height: 300px;">
								<li><a class="area">서울</a></li>
								<li><a class="area">경기</a></li>
								<li><a class="area">인천</a></li>
								<li><a class="area">강원</a></li>
								<li><a class="area">대전</a></li>
								<li><a class="area">충남</a></li>
								<li><a class="area">세종</a></li>
								<li><a class="area">충북</a></li>
								<li><a class="area">대구</a></li>
								<li><a class="area">경북</a></li>
								<li><a class="area">부산</a></li>
								<li><a class="area">울산</a></li>
								<li><a class="area">경남</a></li>
								<li><a class="area">광주</a></li>
								<li><a class="area">전남</a></li>
								<li><a class="area">전북</a></li>
								<li><a class="area">제주</a></li>
							</ul>
						</li>
				   		<input type="button" class="btn btn-sm" id="search" value="검색" style="float: right;margin-left: 5px;background-color: rgb(64,128,96);color: white;">
				   		<input type="hidden" id="area">
	        			<input type="search" style="float: right" id="searchbar" >
	        		</div>
	        		<div class="top-space" id=top-space>
							
	        		</div>	
	      		</div>
            </section>

<!--product section-->
<section id="product" class="product">
    <div class="container">
        <div class="main_product roomy-80">
            <div class="head_title text-center fix">
                <h2 class="text-uppercase">이번 주 인기상품</h2>
                <h5>인기 폭발! 이번 주 가장 인기 있는 상품 TOP 12</h5>
            </div>
            <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                <!-- Indicators -->
                <ol class="carousel-indicators">
                    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                </ol>
                <!-- Wrapper for slides -->
                <div class="carousel-inner" role="listbox">
                    <div class="item active">
                        <div class="container">
                            <div class="row">
                           	<c:forEach var="svo" items="${sList }" begin="0" end="3">
                                <div class="col-sm-3">
                                    <div class="port_item xs-m-top-30">
                                        <div class="port_img">
                                        	<a href="../shop/shop_detail.do?gno=${svo.gno }">
                                            <img src="${svo.goods_image }" alt="" width="290" height="250"/>
                                            </a>
                                        </div>
                                        <div class="port_caption m-top-20 text-center">
                                            <h5>${svo.brand }</h5>
                                            <h6>${svo.goods_name }</h6>
                                        </div>
                                    </div>
                                </div>
                               </c:forEach>
                            </div>
                        </div>
                    </div>

                    <div class="item">
                        <div class="container">
                            <div class="row">
                            <c:forEach var="svo" items="${sList }" begin="4" end="7">
                                <div class="col-sm-3">
                                    <div class="port_item xs-m-top-30">
                                        <div class="port_img">
                                        	<a href="../shop/shop_detail.do?gno=${svo.gno }">
                                            <img src="${svo.goods_image }" alt="" width="290" height="250"/>
                                            </a>
                                        </div>
                                        <div class="port_caption m-top-20 text-center">
                                            <h5>${svo.brand }</h5>
                                            <h6>${svo.goods_name }</h6>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach> 
                            </div>
                        </div>
                    </div>

                    <div class="item">
                        <div class="container">
                            <div class="row">
                            <c:forEach var="svo" items="${sList }" begin="8" end="11">
                                <div class="col-sm-3">
                                    <div class="port_item xs-m-top-30">
                                        <div class="port_img">
                                        	<a href="../shop/shop_detail.do?gno=${svo.gno }">
                                            <img src="${svo.goods_image }" alt="" width="290" height="250"/>
                                            </a>
                                        </div>
                                        <div class="port_caption m-top-20 text-center">
                                            <h5>${svo.brand }</h5>
                                            <h6>${svo.goods_name }</h6>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            </div>
                        </div>
                    </div>

                </div>

                <!-- Controls -->
                <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
                    <i class="fa fa-angle-left" aria-hidden="true"></i>
                    <span class="sr-only">Previous</span>
                </a>

                <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                    <i class="fa fa-angle-right" aria-hidden="true"></i>
                    <span class="sr-only">Next</span>
                </a>
            </div>
        </div><!-- End off row -->
    </div><!-- End off container -->
</section><!-- End off Product section -->



            <!--Test section-->
            <section id="test" class="test bg-grey roomy-60 fix">
                <div class="container">
                    <div class="main_product roomy-80">
                        <div class="head_title text-center fix">
                            <h2 class="text-uppercase">지역별 맛집</h2>
                            <h5>현지의 맛을 만나다: 지역별 맛집 추천</h5>
                        </div>

                        <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                            <!-- Indicators -->
                            <ol class="carousel-indicators">
                                <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                                <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                                <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                            </ol>

                            <!-- Wrapper for slides -->
                            <div class="carousel-inner" role="listbox">
                                <div class="item active">
                                    <div class="container">
                                        <div class="row">
                                        	<c:forEach var="vo" begin="1" end="4" items="${flist }">
                                        		<div class="col-sm-3">
	                                                <div class="port_item xs-m-top-30">
	                                                    <div class="port_img">
	                                                        <img src="${vo.poster }" alt="" />
	                                                    </div>
	                                                    <div class="port_caption m-top-20">
	                                                        <h5>${vo.name }</h5>
	                                                        <h6>- ${vo.address }</h6>
	                                                    </div>
	                                                </div>
	                                            </div>
                                        	</c:forEach>
                                            
                                            
                                        </div>
                                    </div>
                                </div>

                                <div class="item">
                                    <div class="container">
                                        <div class="row">
                                        
                                        	<c:forEach var="vo" begin="5" end="8" items="${flist }">
                                        		<div class="col-sm-3">
	                                                <div class="port_item xs-m-top-30">
	                                                    <div class="port_img">
	                                                        <img src="${vo.poster }" alt="" />
	                                                    </div>
	                                                    <div class="port_caption m-top-20">
	                                                        <h5>${vo.name }</h5>
	                                                        <h6>- ${vo.address }</h6>
	                                                    </div>
	                                                </div>
	                                            </div>
                                        	</c:forEach>
                                           
                                        </div>
                                    </div>
                                </div>

                                <div class="item">
                                    <div class="container">
                                        <div class="row">
                                        
                                        	<c:forEach var="vo" begin="9" end="12" items="${flist }">
                                        		<div class="col-sm-3">
	                                                <div class="port_item xs-m-top-30">
	                                                    <div class="port_img">
	                                                        <img src="${vo.poster }" alt="" />
	                                                    </div>
	                                                    <div class="port_caption m-top-20">
	                                                        <h5>${vo.name }</h5>
	                                                        <h6>- ${vo.address }</h6>
	                                                    </div>
	                                                </div>
	                                            </div>
                                        	</c:forEach>
                                            
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <!-- Controls -->
                            <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
                                <i class="fa fa-angle-left" aria-hidden="true"></i>
                                <span class="sr-only">Previous</span>
                            </a>

                            <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                                <i class="fa fa-angle-right" aria-hidden="true"></i>
                                <span class="sr-only">Next</span>
                            </a>
                        </div>
                    </div><!-- End off row -->
                </div><!-- End off container -->
            </section><!-- End off test section -->
</body>
</html>