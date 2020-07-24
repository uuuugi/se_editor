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
#workSpaceList{
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
<iframe id="workSpaceList" name = "workSpaceList" src="workSpaceList.jsp"> </iframe>
<iframe id="editor" name = "editor" src="editor.jsp"> </iframe>
<iframe id="run" name = "run"> run</iframe>
</body>
</html>