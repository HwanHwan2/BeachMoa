<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>추천 해수욕장 목록</title>
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
  background-color: #aaa;
  width: 100%;
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
<h2>추천 해수욕장 리스트</h2>
<table class="w3-table w3-bordered" style="width: 1200px; margin:auto">
             <c:forEach items="${recomendbeachList}" var="beach">
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
</table>	
</div>
</body>
</html>