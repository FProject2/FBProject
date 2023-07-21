<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
<style type="text/css">
	table {
	      }
	table tr {
	  	height: 70px;
	}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
	$(function(){
		$('#modifyBtn').click(function(){
			let x=(document.body.offsetWidth/2)-(450/2)
			let y=(window.screen.height/2)-(200/2)-50
			window.open("../mypage/member_info_modify.do?"+$('#frm').serialize(),"" ,'width=450, height=200, left='+x+', top='+y)
		})
		
		$('.postBtn').click(function(){
			sample6_execDaumPostcode()
		})
		
		$('#memberDelBtn').click(function(){
			let x=(document.body.offsetWidth/2)-(450/2)
			let y=(window.screen.height/2)-(200/2)-50
			window.open("../mypage/member_delete.do","" ,'width=450, height=200, left='+x+', top='+y)
		})
	})
</script>
</head>
<body>
	<div class="container mt-3" style="margin-top: 30px;">
		<h4>내 정보</h4>
		<div style="height:50px;"></div>
		
		<div class="container" style="width:800px;margin: 0">
			<form method=post id="frm">
				<table style="width:850px;">
					<tr>
						<th width="10%">이름</th>
						<td width="30%"><input type=text value="${vo.name }" name=name></td>
						<th width="10%">닉네임</th>
						<td width="30%"><input type=text value="${vo.nickname }" name=nickname></td>
						<td></td>
					</tr>
					<tr>
						<th width="10%">이메일</th>
						<td width="30%"><input type=text value="${vo.email }" name=email></td>
						<th width="10%">성별</th>
						<td width="30%"><input type=text value="${vo.sex }" name=sex></td>
						<td></td>
					</tr>
					<tr>
						<th width="10%">생일</th>
						<td width="30%"><input type=text value="${vo.birthday }" name=birthday></td>
						<th width="10%">휴대폰</th>
						<td width="30%"><input type=text value="${vo.phone }" name=phone></td>
						<td></td>
					</tr>
					<tr>
						<th width="10%">주소</th>
						<td colspan=4>
							<input type=text class="postBtn" id="sample6_postcode" placeholder="우편번호" value="${vo.post }" style="width:100px;" name=post readonly>
							<input type=text class="postBtn" id="sample6_address" placeholder="주소" value="${vo.addr1 }" style="width:300px;" name=addr1 readonly>
							<input type=text id="sample6_detailAddress" placeholder="상세주소" value="${vo.addr2 }" style="width:180px;" name=addr2>
						</td>
					</tr>
					<tr>
						<th width="10%">가입날짜</th>
						<td width="30%">${vo.signdate }</td>
					</tr>
				</table>
				<div style="text-align: right;margin-top: 30px;">
					<input type=button value="수정" id="modifyBtn">
					<input type=button value="회원탈퇴" id="memberDelBtn">
				</div>
			</form>
		</div>
	
	</div>	  
	  
</body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }


                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").value = "";
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
</html>