<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
<title>로그인</title>
<script type="text/javascript">
	
</script>
</head>
<body>
	<div class="container" style="height: 700px;">
		<div class="center-block" style="text-align: center;">
			<div style="text-align: center;">
				<img width="223px" src="${path}/img/beachlogo.png">
			</div>
			<hr>
			<form:form modelAttribute="user" name="l" method="post"
				action="login.do" onsubmit="return inputchk();">
				<div class="check_font" id="login_check"></div>
				<spring:hasBindErrors name="user">
					<font color="red" size="2"> <c:forEach
							items="${errors.globalErrors}" var="error">
							<spring:message code="${error.code}" />
						</c:forEach>
					</font>
				</spring:hasBindErrors>

				<input type="text" class="form-control" name="id"
					style="width: 400px; height: 56px; margin-left: 370px;"
					placeholder="아이디">
				<div class="check_font" style="margin-left: 85px;"
					id="login_id_check"></div>
				<br>
				<input type="password" class="form-control" name="password"
					style="width: 400px; height: 56px; margin-left: 370px;"
					placeholder="비밀번호">
				<div class="check_font" style="margin-left: 85px;"
					id="login_pswd_check"></div>
				<br>
				<button type="submit"
					style="width: 400px; height: 56px; align: center;"
					class="btn btn-primary">
					<font style="font-size: 20px; font-weight: bold">로그인</font>
				</button>
				<br>
				<br>
				<input type="button" class="btn btn-default" value="회원가입"
					onclick="location.href='entry.do'">
				<input type="button" class="btn btn-default" value="아이디찾기"
					onclick="document.getElementById('idsearch').style.display='block'">
				<input type="button" class="btn btn-default" value="비밀번호찾기"
					onclick="document.getElementById('pwsearch').style.display='block'">
				<hr>
			</form:form>
			<div class="center-block">
				<font style="font-size: 22px; color: #808080">간편 로그인</font>
			</div>
			<!-- 이전 소셜 로그인 디자인 
<div class="form-inline" style="width:570px; align:center;">
<div class="login_btn" style="padding:10px;margin-left:20px">
<a id="kakao-login-btn" href="${kakaoUrl}" ><img width="240px" height="56px"src="${path}/img/kakao_login.png"></a></div>
<div class="login_btn" id="naver_id_login" style="padding:10px; margin-right:20px"><a href="${naverUrl}">
<img width="240px" height="56px" src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png"/></a></div>
</div>

<button style="width:400px; height:60px;border:none;margin-top:10px;"
 class="btn btn-secondary" onclick="window.open('${kakaoUrl}','카카오톡 로그인','width=500,height=600,left=530px,top=100px,scrollbars=no')">
