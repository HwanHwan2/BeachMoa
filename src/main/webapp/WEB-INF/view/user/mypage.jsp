<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet" type="text/css">
<title>마이 페이지 : 비치모아</title>

<style type="text/css">
page-title::first-letter {
    font-size: 3.6rem;
    border-bottom: 4px solid #3EA6DD;
}

.select {
   background-color:#FFFFFF;
   height:55px;
   margin-top:5px;
   
}

.select>a{
   color: #ffffff;
   text-decoration: none;
   font-weight: bold;
}

.sub_select{
   font-color:green;
}
.sub_select>a{
   color:#ffffff;
   text-decoration: none;
   font-weight: bold;
}

.form-control{
   width:300px;
}
</style>
</head>
<body>

<div class="w3-content " style="max-width:1500px; height:900px;">
<!--  side bar -->
<div class="w3-container w3-cell" style="width:300px; height:700px; background-color: rgb(214, 240, 255); vertical-align: top; text-align: center">
  <div id="tab_myinfo" class="tab">
        <p><a href="javascript:disp_div('myinfo','tab_myinfo')" class="w3-bar-item w3-button"
         style="font-weight: bold; text-align: center; width:300px; height:50px;  text-decoration:none;">내 정보</a></p>
  </div>
  <div id="tab_mymodify" class="tab">
        <p><a href="javascript:disp_div('mymodify','tab_mymodify')" class="w3-bar-item w3-button" 
        style="font-weight: bold; text-align: center; width:300px; height:50px; text-decoration:none;" >내 정보 수정</a></p>
  </div>
  <div id="tab_myactivity" class="tab">
        <p><a href="javascript:disp_div('myactivity','tab_myactivity')"class="w3-bar-item w3-button" 
        style="font-weight: bold; text-align: center; width:300px; height:50px; text-decoration:none;">나의 활동 정보</a></p>
  </div>
<!--   <p><a href="#" class="w3-bar-item w3-button" style="font-weight: bold; text-align: center; width:290px; height:75px">회원 탈퇴</a></p>
 -->
</div>
<div class="w3-container w3-cell" style="margin-left: 30px">
<!--  회원정보 -->
<div id="myinfo" class="info">
  <h1 style="font-weight: bold; " >마이 페이지<span style="color:rgb(214, 240, 255)"><i class="fa fa-star fa-2x"></i></span></h1>
  <table class="w3-table w3-bordered" style="width: 800px; border-style: dorder">
  <tr> </tr>
    <tr style="width: 60px; height: 50px">
      <th style="width: 100px">아이디</th>
      <td>${user.id}</td>
    </tr>
            <tr style="height: 50px">
      <th>이름</th>
      <td>${user.name}</td>
    </tr>
    <tr style="height: 50px">
      <th>별명</th>
      <td>${user.nickname}</td>
    </tr>
        <tr style="height: 50px">
      <th>성별</th>
      <td>
      <c:choose>
         <c:when test="${user.gender=='null'}">
            정보 없음
         </c:when>
         <c:otherwise>
             ${user.gender}
         </c:otherwise>
      </c:choose>
     
      </td>
    </tr>
        <tr style="height: 50px">
      <th>연령대</th>
      <td>
         <c:choose>
         <c:when test="${user.age_range=='0'}">
            정보 없음
         </c:when>
         <c:otherwise>
             ${user.age_range}대
         </c:otherwise>
      </c:choose>
      </td>
          <tr style="height: 50px">
      <th>이메일</th>
      <td>${user.email}</td>
    </tr>
  </table>
</div>


<!-- 회원 정보 수정 -->
<div id="mymodify" class="info">
<form:form modelAttribute="user" method="post" name="u"  action="update.do" onsubmit="return validchk();">
  <h1 style="font-weight: bold; " >정보 수정<span style="color:rgb(214, 240, 255)"><i class="fa fa-star fa-2x"></i></span></h1>
  <table class="w3-table w3-bordered" style="width: 800px">
  <tr> </tr>
    <tr style="width: 60px; height: 50px">
      <th style="width: 100px">아이디</th>
      <td>${user.id}</td>
    </tr>
        <tr style="height: 50px">  
      <th>비밀번호</th>
      <td><button id="pwbtn" type="button" class="btn btn-primary" data-toggle="modal" data-target="#pwmodal">비밀번호 변경</button>
