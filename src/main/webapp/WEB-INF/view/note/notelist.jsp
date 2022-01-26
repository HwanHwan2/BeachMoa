<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 부트스트랩 모달, -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<title>쪽지 리스트</title>
<!-- 부트스트랩 모달, -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
	.modal-dialog {z-index: 1050;}
	.modal-open {
  overflow: hidden;
}

.modal-open .modal {
  overflow-x: hidden;
  overflow-y: auto;
}

.modal {
  position: fixed;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  z-index: 1050;
  display: none;
  overflow: hidden;
  outline: 0;
}

.modal-dialog {
  position: relative;
  width: auto;
  margin: 0.5rem;
  pointer-events: none;
}

.modal.fade .modal-dialog {
  transition: -webkit-transform 0.3s ease-out;
  transition: transform 0.3s ease-out;
  transition: transform 0.3s ease-out, -webkit-transform 0.3s ease-out;
  -webkit-transform: translate(0, -25%);
  transform: translate(0, -25%);
}

@media screen and (prefers-reduced-motion: reduce) {
  .modal.fade .modal-dialog {
    transition: none;
  }
}

.modal.show .modal-dialog {
  -webkit-transform: translate(0, 0);
  transform: translate(0, 0);
}

.modal-dialog-centered {
  display: -ms-flexbox;
  display: flex;
  -ms-flex-align: center;
  align-items: center;
  min-height: calc(100% - (0.5rem * 2));
}

.modal-dialog-centered::before {
  display: block;
  height: calc(100vh - (0.5rem * 2));
  content: "";
}

.modal-content {
  position: relative;
  display: -ms-flexbox;
  display: flex;
  -ms-flex-direction: column;
  flex-direction: column;
  width: 100%;
  pointer-events: auto;
  background-color: #fff;
  background-clip: padding-box;
  border: 1px solid rgba(0, 0, 0, 0.2);
  border-radius: 0.3rem;
  outline: 0;
}

.modal-backdrop {
  position: fixed;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  z-index: 1040;
  background-color: #000;
}

.modal-backdrop.fade {
  opacity: 0;
}

.modal-backdrop.show {
  opacity: 0.5;
}

.modal-header {
  display: -ms-flexbox;
  display: flex;
  -ms-flex-align: start;
  align-items: flex-start;
  -ms-flex-pack: justify;
  justify-content: space-between;
  padding: 1rem;
  border-bottom: 1px solid #e9ecef;
  border-top-left-radius: 0.3rem;
  border-top-right-radius: 0.3rem;
}

.modal-header .close {
  padding: 1rem;
  margin: -1rem -1rem -1rem auto;
}

