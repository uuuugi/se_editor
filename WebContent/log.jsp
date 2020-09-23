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

	if((String)session.getAttribute("authority")==null)//관리자가 아닐경우 index로 돌아감
		response.sendRedirect("../index.jsp");

	LogDAO Ldao = new LogDAO();
%>
<form action="log.jsp" method="post" target="_self">
<input type="hidden" name="all" value="1">
<input type="submit" value="로그 전체보기">
</form>

<form action="log.jsp" method="post" target="_self">
<input type="text" name="id" >
<input type="submit" value="id로 로그보기">
</form>


<form action="log.jsp" method="post" target="_self">
<input type="date" name="date">
<input type="submit" value="날짜로 로그보기">
</form>

<form action= "log.jsp" method="post" target="_self">
	<select name="language" class="sel">
		<option value="c">c</option>
		<option value="java">java</option>
		<option value="python">python</option>
		<option value="javascript">javascript</option>
		</select>
<input type="submit" value="언어로 검색">
</form>


<hr>
<%
ArrayList<LogVO> list = new ArrayList<LogVO>();

if(request.getParameter("all")!=null){// 전체저장
	list = Ldao.getLogAll();
}

if(request.getParameter("date")!=null){// 날짜별 저장
	String date="";
	
	date=request.getParameter("date");
	date = Ldao.changeDate(date);
	
	list = Ldao.getLogByDate(date);
}

if(request.getParameter("id")!=null){// id별로 저장
	String id = (String)request.getParameter("id");
	list = Ldao.getLogById(id);
}

if(request.getParameter("language")!=null){//언어별로 저장
	String language=(String)request.getParameter("language");
	list = Ldao.getLogByLanguage(language);
}

if(list!=null){// 출력부분
	for(int i=0; i<list.size(); i++){
		out.print(list.get(i).getId());
		out.print(list.get(i).getId2());
		out.print(list.get(i).getSession1());
		out.print(list.get(i).getSession2());
		out.print(list.get(i).getContainerId());
		out.print(list.get(i).getLanguage());
		out.print(list.get(i).getResult());
		out.println("<br>");
		} 
}
%>
</body>
</html>