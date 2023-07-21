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
$(document).ready(function(){
  $("#search").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable tr").filter(function() {
      $(this).toggle($(this).find("td:eq(1)").text().toLowerCase().indexOf(value) > -1)
    });
    
  });
  
  $(".check_ok").change(function(){
	  let ono=$(this).attr("data-ono")
	  let check_ok=$(this).val()
	  
	  location.href="../adminpage/check_ok.do?ono="+ono+"&check_ok="+check_ok
  })

  $('.connect').click(function(){
	  let gno=$(this).attr('data-gno')
	  
	  location.href="../shop/shop_detail.do?gno="+gno
  })
});
</script>
<style type="text/css">

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
		#myTable span:hover{
			cursor: pointer;
			font-weight: bold;
		}
</style>
</head>
<body>
	<div class="container mt-3" style="overflow-y: scroll;;height:800px;width:850px">
	  <h4>주문 관리</h4>
	  <div style="height:30px;"></div>
	  <p>주문 리스트</p><div><input type=search id="search" placeholder="상품명을 입력하세요.." style="width: 200px;"></div>   
	  <table class="table table-hover" style="table-layout: auto;">
	    <thead>
	      <tr>
	        <th></th>
	        <th>상품명</th>
	        <th>주문자</th>
	        <th>개수</th>
	        <th>총 금액</th>
	        <th>주문일</th>
	        <th></th>
	      </tr>
	    </thead>
	    <tbody id=myTable>
	    	<c:forEach var="vo" items="${list }">
	    		<tr class="item">
			        <td width=10%><span class=connect data-gno="${vo.gno }"><img src="${vo.goods_poster }" width=60px height=50px></span></td>
			        <td><span class=connect data-gno="${vo.gno }">${vo.goods_name }</span></td>
			        <td>${vo.member_name }</td>
			        <td>${vo.amount }</td>
			        <td>${vo.tprice }</td>
			        <td>${vo.regdate }</td>
			        <td>
			        	<select class=check_ok data-ono="${vo.ono }">
			        		<option ${vo.check_ok==0?'selected':'' } value="0">대기</option>
			        		<option ${vo.check_ok!=0?'selected':'' } value="1">승인</option>
			        	</select>
			        </td>
			    </tr>
	    	</c:forEach>
	    </tbody>
	  </table>
	</div>
	
</body>
</html>