</td>
    </tr>
        <tr style="height: 50px">
      <th>이름</th>
      <td><input class="form-control" id="name" type="text" value="${user.name}" readonly="readonly"/></td>
    </tr>
       <tr style="height: 50px">
      <th>별명</th>
      <td><input class="form-control" id="nickname" name="nickname" type="text" value="${user.nickname}" />
      <div class="check_font" id="nickname_check"></div></td>
    </tr>
        <tr style="height: 50px">
      <th>성별</th>
      <td><input class="form-control" id="name" type="text" value="${user.gender}" readonly="readonly"/></td>
    </tr>
        <tr style="height: 50px">
      <th>연령대</th>
      <td><input class="form-control" id="name" type="text" value="${user.age_range}" readonly="readonly"/></td>
          <tr style="height: 50px">
      <th>이메일</th>
      <td><input id="email" class="form-control" type="text" value="${user.email}" readonly="readonly"/></td>
    </tr>

  </table>
  <br><br>
  <div style="align-items: center; text-align: center">
  <button class="w3-button w3-gray w3-round-large" style="width:300px" type="submit">정보 수정</button>
  </div>
     </form:form>
<!-- modal 비밀번호 변경  -->
<div class="modal fade" id= "pwmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content" style="background-color: white">
    <div class="modal-header">
    <h4 class="modal-title" id="myModalLabel" style="text-align: left; font-weight: bold">비밀번호 변경</h4>
    <button type="button" data-dismiss="modal" class="close" aria-label="Close"><span aria-hidden="true">&times;</span></button>
    </div>
    <form action="changepass.do" method="post" name="p" onsubmit="return validCheck();">
    <input type="hidden" id="id" value="${login.id}">
    <div class="modal-body">
         <div class="center-block">
         <div class="check_font" id="all_check"></div>
         </div>
          
          <div class="form-group">
            <label for="now_pw" class="control-label">현재 비밀번호:</label>
            <input type="password" class="form-control" id="now_pw" name="now_pw" style="width : 95%">
            <div class="check_font" id="now_pw_check"></div>
          </div>
          <div class="form-group">
            <label for="new_pw" class="control-label">새 비밀번호:</label>
            <input type="password" class="form-control" id="new_pw" name="new_pw" style="width : 95%">
            <div class="check_font" id="new_pw_check"></div>
          </div>
          <div class="form-group">
            <label for="check_new_pw" class="control-label">새 비밀번호 확인:</label>
            <input type="password" class="form-control" id="check_new_pw" name="check_new_pw" style="width : 95%">
             <div class="check_font" id="check_new_pw_check"></div>
          </div>
                 
          </div>  
     <div class="modal-footer">
        <button type="submit" class="btn btn-primary" >변경하기</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">돌아가기</button>
     </div>
      </form>
    </div>
  </div>
</div>

</div>

<!-- 나의 활동 정보  -->
<div id="myactivity" class="info">
  <h1 style="font-weight: bold;" >나의 활동<span style="color:rgb(214, 240, 255)"><i class="fa fa-star fa-2x"></i></span></h1>
   <c:if test="${listcount > 0}"> <%--등록된 게시물이 있음 --%></c:if>
  <span style="font-weight: bold; color: gray">총 게시글 수:<font color="#007BFF">${listcount}</font>건 </span>
  <span style="font-weight: bold; color: gray">˙ 총 리뷰 수:<font color="#007BFF">${reviewcount}</font>건 </span>  
  <span style="font-weight: bold; color: gray">˙ 총 댓글 수:<font color="#007BFF">${commentcount}</font>건</span>
  <!--  -->
  <div class="form-inline"> 
  <div id="tab_myboard" class="subtab">
        <p><a href="javascript:list_disp('myboard','tab_myboard')" class="w3-bar-item w3-button"
         style="font-weight: bold; text-align: center; width:290px; height:50px;  text-decoration:none;">작성글</a></p>
  </div>
  <div id="tab_myreview" class="subtab">
        <p><a href="javascript:list_disp('myreview','tab_myreview')" class="w3-bar-item w3-button" 
        style="font-weight: bold; text-align: center; width:290px; height:50px; text-decoration:none;" >작성 리뷰</a></p>
  </div>
  <div id="tab_mycomment" class="subtab">
        <p><a href="javascript:list_disp('mycomment','tab_mycomment')"class="w3-bar-item w3-button" 
        style="font-weight: bold; text-align: center; width:290px; height:50px; text-decoration:none;">작성 댓글</a></p>
  </div>
  </div>
