<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 이름과 email을 입력받는 form -->
이름과 회원가입시 사용했던 이메일을 입력해주세요
<form action="doFindId.jsp" method="post">
<input type="text" name="name" placeholder="name">
<input type="text" name="email" placeholder="Email@hs.ac.kr">
<input type="submit" value="완료">
</form>
</body>
</html>