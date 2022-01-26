<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<title><decorator:title /></title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="//unpkg.com/bootstrap@4/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.js"></script>
<script src='//unpkg.com/jquery@3/dist/jquery.min.js'></script>
<script src='//unpkg.com/popper.js@1/dist/umd/popper.min.js'></script>
<script src='//unpkg.com/bootstrap@4/dist/js/bootstrap.min.js'></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<link rel='stylesheet' href='//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css'/>
<script src='//code.jquery.com/jquery.min.js'></script>
<script src='//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js'></script>
<head>
<style>
	.dropdown:hover .dropdown-menu {
    	display: block;
    	margin-top: 0;
	}
	.dropdown-header {
		font-size : 25px;
	}
</style>
<decorator:head/>

</head>
<body>

<!-- !PAGE CONTENT! -->
<div class="w3-content" style="max-width:1500px">	
<div style="width: 1500px;" class="w3-white w3-bar">
  <header class="w3-right w3-container w3-large w3-padding-24">
      <!-- 로그인, 비로그인 -->
    <c:choose>
       <c:when test="${login eq null}">
          <a href="${path}/user/login.do" class="w3-button w3-white"style="text-decoration:none">로그인</a>
          <a href="${path}/user/entry.do" class="w3-button w3-white" style="text-decoration:none">회원 가입</a>
       </c:when>
       <c:otherwise>
       <div style="float: left;">
       <div class = "w3-cell">
    			<a href = "${path}/note/notelist.do?id=${login.id}" class = "w3-button w3-white" style = "text-decoration:none">쪽지 <b style = "font-color:red;" id = "NoteCount"></b> 개</a>
       </div> 		
       <div class = "w3-cell">
    		<div class = "w3-cell dropdown">
    			<a href = "#">
    				<img src = "${path}/img/nopush.PNG" style = "width:22px; height:32px;" id = "dropdownMenu1"><span class = "badge" style = "background-color : #6ea6e3;margin-right: 50px;"></span>
    			</a>    				
    			<div class="dropdown-menu pull-left" role="menu" aria-labelledby="dropdownMenu1" id = "alarmCard" style = "width:340px; max-height:300px; position:absolute; padding:5px; overflow:auto;">
    				<div class = "dropdown-header">
    					<h5><b>알림<span class = "badge"></span>개</b></h5>
    				</div>
    				<div class = "dropdown_body">
    					<!-- alarm content -->
    				</div>
  				</div>
    		</div>
    	</div>
    	</div>
    	<div style="float: right">
          <c:if test="${login.logintype eq 'admin' }">
          <a href="${path}/admin/main.do" class="w3-button w3-white" style="text-decoration:none">관리자 모드</a>
          </c:if>
          <a class="w3-button w3-white" href="${path}/user/mypage.do" style="text-decoration:none">마이페이지</a>
          <a class="w3-button w3-white" href="${path}/user/logout.do" style="text-decoration:none">로그아웃</a>
       </div>
       </c:otherwise>
    </c:choose>

	
  </header>
  <!-- Header -->
  <header class="w3-container w3-xlarge w3-padding-24">
    <a href="${path}/user/main.do" class="w3-left w3-button w3-white"><img height="52px" src="${path}/img/beachlogo.png"></a>
    <a href="https://map.kakao.com/" target="_blank" class="w3-button w3-white w3-right" style="font-weight: bold;text-decoration:none">길찾기</a>
    <a href="../board/list.do?btype=2" class="w3-button w3-white w3-right" style="margin-right: 25px;font-weight: bold;text-decoration:none;">건의게시판</a>
    <a href="../board/list.do?btype=1" class="w3-button w3-white w3-right" style="margin-right: 25px;font-weight: bold;text-decoration:none">자유게시판</a>
    <a href="../board/list.do?btype=0" class="w3-button w3-white w3-right" style="margin-right: 25px;font-weight: bold;text-decoration:none">공지사항</a>
        <div class="dropdown">
  		<a href="#" class="w3-button w3-white w3-right" style="margin-right: 25px;font-weight: bold;text-decoration:none" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">해수욕장 정보</a>
 		<ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
    		<li role="presentation" style="width: 200px;text-align: center;"><a href="../beach/list.do" style="font-size: 20px;text-decoration: none;"  role="menuitem" tabindex="1">해수욕장 리스트</a></li>
    		<li role="presentation" style="width: 200px;text-align: center;	"><a href="../beach/recomendlist.do" style="font-size: 20px;text-decoration: none;"  role="menuitem" tabindex="2">추천 해수욕장</a></li>
  		</ul>
	</div>
  </header>
  <div class="center-block">
  <img class="banner" alt="beachmoa와 함께" src="${path}/img/beachbanner.png" style="width:100%"></div>
