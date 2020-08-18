<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function goWrite(){
		location.href="write.jsp";
	}
</script>
</head>
<body>

<iframe name="list" src="bulletinBoardList.jsp" style="width:80vw; height:80vh"> </iframe>
<hr>
<input type="button" value="작성하기" onclick="goWrite()">
</body>
</html>