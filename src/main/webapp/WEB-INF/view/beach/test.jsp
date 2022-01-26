<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%-- /WEB-INF/view/board/list.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>    
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>게시판 목록</title>
</head>
<body>
<h2>별점 표시하기</h2>
<div class="review">
	<div class="rating" data-rate="3">
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>	
	</div>
	<div class="rating" data-rate="5">
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>	
	</div>
	<div class="rating" data-rate="2">
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>	
	</div>		
</div>

<hr>
<h2>별점주기</h2>
<div class="make_star">
	<select name="" id="makeStar">
		<option value="1">1</option>
		<option value="2">2</option>
		<option value="3">3</option>
		<option value="4">4</option>
		<option value="5">5</option>
	</select>
	<div class="rating" data-rate="3">
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>	
	</div>
</div>

<script type="text/javascript">
$(function(){
	var rating = $('.review .rating');
	
	$('.make_star svg').click(function(){
		var targetNum = $(this).index() + 1;
		$('.make_star svg').css({color:'#ccc'});
		$('.make_star svg:nth-child(-n+' + targetNum + ')').css({color:'#FFD400'});
		$('#rating').val(targetNum);
		consloe.log(ratgetNum);
		return targetNum.value;
	})
});
</script>
</body></html>