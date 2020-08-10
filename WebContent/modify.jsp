<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	memberVO vo= new memberVO();
	memberDAO dao = new memberDAO();
	vo.setId((String) session.getAttribute("id"));
	vo.setPw((String) request.getParameter("pw"));
	
	int loginResult = dao.dologin(vo);

	if(loginResult == 0){
		%>
		out.println("<script>alert('비밀번호가 틀렸습니다.'); history.back();</script>");
	<% }
	else{
		
	}
%>
</body>
</html>