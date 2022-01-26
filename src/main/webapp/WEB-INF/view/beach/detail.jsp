<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet" type="text/css">
<title>해수욕장 상세 정보</title>
<style>
/* Fake image */
.fakeimg {
  background-color: #aaa;
  width: 100%;
  padding: 20px;
}

/* Add a card effect for articles */
.card {
   background-color: white;
   padding: 0px 200px;
   margin-top: 20px;
   margin-left: 20%;
   width: 1000px;
   position : absolute;
}
.image_upload_list {
    float: left;
    width: 403px;
    min-height: 33px;
    border: 1px solid #e5e5e5;
    font-family: inherit;
    font-size: 14px;
    color: #535353;
    line-height: 33px;
    text-indent: 10px;
    margin-right: 13px;
}


/*
.rating svg:nth-child(-n+3){
	color : #F05522;
}
*/
/* Clear floats after the columns */
</style>
</head>
<body>
<div class="w3-content " style="max-width:1500px">
<div class="w3-container w3-cell" style = "height:200px; width:600px; text-align: center;">
  <h2 style="font-weight: bold">${beach.beachNm}</h2>
  <p><span style="color:rgb(214, 240, 255)">
  <c:choose>
    <c:when test="${beach.avgrating < 5.0 && beach.avgrating >=4.1}"> <!--  5.0점에서 4.1 사이는 전부 4개 반 -->
        <span style="color:rgb(214, 240, 255)"><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="fas fa-star-half-alt fa-2x"></i></span>
    </c:when>
    <c:when test="${beach.avgrating == 4.0}"> <!--  4.0이면 별 4개에 빈별 1개 -->
        <span style="color:rgb(214, 240, 255)"><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="far fa-star fa-2x"></i></span>
    </c:when>
     <c:when test="${beach.avgrating < 4.0 && beach.avgrating >=3.1}"> <!-- 3.9점에서 3.1점사이는 전부 3개 반 -->
        <span style="color:rgb(214, 240, 255)"><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="fas fa-star-half-alt fa-2x"></i><i class="far fa-star fa-2x"></i></span>
    </c:when>
    <c:when test="${beach.avgrating == 3.0}"> <!--  3.0이면 별 3개에 빈별 2개 -->
        <span style="color:rgb(214, 240, 255)"><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i></span>
    </c:when>
         <c:when test="${beach.avgrating < 3.0 && beach.avgrating >=2.1}"><!-- 2.9점에서 2.1점 사이는 2개풀  1개 반 2개 빈별 -->
        <span style="color:rgb(214, 240, 255)"><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="fas fa-star-half-alt fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i></span>
    </c:when>
    <c:when test="${beach.avgrating == 3.0}"> <!--  2.0이면 별 2개에 빈별 3개 -->
        <span style="color:rgb(214, 240, 255)"><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i></span>
    </c:when>
         <c:when test="${beach.avgrating < 2.0 && beach.avgrating >=1.1}"> <!--  1.9 부터 1.1 까지의 별 1개 반별 3개 빈별 -->
        <span style="color:rgb(214, 240, 255)"><i class="fas fa-star fa-2x"></i><i class="fas fa-star-half-alt fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i></span>
    </c:when>
     <c:when test="${beach.avgrating == 3.0}"> <!--  1.0이면 별 1개에 빈별 4개 -->
        <span style="color:rgb(214, 240, 255)"><i class="fas fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i></span>
    </c:when>
         <c:when test="${beach.avgrating < 1.0 && beach.avgrating >=0.1}">
        <span style="color:rgb(214, 240, 255)"><i class="fas fa-star-half-alt fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i></span>
    </c:when>
     <c:when test="${beach.avgrating == 3.0}"> <!--  0.0이면  빈별 5개 -->
        <span style="color:rgb(214, 240, 255)"><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i></span>
    </c:when>
    <c:otherwise>
       <span style="color:rgb(214, 240, 255)"><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i></span>
    </c:otherwise>
