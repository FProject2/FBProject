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
	.row1 {
		margin: 0px auto;
		width: 900px;
	}
	
	.table > th {
		vertical-align: middle;
		text-align: center;
	}
	
	#order {
		padding-left: 740px;
	}
</style>

<script type="text/javascript" src="https://code.jquery.com/jquery.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script type="text/javascript">
$(function() {
	
	$('#buyBtn').click(function() {
		let addr2=$('#addr2').val();
		if(addr2.trim()==""){
			alert("필수 정보를 입력해주세요!");
			$('#addr2').focus();
			return;
		}
		
	requestPay();
	
	})
})

var IMP = window.IMP; // 생략 가능
IMP.init("imp37752386"); // 예: imp00000000
function requestPay() {
	console.log('clicked');
	  // IMP.request_pay(param, callback) 결제창 호출
		IMP.request_pay({
		    pg : 'html5_inicis', // version 1.1.0부터 지원.
		        /*
		            'kakao':카카오페이,
		            'inicis':이니시스, 'html5_inicis':이니시스(웹표준결제),
		            'nice':나이스,
		            'jtnet':jtnet,
		            'uplus':LG유플러스
		        */
		    pay_method : 'card', // 'card' : 신용카드 | 'trans' : 실시간계좌이체 | 'vbank' : 가상계좌 | 'phone' : 휴대폰소액결제
		    merchant_uid : 'merchant_' + new Date().getTime(),
		    name : '주문명:결제테스트',
		    amount : 14000,
		    buyer_email : 'iamport@siot.do',
		    buyer_name : '구매자이름',
		    buyer_tel : '010-1234-5678',
		    buyer_addr : '서울특별시 강남구 삼성동',
		    buyer_postcode : '123-456',
		    app_scheme : 'iamporttest' //in app browser결제에서만 사용 
		}, function(rsp) {
		    if ( rsp.success ) {
		        var msg = '결제가 완료되었습니다.';
		        msg += '고유ID : ' + rsp.imp_uid;
		        msg += '상점 거래ID : ' + rsp.merchant_uid;
		        msg += '결제 금액 : ' + rsp.paid_amount;
		        msg += '카드 승인번호 : ' + rsp.apply_num;
		        location.href = "../cart/orderComplete.do?ono="+$('#ono').attr('data-no');
		    } else {
		        var msg = '결제에 실패하였습니다.';
		        msg += '에러내용 : ' + rsp.error_msg;
		        location.href = "../cart/orderComplete.do?ono="+$('#ono').attr('data-no');
		        
		    }
		});
}
</script>
</head>
<body>

<div style="height: 100px;"></div>

<div class="container">
	<div class="row" id="buy">
		
		<div class="row1" style="margin-top:50px; ;margin-bottom: 100px;">
			<h3 style="margin-bottom: 20px">주문 상품</h3>
			<table class="table">
				<tr class="success">
					<th width=30%></th>
					<th width=40% class="text-center">상품명</th>
					<th width=10% class="text-center">가격</th>
					<th width=10% class="text-center">수량</th>
					<th width=10% class="text-center">Total</th>
				</tr>
				<c:forEach var="vo" items="${list }">
					<tr style="padding: 10px;">
						<td width=30%>
							<img src="${vo.goods_poster }" style="width: 100px; height: 100px;" id="ono" data-no="${vo.ono }">
						</td>
						<td width=40% class="text-center" style="vertical-align: middle;">${vo.goods_name }</td>
						<td width=10% class="text-center" style="vertical-align: middle;">${vo.price }</td>
						<td width=10% class="text-center" style="vertical-align: middle;">${vo.amount }</td>
						<td width=10% class="text-center total" style="vertical-align: middle;">${vo.tprice }</td>
						
					</tr>
				</c:forEach>
			</table>
		</div>
		
		<div class="row1 buyForm" >
			<h3 style="margin-bottom: 20px">주문자 정보</h3>
			<table class="table" style="margin-bottom: 20px;">
				<tr>
					<th width=10% class="success text-center">이름</th>
					<td width=40%>
						<input type="text" class="form-control-sm" name=name id=name value="${sessionScope.name }">
					</td>
					<th width=10% class="success text-center">연락처</th>
					<td width=40%>
						<input type="text" class="form-control-sm" name=phone id=phone placeholder=" -를 포함해서 입력하세요 " value="${sessionScope.phone }">
					</td>
				</tr>
				<tr>
					<th width=10% class="success text-center">우편번호</th>
					<td width=90% colspan="3">
						<input type="text" class="form-control-sm" name=post id=post style="margin-right: 10px;display: inline;" value="${sessionScope.post }">
						<input type="button" class="btn btn-sm btn-default" value="우편번호 검색">
					</td>
				</tr>
				<tr>
					<th width=10% class="success text-center">주소</th>
					<td width=90% colspan="3">
						<input type="text" class="form-control-sm" name=addr1 id=addr1 size=100 value="${sessionScope.addr1 }" readonly>
					</td>
				</tr>
				<tr>
					<th width=10% class="success text-center">상세주소</th>
					<td width=90% colspan="3">
						<input type="text" class="form-control-sm" name=addr2 id=addr2 value="">
					</td>
				</tr>
			</table>
		</div>
		
		<div class="row1" id="order" style="margin-bottom: 80px;">
			<table>
				<tr>
					<td colspan=2>
						<input type=button class="btn btn-lg btn-success" value="결제하기" style="width: 150px;" id="buyBtn">
						<input type=hidden >
					</td>
				</tr>
			</table>
		</div>
		
	</div>
</div>
</body>
</html>