</div>
</div>
<div class="w3-main" style="margin-top:50px; height:auto;">
    <decorator:body/>
</div>
<footer style="height: 200px;background-color: #D6F0FF;"></footer>
<!-- 알람 갯수 -->
<script>

	//알림 갯수
	$.ajax({
		type : "get",
		url : "${path}/alarm/AlarmCnt.do?id=${login.id}",
		success : function(data) {
			if(data != null) {
				$(".badge").text(data);
			}
			else {
				$(".badge").text("0");
			}
		}
	})
	//알림 상세보기
	

	var arr = new Array();
	$.ajax({
		type : "POST",
		data : JSON.stringify(arr),
		dataType : 'json',
		url : "${path}/alarm/AlarmDetail.do?id=${login.id}",
		success : function(data) {
			if(data != null) {
				var values = JSON.stringify(data); //사용자의 알림들을 가져와 values에 저장.
				$.each(JSON.parse(values), function(index, value) {
				   let html = "<div class = 'alarm"+value.a_no+"' onmouseover=onmouseover1("+value.a_no+") onmouseout=onmouseout1("+value.a_no+") style = 'height:50px;'>";
				   	   html += "<a href = " + value.a_href + " class = 'alarmhref" + value.a_no + "'style = 'padding 8px; float:left;'>";
					   html += "	<li class = 'alarm-item' style = 'margin:2px 2px 2px 2px'>";
					   html += "		<div class = 'title'>";
					   html += "			<b>" + value.a_sent_id + value.a_title + "</b>";
					   html += "		</div>";
					   html += "		<div class = 'content'>";
					   if(value.a_content.length > 15){
						   let str = value.a_content.substr(0,14) +"....";
					   html += 				 str;
					   } else {
					   html += 				 value.a_content;
					   }
					   html += "		</div>";
					   html += "		<a href ='javascript:AlarmDelete(" + value.a_no + ")' class = 'alarmDeleteBtn" 
					   					+ value.a_no + "' id = 'alarmMouse" + value.a_no + "' style = 'float:right; visibility:hidden;'>X</a>";
					   html += "	</li>";
					   html += "</a>";
					   html += "</div>";
					$(".dropdown_body").append(html);
				})
			} else {
				$(".dropdown_body").append("알림이 없습니다.");
			}
		},
		error : function(data) {
			console.log("에러남 : " + data);
		}
	})
	
	//쪽지 갯수
	$.ajax({
		type : "GET",
		url : "${path}/note/NoteCount.do?id=${login.id}",
		success : function(data) {
			if(data != null){
				$("#NoteCount").text(data);
			} else {
				$("#NoteCount").text("0");
			}
		}
	})
	
	

	<!-- 알람 삭제 -->
	function AlarmDelete(a_no){
		$.ajax({
			type : "POST",
			url : "${path}/alarm/AlarmDelete.do?a_no=" + a_no,
			success : function(data){
				if(data == 1){
					$(".alarmhref"+a_no).remove();
				} else if(data == 0) {
					alert("알람 삭제 실패");
				}
			}
		})
	}
</script>

<script>
function onmouseover1(a_no){
	$("#alarmMouse"+a_no).css("visibility","visible");
}
function onmouseout1(a_no){
	$("#alarmMouse"+a_no).css("visibility","hidden");
}
</script>

 <!-- 로그인 되어 있는 경우에만 웹소켓 접근하기 -->
<c:if test = "${login ne null }">
	<script>
		$(document).ready(function(){
			connect();
		})
		function connect(){
			ws = new WebSocket("ws://localhost:8080/BeachMoa/EchoHandler.do");
			ws.onopen = function(){
				console.log("${login.id} 접속 완료");
			}
			ws.onclose = function(){
				console.log("${login.id} 끊김.");
			}
			ws.onerror = function(event) {
				console.log(event);
			}
			ws.onmessage = function(event) {
				//알림이 왔을 때 알림 갯수 갱신하기.
				$.ajax({
					type : "get",
					url : "${path}/alarm/AlarmCnt.do?id=${login.id}",
					success : function(data) {
						if(data != null) {
							$(".badge").text(data);
						}
						else {
							$(".badge").text("0");
						}
					}
				})
				//토스트창 설정 후 보이기
				toastr.options = {
						"escapeHtml" : true,
						"closeButton" : true, // 닫기X버튼 활성화 여부
						"newestOnTop" : true, //새로운 토스트창이 나올 곳. 해보면 알듯
						"closeDuration" : 5000, //사라지는 시간. 밀리초
						"progressBar" : true, //모래시계처럼
				}
				let strs = event.data;
				let arr = strs.split(",");
				toastr.info(arr[1],arr[0],{timeOut : 5000});
			}
		}
	</script>
</c:if>

<script>

</script>
</body>
</html>