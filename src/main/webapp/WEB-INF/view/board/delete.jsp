<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 삭제</title>
<script>
function removeCheck() {
	 if (confirm("게시글을 삭제하시겠습니까?") == true){    //확인
	     document.removefrm.submit();
	 }else{   //취소
	     return false;
	 }
	}
</script>
</head>
<body>

</body>
</html>