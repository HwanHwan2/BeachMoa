<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
	<form:form modelAttribute="user" method="post" name="f" action="entry.do"  onsubmit="return AuthChk();">
		<input type="hidden" id="getauth" name="getauth" value="0" >
		<article class="container" style="width:500px; height:1000px">
			<div class="page-header">
				<div class="center-block">
					<h3><font style="font-size:35px;">회</font>원가입</h3>
					<hr>
					<div class="check_font" id="all_check"></div>
				</div>
			</div>
			<spring:hasBindErrors name="user">
				<font color="red"> 
					<c:forEach items="${errors.globalErrors}" var="error">
						<spring:message code="${error.code}" />
					</c:forEach></font>	
			</spring:hasBindErrors>
			<div class="col-xs-6 sm-6" style="width:500px;">
				<div class="center-block">
				<div class="form-group">
					<label class="label_st" for="name">이름</label>
					<form:input path="name" cssClass="form-control" cssStyle="text-align:left"/>
					<font color="red"><form:errors path="name"/></font>
					<div class="check_font" id="name_check"></div>
				</div>
					<div class="form-group">
						<label class="label_st" for="nickname">닉네임</label>
						<form:input path="nickname" cssClass="form-control" cssStyle="text-align:left"/>
							<font color="red"><form:errors path="nickname"/></font>
							<div class="check_font" id="nickname_check"></div>
					</div>
					<div class="form-group">
						<label class="label_st" for="id">아이디</label>
						<form:input id="id" name="id" path="id" cssClass="form-control"/>
							<font color="red"><form:errors path="id"/></font>
							<div class="check_font" id="id_check"></div>
					</div>
					<div class="form-group">
						<label class="label_st" for="inputPassword">비밀번호</label>
						<form:password path="password" cssClass="form-control"/>
						<font color="red"><form:errors path="password"/></font>
						<div class="check_font" id="pass_check"></div>
					</div>
					<div class="form-group">
						<label class="label_st" for="inputPasswordCheck">비밀번호 재확인</label>
						<form:password path="password2" cssClass="form-control"/>
							<font color="red"><form:errors path="password2"/></font>
							<div class="check_font" id="pass2_check"></div>
							
					</div>
					<div class="form-group">
						<label class="label_st" for="email">이메일</label>
						<div class="form-inline" style="width:500px;">
						<input class="form-control" style="width:350px;"type="email" id="email" name="email" > 							
						 <input class="form-control" type="button" style="height:51px; background-color:#007BFF;color:white;font-weight:bold;" id="btn_mail_auth" value="인증번호 받기">
						 </div>
						 <font color="red"><form:errors path="email"/></font>
						 <div class="check_font" id="email_check"></div>
						 <input type="text" id="auth_num" name="auth_num" class="form-control" readonly placeholder="인증번호 입력란" />
						 <div class="check_font" id="auth_check"></div><!-- 인증번호 틀리면 텍스트 추가 -->
						 <input type="hidden" id="authdata" name="authdata" value="">
					</div>
					
					<div class="form-inline" style="width: 500px;">

						<span style="width: 240px; display: inline-block;"> <label class="label_st"
							for="inputgender">성별</label> 
							<form:select path="gender" cssClass="w3-select">
								<form:option value="">선택하세요</form:option>
								<form:option value="남자">남</form:option>
								<form:option value="여자">여</form:option>
							</form:select>
							<font color="red"><form:errors path="gender"/></font>
						</span> 
						<span style="width: 240px; display: inline-block; margin-left: 20px;">
							<label class="label_st" for="inputbirthyear">출생년도</label> <form:select
								path="birthyear" cssClass="w3-select">
								<option value="">선택하세요</option>
								<jsp:useBean id="today" class="java.util.Date" />
								<fmt:formatDate var="now" value="${today}" pattern="yyyy" />
								<c:forEach var="i" begin="0" end="100" step="1">
									<form:option value="${now-i}">${now-i}년</form:option>
								</c:forEach>
							</form:select>
							<font color="red"><form:errors path="birthyear"/></font>
						</span>

					</div>

					<div class="center-block" style="width: 500px;">
						<button type="submit"  id="join-submit" class="btn btn-primary" style="width:500px;height:52px;margin-top:50px; ">
							<font size="4">회원가입<i class="fa fa-check spaceLeft"></i></font>
						</button>
					</div>
				</div>
			</div>

		</article>
	</form:form>