<!-- 작성글 -->
<div id="myboard" class="list">
  <form action="boarddelete.do" name="b" method="post">
  <input type="hidden" name="type" value="board">
  <table class="table table-hover" style="width: 900px">
    <tr>
      <th colspan="4" style="width:40%; font-weight: bold; text-align: center">제목</th>
      <th style="width:10%; font-weight: bold; text-align: center">작성일</th>
      <th style="width:8%; font-weight: bold; text-align: center">조회수</th>  
    </tr>
    <c:choose>
    <c:when test="${empty myboardlist}">
    <tr>
    <th colspan="6" style="text-align:center">작성하신 게시글이 없습니다.</th>
    </tr>
    </c:when>
    <c:otherwise>
    <c:forEach items="${myboardlist}" var="board"> 
     <tr>
     <td style="text-align:center;"><input type="checkbox" class="board" name="boardchk" value="${board.seq}"></td>
     <td style="text-align: center">
  <c:choose>
<c:when test="${board.btype eq '1'}">자유게시판</c:when>
<c:when test="${board.btype eq '2'}">건의게시판</c:when>
<c:otherwise>공지사항</c:otherwise>
</c:choose>
</td>
   
     <td style="text-align: center">${board.seq}</td>
     <td style="text-align: center;width:25%">

     <a href="${path}/board/info.do?seq=${board.seq}&btype=${board.btype}" target="_blank" style="color: #333333;float: left">${board.subject}</a></td>
     <td><fmt:formatDate value="${board.regdate}" pattern="yyyyMMdd" var="rdate"/>
           <c:if test="${today == rdate}">
                  <fmt:formatDate value="${board.regdate}" pattern="HH:mm"/>
           </c:if>
           <c:if test="${today != rdate}">
                  <fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd."/>
           </c:if>
         </td>
     <td style="text-align: center">${board.readcnt}</td>
     </tr>
     </c:forEach>
     </c:otherwise>
     </c:choose>
  </table>
  <div class="form-group">
  <input type="checkbox" onchange="b_allchk(this)">전체선택
  <div style="text-align:right">
  <input class="btn btn-primary" type="button" onclick="return boardinputchk()" value="삭제" >
  </div>
  </div>
  </form>
  <c:if test="${!empty myboardlist}">
      <!-- 페이징 부분 -->
   <div class="container" style="background-color: #f9f9f9   ; width: auto;height:100%;position:relative;">
    <ul class="pagination justify-content-center" style="margin-top: 15px;margin-bottom: 15px;   ">
          <li><a href="javascript:boardpage(${startpage})"><<</a></li>
        <c:if test="${pageNum <=1}">
           <li><a href="javascript:boardpage(${pageNum})"><</a></li>
        </c:if>
        <c:if test="${pageNum > 1}">
           <li><a href="javascript:boardpage(${pageNum-1})"><</a></li>
         </c:if>
      
        <c:forEach var="a" begin="${startpage}" end="${endpage}">
            <li><a href="javascript:boardpage(${a})">${a}</a></li>
         </c:forEach>
           
        <c:if test="${pageNum >= maxpage}">   
           <li><a href="javascript:boardpage(${pageNum})">></a></li>
        </c:if>
        <c:if test="${pageNum < maxpage}">
            <li><a href="javascript:boardpage(${pageNum+1})">></a></li>
        </c:if>
        <li><a href="javascript:boardpage(${endpage})">>></a></li>
    </ul><hr style="margin-top: 5px;margin-bottom: 15px">

</div>
</c:if>
</div>
<!-- 작성 게시글 페이징 부분 -->
<form action="mypage.do" method="post" name="boardform" class="form-inline">
<input type="hidden" name="pageNum" value="1">
<input type="hidden" name="type" value="board">
<input type="hidden" name="tab" value="myactivity">
<input type="hidden" name="subtab" value="myboard">


</form>

<!-- 내가 작성한 리뷰글 -->
<div id="myreview" class="list">
 <form action="reviewdelete.do" name="r" method="post">
  <input type="hidden" name="type" value="board">
