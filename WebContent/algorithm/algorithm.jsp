<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body{
	margin:0,0,0,0;
	padding:0,0,0,0;
}
iframe{
	margin:0;
	padding:0;
	border:0;
	border-image:0;
}
#algorithmList{
	background-color:red;
	width : 15vw;
	height : 79vh;
	float : left;
	display : inline-block;
}
#run{
	background-color:gray;
	width: 99vw;
	height: 20vh;
	display:block;
}
#editor{
	width: 82vw;
	height: 79vh;
	display: inline-block;
}
</style>
</head>
<body>
<iframe src= "algorithmList.jsp" id = "algorithmList" name="algorithmList"></iframe>
<iframe src= "editorForAlgorithm.jsp" id = "editor" name = "editor"></iframe>
<iframe src= ../ide/run.jsp id = "run" name = "run"></iframe>
</body>
</html>