<!-- Jquery, ajax부분 -->
<script type="text/javascript">
function AuthChk(){
	const name = f.name.value;
	const nickname = f.nickname.value;
	const id = f.id.value;
	const password = f.password.value;
	const password2 = f.password2.value;
	const gender = f.gender.value;
	const birthyear = f.birthyear.value;
	const email = f.email.value;
	
	if(name == "" || nickname == "" || id == "" || password == "" || 
			password2 == "" || gender == "" || birthyear == "" || email == ""){	
		$("#all_check").text("미입력 정보가 있습니다.")
		return false;
		
	}
	if(f.getauth.value=="0"){
		$("#auth_check").text("인증번호를 받아 인증번호를 입력해주세요.");
		return false;
	}
	if(f.auth_num.value == ""){
		f.auth_num.focus();
		$("#auth_check").text("인증번호를 확인해주세요");
		return false;
	}
	setTimeout(function(){
		f.submit();
	},1000);
}
//이름
$("#name").blur(function(){
	var nameReg = /^[가-힣]{2,10}$/
	var name = $('#name').val();
	console.log(name);
	if(name==""){
		$("#name_check").text("필수 입력정보입니다.")
	//정규식이 틀릴경우
	}else if(!nameReg.test(name)){
		console.log(nameReg.test(name))
		$("#name").val("")
		$("#name_check").text("이름에 대한 정보만 입력해주세요.")
	}else{
		$("#name_check").text("")
	}
})
//닉네임
$("#nickname").blur(function(){
	var nickReg = /^[가-힣a-zA-Z0-9]{2,8}$/
	var nickname = $('#nickname').val();
	// ajax 중복 들어갈 부분.
	$.ajax({
		url : '${path}/user/nickCheck.do?nickname='+nickname,
		type : 'get',
		success : function(data){
			console.log(data);
			if(data==1){
				$("#nickname_check").text("중복되는 닉네임입니다.");
				$('#nickname').val("");
			}else{
				if(nickname==""){
					$("#nickname_check").text("필수 입력정보입니다.")
				//정규식이 틀릴경우
				}else if(!nickReg.test(nickname)){
					console.log(nickReg.test(nickname))
					$("#nickname_check").text("초성을 제외한 한,영,숫자 2자에서 8자만 가능합니다.")
					$('#nickname').val("");
				}else{
					$("#nickname_check").text("")
					}
				}
			},error : function(){
					console.log("실패")
			}
	});
});

// 아이디 유효성 검증(1 = 중복 / 0 != 중복)
	$("#id").blur(function() {
		var idReg = /^[a-z0-9][a-z0-9_\-]{3,11}$/;
		var id = $('#id').val();
		$.ajax({
			url : '${path}/user/idCheck.do?id='+id,
			type : 'get',
			success : function(data) {
				console.log("중복 확인(1:중복, 0:중복X) : "+ data);							
				
				if (data == 1) {
						// 1 : 아이디가 중복되는 경우
						$('#id').val("");
						$("#id_check").text("사용중인 아이디입니다");
						
					} else {
						// 0 : 아이디가 중복되지 않는 경우
						if(idReg.test(id)){
							console.log(idReg.test(id))
							$("#id_check").text("")
						}else if(id == ""){
							$("#id_check").text("필수 입력정보입니다.");
						}else{
							$('#id').val("");
							$("#id_check").text("4~12자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.");
						}
					}
				}, error : function() {
						console.log("실패");
				}
			});
		});
//비밀번호 유효성 검증.
	$("#password").blur(function(){
		//비밀번호 유효성 나중에 추가하기
		//var passReg = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]).{8,16}$/;
		var pass = $('#password').val();
		console.log(pass);
		if(pass==""){
			$("#pass_check").text("필수 입력정보입니다.")
			}
		else if(pass.length < 8){
			$("#password").val("")
			$("#pass_check").text("비밀번호는 8자에서 12자만 가능합니다.")
		}else{
			$("#pass_check").text("")
		}
	})
	
//재확인 비밀번호 유효성 검증
	$("#password2").blur(function(){
		//비밀번호 유효성 나중에 추가하기
		//var passReg = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]).{8,16}$/;
		var pass = $('#password2').val();
		var password = $('#password').val();
		if(password ==""){
			$("#password").focus();
			$("#pass_check").text("비밀번호 입력후 재확인 비밀번호를 입력해주세요.")
			$("#password2").val("")
			}
		else if(pass==""){
			$("#pass2_check").text("재확인 비밀번호를 입력해주세요.")
			}
		else if(pass.length < 8){
			$("#password2").val("")
			$("#pass2_check").text("비밀번호는 8자에서 12자만 가능합니다.")
		}else if($("#password").val() != $("#password2").val()){
			$("#password2").val("")
			$("#pass2_check").text("입력하신 비밀번호와 재확인 비밀번호가 일치하지 않습니다.")
		}
		else{
			$("#pass2_check").text("")
		}
	})

//이메일 인증
//	$(document).ready(function() {
	$("#btn_mail_auth").click(function(){
		var emailReg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])+\.[a-zA-Z]{2,4}$/i
		var user_email = $('#email').val()
		//console.log(user_email) 이메일 값 확인
		var key;  //입력키
		if(user_email == ""){
			$('#email_check').text("이메일을 입력해주세요.")
			$('#email').focus();
			return false;
		}else if(!emailReg.test(user_email)){
			$('#email_check').text("이메일을 다시 확인해주세요.")
			$('#email').focus();
		}else{
			$('#email_check').text("")
		$.ajax({
			url :'${path}/user/mailAuth.do?email='+user_email,
			type : 'get',
			success : function(data){
				console.log('${AuthNum}')
				alert("인증번호가 전송되었습니다.")
				$("#getauth").val("1");
				$("#auth_num").attr('readonly',false);
				$("#auth_num").attr('placeholder',"인증번호 8자리를 입력해주세요.");
				
			}, error : function(){
				console.log("인증번호 전송 실패");
			}
			})
		}
	})
//})

</script>
</body>
</html>