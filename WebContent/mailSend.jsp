<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mail.*" %>
<%@ page import="member.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	memberVO vo = new memberVO();
	vo.setId((String) request.getParameter("id"));
	vo.setMail((String) request.getParameter("Email"));
	
	memberDAO dao = new memberDAO();
	
	if(dao.checkIdnEmail(vo)==true)
		{
		mailSender.sendMail(vo);
		out.println("<script>alert('메일이 전송되었습니다.'); location.href='index.jsp'</script>");
		}
	else
		out.println("<script>alert('입력한 정보와 일치하는 id가 없습니다.'); history.back();</script>");
%>
</body>
</html>