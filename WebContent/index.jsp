<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function logOut(){
		location.href="logout.jsp";//로그아웃 jsp로 이동해서 세션 삭제
	}
	function openIDE(){
		window.open("IDE.jsp");// editor 열기
	}
	function modify(){
		location.href="pwCheckForModify.jsp"; // modify.jsp로 이동
	}
</script>
</head>
<body>
<h2>메인화면</h2>
<%
request.setCharacterEncoding("utf-8");
if(session.getAttribute("id")==null){// 세션이 없을경우에만 loginform 과 회원가입 생성
 %>
<form method="post" action="join.jsp">
	<input type="submit" value="회원가입 하러가기" />`
</form>

<form method="post" action="doLogin.jsp">
	<label for="id">아이디</label>
	<input  type="text" name="id" id="id" placeholder="id" required />
	<label for="pass">비밀번호</label>
	<input type="password" name="pw" id="pw" placeholder="pw" required />
	<input type="submit" value="로그인" />
</form>
<%} 
else {%>
	<input type="button" value="logout" onclick ="logOut()" > <!-- 로그인이 되어있다면 로그아웃과 editor창 생성 -->
	<input type="button" value="IDE 열기" onclick ="openIDE()" > <!-- editor 오픈버튼 -->
	<input type="button" value="회원정보 수정" onclick="modify()" >
<% } %>

</body>
</html>