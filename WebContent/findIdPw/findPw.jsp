<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- id와 email을 입력받아 mail을 전송하기 위한 form -->
<form action ="mailSend.jsp">
id를 입력하세요
<input type ="text" id ="id" name = "id" placeholder="id"> <br>
입력시 사용했던 email을 입력하세요
<input type ="text" id ="Email" name = "Email" placeholder="email@SE.com"><br>
<input type ="submit" value ="발송">
</form>

</body>
</html>