.modal-title {
  margin-bottom: 0;
  line-height: 1.5;
}

    .modal-body {
     position: relative;
     -ms-flex: 1 1 auto;
     flex: 1 1 auto;
     padding: 1rem;
    }

    .modal-footer {
      display: -ms-flexbox;
      display: flex;
     -ms-flex-align: center;
      align-items: center;
     -ms-flex-pack: end;
     justify-content: flex-end;
     padding: 1rem;
     border-top: 1px solid #e9ecef;
    }

     .modal-footer > :not(:first-child) {
     margin-left: .25rem;
    }

      .modal-footer > :not(:last-child) {
      margin-right: .25rem;
     }

      .modal-scrollbar-measure {
      position: absolute;
      top: -9999px;
      width: 50px;
      height: 50px;
      overflow: scroll;
    }

     @media (min-width: 576px) {
        .modal-dialog {
        max-width: 500px;
        margin: 1.75rem auto;
     }
       .modal-dialog-centered {
        min-height: calc(100% - (1.75rem * 2));
     }
       .modal-dialog-centered::before {
       height: calc(100vh - (1.75rem * 2));
     }
      .modal-sm {
      max-width: 300px;
     }
</style>
<script type = "text/javascript">
   function allchkbox(allchk){
      $(".idchks").prop("checked",allchk.checked)
   }
   function listdo(page) {
	   document.searchform.pageNum.value=page;
	   document.searchform.submit();
   }
</script>
</head>
<body>
<div class = "container">
	<div class = "header">
		<h1 class="page-header">쪽지</h1>
		<button type="button" class = "btn btn-info" data-toggle="modal" data-target="#sendNote">쪽지작성</button>&nbsp;
		<input type = "button" class="btn btn-danger" value = "쪽지삭제" id = "DeleteNote"><br><br>
	</div>
	<table class = "table table-hover">
		<tr style="height: 49px; background-color: #F8FBFF">
			<th style="width: 88px"><input type = "checkbox" name = "allchk" onchange="allchkbox(this)"></th>
			<th style="width: 50px">No</th>	
			<th style="width: 700px">제목</th>
			<th style="width: 120px">보낸 사람</th>
			<th style="width: 150px">작성일자</th>
		</tr>
		<c:if test = "${not empty notelist}">
		<c:forEach var = "note" items = "${notelist}"> <!-- 온 쪽지가 있는 경우 -->
		<c:set var = "noteno" value = "${noteno-1}" />
		<tr style = "height:49px;">
			<td><input type = "checkbox" name = "idchks" class = "idchks" id = "${note.n_no}"></td>
			<td>${noteno}</td>
			<td><a href = "#" data-toggle="modal" data-target="#noteDetail" 
						data-sentid = "${note.n_sent_id}" 
						data-title = "${note.title}"
						data-note = "${note.note}">
				${note.title}</a></td>
			<td>${note.n_sent_id}</td>
			<td><fmt:formatDate value="${note.date_sent}" pattern="yyyy-MM-dd"/></td>
		</tr>
		</c:forEach>
		</c:if>
		<c:if test = "${empty notelist}">
			<tr>
				<th colspan = "5" style = "text-align:center;">쪽지가 없습니다.</th>
			</tr>
		</c:if>
	</table>
</div>
<div class="container" style="background-color: #f9f9f9	; width: 1140px;height:100%;position:relative;">
	 <ul class="pagination justify-content-center" style="margin-left: 450px;margin-top: 15px;margin-bottom: 15px;	">
	 		<li><a href="javascript:listdo(${startpage})"><<</a></li>
     	<c:if test="${pageNum <=1}">
     		<li><a href="javascript:listdo(${pageNum})"><</a></li>
     	</c:if>
     	<c:if test="${pageNum > 1}">
     		<li><a href="javascript:listdo(${pageNum-1})"><</a></li>
      	</c:if>
      
     	<c:forEach var="a" begin="${startpage}" end="${endpage}">
      		<li><a href="javascript:listdo(${a})">${a}</a></li>
      	</c:forEach>
      	  
     	<c:if test="${pageNum >= maxpage}">	
     		<li><a href="javascript:listdo(${pageNum})">></a></li>
     	</c:if>
     	<c:if test="${pageNum < maxpage}">
      		<li><a href="javascript:listdo(${pageNum+1})">></a></li>
     	</c:if>
     	<li><a href="javascript:listdo(${endpage})">>></a></li>
    </ul><hr style="margin-top: 5px;margin-bottom: 15px">
</div>

<!-- 쪽지 보내기 모달 -->
<div class="modal" tabindex="-1" role="dialog" id = "sendNote">
  <div class="modal-dialog modal-dialog-centered" role="document">
  	<input type="hidden" name="n_sent_id" id = "sentid" value="${sessionScope.login.id}">
  	<form:form modelAttribute="note" id = "send" action="../note/sendNote.do" method="post" name="f">
  	<input type = "hidden" name = "n_sent_id" value = "${sessionScope.login.id}">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">쪽지 전송</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close" id = "closeModal">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<div class="form-group">
    		<label for="exampleInputEmail1">받는 아이디</label>
    		<input type="text" class="form-control" name="n_recv_id" id = "recvid" placeholder="받는 아이디를 입력하세요.">
  		</div>
  		<div class="form-group">
    		<label for="exampleInputEmail1">제목</label>
    		<input type="text" class="form-control" name="title" id = "title" placeholder="제목를 입력하세요.">
  		</div>
  		<div class="form-group">
    		<label for="exampleInputEmail1">내용</label>
    		<textarea class = "form-control" cols="50" rows="10" name = "note" id = "content" placeholder = "내용을 입력하세요."></textarea>
  		</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        <button type="submit" class="btn btn-primary" id = "sendBtn">전송</button>
      </div>
    </div>
    </form:form>
  </div>
</div>

<!-- 쪽지 상세보기 -->
<div class = "modal" tabindex = "-1" role = "dialog" id = "noteDetail">
	<div class = "modal-dialog modal-dialog-centered" role = "document">
		<div class = "modal-content">
			<div class = "modal-header">
				<h4 class = "modal-title">쪽지 상세보기</h4>
				<button type = "button" class = "close" data-dismiss = "modal" aria-label = "Close" id = "closeModal2"><span aria-hidden="true">&times;</span></button>
			</div>
			<div class = "modal-body">
				<div class="form-group">
    				<label for="exampleInputEmail1">보낸 사람</label>
    				<p class = "lead" id = "show_sentid"/>
  				</div>
  				<div class="form-group">
    				<label for="exampleInputEmail1">제목</label><br>
    				<p class = "lead" id = "show_title"/>
  				</div>
  				<div class="form-group">
    				<label for="exampleInputEmail1">내용</label><br>
    				<p class = "lead" id = "show_note"/>
  				</div>
			</div>
			<div class = "modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<script>
	//쪽지 작성 모달
	$('#NoteModal').on('click', function(){
		$('#sendNote').modal('show');
	});
	$('#closeModal').on('click', function(){
		$('#sendNote').modal('hide');
	});
	
	//쪽지 상세정보 모달
	$('#noteDetail').on('click', function() {
		$('#noteDetail').modal('show');
	})
	$('#noteDetail').on('show.bs.modal', function(event) {          
            $("#show_sentid").text($(event.relatedTarget).data('sentid'));
            $("#show_title").text($(event.relatedTarget).data('title'));
            $("#show_note").text($(event.relatedTarget).data('note'));
    });
	$('#closeModal2').on('click', function(){
		$('#noteDetail').modal('hide');
	});
	
	
	$('#send').submit(function(){
		var sent_id = "${login.id}";
		var recv_id = $("input#recvid").val();
		var title = $("input#title").val();
		var note = $("input#content").val();
		var href = "${path}/note/notelist.do?id=" + recv_id;
		var today = new Date();
		
		var AlarmParam = {
			"a_sent_id" : "${login.id}",
			"a_recv_id" : $("input#recvid").val(),
			"a_title" : "님이 쪽지를 보냈습니다.",
			"a_content" : title,
			"a_href" : href,
			"a_date" : today
		};
		$.ajax({
			type : "POST",
			url : "${path}/alarm/saveAlarm.do",
			data : JSON.stringify(AlarmParam),
			contentType : 'application/json; charset = UTF-8',
			async : false,
			success : function(data) {
				alert("쪽지 알림을 DB에 저장");
				let Message = "0" + "," + sent_id + "," + recv_id + "," + title + "," + today;
				ws.send(Message);
			}
		})
	})
</script>

<!-- 쪽지 삭제 -->
<script>
	$("#DeleteNote").on("click",function(){
			var cnt = $("input[name='idchks']:checked").length;
			var checkArr = new Array();
			$("input[name='idchks']:checked").each(function() {
        	    checkArr.push($(this).attr('id'));
        	});
			if(cnt == 0) {
				alert("선택한 쪽지가 없습니다.");
			} else {
				var confirm_val = confirm("정말 삭제하시겠습니까?"); 
				if(confirm_val) {
					$.ajax({
						type : "POST",
						url : "${path}/note/deleteNote.do",
						data :{ chbox : checkArr },
						success : function() {
							alert("쪽지를 삭제했습니다.");
							location.href = "${path}/note/notelist.do?id=${login.id}";
						}
					})
				}
			}
		})
</script>
</body>
</html>