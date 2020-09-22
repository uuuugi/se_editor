<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="log.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	LogDAO dao = new LogDAO();
	ArrayList <LogVO> list = new ArrayList <LogVO>(dao.getLogById("null"));
	
	for(int i=0; i<list.size(); i++)
	{
		out.print(list.get(i).getId());
		out.print(list.get(i).getId2());
		out.print(list.get(i).getSession1());
		out.print(list.get(i).getSession2());
		out.print(list.get(i).getContainerId());
		out.print(list.get(i).getLanguage());
		out.print(list.get(i).getResult());
		out.println("<br>");
	}
%>
</body>
</html>