<table class="table table-hover" style="width: 900px">
    <tr>
      <th colspan="4" style="width:40%; font-weight: bold; text-align: center">제목</th>
      <th style="width:8%; font-weight: bold; text-align: center">작성일</th>  
      <th style="width:10%; font-weight: bold; text-align: center">추천수</th>
    </tr>
    <c:choose>
    <c:when test="${empty myreviewlist}">
    <tr>
    <th colspan="6" style="text-align:center">작성하신 리뷰가 없습니다.</th>
    </tr>
    </c:when>
    <c:otherwise>
    <c:forEach items="${myreviewlist}" var="review"> 
     <tr>
     <td style="text-align:center;"><input type="checkbox"  class="review" name="reviewchk" value="${review.r_seq}"></td>
   <td style="text-align:left;">${review.beachNm}</td>   
     <td colspan="2"style="text-align: center;width:25%">
     <a href="${path}/beach/detail.do?beachno=${review.beachno}" target="_blank" style="color: #333333;float:left">${review.subject}</a></td>
     <td><fmt:formatDate value="${review.regdate}" pattern="yyyyMMdd" var="rdate"/>
           <c:if test="${today == rdate}">
                  <fmt:formatDate value="${review.regdate}" pattern="HH:mm"/>
           </c:if>
           <c:if test="${today != rdate}">
                  <fmt:formatDate value="${review.regdate}" pattern="yyyy-MM-dd."/>
           </c:if>
    </td>
    <td style="text-align:center">
       ${review.recomcnt}
    </td>
     </tr>
     </c:forEach>
     </c:otherwise>
     </c:choose>
  </table>
  <div class="form-group">
  <input type="checkbox" onchange="r_allchk(this)">전체선택
  <div style="text-align:right">
  <input class="btn btn-primary" type="button" onclick="return reviewinputchk()" value="삭제" >
  </div>
  </div>
  </form>
    <c:if test="${!empty myreviewlist}">
      <!-- 페이징 부분 -->
   <div class="container" style="background-color: #f9f9f9   ; width: auto;height:100%;position:relative;">
    <ul class="pagination justify-content-center" style="margin-top: 15px;margin-bottom: 15px;   ">
          <li><a href="javascript:boardpage(${startpage})"><<</a></li>
        <c:if test="${pageNum <=1}">
           <li><a href="javascript:boardpage(${pageNum})"><</a></li>
        </c:if>
        <c:if test="${pageNum > 1}">
           <li><a href="javascript:boardpage(${pageNum-1})"><</a></li>
         </c:if>
      
        <c:forEach var="a" begin="${startpage}" end="${endpage}">
            <li><a href="javascript:boardpage(${a})">${a}</a></li>
         </c:forEach>
           
        <c:if test="${pageNum >= maxpage}">   
           <li><a href="javascript:boardpage(${pageNum})">></a></li>
        </c:if>
        <c:if test="${pageNum < maxpage}">
            <li><a href="javascript:boardpage(${pageNum+1})">></a></li>
        </c:if>
        <li><a href="javascript:boardpage(${endpage})">>></a></li>
    </ul><hr style="margin-top: 5px;margin-bottom: 15px">

</div>
</c:if>
</div>
<!--  -->

<!-- 내가 작성한 댓글  -->
<div id="mycomment" class="list">
 <form action="commentdelete.do" name="c" method="post">
  <input type="hidden" name="type" value="board">
