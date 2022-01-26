<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<style>
	.w3-col l3 m6 w3-margin-bottom {
		width:40%;
		height:40%; 
		background-color:white; 
		border:2px solid; 
		box-shadow: 1px 1px 1px black;
	}
</style>
</head>
<body>
<div class="w3-row-padding">
	<h1 class="page-header">Main Page</h1>
    <div class="w3-col l3 m6 w3-margin-bottom" style = "width:40%; height:40%; background-color:white; border:2px solid; box-shadow: 1px 1px 1px black;">
    	<h1 style = "text-align:center"><b>신고 누적 게시글</b> <b style = "font-size:40px;">${reportcount}</b><b>건</b></h1>
      <table class = "table table-hover" style = "text-align:center;">
      <caption style = "text-align:right;"><a href = "#">+더보기</a></caption>
      	<tr><td width="20%">작성자</td><td width = "60%">제목</td><td width = "25%">게시일자</td></tr>
      	<c:forEach var = "boardlist" items = "${boardlist}">
      		<tr><td>${boardlist.id}</td><td>${boardlist.subject}</td><td>${boardlist.regdate}</td></tr>
      	</c:forEach>
      </table>
    </div>
    <div class="w3-col l3 m6 w3-margin-bottom" style = "width:40%; height:40%; background-color:white; border:2px solid; box-shadow: 1px 1px 1px black;">
    	<h1 style = "text-align:center"><b>신고 누적 게시글</b> <b style = "font-size:40px;">${reportcnt}</b><b>건</b></h1>
      <table class = "table table-hover">
      <caption style = "text-align:right;"><a href = "#">+더보기</a></caption>
      	<tr><td>제목</td><td>게시일자</td><td>작성자</td></tr>
      	<tr><td>제목</td><td>게시일자</td><td>작성자</td></tr>
      </table>
    </div>
</div>
<div class = "w3-row-padding">
    <div class="w3-col l3 m6 w3-margin-bottom" style = "width:40%; height:40%; background-color:white; border:2px solid; box-shadow: 1px 1px 1px black;">
    	<h1 style = "text-align:center"><b>신고 누적 게시글</b> <b style = "font-size:40px;">${reportcnt}</b><b>건</b></h1>
      <table class = "table table-hover">
      <caption style = "text-align:right;"><a href = "#">+더보기</a></caption>
      	<tr><td>제목</td><td>게시일자</td><td>작성자</td></tr>
      	<tr><td>제목</td><td>게시일자</td><td>작성자</td></tr>
      </table>
    </div>
    <div class="w3-col l3 m6 w3-margin-bottom" style = "width:40%; height:40%; background-color:white; border:2px solid; box-shadow: 1px 1px 1px black;">
    	<h1 style = "text-align:center"><b>신고 누적 게시글</b> <b style = "font-size:40px;">${reportcnt}</b><b>건</b></h1>
      <table class = "table table-hover">
      <caption style = "text-align:right;"><a href = "#">+더보기</a></caption>
      	<tr><td>제목</td><td>게시일자</td><td>작성자</td></tr>
      	<tr><td>제목</td><td>게시일자</td><td>작성자</td></tr>
      </table>
    </div>
</div>
</body>
</html>