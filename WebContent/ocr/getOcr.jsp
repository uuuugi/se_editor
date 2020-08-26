<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	
	String ocrCode = "";
	String imgUrl="";
	if(request.getParameter("ocrCode")!=null){
		ocrCode = request.getParameter("ocrCode");
		imgUrl = request.getParameter("imgUrl");
	}
%>
	<img src='<%=imgUrl %>'>
	<%= ocrCode %>
	
	<form action="editor.jsp" target="editor" method="post">
		<input type="hidden" name="ocr" value="1">
		<input type="hidden" name="ocrCode" value='<%=ocrCode %>'>
		<input type="submit" value="에디터로 코드 옮기기">
	</form>
	
	<form method="post" enctype="multipart/form-data" action="uploadFile.jsp">
	<p><input type="file" name="filename"></p>
	<p><input type="submit" value="전송"></p> 
</form>
</body>
</html>