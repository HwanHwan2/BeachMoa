<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디찾기 : BeachMoa</title>
</head>
<body>
<div class="container">
<div class="center-block">
<h3>아이디 찾기</h3>
<hr>
<c:forEach var="u" items="${list}">
아이디:${u.id} 가입일자:<fmt:formatDate value="${u.join_date}" pattern="yyyy-MM-dd"/><hr>
</c:forEach>
<a class="btn btn-primary" href="login.do">로그인 하기</a>
</div>
</div>
</body>
</html>