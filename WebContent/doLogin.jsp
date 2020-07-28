<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% request.setCharacterEncoding("utf-8"); %>
	<%
	memberVO vo = new memberVO();
	memberDAO dao = new memberDAO();
	int loginResult;
	
	String id=request.getParameter("id");
	String pw=request.getParameter("pw");
	
	System.out.println(id + "  " + pw);
	vo.setId(id);
	vo.setPw(pw);

	loginResult = dao.dologin(vo);
	
	if(loginResult==1){
		session.setAttribute("id", vo.getId());
		response.sendRedirect("index.jsp");
	}else if(loginResult==0){
		out.println("<script>alert('비밀번호가 틀렸습니다.'); history.back();</script>");
	}else{
		out.println("<script>alert('아이디가 틀렸습니다.'); history.back();</script>");
	}
%>
</body>
</html>