<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>test</title>
</head>
<body>

<div class="form-group">
	<label for="user_id">아이디</label>
		<input type="text" class="form-control" id="id" name="id" placeholder="ID" required>
<div class="check_font" id="id_check"></div>
 <input type="button" name="btn_mail_auth" id="btn_mail_auth" class="btn btn-primary" value="인정번호 발송">
</div>
<script>
// 아이디 유효성 검사(1 = 중복 / 0 != 중복)
	$("#id").blur(function() {
		var member_id = $('#id').val();
		$.ajax({
			url : '${path}/user/idCheck.do?id='+ member_id,
			type : 'get',
			success : function(data) {
				console.log("중복 확인(1:중복, 0:중복X) : "+ data);							
				
				if (data == 1) {
						// 1 : 아이디가 중복되는 문구
						$("#id_check").text("사용중인 아이디입니다");
						$("#id_check").css("color", "red");
					} else {
						$("#id_check").text("사용가능한 아이디입니다");
						$("#id_check").css("color", "red");
					}
				}, error : function() {
						console.log("실패");
				}
			});
		});
		
	$(".btn_mail_auth").click(function(){
		alert("버튼 클릭")
	})
</script>
</body>
</html>