</c:choose>
  </span></p>
  <br>
  <p style="font-weight: bold">${beach.intro}</p>
  <p><font style="font-weight: bold">이용 시간 :</font>${beach.swtime}</p>
  <p><font style="font-weight: bold">주차장 여부 :</font>${beach.parking}</p>
  <p><font style="font-weight: bold">샤워장 구비 :</font> ${beach.shower}&emsp;&emsp;&emsp;<font style="font-weight: bold">온수 :</font>${beach.hotwater}</p>
  <p><font style="font-weight: bold">탈의실 여부:</font>${beach.fitting}&emsp;&emsp;&emsp;<font style="font-weight: bold">화장실 여부:</font>${beach.toilet}</p>
  <p><font style="font-weight: bold">식수대 여부 :</font>${beach.watersup}&emsp;&emsp;&emsp;<font style="font-weight: bold">마트 :</font>${beach.mart}</p>
  <p><font style="font-weight: bold">파라솔 여부 :</font>${beach.parasol}&emsp;&emsp;&emsp;<font style="font-weight: bold">야영장 :</font>${beach.camp}</p>
</div>
<div class="w3-container  w3-cell"  style = "height:200px; width:600px; text-align: center">
<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel" style="width:100%;">
  <ol class="carousel-indicators">
    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
    <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
  </ol>
  <div class="carousel-inner" style="height:400px; width:800px;">
  <c:forEach items="${beachimglist}" var="beachimg">
	<c:if test="${beach.beachno == beachimg.beachno}">
    <div class="carousel-item active">
    </div></c:if>
	</c:forEach>
	 <c:forEach items="${reviewList}" var="reviewimg">
    <div class="carousel-item">
      <img class="d-block w-100" src="../img/beachimg/${beach.beachno}/${reviewimg.fileurl}"/>
    </div>
	</c:forEach>
  </div>
  <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>
</div>

<br>
<div class="row" style="display:inline-block; margin-left: 12%;">
  <div>
    <div class="card">
      <div class="main" style="width: 1300px; height: 800px; display:inline-block; text-align: center">
  		<div class = "container2">
			<div id="map"  style="width:100%; height:800px;"></div>
		</div>
		<!-- 지도 표시하는 부분 설정 -->
		<script type="text/javascript"
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e89a0e1e85cdc23f683d592725eb29ed&libraries=services"></script>
		<script>
			//지도 설정 script
			//=============================================지도 생성==========================================================
			var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
			var options = { //지도를 생성할 때 필요한 기본 옵션
				center : new kakao.maps.LatLng(37.566745, 126.978837), //지도의 중심좌표.
				level : 5 //지도의 레벨(확대, 축소 정도)
			};
			var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

			var zoomControl = new kakao.maps.ZoomControl(); //지도 확대축소
			map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);//지도 확대축소
			
			//=========================================해수욕장 좌표를 이용하여 마커로 표현하기==========================================
			// 마커를 표시할 위치와 title 객체 배열입니다 
			var positions = [
						{
							title : "${beachinfo.beachNm}",
							latlng : new kakao.maps.LatLng(${beachinfo.corX}, ${beachinfo.corY}),
							content : '<div class = "overlaybox" style = "width:auto;height:140px;">' + 
							   		  '	<div class = "title">' + 
							   		  '		<b>${beachinfo.beachNm}</b>' +
							  		  '		<div class = "close" onclick = "close()" title="닫기"></div>'	 + 
							   		  '	</div>' +
							   		  '	<div class = "intro"><${beachinfo.intro}></div>' +
							   		  ' <div class = "address">${beachinfo.address}</div>' +
							   		  ' <div class = "tel">${beachinfo.tel}</div>' +
							   		  '</div>'
						}
			];
			var locPosition = positions[0].latlng; //해수욕장의 좌표값을 저장
			console.log(locPosition);
			var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; // 마커 이미지의 이미지 주소입니다
			
			for (var i = 0; i < positions.length; i ++) { // 마커를 생성합니다
				var imageSize = new kakao.maps.Size(10, 21); //마커 사이즈 설정
				var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);  // 마커 이미지를 생성합니다  
			    var marker = new kakao.maps.Marker({
			        map: map, // 마커를 표시할 지도
			        position: positions[i].latlng // 마커의 위치
			    });
			    var infowindow = new kakao.maps.InfoWindow({ // 마커에 표시할 인포윈도우를 생성합니다
			        content: positions[i].content // 인포윈도우에 표시할 내용
			    });
			    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
			    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
			    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
			    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
			    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
			    displayMarker(locPosition,positions[0].title);
			}
			
			map.setCenter(locPosition); // 지도 중심좌표를 접속위치로 변경합니다 
			
			function makeOverListener(map, marker, infowindow) { //마우스를 올렸을 때 장소 나타내기
			    return function() {
			        infowindow.open(map, marker);
			    };
			}
			function makeOutListener(infowindow) { //마우스를 내렸을 때 장소 안나타내기
			    return function() {
			        infowindow.close();
			    };
			}
			function close() {
			    overlay.setMap(null);     
			}
			
			
			//==========================================해수욕장 정보를 가져와서 마커로 표현하고 지도 중심 좌표 설정하기======================================
			var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; // 내 위치 마커 이미지.
			var imageSize = new kakao.maps.Size(29, 42); //마커 사이즈 설정
			var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);  // 마커 이미지를 생성합니다  
			function displayMarker(locPosition, message) { 
				map.setCenter(locPosition); // 지도 중심좌표를 접속위치로 변경합니다 
				console.log(locPosition);
			}
			
			
		</script>
	</div>
    </div>
    <!-- Large modal -->


