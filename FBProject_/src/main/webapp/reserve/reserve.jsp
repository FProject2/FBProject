<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
function openTabs(detailName) {
  var i;
  var x = document.getElementsByClassName("tabs");
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";  
  }
  document.getElementById(detailName).style.display = "block";  
}
</script>
<script type="text/javascript">

 $(function(){
          
    // 모달 기능
    const modalOpenButton = document.getElementById('modalOpenButton');
    const modalCloseButton = document.getElementById('modalCloseButton');
    const modal = document.getElementById('modalContainer');

    modalOpenButton.addEventListener('click', () => {
      modal.classList.remove('hidden');
    });

    modalCloseButton.addEventListener('click', () => {
      modal.classList.add('hidden');
    });
    
    // 값 전송
      $.ajax({
         type:'post',
         url:'../diary/diary.do',
         data:{"gno":${gno}},
         success:function(result)
         {
            /* alert(${gno}) */
            $('#reserve_day').html(result);
         }
      })
      
      $(function() {
          // 예약하기 버튼 클릭 시 처리
          $("#resBtn").click(function() {
              let gno = ${gno};
              let price = ${gvo.gprice};
              let rday = $('#ground_day').text();
              let time = $('#ground_t').text();
              
                  $.ajax({
                      type: 'post',
                      url: '../reserve/reserve_insert.do',
                      data: {
                          "gno": gno,
                          "price": price,
                          "rday": rday,
                          "time": time
                      },
                      success: function(response) {
                          // 성공 시 완료 창 표시
                          Swal.fire({
                              title: '완료',
                              text: '예약이 완료되었습니다!',
                              icon: 'success'
                          }).then(function() {
                              // 페이지 이동
                              window.location.href = '../main/main.do';
                          });
                      }
                  });
          });
      });
      
   }) 
</script>

<style>

.container11{
/*    background-color: #DCDCDC; */
   padding-top: 130px;
   padding-bottom: 100px;
   margin-left: 100px;
   margin-right:100px;
   height:auto;
}

.mainImg{
  width: 100%;
  height: 100%;
  margin: 0px auto;

}

.content11 {
   .wrapper {
      display: flex;
      justify-content: space-around;
      
      .section-left {
         width: 60%;
      }
      
      .section-right {
         margin: 15px;
         text-align: center;
      }
   
   
      .box {
      
         padding: 20px;
         margin: 20px;
         background-color: white;
         &.mx-0 {
            margin-left: 0;
            margin-right: 0;
         }
      }
   }
}

.section-bottom {
   color:black;
   padding:40px;
   margin: 15px;
   height: auto;
   text-align: left;
   background-color: white;
}

.com {
   width:90%;
   height:auto;
   display: flex;
   margin: 0 auto;
   padding: 16px;
   margin-bottom: 10px;
   border-top: 1px solid black;
   
}

.review {
   width:70%;
   height:auto;
   .title {
      margin-top: 0;
   }
}

#map {
   display: inline-block;
}

#resBtn {
   width:80%;
   height:50px;
   margin:15px;
   color:white;
   background-color: #538053;
   border-radius: 10px;
   font-size: 20px;
   border:none;
}

#revBtn {
   font-size:13px;
   color:black;
   background-color:red;
   border-radius: 10px;
   border:none;
   margin-left: 1000px;
   margin-bottom:20px;
}

#revTitle {
   display: flex;
   justify-content: space-around;
     margin: 0px auto;
}

#score {
   margin-left: 20px;
   
}

.imgBox {
    width: 50px;
    height: 50px; 
    border-radius: 70%;
    overflow: hidden;
}
.profile {
    width: 100%;
    height: 100%;
    object-fit: cover;
}


.w3-black, .w3-hover-black:hover {
    color: #fff!important;
    background-color: #538053;
}

<!-- 모달 -->
#modalOpenButton, #modalCloseButton {
  cursor: pointer;
}

#modalContainer {
  width: 100%;
  height: 100%;
  position: fixed;
  top: 0;
  left: 0;
  display: flex;
  justify-content: center;
  align-items: center;
  background: rgba(0, 0, 0, 0.5);
}

#modalContent {
  position: absolute;
  background-color: #ffffff;
  width: 400px;
  height: auto o;
  padding: 30px;
}

#modalContainer.hidden {
  display: none;
}


</style>

<!-- 지도 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=354e8d1599001215c257e974091bc45c&libraries=services"></script>   

</head>
<body>