<img src="${path}/img/kakao-login.png" width="360px">
</button>
 -->

			<!-- 팝업테스트 login -->

			<img style="width: 400px; height: 60px; margin-top: 10px;"
				src="${path}/img/kakao-login.png" class="btn btn-light"
				onclick="window.open('${kakaoUrl}','카카오 로그인','width=500,height=600,left=530px,top=100px')">
			<img style="width: 400px; height: 60px; margin-top: 10px;"
				src="${path}/img/naver-login.png" class="btn btn-light"
				onclick="window.open('${naverUrl}','네이버 로그인','width=600,height=500,left=530px,top=100px')">

		</div>
	</div>
	<!-- 아이디 찾기 Modal -->
	<div id="idsearch" class="w3-modal">
		<div class="w3-modal-content w3-card-4 w3-animate-zoom"
			style="max-width: 550px;">

			<div class="w3-center">
				<br> <span onclick="idsearch_hide()"
					class="w3-button w3-xlarge w3-transparent w3-display-topright"
					title="창 닫기">&times;</span>
			</div>
			<form class="w3-container" action="idsearch.do" method="post"
				name="i" onsubmit="">
				<div class="w3-section">

					<table class="w3-table-all w3-border w3-white w3-center">
						<caption style="text-align: left">
							<font style="font-weight: bold; font-size: 15px; color: black">아이디
								찾기</font>
						</caption>
					</table>
					<hr>
					<div class="center-block">
						<div class="form-group">
							<label class="label_st" for="name">이름</label> <input
								class="form-control" type="text" id="name" name="name" required>
							<div class="check_font" id="name_check"></div>
						</div>
						<div class="form-group">
							<label class="label_st" for="id_email">이메일</label>
							<div class="form-inline">
								<input class="form-control" style="width: 360px;" type="email"
									id="id_email" name="email" required> <input
									class="form-control" type="button"
									style="width: 120px; height: 51px; background-color: #007BFF; color: white; font-weight: bold;"
									id="btn_mail_auth" value="인증번호 받기">
							</div>
						</div>
						<div class="check_font" id="name_email_check"></div>
						<div class="w3-center">
							<input type="text" id="auth_num" name="auth_num"
								class="form-control" readonly placeholder="인증번호 입력란" />
							<div class="check_font" id="auth_check"></div>
							<button class="btn btn-primary"
								style="width: 450px; height: 40px;" onclick="AuthChk()"
								type="button">아이디 찾기</button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>

	<!-- 비밀번호 찾기 Modal -->
	<div id="pwsearch" class="w3-modal">
		<div class="w3-modal-content w3-card-4 w3-animate-zoom"
			style="max-width: 550px">

			<div class="w3-center">
				<br>
				<button onclick="pwsearch_hide()"
					class="w3-button w3-xlarge w3-transparent w3-display-topright"
					title="창 닫기">&times;</button>
			</div>
			<form class="w3-container" action="pwsearch.do" method="post"
				name="p" onsubmit="">
				<div class="w3-section">
					<table class="w3-table-all w3-border w3-white w3-center">
						<caption style="text-align: left">
							<font style="font-weight: bold; font-size: 15px; color: black">비밀번호
								찾기</font>
						</caption>
					</table>
					<font style="color: #BDBDBD;">비밀번호 찾기 시 이메일로 임시 비밀번호가 전송됩니다.</font>
					<hr>
					<div>
						<div style="text-align: left">
							<label><b>아이디</b></label>
						</div>
						<input class="w3-input w3-border w3-margin-bottom" type="text"
							id="id" name="id" required>
						<div class="check_font" id="id_check"></div>
						<div style="text-align: left">
							<label><b>이메일</b></label>
						</div>
						<input class="w3-input w3-border w3-margin-bottom" type="email"
							id="pw_email" name="email" required>
						<div class="check_font" id="id_email_check"></div>
						<div class="w3-center">
							<button class="btn btn-primary"
								style="width: 450px; height: 40px;" type="submit">비밀번호
								찾기</button>
						</div>
					</div>
				</div>

			</form>
		</div>
	</div>
	<script type="text/javascript">
		function inputchk() {
			const id = l.id.value;
			const password = l.password.value;

			if (id == "") {
				$('#login_id_check').text("아이디를 입력해주세요.")
				l.id.focus();
				return false;
			}

			if (password == "") {
				$('#login_id_check').text("")
				$('#login_pswd_check').text("비밀번호를 입력해주세요.")
				l.password.focus();
				return false;
			}
			l.submit();
		}
		//======== modal 닫기 ========
		function pwsearch_hide() {
			document.getElementById('pwsearch').style.display = "none";
			//입력값 초기화 부분
			$('#id').val("");
			$('#pw_email').val("");
			$('#id_check').text("");
			$('#id_email_check').text("");
		}

		function idsearch_hide() {
			document.getElementById('idsearch').style.display = "none";
			//입력값 초기화 부분
			$('#name').val("");
			$('#id_email').val("");
			$('#name_check').text("");
			$('#name_email_check').text("");
		}

		//======== 아이디 찾기 ========
		$("#name").blur(function() {
			var nameReg = /^[가-힣]{2,10}$/
			var name = $('#name').val();
			var email = $('#id_email').val();
			console.log(name);
			if (name == "") {
				$("#name_check").text("필수 입력정보입니다.")
				//정규식이 틀릴경우
			} else if (!nameReg.test(name)) {
				console.log(nameReg.test(name))
				$("#name").val("")
				$("#name_check").text("이름에 대한 정보만 입력해주세요.")
			} else {
				if (email != "") {
					$('#name_email_check').text("");
				}
				$("#name_check").text("")
			}
		})

		$('#id_email').blur(
				function() {
					var name = $('#name').val();
					var email = $('#id_email').val();
					if (email == "" && name == "") {
						$('#name').focus();
						$('#name_check').text("이름을 먼저 입력해주세요.");
						return false;
					} else if (email != "" && name == "") {
						$('#name').focus();
						$('#name_check').text("필수 입력정보입니다.");
						return false;
					} else if (email == "" && name != "") {
						$('#name_email_check').text("필수 입력정보입니다.");
						$('#id_email').focus();
						return false;
					} else {
						$.ajax({
							url : '${path}/user/emailCheck2.do?name=' + name
									+ '&email=' + email,
							type : 'get',
							success : function(data) {
								console.log(data);
								//존재
								if (data > 0) {
									$('#name_email_check').text("");
								} else {
									$('#name_email_check').text(
											"등록된 사용자가 아닙니다.");
									$('#id_email').val("");
									$('#name').val("");
									$('#name').focus();
								}

							}
						})
					}
				})

		function AuthChk() {

			/* if(i.auth_num.value != "${AuthNum}"){
				alert("인증번호가 일치하지 않습니다.")
				i.auth_num.focus();
				$("#auth_check").text("인증번호를 확인해주세요");
				return false;
			} */
			setTimeout(function() {
				i.submit();
			}, 1000);
		}
		/*
		 if(email=="" && name==""){
		 $('#name').focus();
		 $('#name_check').text("이름을 먼저 입력해주세요.");
		 }else{		
		 if(name==""){
		 $('#name').focus();
		 $('#name_check').text("필수 입력정보입니다.");
		 }else if(email==""){
		 $('#name_email_check').text("필수 입력정보입니다.");
		 $('#id_email').focus();
		 }else{
		 $('#name_email_check').text("");
		 }
		 }
		 */
		$("#btn_mail_auth").click(
				function() {
					var email = $('#id_email').val();
					//console.log(user_email) 이메일 값 확인
					var key; //입력키
					var name = $('#name').val();
					console.log(name);
					if (name == "") {
						$('#name').focus();
						$('#name_check').text("필수 입력정보입니다.");
						return false;
					} else if (email == "") {
						$('#name_email_check').text("필수 입력정보입니다.");
						$('#id_email').focus();
						return false;
					} else {
						$.ajax({
							url : '${path}/user/idemailAuth.do?email=' + email,
							type : 'get',
							success : function(data) {
								console.log('${AuthNum}')
								alert("인증번호가 전송되었습니다.")
								$("#auth_num").attr('readonly', false);
								$("#auth_num").attr('placeholder',
										"인증번호 8자리를 입력해주세요.");

							},
							error : function() {
								console.log("인증번호 전송 실패");
							}
						})
					}
				})

		//===== 비밀번호 찾기 ===== 
		//아이디 유효성 검증(1 = 존재 / 0 = 존재하지않음)
		$("#id").blur(function() {
			var idReg = /^[a-z0-9]{4,12}$/g;
			var id = $('#id').val();
			var email = $('#pw_email').val();
			$.ajax({
				url : '${path}/user/idCheck.do?id=' + id,
				type : 'get',
				success : function(data) {
					console.log("중복 확인(1:중복, 0:중복X) : " + data);
					if (data == 0) {
						if (id == "") {
							$("#id_check").text("필수 입력정보입니다.");
							$("#id_check").css("color", "red");
							$('#id_email_check').text("")
						} else {
							$('#id').val("");
							$("#id_check").text("아이디가 존재하지 않습니다.");
							$("#id_check").css("color", "red");
						}
					} else {
						if (id != "" && email != "") {
							$('#id_email_check').text("비밀번호 찾기를 눌러주세요")
							$("#id_email_check").css("color", "green");
						}
						$("#id_check").text("");
					}
				},
				error : function() {
					console.log("실패");
				}
			});
		});
		//아이디 이메일 검증	
		$("#pw_email").blur(
				function() {
					var email = $('#pw_email').val();
					var id = $('#id').val();
					$.ajax({
						url : '${path}/user/emailCheck.do?email=' + email
								+ '&id=' + id,
						type : 'get',
						//data = 1 해당 아이디 email 존재 , 0 = 해당 아이디 email 존재 X
						success : function(data) {
							if (id == "") {
								$("#id_check").text("필수 입력정보입니다.")
								$('#id').focus();
								return false;
							}
							if (data == 1) {
								$('#id_email_check').text("비밀번호 찾기를 눌러주세요")
								$("#id_email_check").css("color", "green");
							} else {
								if (email == "") {
									$("#pw_email").val("");
									$('#pw_email').focus();
									$("#id_email_check").text("필수 입력정보입니다.")
									$("#id_email_check").css("color", "red");
								} else {
									$("#pw_email").val("");
									$("#id_email_check").text(
											"이메일 정보가 맞지 않습니다.")
									$("#id_email_check").css("color", "red");
								}
							}
							console.log(data);
						},
						error : function() {
							console.log("실패");
						}
					});
				});
	</script>
</body>
</html>