<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="member.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		memberVO vo = new memberVO();
	memberDAO dao = new memberDAO();
	vo.setId((String) session.getAttribute("id"));
	vo.setPw((String) request.getParameter("pw"));

	int loginResult = dao.dologin(vo);

	if (loginResult == 0) {
	%>
	out.println("<script>alert('비밀번호가 틀렸습니다.'); history.back();</script>");
	<%
		} else {
	vo = dao.getMemberVO(vo.getId());
	%>
	<form action="doModify.jsp" method="post">
	이름
	<input type="text" name ="name" value="<%=vo.getName()%>"><br>
	메일주소
	<input type="text" name="mail" value="<%=vo.getMail()%>"><br>
	자기소개
	<input type="text" name="info" value="<%=vo.getInfo()%>"><br>
	<input type="submit" value="정보 수정">
	</form>
	<%	}
	%>
</body>
</html>