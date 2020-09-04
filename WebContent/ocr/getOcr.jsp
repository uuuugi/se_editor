<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
*{
background-color:#1e1e1e;
color : white;
}
.button1{
background-color:white;
color:black;
}
.img{
background-color:white;
color:black;
}
</style>
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
	<div class="img">
	이미지 사진과 코드가 나올 위치
	<img src='<%=imgUrl %>'>
	<%= ocrCode %>
	</div>
	
	<form action="editor.jsp" target="editor" method="post">
		<input type="hidden" name="ocr" value="1">
		<input type="hidden" name="ocrCode" value='<%=ocrCode %>'>
		<input class="button1" type="submit" value="에디터로 코드 옮기기">
	</form>
	
	<form method="post" enctype="multipart/form-data" action="uploadFile.jsp">
	<p><input type="file" name="filename"></p>
	<p><input class="button1" type="submit" value="전송"></p> 
</form>
</body>
</html>