<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
  <!--  리뷰 작성 FORM --> 
    <form:form modelAttribute="review" action="../review/reviewwrite.do" enctype="multipart/form-data">
    <div class="modal-content">
     <div class="modal-header">
     <input type="hidden" name="id" value="${sessionScope.login.id}">
     <input type="hidden" name="rating" id ="rating">
     <input type="hidden" name="nickname" value ="${sessionScope.login.nickname}">
     <input type="hidden" name="beachno" value="${beach.beachno}">
       <h4 class="modal-title">${beach.beachNm}</h4>
 <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
  </div>
 <table class="w3-table w3-bordered" style="text-align: center; width:750px;">
    <tr>
      <th style="width: 100px; vertical-align: middle;">평가</th>
      <td><div class="make_star">
	<div class="rating">
		<i class="fas fa-star fa-3x" style="color: #ccc;"></i>
		<i class="fas fa-star fa-3x" style="color: #ccc;"></i>
		<i class="fas fa-star fa-3x" style="color: #ccc;"></i>
		<i class="fas fa-star fa-3x" style="color: #ccc;"></i>
		<i class="fas fa-star fa-3x" style="color: #ccc;"></i>	
	</div>
</div>
</td>
    </tr>
    <tr>
      <th>장소 이름</th>
      <td style="text-align: center;">${beach.beachNm}</td>
    </tr>
    <tr>
      <th>리뷰 제목</th>
      <td style="text-align: center;"><input type="text" name="subject" id="subject" value="" placeholder="제목을 입력해주세요" style="width:640px;"></td>
    </tr>
    <tr>
      <th style="vertical-align: middle;">리뷰 내용</th>
      <td> 
     <form:textarea  path="content" style="width:640px; height:200px;"/>
   <font color="red"><form:errors path="content" /></font></td>
  <!--  --> 
    </tr>
    <tr>
      <th style="vertical-align: middle;">여행 사진</th>
      <td>
      <div class="form-group" id="file1dsad">
        <div style="color: rgb(80, 188, 223); font-size: 14px;">
                                *가장 잘나온 사진 한장만 업로드 하세요 <br>
                                *업로드한 사진은 BeachMoa 사이트에도 함께 업로드됩니다.
                            </div>
        <div class="file-group">
            <input type="file" name="file1" multiple="multiple"/>
        </div>
        
    </div>
    </tr>
  </table>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        <button type="submit" class="btn btn-primary">리뷰 등록</button>
      </div>
    </div>
     <script type="text/javascript">
     $(function(){
    	 var rating = $('.review .rating');
    	$('.make_star svg').click(function(){
    		var targetNum = $(this).index() + 1;
    		$('.make_star svg').css({color:'#ccc'});
    		$('.make_star svg:nth-child(-n+' + targetNum + ')').css({color:'#FFD400'});
    		$('#rating').val(targetNum);
    		return targetNum.value;
    	})
    	
    });
    </script>
	</form:form>
  </div>
