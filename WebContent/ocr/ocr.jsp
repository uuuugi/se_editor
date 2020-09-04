<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
* {
	color: white;
}

.button1 {
	color: black;
}
</style>
</head>
<body>
	<form method="post" enctype="multipart/form-data"
		action="uploadFile.jsp">
		<p>
			<input type="file" name="filename"> <br> (2MB를 넘을 수 없음)
		</p>
		<p>
			<input class="button1" type="submit" value="전송">
		</p>
	</form>
</body>
</html>