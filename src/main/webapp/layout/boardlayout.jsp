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
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet" type="text/css">
<head>
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
          <c:if test="${login.logintype eq 'admin' }">
          <a href="${path}/admin/main.do" class="w3-button w3-white" style="text-decoration:none">관리자 모드</a>
          </c:if>
          <a class="w3-button w3-white" href="mypage.do" style="text-decoration:none">마이페이지</a>
          <a class="w3-button w3-white" href="logout.do" style="text-decoration:none">로그아웃</a>
       </c:otherwise>
    </c:choose>

	
  </header>
  <!-- Header -->
  <header class="w3-container w3-xlarge w3-padding-24">
    <a href="${path}/user/main.do" class="w3-left w3-button w3-white"><img height="52px" src="${path}/img/beachlogo.png"></a>
    <a href="#about" class="w3-button w3-white w3-right" style="font-weight: bold;text-decoration:none">길찾기</a>
    <a href="../board/list.do?btype=2" class="w3-button w3-white w3-right" style="margin-right: 25px;font-weight: bold;text-decoration:none;">건의게시판</a>
    <a href="../board/list.do?btype=1" class="w3-button w3-white w3-right" style="margin-right: 25px;font-weight: bold;text-decoration:none">자유게시판</a>
    <a href="../board/list.do?btype=0" class="w3-button w3-white w3-right" style="margin-right: 25px;font-weight: bold;text-decoration:none">공지사항</a>
    <a href="#about" class="w3-button w3-white w3-right" style="margin-right: 25px;font-weight: bold;text-decoration:none">해수욕장 정보</a>
  </header>
  </div>
  <div class="center-block">
  <img class="banner" alt="beachmoa와 함께" src="${path}/img/beachbanner.png" style="width:100%"></div>
  
</div>
<div class="w3-main" style="margin-top:50px; height:auto;">
    <decorator:body/>
</div>
<footer style="height: 200px;background-color: #D6F0FF"></footer>
<script>
	$.ajax({
		type : "get",
		url : "${path}/user/AlarmCnt.do?id=${login.id}",
		success : function(data) {
			if(data != null) {
				$(".badge").text(data);
			}
			else {
				$(".badge").text("0");
			}
		}
	})
	$("#alarm").on("click",function(){
		
	})
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
				toastr.options = {
						"escapeHtml" : true,
						"closeButton" : true,
						"newestOnTop" : true,
						"closeDuration" : 5000,
						"progressBar" : true,
				}
				let strs = event.data;
				let arr = strs.split(",");
				toastr.info(arr[1],arr[0],{timeOut : 5000});
			}
		}
	</script>
</c:if>
</body>
</html>