<table class="table table-hover" style="width: 900px">
    <tr>
      <th colspan="4" style="width:40%; font-weight: bold; text-align: center">내용</th>
      <th style="width:8%; font-weight: bold; text-align: center"></th>  
      <th style="width:10%; font-weight: bold; text-align: center">작성일</th>
    </tr>
    <c:choose>
    <c:when test="${empty mycommentlist}">
    <tr>
    <th colspan="6" style="text-align:center">작성하신 댓글이 없습니다.</th>
    </tr>
    </c:when>
    <c:otherwise>
    <c:forEach items="${mycommentlist}" var="comment"> 
     <tr>
     <td style="text-align:center;"><input type="checkbox" class="comment" name="commentchk" value="${comment.c_seq}"></td>
   <td colspan="3" style="text-align:left;">${comment.c_content}</td>   
     <td style="text-align: center;width:25%">
     <a href="${path}/board/info.do?seq=${comment.b_seq}&btype=${comment.btype}" target="_blank" style="color: #333333;float: left">원문보기▶</a></td>
     <td><fmt:formatDate value="${comment.c_regdate}" pattern="yyyyMMdd" var="rdate"/>
           <c:if test="${today == rdate}">
                  <fmt:formatDate value="${comment.c_regdate}" pattern="HH:mm"/>
           </c:if>
           <c:if test="${today != rdate}">
                  <fmt:formatDate value="${comment.c_regdate}" pattern="yyyy-MM-dd."/>
           </c:if>
    </td>
     </tr>
     </c:forEach>
     </c:otherwise>
     </c:choose>
  </table>
  <div class="form-group">
  <input type="checkbox" onchange="c_allchk(this)">전체선택
  <div style="text-align:right">
  <input class="btn btn-primary" type="button" onclick="return commentinputchk()" value="삭제" >
  </div>
  </div>
  </form>
    <c:if test="${!empty mycommentlist}">
      <!-- 페이징 부분 -->
   <div class="container" style="background-color: #f9f9f9   ; width: auto;height:100%;position:relative;">
    <ul class="pagination justify-content-center" style="margin-top: 15px;margin-bottom: 15px;   ">
          <li><a href="javascript:boardpage(${startpage})"><<</a></li>
        <c:if test="${pageNum <=1}">
           <li><a href="javascript:boardpage(${pageNum})"><</a></li>
        </c:if>
        <c:if test="${pageNum > 1}">
           <li><a href="javascript:boardpage(${pageNum-1})"><</a></li>
         </c:if>
      
        <c:forEach var="a" begin="${startpage}" end="${endpage}">
            <li><a href="javascript:boardpage(${a})">${a}</a></li>
         </c:forEach>
           
        <c:if test="${pageNum >= maxpage}">   
           <li><a href="javascript:boardpage(${pageNum})">></a></li>
        </c:if>
        <c:if test="${pageNum < maxpage}">
            <li><a href="javascript:boardpage(${pageNum+1})">></a></li>
        </c:if>
        <li><a href="javascript:boardpage(${endpage})">>></a></li>
    </ul><hr style="margin-top: 5px;margin-bottom: 15px">

</div>
</c:if>
</div>
<!-- 내가 작성한 댓글 페이징부분 -->
 <form action="mypage.do" method="post" name="commentform" class="form-inline">
   <input type="hidden" name="pageNum" value="1">
   <input type="hidden" name="type" value="comment">
   <input type="hidden" name="tab" value="myactivity">
   <input type="hidden" name="subtab" value="mycomment">   
</form>
<!--  -->



</div>


</div>
</div>
<script type="text/javascript">
/* 
   function pwmodal_hide(){
      document.getElementById('pwmodal').style.display="none";
      //입력값 초기화 부분
      $('#now_pw').val("");
      $('#new_pw').val("");
      $('#check_new_pw').val("");
      $('#now_pw_check').text("");
      $('#new_pw_check').text("");
      $('#_new_pw_check').text("");
      
   }
 */   
 
/**/
  function validchk(){
    const nickname = u.nickname.value;
    if(nickname == ""){
       $('#nickname_check').text("변경을 위한 필수 입력정보입니다.")
       u.nickname.focus();
       return false;
    }
    if(nickname == '${user.nickname}'){
       u.nickname.focus();
       return false; 
    }
 }
 
/* 게시글 삭제  */ 

   function boardinputchk(){
      if($('input[name=boardchk]').is(":checked")==false){
         alert("선택된 게시글이 없습니다.")
         return false;
      }else{
      var chk = confirm("정말로 삭제하시겠습니까?")
      if(chk){
         b.submit();
      }   
      else{
         return false;
         }
      }
   }
   
   function commentinputchk(){
      if($('input[name=commentchk]').is(":checked")==false){
         alert("선택된 댓글이 없습니다.")
         return false;
      }else{
      var chk = confirm("정말로 삭제하시겠습니까?")
      if(chk){
         c.submit();
      }   
      else{
         return false;
         }
      }
   }
   
   function reviewinputchk(){
      if($('input[name=reviewchk]').is(":checked")==false){
         alert("선택된 리뷰가 없습니다.")
         return false;
      }else{
      var chk = confirm("정말로 삭제하시겠습니까?")
      if(chk){
         r.submit();
      }   
      else{
         return false;
         }
      }
   }
   
