<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body{
	background-color:#1e1e1e;
	margin:0,0,0,0;
	padding:0,0,0,0;
}
iframe{
	margin:0;
	padding:0;
	border:0;
	border-image:0;
}
#workSpaceList{
	background-color:#1e1e1e;
	width : 15vw;
	height : 79vh;
	float : left;
	display : inline-block;
}
#run{
	background-color:#1e1e1e;
	width: 99vw;
	height: 20vh;
	display:block;
}
#editor{
	background-color:#1e1e1e;
	width: 62vw;
	height: 79vh;
	display: inline-block;
	
}
#ocr{
	background-color:#1e1e1e;
	width: 20vw;
	height: 79vh;
	display: inline-block;
}
</style>
</head>
<body>
<iframe id="workSpaceList" name = "workSpaceList" src="workSpaceList.jsp"> </iframe>
<iframe id="editor" name = "editor" src="editor.jsp"> </iframe>
<iframe id="ocr" name ="ocr" src="../ocr/ocr.jsp"> </iframe>
<iframe id="run" name = "run"> run</iframe>
</body>
</html>