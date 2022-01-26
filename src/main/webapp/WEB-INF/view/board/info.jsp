<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<meta charset="UTF-8">
<title>BeachMoa : 게시글</title>
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
<script>
function resize(obj) {
  obj.style.height = "1px";
  obj.style.height = (12+obj.scrollHeight)+"px";
}

function removeCheck() {
    if (confirm("게시글을 삭제하시겠습니까?") == true){    //확인
        document.d.submit();
    }else{   //취소
        return false;
    }
   }
<!--
   function removeComment() {
       if (confirm("댓글을 삭제하시겠습니까?") == true){    //확인
           document.del.submit();
       }else{   //취소
           return false;
       }
      }
-->   
$('.dropdown-toggle').dropdown();
$('.dropdown-toggle').dropdown('toggle');

var location = document.querySelector("#commentmove").offsetTop;
</script>
<style>
textarea.autosize { min-height: 50px; }
.menu{color: #b7b7b7}
.modal {
        text-align: center;
}
 
@media screen and (min-width: 768px) { 
        .modal:before {
                display: inline-block;
                vertical-align: middle;
                content: " ";
                height: 100%;
        }
}
 
.modal-dialog {
        display: inline-block;
        text-align: left;
        vertical-align: middle;
}
</style>
</head>
<body>
<div style="width: 1170px;height: 50px;margin-top: 20px;margin-left: 465px;">
   <a href="list.do?btype=${board.btype}" class="btn btn-info w3-right" style="margin-left: 5px;">목록</a>
<!-- 
   <c:if test="${maxseq!=board.seq}">
      <a href="info.do?seq=${board.seq+1}&btype=${board.btype}" class="btn btn-info w3-right"><i class="icon-chevron-right"></i>다음글</a>${maxseq}
   </c:if>
 -->
</div>
<c:if test="${board.reportcnt<5}">
<div class="container" style="border : 1px solid #ebecef;border-radius: 6px; width: 1170px;height: auto; padding: 29px 29px 0;">
   <c:if test="${board.btype==0}">
      <a href="list.do?btype=0" style="color: #03c75a;text-decoration: none">공지사항 <i class="fas fa-angle-right"></i></a>
   </c:if>
      <c:if test="${board.btype==1}">
      <a href="list.do?btype=1" style="color: #03c75a;text-decoration: none">자유게시판 <i class="fas fa-angle-right"></i></a>
   </c:if>
      <c:if test="${board.btype==2}">
      <a href="list.do?btype=2" style="color: #03c75a;text-decoration: none">건의게시판 <i class="fas fa-angle-right"></i></a>
   </c:if>
<h1>${board.subject}</h1>
<a href="#" style="font-size: 13px; font-weight: 700;text-decoration: none;color: inherit">${board.nickname}</a>
<div>
   <div style="float: left">
      <span style="margin-right: 8px;color: #979797;">
         <fmt:formatDate value="${board.regdate}" pattern="yyyyMMdd" var="rdate"/>
         <c:if test="${today == rdate}">
            <fmt:formatDate value="${board.regdate}" pattern="HH:mm"/>
         </c:if>
         <c:if test="${today != rdate}">
            <fmt:formatDate value="${board.regdate}" pattern="yyyy.MM.dd."/>
         </c:if>
      </span>
      <span style="color: #979797">조회 ${board.readcnt}</span>
   </div>
   <div style="float: right">
   <c:if test="${board.btype==1}">
      <a href="#" style="text-decoration: none; color: #000000;font-size: 17px">
         <i class="far fa-comment-dots" style="width: 17px;height: 17px;margin-right: 6px;vertical-align: top;color:#323232"></i>댓글 ${commentcount}
      </a>
   </c:if>
   </div>
</div>
<br>
<hr style="border-bottom: 1px solid #ebecef"><br>
<div>
   <p style="line-height: 1.8;">${board.content}</p>
</div>
<div style="margin: 40px 0 26px;">
   <a href="#" style="color: #323232;"><strong>${board.nickname}</strong>님의 게시글 더보기 <i class="fas fa-angle-right"></i></a>
</div>
<c:if test="${board.btype==1}">
<a role="button" style="text-decoration: none; color: #000000;font-size: 17px" onclick="window.scrollTo({top:location, behavior:'smooth'});">
   <i class="far fa-comment-dots" style="width: 17px;height: 17px;margin-right: 6px;vertical-align: top;color:#323232"></i>댓글 ${commentcount}
</a>
</c:if>
<c:if test="${!empty sessionScope.login}">
<c:if test="${board.btype==1}">
<a class="boardreportbtn" style="text-decoration: none; color: #000000;font-size: 17px;margin-left: 10px;cursor:pointer">
   <i class="fas fa-exclamation"></i>신고하기
</a>   
</c:if>
</c:if>
<hr style="border-bottom: 1px solid #ebecef"><br>
<c:if test="${commentcount != 0}">
<div style="margin-top: 0px;">
   <p style="font-size: 17px;font-weight: 700">댓글</p>
</div>
</c:if>
<!-- 댓글 리스트 -->
<div id="commentmove"></div>
<c:forEach var="comment" items="${commentlist}">
<c:if test="${comment.c_grp == 0}">
<div style="border-top: 1px solid #f2f2f2;padding: 12px 23px 10px 0;">
<!-- <div style="margin-left: 100px;"></div> -->
<div>
   <p style="font-weight: 700;">${comment.nickname}</p>
   <div class="dropdown w3-right">
<c:if test="${!empty sessionScope.login}">
   <span class="glyphicon glyphicon-option-vertical dropdown-toggle menu" data-toggle="dropdown" style="#b7b7b7" role="button"></span>
    <ul class="dropdown-menu" style="float: right" role="menu">
       <c:if test="${sessionScope.login.nickname==comment.nickname}">
       <c:if test="${sessionScope.login.id!='admin'}">
       <li><a class="reply_edit_btn test" id="${comment.c_seq}0" style="text-decoration: none;cursor:pointer">수정</a></li>
       <li style="padding-left: 20px;"><form:form modelAttribute="comment" action="c_delete.do" method="post" name="del">
             <input type="hidden" name="b_seq" value="${board.seq}">
            <input type="hidden" name="c_seq" value="${comment.c_seq}">
            <input type="hidden" name="btype" value="${board.btype}">
            <button class="test" style="color: black;text-decoration: none;background: none;border: none;padding-left: 0px;" >삭제</button>
          </form:form>
       </li>
       </c:if>
       </c:if>
       <c:if test="${sessionScope.login.id=='admin'}">
       <li><a class="reply_edit_btn test" id="${comment.c_seq}0" style="text-decoration: none;cursor:pointer">수정</a></li>
       <li style="padding-left: 20px;"><form:form modelAttribute="comment" action="c_delete.do" method="post" name="del">
             <input type="hidden" name="b_seq" value="${board.seq}">
            <input type="hidden" name="c_seq" value="${comment.c_seq}">
            <input type="hidden" name="btype" value="${board.btype}">
            <button class="test" style="color: black;text-decoration: none;background: none;border: none;padding-left: 0px;" >삭제</button>
          </form:form>
       </li>
       </c:if>      
       <li><a class="commentreportbtn" style="cursor: pointer;">신고</a></li>
   </ul>
   </c:if>
   </div>
   <p>${comment.c_content}</p>
   <p style="color: #979797;float: left;margin-right: 8px">
      <fmt:formatDate value="${comment.c_regdate}" pattern="yyyyMMdd" var="rdate"/>
      <c:if test="${today == rdate}">
         <fmt:formatDate value="${comment.c_regdate}" pattern="HH:mm"/>
      </c:if>
      <c:if test="${today != rdate}">
         <fmt:formatDate value="${comment.c_regdate}" pattern="yyyy.MM.dd."/>
      </c:if>
   </p>
<!-- 댓글 신고 -->
<form:form modelAttribute="board" action="report2.do" method="post" name="r">
<input type="hidden" name="b_seq" value="${board.seq}">
<input type="hidden" name="c_seq" value="${comment.c_seq}">
<input type="hidden" name="id" value="${sessionScope.login.id}">
<input type="hidden" name="btype" value="${board.btype}">
<div class="modal fade" id="commentreport" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
         <h4 class="modal-title w3-left" id="myModalLabel" style="text-align: left;">신고하기</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close" ><span aria-hidden="true">×</span></button>
      </div>
      <div class="modal-body">
        <p>신고 제목</p>
        <textarea class="form-control" name="reportsubject" style="width: 10	0%;height: 40px;resize: none;display: inline;"></textarea><br><br>
        <p>신고 내용</p>
        <textarea class="form-control" name="reportcontent" style="width: 100%;height: 200px;resize: none;display: inline;"></textarea><br>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
        <button type="submit" class="btn btn-danger">신고하기</button>
      </div>
    </div>
  </div>
</div>
</form:form>
<script type="text/javascript">
$(".commentreportbtn").on( "click", function() {
    $("#commentreport").modal();
});
</script>
<c:if test="${!empty sessionScope.login}">
<!-- 댓글 답글 -->
   <a id="${comment.c_seq}2" class="reply_edit_btn test" style="float: left;color: #979797;text-decoration: none">답글쓰기</a><br>
       <form:form modelAttribute="board" action="c_reply.do" method="post">
          <input type="hidden" name="id" value="${sessionScope.login.nickname}">
         <input type="hidden" name="b_seq" value="${board.seq}">
         <input type="hidden" name="c_seq" value="${comment.c_seq}">
         <input type="hidden" name="btype" value="${board.btype}">
         <div class="${comment.c_seq}3" style="display: none;margin-left: 50px;height: 110px;width: 100%"><br>
            <textarea class="form-control" name="c_content" style="width: 600px;height: 70px;resize: none;display: inline;"></textarea>
            <button type="submit" style="height: 70px;width:70px;margin-bottom: 60px;" class="btn btn-default">등록</button>
         </div>
      </form:form>
</c:if>
<script type="text/javascript">
$(function (){
   $("#${comment.c_seq}2").click(function (){
      $(".${comment.c_seq}3").toggle(); 
      }); 
   });
</script>
<!-- 댓글 수정 -->
<form:form modelAttribute="board" action="c_update.do" method="post">
   <input type="hidden" name="b_seq" value="${board.seq}">
   <input type="hidden" name="c_seq" value="${comment.c_seq}">
   <input type="hidden" name="btype" value="${board.btype}">
   <div class="${comment.c_seq}1" style="display: none;margin-left: 50px;height: 110px;width: 100%"><br>
      <textarea class="form-control" name="c_content" style="width: 600px;height: 70px;resize: none;display: inline;">${comment.c_content}</textarea>
      <button type="submit" style="height: 70px;width:70px;margin-bottom: 60px;" class="btn btn-default">수정</button>
   </div>
</form:form>
<script>
   $(function (){
      $("#${comment.c_seq}0").click(function (){
         $(".${comment.c_seq}1").toggle(); 
         if( $(this).html() == '수정' ) {
               $(this).html('수정 취소');
             }
             else {
               $(this).html('수정');
             }
         }); 
      });
</script>
</div>
</div>
</c:if>

<!-- 답글
    답글
    답글 -->
<c:forEach var="comment2" items="${commentlist}">
<c:if test="${comment2.c_grp == comment.c_seq}">
<div style="border-top: 1px solid #f2f2f2;padding: 12px 23px 10px 0;">
<div style="margin-left: 80px;"><br>
   <p style="font-weight: 700;">${comment2.id}</p>
   <div class="dropdown w3-right">
   <c:if test="${!empty sessionScope.login}">
   <span class="glyphicon glyphicon-option-vertical dropdown-toggle menu" data-toggle="dropdown" style="#b7b7b7" role="button"></span>
    <ul class="dropdown-menu" style="float: right" role="menu">
    <c:if test="${sessionScope.login.nickname==comment.nickname}">
    <c:if test="${sessionScope.login.id!='admin'}">
       <li><a class="reply_edit_btn test" id="${comment2.c_seq}0" style="text-decoration: none;cursor:pointer">수정</a></li>
       <li style="padding-left: 20px;">
          <form:form modelAttribute="comment" action="c_delete.do" method="post" name="del">
          <input type="hidden" name="btype" value="${board.btype}">
             <input type="hidden" name="b_seq" value="${board.seq}">
            <input type="hidden" name="c_seq" value="${comment2.c_seq}">
            <button class="test" style="color: black;text-decoration: none;background: none;border: none;padding-left: 0px;" >삭제</button>
          </form:form>
       </li>   
    </c:if>
    </c:if>
    <c:if test="${sessionScope.login.id=='admin'}">
       <li><a class="reply_edit_btn test" id="${comment2.c_seq}0" style="text-decoration: none;cursor:pointer">수정</a></li>
       <li style="padding-left: 20px;">
          <form:form modelAttribute="comment" action="c_delete.do" method="post" name="del">
             <input type="hidden" name="b_seq" value="${board.seq}">
            <input type="hidden" name="c_seq" value="${comment2.c_seq}">
            <input type="hidden" name="btype" value="${board.btype}">
            <button class="test" style="color: black;text-decoration: none;background: none;border: none;padding-left: 0px;" >삭제</button>
          </form:form>
       </li>   
    </c:if>
       <li><a id="commentreportbtn1" style="cursor: pointer;">신고</a></li>
   </ul>
   </c:if>
   </div>
   <p>${comment2.c_content}</p>
   <p style="color: #979797;float: left;margin-right: 8px">
      <fmt:formatDate value="${comment2.c_regdate}" pattern="yyyyMMdd" var="rdate"/>
      <c:if test="${today == rdate}">
         <fmt:formatDate value="${comment2.c_regdate}" pattern="HH:mm"/>
      </c:if>
      <c:if test="${today != rdate}">
         <fmt:formatDate value="${comment2.c_regdate}" pattern="yyyy.MM.dd."/>
      </c:if>
   </p>
<!-- 댓글 답글 신고 -->
<form:form modelAttribute="board" action="report2.do" method="post" name="r">
<input type="hidden" name="b_seq" value="${board.seq}">
<input type="hidden" name="c_seq" value="${comment2.c_seq}">
<input type="hidden" name="btype" value="${board.btype}">
<input type="hidden" name="id" value="${sessionScope.login.id}">
<div class="modal fade" id="commentreport1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
         <h4 class="modal-title w3-left" id="myModalLabel" style="text-align: left;">신고하기</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close" ><span aria-hidden="true">×</span></button>
      </div>
      <div class="modal-body">
        <p>신고 제목</p>
        <textarea class="form-control" name="reportsubject" style="width: 100%;height: 40px;resize: none;display: inline;"></textarea><br><br>
        <p>신고 내용</p>
        <textarea class="form-control" name="reportcontent" style="width: 100%;height: 200px;resize: none;display: inline;"></textarea><br>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
        <button type="submit" class="btn btn-danger">신고하기</button>
      </div>
    </div>
  </div>
</div>
</form:form>
<script type="text/javascript">
$("#commentreportbtn1").on( "click", function() {
    $("#commentreport1").modal();
});
</script>
<!-- 댓글 수정 -->
<form:form modelAttribute="board" action="c_update.do" method="post">
   <input type="hidden" name="b_seq" value="${board.seq}">
   <input type="hidden" name="btype" value="${board.btype}">
   <input type="hidden" name="c_seq" value="${comment2.c_seq}">
   <div class="${comment2.c_seq}1" style="display: none;margin-left: 50px;height: 110px;width: 100%"><br>
      <textarea class="form-control" name="c_content" style="width: 600px;height: 70px;resize: none;display: inline;">${comment2.c_content}</textarea>
      <button type="submit" style="height: 70px;width:70px;margin-bottom: 60px;" class="btn btn-default">수정</button>
   </div>
</form:form>
<script>
   $(function (){
      $("#${comment2.c_seq}0").click(function (){
         $(".${comment2.c_seq}1").toggle(); 
         if( $(this).html() == '수정' ) {
               $(this).html('수정 취소');
             }
             else {
               $(this).html('수정');
             }
         }); 
      });
</script>
<!-- 답글의 답글 
   <a id="${comment2.c_seq}6" class="reply_edit_btn test" style="float: left;color: #979797;text-decoration: none">답글쓰기</a><br>
       <form:form modelAttribute="board" action="c_reply.do" method="post">
          <input type="hidden" name="id" value="de0218">
         <input type="hidden" name="b_seq" value="${board.seq}">
         <input type="hidden" name="c_seq" value="${comment2.c_seq}">
         <div class="${comment2.c_seq}7" style="display: none;margin-left: 50px;height: 110px;width: 100%"><br>
            <textarea class="form-control" name="c_content" style="width: 600px;height: 70px;resize: none;display: inline;"></textarea>
            <button type="submit" style="height: 70px;width:70px;margin-bottom: 60px;" class="btn btn-default">등록</button>
         </div>
      </form:form>
<script type="text/javascript">
$(function (){
   $("#${comment2.c_seq}6").click(function (){
      $(".${comment2.c_seq}7").toggle(); 
      }); 
   });
</script>
 -->
</div>
</div>
<br>
</c:if>
</c:forEach>
</c:forEach>
<!-- 댓글 수정 end -->
<!-- 댓글 리스트 end -->

<!-- 댓글 작성 -->
<c:if test="${!empty sessionScope.login.nickname}">
<c:if test="${board.btype!=0}">
<form:form modelAttribute="comment" id = "SendComment" action="c_write.do" method="post">
   <input type="hidden" name="b_seq" value="${board.seq}">
   <input type="hidden" name="btype" value="${board.btype}">
   <input type="hidden" name="id" value="${sessionScope.login.id}">
   <div id="recomment">
   <div style="margin: 12px 0 29px;padding-top: 16px;float: left;width: 89%">
      <em style="display: block;margin-bottom: 10px;font-weight: 700;font-size: 13px;font-style: normal;">${sessionScope.login.nickname}</em>
      <textarea class="autosize form-control" name="c_content" id = "CommentText" onkeydown="resize(this)" onkeyup="resize(this)" placeholder="댓글을 남겨보세요" style="height: 118px;resize: none;min-height: 108px"></textarea> 
   </div>
   <div style="float: right;width: 10%; height: 118px">
      <input type="submit" class="form-control" value="등록" id = "CommentSubmit" style="height: 118px;margin-top: 57px;">
   </div>
   </div>
</form:form>
</c:if>
</c:if>
<!-- 댓글 작성 end -->
</div>
<!-- 댓글 알림 -->
<script>
	$("#SendComment").submit(function(){
		var sentid = "${login.id}";
		var recvid = "${board.id}";
		var title = "님이 게시물에 댓글을 남겼습니다.";
		var content = $("#CommentText").val();
		var href = "${path}/board/info.do?seq=${board.seq}&btype=${board.btype}";
		var today = new Date();
	
		if(sentid == recvid){
			return;
		}
		
		var CommentParam = {
			"a_sent_id" : sentid,
			"a_recv_id" : recvid,
			"a_title" : title,
			"a_content" : content,
			"a_href" : href,
			"a_date" : today
		}
		$.ajax({
			type : "POST",
			url : "${path}/alarm/saveAlarm.do",
			data : JSON.stringify(CommentParam),
			contentType : 'application/json; charset = UTF-8',
			async : false,
			success : function(data) {
				let Message = "1" + "," + sentid + "," + recvid + "," + content + "," + today;
				ws.send(Message);
			}
		})
	})
</script>
</c:if>
<!-- 신고 5 누적 게시글 -->
<c:if test="${board.reportcnt>4}">
<div class="container" style="border : 1px solid #ebecef;border-radius: 6px; width: 1170px;height: 500px; padding: 29px 29px 0;margin-bottom: 60px;">
   <c:if test="${board.btype==0}">
      <a href="list.do?btype=0" style="color: #03c75a;text-decoration: none">공지사항 <i class="fas fa-angle-right"></i></a>
   </c:if>
      <c:if test="${board.btype==1}">
      <a href="list.do?btype=1" style="color: #03c75a;text-decoration: none">자유게시판 <i class="fas fa-angle-right"></i></a>
   </c:if>
      <c:if test="${board.btype==2}">
      <a href="list.do?btype=2" style="color: #03c75a;text-decoration: none">건의게시판 <i class="fas fa-angle-right"></i></a>
   </c:if>
   <h1>${board.subject}</h1>
   <div style="text-align: center;color: #757575;margin-top: 150px;">
      <p><span class="glyphicon glyphicon-lock"></span>&nbsp;&nbsp;신고가 누적된 글입니다.</p>
      <strong style="color : #008bcc">관리자에게 문의하여 주세요.</strong>
   </div><br><br><br>
</div>
</c:if>
<!-- 하단 버튼 -->
<div class="container" style="width: 1170px;height: 50px;margin-top: 20px">
<c:if test="${!empty sessionScope.login.nickname}">
<c:if test="${board.btype!=0}">
<div style="float: left">
   <a href="write.do" class="btn btn-success"><i class="fas fa-pencil-alt"></i>_ 글쓰기</a>
</div>
</c:if>
<div style="float: left">
<c:if test="${board.nickname==sessionScope.login.nickname}">
   <a href="update.do?seq=${board.seq}" class="btn btn-info" style="margin-left: 10px;">수정</a>
</c:if>
</div>
<c:if test="${board.nickname==sessionScope.login.nickname}">
<div style="float: left">
   <form:form modelAttribute="board" action="delete.do" method="post" name="d">
   <input type="hidden" name="seq" value="${board.seq}">
      <a href="javascript:removeCheck()" class="btn btn-info" style="margin-left: 10px;">삭제</a>
   </form:form>
</div>
</c:if>
</c:if>
   <a class="btn btn-info w3-right" style="margin-left: 10px;cursor: pointer;"onclick="window.scrollTo(0,0);"><i class="fas fa-chevron-up"></i> TOP</a>
   <a href="list.do?btype=${board.btype}" class="btn btn-info w3-right">목록</a>
</div>

<!-- 게시물 신고 -->
<form:form modelAttribute="board" action="report.do" method="post" name="r">
<input type="hidden" name="b_seq" value="${board.seq}">
<input type="hidden" name="btype" value="${board.btype}">
<input type="hidden" name="id" value="${sessionScope.login.id}">
<div class="modal fade" id="report" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
         <h4 class="modal-title w3-left" id="myModalLabel" style="text-align: left;">신고하기</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close" ><span aria-hidden="true">×</span></button>
      </div>
      <div class="modal-body">
        <p>신고 제목</p>
        <textarea class="form-control" name="reportsubject" style="width: 100%;height: 40px;resize: none;display: inline;"></textarea><br><br>
        <p>신고 내용</p>
        <textarea class="form-control" name="reportcontent"style="width: 100%;height: 200px;resize: none;display: inline;"></textarea><br>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
        <button type="submit" id = "BoardSubmit"class="btn btn-danger">신고하기</button>
      </div>
    </div>
  </div>
</div>
</form:form>
<!-- 게시물 신고 알림 -->
<script>
$("#BoardSubmit").on("click",function(){
	var sentid = "${login.id}";
	var recvid = "${board.id}";
	var title = "님이 해당 게시물을 신고했습니다.";
	var content = "${board.subject}"; //신고 당한 게시물 제목
	var href = "${path}/board/info.do?seq=${board.seq}&btype=${board.btype}";
	var today = new Date();

	var BoardReportParam = {
		"a_sent_id" : sentid,
		"a_recv_id" : recvid,
		"a_title" : title,
		"a_content" : content,
		"a_href" : href,
		"a_date" : today
	}
	if(sentid == recvid){
		return;
	}
	$.ajax({
		type : "POST",
		url : "${path}/alarm/saveAlarm.do",
		data : JSON.stringify(BoardReportParam),
		contentType : 'application/json; charset = UTF-8',
		async : false,
		success : function(data) {
			let Message = "2" + "," + sentid + "," + recvid + "," + content + "," + today;
			ws.send(Message);
		}
	})
})
</script>
<script type="text/javascript">
$(".boardreportbtn").on( "click", function() {
    $("#report").modal();
});
</script>

</body>
</html>