<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://kit.fontawesome.com/5ab18e86d3.js" crossorigin="anonymous"></script>
<title>Insert title here</title>
<script type="text/javascript">
$(document).ready(function(){
    let weatherIcon = {
        '01' : 'fas fa-sun fa-3x',
        '02' : 'fas fa-cloud-sun fa-3x',
        '03' : 'fas fa-cloud fa-3x',
        '04' : 'fas fa-cloud-meatball fa-3x',
        '09' : 'fas fa-cloud-sun-rain fa-3x',
        '10' : 'fas fa-cloud-showers-heavy fa-3x',
        '11' : 'fas fa-poo-storm fa-3x',
        '13' : 'far fa-snowflake fa-3x',
        '50' : 'fas fa-smog fa-3x'
    };
 	loc = ['Seoul','Chuncheon','Gangneung-si', 'Busan','Gwangju','Mokpo','Yeosu','Jeju-do'];
 	lockr = ['서울', '춘천','강릉', '부산', '광주', '목포', '여수', '제주도']
 	for(var i=0; i<loc.length; i++){
    $.ajax({
        url: 'http://api.openweathermap.org/data/2.5/weather?q='+loc[i]+'&lang=Kr&appid=741f69cfc6904b15542779af6cdcb7e1&units=metric',
        dataType: 'json',
        async:false,
        type: 'GET',
        success: function(data){
            var $Icon = (data.weather[0].icon).substr(0,2);
            var $Temp = Math.floor(data.main.temp) + 'º';
            var $city = lockr[i];
            var $description = data.weather[0].description;
            var $feels = data.main.feels_like;
            var $hum = data.main.humidity;
            var $min = data.main.temp_min;
            var $max = data.main.temp_max;
            var $wind = data.wind.speed;
             $('.CurrIcon'+i).append('<i class="' + weatherIcon[$Icon] + '"></i>');
             $('.CurrTemp'+i).prepend($Temp);
             $('.City'+i).append($city);
        }
    });
 	}
})
</script>

<style>
.vl {
  border-left: 2px solid gray;
  height: 353px;
  position: absolute;
  left: 50%;
  margin-left: -3px;
  margin-top : 880px;
  top: 0;
}	
body {font-family: "Raleway", Arial, sans-serif}
.w3-row img {margin-bottom: -8px}
* {box-sizing: border-box;}
body {font-family: Verdana, sans-serif;}
.mySlides {display: none;}	
.mySlides1 {display: none;}
img {vertical-align: middle;}

</style>
</head>
<body>
<div class="container" style="height:auto;">	
<!-- 슬라이드 이미지 -->
<table>
<tr>
	<td>
		<p style="font-weight: bold;font-size: 20px;">이런 해수욕장은 어떤가요?</p>
		<p style="font-weight: bold;color: gray;">※사진 클릭 시 해당 해수욕장 리뷰로 이동합니다.</p>
	</td>
	<td style="font-weight: bold;font-size: 20px;">
		오늘의 날씨
	</td>	
</tr>
<tr>
	<td>
		<a href="../beach/detail.do?beachno=1">
  			<img src="/../../../BeachMoa/img/해변12.jpg" style="width:70%">
  		</a>
	</td>
<!-- 날씨 -->
		<c:forEach var="i" begin="0" end="3">
			<td style="width: 110px;">
			<div class = 'weather${i}'>
				<div class = 'CurrIcon${i}'></div>
				<div class = 'City${i}' style="font-size: 20px;font-weight: bold"></div>
    			<div class = 'CurrTemp${i}' style="font-size: 20px;font-weight: bold"></div>
			</div>
			</td>
		</c:forEach>
</tr>
</table>
</div>
<div class="container">
<!-- 왼쪽 게시글 -->
<hr style="border-color: gray;">	
<table class="table table-hover" style="width: 40%;float: left;height:auto;">
      <tr style="height: 49px; background-color: #F8FBFF">
	  	<td  style="font-weight: bold;font-size: 20px;">공지사항</td>
	  	<td style="text-align: right;"><a href="../board/list.do?btype=0">+더보기</a></td>
	  </tr>	
		<c:forEach var="board" items="${boardlist2}">
		<c:set var="boardno" value="${boardno-1}"/>
			<tr>
				<td><a href="${path}/board/info.do?seq=${board.seq}&btype=0" style="color: #333333;float: left">${board.subject}&nbsp;&nbsp;</a></td>
				<td>${board.nickname}</td>
			</tr>
		</c:forEach>
</table>
<div class="vl" style="float: left"></div>
<!-- 오른쪽 게시글 -->
<table class="table table-hover" style="width: 40%;float: right;">
      <tr style="height: 49px; background-color: #F8FBFF">
	  	<td style="font-weight: bold;font-size: 20px;">자유게시판</td>
	  	<td style="text-align: right;"><a href="../board/list.do?btype=1">+더보기</a></td>
	  </tr>	 
		<c:forEach var="board" items="${boardlist3}">
		<c:set var="boardno" value="${boardno-1}"/>
			<tr>
				<td><a href="${path}/board/info.do?seq=${board.seq}&btype=0" style="color: #333333;float: left">${board.subject}&nbsp;&nbsp;</a></td>
				<td>${board.nickname}</td>
			</tr>
		</c:forEach>
</table>
</div>
<div style="margin-bottom: 300px;"></div>
<br><br><br><br><br>		

</body>
</html>