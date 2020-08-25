<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function openIDE(){
		window.open("ide\\IDE.jsp");// editor 열기
	}
	function go(url){
		location.href=url;
	}
</script>
</head>
<body>
<h2>메인화면</h2>
<%
request.setCharacterEncoding("utf-8");
if(session.getAttribute("id")==null){// 세션이 없을경우에만 loginform 과 회원가입 생성
 %>
	<input type="submit" value="회원가입 하러가기" onclick="go('join\\join.jsp')" />
	<input type="button" value="아이디 찾기" onclick="go('findIdPw\\findId.jsp')" />
	<input type="button" value="비밀번호 찾기" onclick="go('findIdPw\\findPw.jsp')" />
	
<form method="post" action="doLogin.jsp">
	<label for="id">아이디</label>
	<input  type="text" name="id" id="id" placeholder="id" required />
	<label for="pass">비밀번호</label>
	<input type="password" name="pw" id="pw" placeholder="pw" required />
	<input type="submit" value="로그인" />
</form>
<%} 
else {%>
	<input type="button" value="logout" onclick ="go('logout.jsp')" > <!-- 로그인이 되어있다면 로그아웃과 editor창 생성 -->
	<input type="button" value="IDE 열기" onclick ="openIDE()" > <!-- editor 오픈버튼 -->
	<input type="button" value="회원정보 수정" onclick="go('userInfo\\pwCheckForModify.jsp')" >
	<input type="button" value="게시판" onclick ="go('bulletinBoard\\bulletinBoard.jsp')" >
	<input type="button" value="알고리즘" onclick="go('algorithm\\algorithm.jsp')">
	<input type="button" value="문의하기" onclick="go('inquiry\\inquiry.jsp')">
<% 
	if("master".equals( (String)session.getAttribute("authority")) ){%>
		<input type ="button" value="문의보기" onclick="go('inquiry\\inquiryMasterMode.jsp')">
	<%}%>
<% } %>

</body>
</html>