</div> <%--모달창의 끝  --%>


      <h2><font style="font-weight: bold;">여행가의 리뷰</font><font style="color: orange;">(${listcount})</font>
      <c:if test="${login.id != null}">
      <font style="float: right;"><button type="button" class="btn btn-primary" data-toggle="modal" data-target=".bs-example-modal-lg">리뷰 쓰기</button></font></c:if></h2>
	<div style="top: 50%; left: 50%; margin-left: 15%; display: inline-block;">
    <table class="w3-table w3-bordered">
  <tr><td>
      <form action="detail.do" method="post" name="searchform">
         <input type="hidden" name="pageNum" value="1">
         <input type="hidden" name="beachno" value="${beach.beachno}">
      </form></td></tr>
 <c:if test="${listcount > 0}"> <%--등록된 게시물이 있음 --%>
             <c:forEach items="${reviewList}" var="review">
             <c:set var="reviewno" value="${reviewno - 1}" />
      <%-- 리뷰 나오는곳 --%>
       <div class="card" style="width : 1000px;">
       <div><h5 style="font-weight: bold;">${review.nickname} <font style="color: gray;">님이 리뷰를 작성했습니다. &nbsp;&nbsp;&nbsp;<fmt:formatDate value="${review.regdate}" pattern="yyyy년 MM월"/></font>
       </h5></div>
       <div><c:choose>
    <c:when test="${review.rating == 4.0}"> <!--  4.0이면 별 4개에 빈별 1개 -->
        <span style="color:rgb(214, 240, 255)"><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="far fa-star fa-2x"></i></span>
    </c:when>
    <c:when test="${review.rating == 3.0}"> <!--  3.0이면 별 3개에 빈별 2개 -->
        <span style="color:rgb(214, 240, 255)"><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i></span>
    </c:when>
    <c:when test="${review.rating == 2.0}"> <!--  2.0이면 별 2개에 빈별 3개 -->
        <span style="color:rgb(214, 240, 255)"><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i></span>
    </c:when>
     <c:when test="${review.rating == 1.0}"> <!--  1.0이면 별 1개에 빈별 4개 -->
        <span style="color:rgb(214, 240, 255)"><i class="fas fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i></span>
    </c:when>
         <c:when test="${review.rating == 0.0}">
        <span style="color:rgb(214, 240, 255)"><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i></span>
    </c:when>
    <c:otherwise>
       <span style="color:rgb(214, 240, 255)"><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i></span>
    </c:otherwise>