<div class="container11">

   <!-- 메인 이미지 -->
   <div class="section-main" style="width:100%; height:500px">
      <img src="${gvo.gimage }" class="mainImg">
   </div>

    <div class="content11">
       <div class="wrapper">
         <!-- left -->
         <div class="section-left">
            <div class="box">
               <div class="row" style="border-bottom: 1px solid grey; padding-bottom: 20px; padding-top: 20px;">
                  <h3><b>${gvo.gname }</b></h3>
                  ${gvo.gaddr }
               </div>
               <div class="row" style="border-bottom: 1px solid grey; padding-bottom: 20px; padding-top: 20px;">
                  <h3>${gvo.gprice }원/ 2시간</h3>
                  매치 시작 10분 전 신청이 마감돼요
               </div>
               <div class="row" style="border-bottom: 1px solid grey; padding-bottom: 20px; padding-top: 20px;">
                  <h3>경기장 정보</h3>
                  <img src="../main/assets/images/주차.png" style="width:30px;">무료 주차
                  <img src="../main/assets/images/남녀모두.png" style="width:30px;">남녀 모두
                  <img src="../main/assets/images/풋살화.png" style="width:30px;">풋살화 대여
                  <img src="../main/assets/images/화장실.png" style="width:30px;">화장실 
               </div>
            </div>
            
            <div class="w3-bar w3-black">
              <button class="w3-bar-item w3-button" onclick="openTabs('tabs_1')">구장 특이사항</button>
              <button class="w3-bar-item w3-button" onclick="openTabs('tabs_2')">매칭 진행 방식</button>
              <button class="w3-bar-item w3-button" onclick="openTabs('tabs_3')">리뷰</button>
            </div>

              <div id="tabs_1" class="tabs">
               <div class="box">
               <div class="row" style="padding-bottom: 20px; padding-top: 20px;">
                  <h3>구장 특이사항</h3>
                  <pre>
${gvo.gnotice }
                  </pre>
               </div>
               </div>                
               </div>
              
               <div id="tabs_2" class="tabs" style="display:none">
                  <div class="box">
                     <div class="row" style="padding-bottom: 20px; padding-top: 20px;">
                        <h3>매치 진행 방식</h3>
                        <pre>
<b>매치 규칙</b>
●모든 파울은 사이드라인에서 킥인
●골키퍼에게 백패스 가능. 손으로는 잡으면 안돼요
●사람을 향한 태클 금지
      
<b>진행 방식</b>
●풋살화와 개인 음료만 준비하세요
●매니저가 경기 진행을 도와드려요
●골키퍼와 휴식을 공평하게 돌아가면서 해요
●레벨 데이터를 기준으로 팀을 나눠요
●친구끼리 와도 팀 실력이 맞지 않으면 다른 팀이 될 수 있어요
      
