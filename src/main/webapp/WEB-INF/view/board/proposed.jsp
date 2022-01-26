<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<meta charset="UTF-8">
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
<title>비밀글보기</title>
</head>
<body>
<div style="width: 1170px;height: 50px;margin-top: 20px;margin-left: 465px;">
	<a href="list.do?btype=${board.btype}" class="btn btn-info w3-right" style="margin-left: 10px;">목록</a>
	<a href="info.do?seq=${board.seq+1}" class="btn btn-info w3-right"><i class="icon-chevron-right"></i>다음글</a>
</div>
<div class="container" style="border : 1px solid #ebecef;border-radius: 6px; width: 1170px;height: auto; padding: 29px 29px 0;margin-bottom: 60px;">
	<a href="list.do?btype=2" style="color: #03c75a;text-decoration: none">건의게시판 <i class="fas fa-angle-right"></i></a>
	<h1>${board.subject}</h1>
	<h4 style="text-align: center;font-weight: bolder;">비밀글보기</h4><br><br><br>
	<div style="text-align: center;color: #757575;">
		<p>이 글은 비밀글입니다. <strong style="color : #008bcc">비밀번호를 입력하여 주세요.</strong></p>
		<p>관리자는 확인버튼만 누르시면 됩니다.</p>
	</div><br><br><br>
	<div style="text-align: center;margin-left: 380px;">
	<form:form modelAttribute="board" action="proposed.do" enctype="multipart/form-data" name="p" cssClass="form-inline">
		<input type="hidden" name="seq" value="${board.seq}">
		<p><span class="glyphicon glyphicon-chevron-right"></span>비밀번호</p>
			<input type="password" name="inputpassword" class="form-control" value="" id="inputpassword" style="width: 182px; height: 30px; margin-right: 13px;margin-left: 20px;margin-bottom : 10px; border: 1px solid #d9d9d9;">
			<font color="red"><form:errors path="password" /></font>
	</form:form>
	</div><br><br><br>
	<c:if test="${sessionScope.login.id != 'admin'}">
	<div style="margin-bottom: 30px;text-align: center;">
		<a href="list.do?btype=2" class="btn btn-default" style="width: 100px;height: 40px">목록</a>
		<a href="javascript:document.p.submit()" class="btn btn-info" style="width: 100px;height: 40px;">확인</a>
	</div>
	</c:if>
	<c:if test="${sessionScope.login.id == 'admin'}">
	<div style="margin-bottom: 30px;text-align: center;">
		<a href="list.do?btype=2" class="btn btn-default" style="width: 100px;height: 40px">목록</a>
		<a href="info.do?seq=${board.seq}&btype=2" class="btn btn-info" style="width: 100px;height: 40px;">확인</a>
	</div>
	</c:if>	
</div>
</body>
</html>	