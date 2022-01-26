<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"> <!-- w3 css -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel='stylesheet' href='//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.min.css'>

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.bundle.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script> <!-- 부트스트랩 -->

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<title><decorator:title/></title>
<decorator:head/>
</head>
<body>
<header class="navbar navbar-expand bd-navbar" style = " font-size:20px; height:100px; background-color:#007BFF;margin-bottom:0px">
<a href="${path}/user/main.do" class="w3-left w3-button w3-white"><img height="52px" src="${path}/img/beachlogo.png"></a>
  <a href="main.do" style = "color:white; font-size:30px; margin:auto;text-decoration:none"><b>관리자 페이지</b></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarNav">
    <!-- 헤더 옆에 추가로 띄울거면 여기에 작성 -->
  </div>
</header>
<div class="container-fluid">
  <div class="row flex-nowrap">
    <div class="bd-sidebar" style = "width:12%; height:1000px; background-color:#D3C6A6; text-align:center;">
      <br><br><br><br><br>
      <c:if test="${login ne null}">
      <a href = "${path}/user/logout.do" class = "w3-baritem w3-button" style = "font-size:20px;text-decoration:none">로그아웃</a> <!-- 글자색상 변경해야함. 하얀색 너무 별로 -->
      </c:if>
      <br><br><br><br><br>
      <h2 class = "w3-center" style = "text-align:center; font-size:35px;"><b>회원관리</b></h2>
      <h4 class = "w3-center" style = "text-align:center;">
         <a href = "userlist.do" class = "w3-baritem w3-button" style = "font-size:20px;text-decoration:none">회원목록</a>
      </h4>
      <br><br><br><br>
        <h2 class = "w3-center" style = "text-align:center; font-size:35px;"><b>게시판 관리</b></h2>
        <h4 class = "w3-center" style = "text-align:center;">
           <a href = "board.do?btype=0" class = "w3-baritem w3-button" style = "font-size:20px;text-decoration:none">공지사항 관리</a>
           <a href = "board.do?btype=1" class = "w3-baritem w3-button" style = "font-size:20px;text-decoration:none">자유게시판 관리</a>
           <a href = "board.do?btype=2" class = "w3-baritem w3-button" style = "font-size:20px;text-decoration:none">건의게시판 관리</a>
           <a href = "report.do" class = "w3-baritem w3-button" style = "font-size:20px;text-decoration:none">신고 누적 게시글</a>
        </h4>
    </div>
    <main class="col-10 py-md-3 pl-md-5 bd-content" role="main" style = "font-size:25px; padding-left: 10rem!important;">
      <decorator:body/>
    </main>
  </div>
</div>
</body>
</html>