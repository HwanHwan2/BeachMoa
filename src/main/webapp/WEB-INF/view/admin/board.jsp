<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<style type="text/css">
   page-title::first-letter {
    font-size: 3.6rem;
    border-bottom: 4px solid #3EA6DD;
}

</style>
<script>
   function listdo(page){
      document.searchform.pageNum.value=page;
      document.searchform.submit();
   }
</script>
</head>
<body>
<div class="container">
<c:if test="${btype==0}">
<div class="page-title io-fn-getScope container" style="font-size: 3rem;font-weight: bold;margin-bottom: 2.5rem;text-align: center;margin-top: 50px">공지사항</div>
</c:if>
<c:if test="${btype==1}">
<div class="page-title io-fn-getScope container" style="font-size: 3rem;font-weight: bold;margin-bottom: 2.5rem;text-align: center;margin-top: 50px">자유게시판</div>
</c:if>
<c:if test="${btype==2}">
<div class="page-title io-fn-getScope container" style="font-size: 3rem;font-weight: bold;margin-bottom: 2.5rem;text-align: center;margin-top: 50px">건의게시판</div>
</c:if>
<hr style="border-color: black">   
<!-- 게시글 출력 --> 
   <table class="table table-hover">
      <tr style="height: 49px; background-color: #F8FBFF">
         <th style="width: 50px">No.</th>
         <th style="width: 788px">제목</th>
         <th style="width: 120px">작성자</th>
         <th style="width: 150px">작성일</th>
         <th style="width: 80px">조회</th>
      </tr>
      <c:if test="${btype==0}">
      <c:forEach var="board" items="${boardlist}">
      <tr style="height: 49px">
      <c:set var="boardno" value="${boardno-1}"/>
         <td>${boardno}</td>
         <td><a href="${path}/board/info.do?seq=${board.seq}&btype=0" style="color: #333333;float: left">${board.subject}&nbsp;&nbsp;</a>
         </td>
         <td>${board.nickname}</td>
         <td><fmt:formatDate value="${board.regdate}" pattern="yyyyMMdd" var="rdate"/>
               <c:if test="${today == rdate}">
                  <fmt:formatDate value="${board.regdate}" pattern="HH:mm"/>
               </c:if>
               <c:if test="${today != rdate}">
                  <fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd."/>
               </c:if>
         </td>
         <td>${board.readcnt}</td>
      </tr>
      </c:forEach>
      </c:if>
      <c:if test="${btype==1}">
      <c:forEach var="board" items="${boardlist}">
      <tr style="height: 49px">
      <c:set var="boardno" value="${boardno-1}"/>
         <td>${boardno}</td>
         <td><a href="${path}/board/info.do?seq=${board.seq}&btype=1" style="color: #333333;float: left">${board.subject}&nbsp;&nbsp;</a>
            <c:if test="${board.commcnt != 0}"><a href="info.do?seq=${board.seq}&btype=1" style="color: red;float: left">[${board.commcnt}]</a></c:if>
         </td>
         <td>${board.nickname}</td>
         <td><fmt:formatDate value="${board.regdate}" pattern="yyyyMMdd" var="rdate"/>
               <c:if test="${today == rdate}">
                  <fmt:formatDate value="${board.regdate}" pattern="HH:mm"/>
               </c:if>
               <c:if test="${today != rdate}">
                  <fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd."/>
               </c:if>
         </td>
         <td>${board.readcnt}</td>
      </tr>
      </c:forEach>
      </c:if>
      <c:if test="${btype==2}">
      <c:forEach var="board" items="${boardlist}">
      <tr style="height: 49px">
      <c:set var="boardno" value="${boardno-1}"/>
         <td>${boardno}</td>
         <td><a href="${path}/board/proposed.do?seq=${board.seq}&btype=2" style="color: #333333;float: left">${board.subject}&nbsp;&nbsp;</a>
            <span class="glyphicon glyphicon-lock"></span>&nbsp;&nbsp;
         </td>
         <td>${board.nickname}</td>
         <td><fmt:formatDate value="${board.regdate}" pattern="yyyyMMdd" var="rdate"/>
               <c:if test="${today == rdate}">
                  <fmt:formatDate value="${board.regdate}" pattern="HH:mm"/>
               </c:if>
               <c:if test="${today != rdate}">
                  <fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd."/>
               </c:if>
         </td>
         <td>${board.readcnt}</td>
      </tr>
      </c:forEach>
      </c:if>
   </table>
     <!-- 페이징 부분 -->
   <div class="container" style="background-color: #f9f9f9   ; width: 1140px;height:100%;position:relative;">
    <ul class="pagination justify-content-center" style="margin-left: 450px;margin-top: 15px;margin-bottom: 15px;   ">
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
       <!-- 검색 부분 -->
    <div class="form-group" style="margin-bottom: 15px;margin-left: 300px">
    <form action="board.do" method="post" name="searchform" class="form-inline">
    <input type="hidden" name="pageNum" value="1">
    <c:if test="${btype==0}">
       <input type="hidden" name="btype" value="0">
    </c:if>
    <c:if test="${btype==1}">
       <input type="hidden" name="btype" value="1">
    </c:if>
    <c:if test="${btype==2}">
       <input type="hidden" name="btype" value="2">
    </c:if>
      <select class="form-control" name="searchtype" style="width:100px;">
      <option value="">선택</option>
      <option value="subject">제목만</option>
      <option value="nickname">글작성자</option>
      <option value="content">글내용</option>
      </select>
      <script>
         searchform.searchtype.value="${param.searchtype}";
      </script>
       <input type="text" class="form-control" placeholder="검색어를 입력해주세요." name="searchcontent" value="${param.searchcontent}" style="width:300px;">
       <input type="submit" class="btn btn-info" value="검색">
   </form>
   </div>
     </div>
</div>
</body>
</html>