<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<title>회원 목록</title>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>
<body>
<div class = "main">
	<h1 class="page-header">회원 목록</h1>

	<div class="w3-col l3 m6 w3-margin-bottom" style = "width:100%; height:100%;">
		<div class = "w3-right" style = "text-align:center;">
    <form action="userlist.do" method="post" name="searchform">
    	<table style = "text-align:center;">
    		<tr><td>
    			<select class="form-control" name="col">
    				<option value="">전체</option>
    				<option value ="nickname">이름</option>
    				<option value ="id">아이디</option>
    				<option value ="email">이메일</option>
    			</select>
    			</td>
    			<td><input type = "text" class="form-control" id="search" name="value" placeholder="입력해주세요.">
    			<td><input type = "submit" class="form-control" value = "검색"></td>
    		</tr>
    	</table>
    </form>
    </div>
		<div class = "userlist">
		총 ${usercount}명의 회원과 함께 합니다.<br>
		검색 건수:${searchcount}
      	<table class = "table table-striped" style = "text-align:center;">
      		<thead>
      			<tr><td width="15%">이름</td><td width="15%">별명</td><td width = "15%">아이디</td><td width="15%">이메일</td><td>사용자 관리</tr>
      		</thead>
      		<c:forEach var ="user" items="${userlist}">
      			<tr><td>${user.name}</td><td>${user.nickname}</td><td>${user.id}</td><td>${user.email}</td><td>
      			<a href ="userdelete.do?id=${user.id} " onclick="return confirm('회원을 탈퇴시키겠습니까?');" style="text-decoration:none">회원탈퇴</a>&nbsp;&nbsp;
      			 <a href = "userupdata.do?id=${user.id}" style="text-decoration:none">회원정보수정</a></td></tr>
      		</c:forEach>
      	</table>
      	</div>
    </div>





	<!-- 회원수정 Modal창 -->
	<div class="modal fade" id="userEntryModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h3 class="modal-title" id="exampleModalLabel">회원가입</h3>
			</div>
			<div class="modal-body">
				아이디<input type = "text" class="form-control" id = "id" placeholder = "아이디를 입력하세요." style = "width=100px;">
				비밀번호<input type = "password" class="form-control" id = "pass1" placeholder = "비밀번호를 입력하세요.">
				비밀번호 재확인<input type = "password" class="form-control" id = "pass2" placeholder = "비밀번호 재확인">
				이름<input type = "text" class="form-control" id = "name" placeholder = "이름">
				성별&nbsp;&nbsp;<input type = "checkbox" id = "gender">남
				   <input type = "checkbox" id = "woman">여
				<br>
				소속병원<input type = "text" class="form-control" id = "aff" placeholder = "소속병원">
				직책<select class = "form-control" id = "a1">
					<option>의사</option>
					<option>간호사</option>
				  </select>
				이메일<input type = "text" class="form-control" id = "email" placeholder = "ex) aaa@bbb.com">
				연락처<input type = "text" class="form-control" id = "phonenum" placeholder = "ex) 010-0000-0000">
			</div>
			<div class="modal-footer">
				<a class="btn" id="userEntry" href="#">회원가입</a>
				<button class="btn" type="button" data-dismiss="modal">돌아가기</button>
			</div>
		</div>
	</div>
</div>
</div>
</body>
</html>