</c:choose></div>
      <h4 style="font-weight: bold;'">${review.subject}</h4>
      <p>${review.content}</p>
      <p>  </p>
      <div class="fakeimg" style="height:200px;">
      <div class="w3-container  w3-cell" >
       <img class="d-block w-100" src="../img/beachimg/${beach.beachno}/${review.fileurl}" style="max-width: 200px; max-height: 180px;">
      </div>
      </div>
      <div><h6>작성날짜 : <fmt:formatDate value="${review.regdate}" pattern="yyyy-MM-dd"/></h6></div>
      <c:if test = "${login.id != null and login.id != review.id}">
      <div>
      <form  name="recform" id="recform" method="post">
      <input type="hidden" name="r_seq" value="${review.r_seq}"/>
       	<input type="hidden" name="id" value="${login.id}"/> 
       	<input type="hidden" name="beachno" value="${beach.beachno}"/>
      <span id="btnRecommend" style="cursor:pointer;">
       	<i class="far fa-thumbs-up fa-1x"></i>&nbsp;<font style="color: gray; font-weight: bold;">도움이 됨${review.recomcnt}</font></span>
       	</form></div></c:if>
       	<div>
       	<c:if test = "${login.id == 'admin' or login.id == review.id}">
       	 <form  name="delete" id="delete" method="post">
      <input type="hidden" name="r_seq" value="${review.r_seq}"/>
       	<input type="hidden" name="id" value="${login.id}"/> 
       	<input type="hidden" name="beachno" value="${beach.beachno}"/>
      <span id="btnRecommend2" style="cursor:pointer;">
       	<font style="color: gray; font-weight: bold;">삭제하기</font></span>
       	<span data-toggle="modal" data-target="#myModal" style="cursor:pointer;">
       	<font style="color: gray; font-weight: bold;">수정하기</font></span>
       	</form></c:if></div>
      </div>
</c:forEach>
<tr><td>
<div class="w3-center">
<div class="w3-bar w3-border w3-round" style="text-align: center;">
     <c:if test="${pageNum > 1}">
       <a class="w3-bar-item w3-button w3" href="javascript:listpage('${pageNum - 1}')">이전</a></c:if>
       <c:if test="${pageNum <= 1}"><a class="w3-bar-item w3-button w3">이전</a></c:if>
     <c:forEach var="a" begin="${startpage }" end="${endpage}">
         <c:if test="${a == pageNum}"><a class="w3-bar-item w3-button w3-green">${a}</a></c:if>
         <c:if test="${a != pageNum}">
         <a href="javascript:listpage('${a}')" class="w3-bar-item w3-button">${a}</a></c:if>
     </c:forEach>
     <c:if test="${pageNum < maxpage}">
       <a class="w3-bar-item w3-button w3" href="javascript:listpage('${pageNum + 1}')">다음</a></c:if>
     <c:if test="${pageNum >= maxpage}"><a class="w3-bar-item w3-button w3">다음</a></c:if></div></div>
   </c:if> <%-- 등록된 게시물이 있는 경우 끝 --%>
    <c:if test="${listcount == 0}"> <%-- 등록된 게시물이 없는 경우 --%>
</c:if></table>	
    

</div>
  </div>
</div>
</div>
<script type="text/javascript">
$(function(){
	var rating = $('.review .rating');
	
	$('.make_star svg').click(function(){
		var targetNum = $(this).index() + 1;
		$('.make_star svg').css({color:'#ccc'});
		$('.make_star svg:nth-child(-n+' + targetNum + ')').css({color:'#FFD400'});
		$('#rating').val(targetNum);
		return targetNum.value;
	})
	
});
$("#btnRecommend").click(function(){
    if(confirm("해당 글을 추천하시겠습니까?")){
        $("#recform").attr("action","../recommend/recommendreview.do").submit();
        alert("해당 글을 추천하였습니다.")
        
        }
    });
$("#btnRecommend2").click(function(){
    if(confirm("해당 리뷰를 삭제하시겠습니까?")){
        $("#delete").attr("action","../review/delete.do").submit();
        alert("해당 리뷰를 삭제하였습니다.")
        
        }
    });
    
$('#myModal').on('show.bs.modal', function (e) {
	  
	})
/*

$(document).ready(function() {
    $("a[name='file-delete']").on("click", function(e) {
        e.preventDefault();
        deleteFile($(this));
    });
})

function addFile() {
    var str = "<div class='file-group'><input type='file' name='file'><a href='#this' name='file-delete'>삭제</a></div>";
    $("#file-list").append(str);
			$("a[name='file-delete']").on("click", function(e) {
        e.preventDefault();
        deleteFile($(this));
    });
}

function deleteFile(obj) {
    obj.parent().remove();
}
*/
function listpage(page) {
	document.searchform.pageNum.value=page;
	document.searchform.submit();
} 
</script>
</body>
</html>