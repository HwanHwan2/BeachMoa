<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>해수욕장 목록</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet" type="text/css">
<style>
* {
  width : 1000px;
}

/* Fake image */
.fakeimg {
  padding: 20px;
}

/* Add a card effect for articles */
.card {
   background-color: white;
   padding: 20px;
   margin-top: 20px;
   width: 350px;
}
/* Clear floats after the columns */
</style>
</head>
<body>
<div class="w3-content " style="max-width:1500px; text-align: center">
<table class="w3-table w3-bordered" style="width: 1200px; margin:auto">
  <tr><td colspan="5">
    <div style="display :block; margin-left: 18%;">
      <form action="list.do" method="post" name="searchform">
         <input type="hidden" name="pageNum" value="1">
        <select name="searchtype" style="width:150px;">
         <option value="">지역을 선택하세요</option>
         <option value="강원">강원</option>
         <option value="경기">경기</option>
         <option value="경남">경남</option>
         <option value="경북">경북</option>
         <option value="부산">부산</option>
         <option value="울산">울산</option>
         <option value="인천">인천</option>
         <option value="전남">전남</option>
         <option value="전북">전북</option>
         <option value="제주">제주</option>
         <option value="충남">충남</option>
         </select>
         <select name="searchtype2" style="width:150px;">
         <option value="">주차장 여부</option>
         <option value="Y">있음</option>
         <option value="N">없음</option>
         </select>
         <select name="searchtype3" style="width:150px;">
         <option value="">야영지 여부</option>
         <option value="Y">가능</option>
         <option value="N">불가능</option>
         </select>
         <select name="searchtype4" style="width:150px;">
         <option value="">샤워실 여부</option>
         <option value="Y">있음</option>
         <option value="N">없음</option>
         </select>
             <script type="text/javascript">
             searchform.searchtype.value="${param.searchtype}";
             searchform.searchtype2.value="${param.searchtype2}";
             searchform.searchtype3.value="${param.searchtype3}";
             searchform.searchtype4.value="${param.searchtype4}";
         </script>
         
         <input type="submit" value="검색">
         <input type="button" value="초기화"
            onclick="location.href='list.do'" >
         <br>
      </form></div></td></tr>
 <c:if test="${listcount > 0}"> <%--등록된 게시물이 있음 --%>
             <c:forEach items="${beachList}" var="beach">
             <c:set var="boardno" value="${boardno - 1}" />
      <tr><td>
      <div style="margin-left: 10%">
    <div class="w3-container w3-cell" style="width: 500px;">
      <a href="detail.do?beachno=${beach.beachno}" style="font-weight: bold; font-size:18pt; width: 200px;">${beach.beachNm}</a>
      <input type="hidden" value="${beachno.sidoNm}">
      <h5> <c:choose>
    <c:when test="${beach.avgrating < 5.0 && beach.avgrating >=4.1}"> <!--  5.0점에서 4.1 사이는 전부 4개 반 -->
        <span style="color:rgb(214, 240, 255)"><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="fas fa-star-half-alt fa-2x"></i></span>
    </c:when>
    <c:when test="${beach.avgrating == 4.0}"> <!--  4.0이면 별 4개에 빈별 1개 -->
        <span style="color:rgb(214, 240, 255)"><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="far fa-star fa-2x"></i></span>
    </c:when>
     <c:when test="${beach.avgrating < 4.0 && beach.avgrating >=3.1}"> <!-- 3.9점에서 3.1점사이는 전부 3개 반 -->
        <span style="color:rgb(214, 240, 255)"><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="fas fa-star-half-alt fa-2x"></i><i class="far fa-star fa-2x"></i></span>
    </c:when>
    <c:when test="${beach.avgrating == 3.0}"> <!--  3.0이면 별 3개에 빈별 2개 -->
        <span style="color:rgb(214, 240, 255)"><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i></span>
    </c:when>
         <c:when test="${beach.avgrating < 3.0 && beach.avgrating >=2.1}"><!-- 2.9점에서 2.1점 사이는 2개풀  1개 반 2개 빈별 -->
        <span style="color:rgb(214, 240, 255)"><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="fas fa-star-half-alt fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i></span>
    </c:when>
    <c:when test="${beach.avgrating == 2.0}"> <!--  2.0이면 별 2개에 빈별 3개 -->
        <span style="color:rgb(214, 240, 255)"><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i></span>
    </c:when>
         <c:when test="${beach.avgrating < 2.0 && beach.avgrating >=1.1}"> <!--  1.9 부터 1.1 까지의 별 1개 반별 3개 빈별 -->
        <span style="color:rgb(214, 240, 255)"><i class="fas fa-star fa-2x"></i><i class="fas fa-star-half-alt fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i></span>
    </c:when>
     <c:when test="${beach.avgrating == 1.0}"> <!--  1.0이면 별 1개에 빈별 4개 -->
        <span style="color:rgb(214, 240, 255)"><i class="fas fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i></span>
    </c:when>
         <c:when test="${beach.avgrating < 1.0 && beach.avgrating >=0.1}">
        <span style="color:rgb(214, 240, 255)"><i class="fas fa-star-half-alt fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i></span>
    </c:when>
     <c:when test="${beach.avgrating == 0.0}"> <!--  0.0이면  빈별 5개 -->
        <span style="color:rgb(214, 240, 255)"><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i><i class="far fa-star fa-2x"></i></span>
    </c:when>
    <c:otherwise>
       <span style="color:rgb(214, 240, 255)"><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i><i class="fas fa-star fa-2x"></i></span>
    </c:otherwise>
