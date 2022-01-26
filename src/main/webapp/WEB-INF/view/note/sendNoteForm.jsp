<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/WEB-INF/view/jspHeader.jsp" %>
<c:set var="port" value="${pageContext.request.localPort}" /> <!-- port번호 -->
<c:set var="server" value="${pageContext.request.serverName}" /> <!-- localhost -->
<c:set var="path" value="${pageContext.request.contextPath}" /> > <!-- 현재 경로 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알림 보내기</title>
<script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script> <!-- SockJs -->
</head>
<body>
	나에게 온 쪽지 <b>${noticecount}</b> 개
	<table>
		<tr><th>아아디</th><th><input type = "text" id = "sendid" value = "${login.id}" readOnly></th></tr>
		<tr><th>보낼 아이디</th><th><input type = "text" id = "recvid" placeholder = "보낼 아이디"></th></tr>
		<tr><th>제목</th><th><input type = "text" id = "title" placeholder = "제목을 입력하세요."></th></tr>
		<tr><th>내용</th><th><textarea cols="50" rows="10" id = "note" placeholder = "내용을 입력하세요."></textarea></th>
		<tr><th><input type = "button" value = "전송" id = "BtnSend"></th></tr>
	</table>
	<button id = "toastr">토스트버튼</button>
	<script>
			<!-- 쪽지 전송 -->
			$('#BtnSend').on("click",function(evt){
				var n_sent_id = $("#sendid").val();
				var n_recv_id = $("#recvid").val();
				var title = $("#title").val();
				var note = $("#note").val();
				var today = new Date();
				
				var NoteParam = {
						"n_sent_id" : n_sent_id,
						"n_recv_id" : n_recv_id,
						"title" : title,
						"note" : note,
						"date_sent" : today
				}
				$.ajax({
					type : "POST",
					url : "${path}/alarm/sendNote.do",
					data : JSON.stringify(NoteParam),
					contentType: 'application/json; charset=UTF-8',
					async : false,
					success : function(data) {
						alert("쪽지를 보냈습니다.");
					}
				});
				
				var AlarmParam = {
						"a_sent_id" : n_sent_id,
						"a_recv_id" : n_recv_id,
						"a_content" : note,
						"a_date" : today
				}
				$.ajax({
					type : "POST",
					url : "${path}/alarm/saveAlarm.do",
					data : JSON.stringify(AlarmParam),
					contentType : 'application/json; charset = UTF-8',
					async : false,
					success : function(data) {
						let Message = "0" + "," + n_sent_id + "," + n_recv_id + "," + note + "," + today;
						ws.send(Message);
					}
				})
			})	
	</script>
</body>
</html>