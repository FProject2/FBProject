<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">

$(function() {

    $('.rSelectBtn').on('click', function(e) {
       e.stopPropagation();
       var id = "${id}"; 
       if (id === null || id === "") {
           // id가 null이거나 비어있는 경우 로그인 페이지로 이동
           alert("로그인이 필요합니다.")
           location.href = "../member/login.do";
       } else {
           // id가 있는 경우 예약 페이지로 이동
           var gno = $(this).closest('.ground_select').attr('data-gno');
           location.href = "../reserve/reserve.do?gno=" + gno;
       } 
   });   
    
    $('#area').val('${area}')
    
});

</script>
</head>
<body>
<!-- 구장리스트 출력 reserve_list -->
<div>
	<c:forEach var="vo" items="${list }" varStatus="s">
		<div class="ground_select" data-gname="${vo.gname }"  data-gno="${vo.gno }" data-gaddr="${vo.gaddr }">
			<div class="card border-left-success shadow h-100 reserve">
				<div class="card-body">
					<div class="col-md-1 time">
					${vo.gno }
					</div>
					<div class="col-md-9 content text-left">
						<a id="gname">${vo.gname }</a><br>
						<sub style="color: gray;font-size: 0.6em">●${vo.gaddr }</sub>
					</div>	
					<div class="col-md-1 button-align state">
						<input type="button" class="btn btn-sm btn-design rSelectBtn" value="예약가능">
					</div>	
				</div>
			</div>
			<div style="height:3px;"></div> 
		</div>
	</c:forEach> 
</div>
<div style="height:3px;"></div>
</body>
</html>