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
		request.setCharacterEncoding("utf-8");
 
	if (request.getAttribute("err") != null) {
		String err = (String) request.getAttribute("err");
		if ("pwMiss".equals(err)) {
			out.println("<script>alert('비밀번호가 틀렸습니다.'); location.href='LoginFormServlet';</script>");
		} else if ("idMiss".equals(err)) {
			out.println("<script>alert('아이디가 틀렸습니다.'); location.href='LoginFormServlet';</script>");
		}
	}
	else
		response.sendRedirect("./index.jsp"); 
	%>
</body>
</html>