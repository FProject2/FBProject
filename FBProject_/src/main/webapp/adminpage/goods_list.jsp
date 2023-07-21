<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script>
/* $(document).ready(function(){
  $("#search").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable tr").filter(function() {
      $(this).toggle($(this).find("td:eq(1)").text().toLowerCase().indexOf(value) > -1)
    });
  });
}); */
$(function(){
	$('#searchBtn').click(function(){
		$('#sFrm').submit();
	})
	
	$('#myTable tr').click(function(){
		let x=(document.body.offsetWidth/2)-(750/2)
		let y=(window.screen.height/2)-(500/2)-50
		let gno=$(this).attr('data-gno')
		window.open("../adminpage/goodsDetail.do?gno="+gno,"",'width=750, height=500, left='+x+', top='+y+',scrollbar=yes')
	})
	$('#insertGoodsBtn').click(function(){
		let x=(document.body.offsetWidth/2)-(400/2)
		let y=(window.screen.height/2)-(550/2)-50
		
		window.open("../adminpage/goodsInsert.do","",'width=400, height=550, left='+x+', top='+y+',scrollbar=yes')
	})
})
</script>
<!-- <style type="text/css">

		.container::-webkit-scrollbar {
		    width: 10px;
		}
		.container::-webkit-scrollbar-thumb {
		    background-color: rgb(180, 180, 180);
		    border-radius: 10px;
		}
		.container::-webkit-scrollbar-track {
		    background-color: white;
		}
</style> -->
</head>

<body>
	<div class="container mt-3" style="/* overflow-y: scroll; */height:830px;width:850px">
	  <h4>물품 관리</h4>
	  <div style="height:30px;"></div>
	  <p>물품 리스트</p>
	  <form method="post" action="../adminpage/goods_list.do" id="sFrm">
		  <div style="margin-bottom: 10px;">
		  	<input type=search name=search id="search" placeholder="상품명을 입력하세요.." value="${search }">
		  	<input type=button id="searchBtn" value="검색">
		  	<!-- <input type=button value="상품등록" id="insertGoodsBtn" style="float: right;"> -->
		  </div>
	  </form>
	  <table class="table table-hover" style="table-layout: auto;">
	    <thead>
	      <tr>
	        <th></th>
	        <th>상품명</th>
	        <th>브랜드</th>
	        <th>원산지</th>
	        <th>판매가</th>
	      </tr>
	    </thead>
	    <tbody id=myTable>
	      <c:forEach var="vo" items="${list }">
	      	<tr data-gno=${vo.gno }>
	      		<td width=10%><img src="${vo.goods_image }"></td>
	        	<td>${vo.goods_name }</td>
	        	<td>${vo.brand }</td>
	        	<td>${vo.origin }</td>
	        	<td>${vo.price }</td>
	        </tr>
	      </c:forEach>
	    </tbody>
	  </table>
	</div>
	<div style="text-align: center;width:100%;" class="pagination1">
		<c:if test="${startpage!=1 }">
	  		<a href="../adminpage/goods_list.do?page=${startpage-1 }&search=${search}">&lt;</a>&nbsp;
	  	</c:if>
	  	<c:forEach var="i" begin="${startpage }" end="${endpage }">
	  		<a href="../adminpage/goods_list.do?page=${i }&search=${search}" style="${curpage==i?'font-weight:bold;color:green':'' }">${i }</a>&nbsp;
	  	</c:forEach>
	  	<c:if test="${endpage!=totalpage }">
	  		<a href="../adminpage/goods_list.do?page=${endpage+1 }&search=${search}">&gt;</a>&nbsp;
	  	</c:if>
	</div>
	
</body>
</html>