//닉네임
 $("#nickname").blur(function(){
    var nickReg = /^[가-힣a-zA-Z0-9]{2,8}$/
    var nickname = $('#nickname').val();
    if(nickname == '${user.nickname}'){
       $("#nickname_check").text("회원님의 현재 닉네임입니다.")
       return false;
    }
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
                $("#nickname_check").text("변경을 위한 필수 입력정보입니다.")
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
 function boardpage(page){
       document.boardform.pageNum.value=page;
       document.boardform.submit();
    }
   /* 전체선택  */
   function b_allchk(chk){
      $(".board").prop("checked",chk.checked)
   }
   function c_allchk(chk){
      $(".comment").prop("checked",chk.checked)
   }
   function r_allchk(chk){
      $(".review").prop("checked",chk.checked)
   }


   $(document).ready(function(){
      $(".info").hide();
      $(".list").hide();
      $("#myinfo").show();
      $("#myboard").show();
      
      $("#tab_myinfo").addClass("select");
   })
   
   function disp_div(id, tab){   
      $(".info").each(function(){
         $(this).hide();
      })
      $(".tab").each(function(){
         $(this).removeClass("select");
      })
      $("#" + id).show();
      $("#" + tab).addClass("select");
   }
   
   function list_disp(id, tab){
      $(".list").each(function(){
         $(this).hide();
      })
      $(".subtab").each(function(){
         $(this).removeClass("sub_select");
      })
      $("#" + id).show();
      $("#" + tab).addClass("sub_select");
   }
   
   /* 회원정보 수정  */
   function validCheck(){
      var pass = $('#now_pw').val();
      var newpass = $('#new_pw').val();
      var chknewpass = $('#check_new_pw').val(); 
      if(chknewpass==""){
            $("#check_new_pw_check").text("필수 입력정보입니다.")
            $("#check_new_pw").focus()
      }
      if(newpass==""){
            $("#new_pw_check").text("필수 입력정보입니다.")
            $("#new_pw").focus()
      }      
      if(pass=="" || newpass=="" || chknewpass==""){
         if(pass==""){
            $("#now_pw_check").text("필수 입력정보입니다.")
            $("#now_pw").focus()
      }
         return false;
      }
      if(chknewpass != newpass){
         $("#check_new_pw_check").text("새 비밀번호와 재확인 비밀번호가 일치하지 않습니다.")
         return false;
      }
      
      p.submit();
   }
   //비밀번호 유효성 검증.
   $("#now_pw").blur(function(){
      //비밀번호 유효성 나중에 추가하기
      //var passReg = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]).{8,16}$/;
      var pass = $('#now_pw').val();
      var id = $('#id').val();
      if(pass==""){
         $("#now_pw_check").text("필수 입력정보입니다.")
         return false;
         }
      else if(pass.length < 8){
         $("#now_pw").val("")
         $("#now_pw_check").text("비밀번호는 8자에서 12자만 가능합니다.")
         return false;
      }else{
         $("#now_pw_check").text("")
      }
      
      $.ajax({
         url : '${path}/user/passCheck.do?id='+id+'&nowpswd='+pass,
         type : 'get',
         success : function(data){
            console.log(data)
            if(data==1){
               $('#now_pw_check').text("비밀번호가 일치합니다.")
               $('#now_pw_check').css("color","green");
            }else{
               $('#now_pw').val("");
               $('#now_pw_check').text("비밀번호가 일치하지 않습니다.")
               $('#now_pw_check').css("color","red");
            }
         }
      })
      
   })
      //새로운 비밀번호 재입력 유효성 검증.
   $("#new_pw").blur(function(){
      //비밀번호 유효성 나중에 추가하기
      //var passReg = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]).{8,16}$/;
      var newpass = $('#new_pw').val();
      if(newpass==""){
         $("#new_pw_check").text("필수 입력정보입니다.")
         $("#new_pw").focus();
         return false;
      }else if(newpass.length < 8){
         $("#new_pw").val("")
         $("#new_pw_check").text("비밀번호는 8자에서 12자만 가능합니다.")
      }else{
         $("#new_pw_check").text("")
      }
   })
   
   //새로운 비밀번호 재입력 유효성 검증.
   $("#check_new_pw").blur(function(){
      //비밀번호 유효성 나중에 추가하기
      //var passReg = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]).{8,16}$/;
      var newpass = $('#new_pw').val();
      var chknewpass = $('#check_new_pw').val();
      if(newpass==""){
         $("#new_pw_check").text("새 비밀번호를 먼저 입력해주세요")
         $("#check_new_pw").val("")
         $("#new_pw").focus();
         return false;
      }else{
         $("#new_pw_check").text("")
      }
      if(chknewpass==""){
         $("#check_new_pw_check").text("필수 입력정보입니다.")
         $("#check_new_pw").focus();
      }else if(chknewpass.length < 8){
         $("#check_new_pw").val("")
         $("#check_new_pw_check").text("비밀번호는 8자에서 12자만 가능합니다.")
      }else{
         $("#check_new_pw_check").text("")
      }
   })
</script>
</body>
</html>