<b>알아두면 좋아요</b>
●서로 존중하고 격려하며 함께 즐겨요
●플랩 평균 레벨은 아마추어2예요
●플랩에서는 하루 평균 180경기가 진행되고 있어요
●매일 3,000여명이 팀 없이도 풋살을 즐기고 있어요
                        </pre>
                     </div>
                  </div>
               </div>
            
            
            <div id="tabs_3" class="tabs" style="display:none">
             <div class="row"  style="padding-bottom: 20px; padding-top: 20px;">
                <table id="revTitle">
               <tr>
                  <th colspan="2" class="text-center" style="font-size:25px">리뷰</th>
               </tr>
               <tr>
                  <th colspan="2" class="text-center" style="font-size:20px">평균 별점 ${totalReviewAvg }</th>
               </tr>
               <tr>
                  <td style="font-size:18px;color:grey; border-right:1px grey solid;padding-right: 13px">전체 리뷰 수 (${totalReview })</td>
                  <td style="font-size:18px;color:grey;padding-left:15px">
                     <button id="modalOpenButton">리뷰 정책</button>
                     <div id="modalContainer" class="hidden">
                     <div id="modalContent">
                        <p><b style="color:black">리뷰정책이란?</b><br><br>
                        football-play는 고객님에게 신뢰성 높은 양질의 리뷰를 제공하기 위하여
                        예약 결제를 통해 실제로 구장을 이용한 회원만 리뷰를 남길 수 있습니다.</p>
                        <button id="modalCloseButton">닫기</button>
                      </div>
                     </div>
                  </td>   
               </tr>
               </table> 
               <div style="padding-bottom:15px;"></div>   
               <div style="height: 400px; overflow: auto"> 
                  <div id="reviewList">
                      <c:forEach var="vo" items="${grList }" varStatus="s">
                        <div class="com">
                           <table style="undefined;table-layout: fixed; width: 76px">
                           <colgroup>
                              <col style="width: 100px">
                              <col style="width: 150px">
                              <col style="width: 150px">
                           </colgroup>
                           <thead>
                              <tr>
                              <th>${vo.id }</th> 
                              <th>${vo.regdate }</th>
                                 <c:choose>
                                    <c:when test="${vo.score == 1}">
                                       <th>( ${vo.score }<img src="../main/assets/images/star.png" style="width:15px" > / 5.0 )</th>
                                    </c:when>
                                    <c:when test="${vo.score == 2}">
                                       <th>( ${vo.score }<img src="../main/assets/images/star.png" style="width:15px" > / 5.0 )</th>
                                    </c:when>
                                    <c:when test="${vo.score == 3}">
                                       <th>( ${vo.score }<img src="../main/assets/images/star.png" style="width:15px" > / 5.0 )</th>
                                    </c:when>
                                    <c:when test="${vo.score == 4}">
                                       <th>( ${vo.score } <img src="../main/assets/images/star.png" style="width:15px" > / 5.0 )</th>
                                    </c:when>
                                    <c:when test="${vo.score == 5}">
                                       <th>( ${vo.score }<img src="../main/assets/images/star.png" style="width:15px" > / 5.0 )</th>
                                    </c:when>
                                 </c:choose>
                              </tr>
                           </thead>
                           <tbody>
                              <tr>
                              <td>
                                 <div class="imgBox" style="background: white;">
                                     <img class="profile" src="../main/assets/images/축구공.png" style="border:none">
                                 </div>
                              </td>
                              <td><div style="width:800px;height300px" name="content" readonly>${vo.content }</div></td>
                              </tr>
                           </tbody>
                           </table>
                        </div>
                     </c:forEach>       
                  </div>
               </div>
            </div> 
            </div>
            </div>
         
         <div class="section-right">
          <input type="submit" value="예약하기" id="resBtn" disabled/>
            <div id="reserve_diary">
               <table style="display: flex; justify-content: center;">
                  <tr>
                       <td width=350px; height=250px; class="success">
                          <table class="table">
                           <caption><h3 class="text-center"><b>예약일 정보</b></h3></caption>
                             <tr>
                                <td id="reserve_day" style="border:none" ></td>
                            </tr>
                            <tr>
                                <td id="ground_time" style="height:60px"></td>
                           </tr>
                            <tr>
                              <td colspan="2" style="height:60px; vertical-align: middle">
                                 <span style="color:gray;display:none" id="gd">예약일:</span><span id="ground_day"></span>
                              </td>
                            </tr>
                           <tr>
                              <td colspan="2" style="height:60px; vertical-align: middle">
                                    <span style="color:gray;display:none" id="gt">예약시간:</span><span id="ground_t"></span>
                              </td>
                           </tr>
                            </table>
                       </td>
                    </tr>
               </table>
            <div>
            <h3><b>구장 위치</b></h3>
               <div id="map" style="width:400px;height:300px;"></div>
               <script>
                  var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                  mapOption = {
                  center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                  level: 3 // 지도의 확대 레벨
                  };  
                                    
                  // 지도를 생성합니다    
                  var map = new kakao.maps.Map(mapContainer, mapOption); 
                                    
                  // 주소-좌표 변환 객체를 생성합니다
                  var geocoder = new kakao.maps.services.Geocoder();
                                    
                  // 주소로 좌표를 검색합니다
                  geocoder.addressSearch('${gvo.gaddr}', function(result, status) {
                                    
                  // 정상적으로 검색이 완료됐으면 
                  if (status === kakao.maps.services.Status.OK) {
                                    
                  var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                                    
                  // 결과값으로 받은 위치를 마커로 표시합니다
                  var marker = new kakao.maps.Marker({
                  map: map,
                  position: coords
                  });
                                    
                  // 인포윈도우로 장소에 대한 설명을 표시합니다
                  var infowindow = new kakao.maps.InfoWindow({
                  content: '<div style="width:150px;text-align:center;padding:6px 0;">${gvo.gname}</div>'
                  });
                  infowindow.open(map, marker);
                                    
                  // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                  map.setCenter(coords);
                  } 
                  });    
               </script>
            </div>

            <div class="box mx-0">
            </div>
            </div>
         </div>
      </div>
        <!-- <div class="section-bottom"></div> -->
   </div>
</div>

</body>
</html>