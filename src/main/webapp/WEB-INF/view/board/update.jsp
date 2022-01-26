<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<script type="text/javascript" src="http://cdn.ckeditor.com/4.5.7/standard/ckeditor.js"></script>	
<meta charset="UTF-8">
<title>BeachMoa : 게시글 수정</title>
<style type="text/css">
	#cke_content{
		margin-left: 25px;
	}
</style>
</head>
<body>
<form:form modelAttribute="board" action="update.do"  enctype="multipart/form-data" name="f">
<form:hidden path="seq" />
<input type="hidden" value="null" name="id">
<div>
<div style="float: left; margin-left: 80px"><h2>글쓰기</h2></div><br>
<div style="float: right;margin-right: 110px">
	<a href="info.do?seq=${board.seq}" class="btn btn-info">취소</a>
	<a href="javascript:document.f.submit()" class="btn btn-info">수정</a>
</div>
</div><br><br>
<hr style="border-color: black;width: 950px;margin-left: 80px">
	<table class="table table-hover" style="width: 950px;margin-left: 80px">
		<tr>
			<td>
				<select class="form-control" name="btype" style="width: 95%; height: 45px; margin-left: 25px">
				<option value="">게시판을 선택해주세요</option>
				<option value="0">공지사항</option>
				<option value="1">자유게시판</option>
				<option value="2">건의게시판</option>
				</select>
				<font color="red"><form:errors path="btype" /></font>
			</td>
		</tr>
		<tr>
			<td>
				<input type="text" name="subject" class="form-control" value="${board.subject}" placeholder="제목을 입력해주세요" style="width: 95%; height: 45px; margin-left: 25px">
				<font color="red"><form:errors path="subject" /></font>
			</td>
		</tr>
		<tr>
			<td>
				<input type="password" name="password" class="form-control" value="" placeholder="비밀번호를 입력해주세요" style="width: 95%; height: 45px; margin-left: 25px">
				<font color="red"><form:errors path="password" /></font>
			</td>
		</tr>
		<tr>
			<td>
				<form:textarea path="content" row="15" cols="80"/>${b.content}
				<script>CKEDITOR.replace("content",{filebrowserImageUploadUrl : "imgupload.do", width:'95%', height : '550px', uiColor : '#FAF4C0'})</script>
				<font color="red"><form:errors path="content" /></font>
			</td>
		</tr>
	</table>
</form:form>
</body>
</html>