</c:choose>
      <br>${beach.avgrating}</h5>
      <p>${beach.address}, ${beach.sidoNm}, ${beach.gugunNm}</p>
      <p>${beach.intro}</p>
      </div>
      <div class="w3-container w3-cell" style="height:200px; width: 400px;">
	<div style="height:100%; width: 100%;">
	<c:forEach items="${beachimglist}" var="beachimg">
	<c:if test="${beach.beachno == beachimg.beachno}">
	<img src="../img/beachimg/${beach.beachno}/${beachimg.fileurl}" style="height:200px;; width: 400px;"/>
	</c:if>
	</c:forEach>
  </div>
      </div>
    </div>
      </td>
      </tr>
</c:forEach>
<tr><td>
<div class="w3-center">
<div class="w3-bar w3-border w3-round" style="text-align: center;">
     <c:if test="${pageNum > 1}">
       <a class="w3-bar-item w3-button w3" href="javascript:listpage('${pageNum - 1}')">이전</a></c:if>
       <c:if test="${pageNum <= 1}"><a class="w3-bar-item w3-button w3">이전</a></c:if>
     <c:forEach var="a" begin="${startpage }" end="${endpage}">
         <c:if test="${a == pageNum}"><a class="w3-bar-item w3-button w3-green">${a}</a></c:if>
         <c:if test="${a != pageNum}">
         <a href="javascript:listpage('${a}')" class="w3-bar-item w3-button">${a}</a></c:if>
     </c:forEach>
     <c:if test="${pageNum < maxpage}">
       <a class="w3-bar-item w3-button w3" href="javascript:listpage('${pageNum + 1}')">다음</a></c:if>
     <c:if test="${pageNum >= maxpage}"><a class="w3-bar-item w3-button w3">다음</a></c:if></div></div>
   </c:if> <%-- 등록된 게시물이 있는 경우 끝 --%>
    <c:if test="${listcount == 0}"> <%-- 등록된 게시물이 없는 경우 --%>
</c:if></table>	
</div>
<script type="text/javascript">
function listpage(page) {
	document.searchform.pageNum.value=page;
	document.searchform.submit();
}

</script>
</body>
</html>