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

<script src='//unpkg.com/jquery@3/dist/jquery.min.js'></script>
<script src='//unpkg.com/popper.js@1/dist/umd/popper.min.js'></script>
<script src='//unpkg.com/bootstrap@4/dist/js/bootstrap.min.js'></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.js"></script>
<head>
<style>
.container {
  width: 600px;
  height: auto; 
  margin-left: auto;
  margin-right: auto; 
  margin-bottom : auto;
  text-align: center;
  
  /*
  	border:1px solid black;
  */
}


input.form-control{
	width: 500px;
	height:51px;
	margin-bottom:8px;
    margin-right: auto; 
    align:left;
	
}
div.form-group{
	text-align:left;
}
img.banner{
	width:1500px;
	height:250px;
	
}

</style>
</head>
<body>

<!-- !PAGE CONTENT! -->
<div class="w3-content" style="max-width:1500px">

  <header class="w3-right w3-container w3-large w3-padding-24">
  	  <!-- 로그인, 비로그인 -->
    <c:choose>
       <c:when test="${login eq null}">
          <a href="${path}/user/login.do" class="w3-button w3-white"style="text-decoration:none">로그인</a>
          <a href="${path}/user/entry.do" class="w3-button w3-white" style="text-decoration:none">회원 가입</a>
       </c:when>
       <c:otherwise>
          <c:if test="${login.nickname eq '관리자' }">
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
    <a href="../beach/list.do" class="w3-button w3-white w3-right" style="margin-right: 25px;font-weight: bold;text-decoration:none">해수욕장 정보</a>
  </header>
  <div class="center-block">
  <img class="banner" alt="beachmoa와 함께" src="${path}/img/beachbanner.png"></div>
  
</div>
<div class="w3-main" style="margin-top:50px; height:auto;">

    <decorator:body/>
</div>
</body>
</html>