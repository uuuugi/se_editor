<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<%@ page import="code.*"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<style>
table{
width:90vw;
display:none;
}
a, a:link, a:visited{
text-decoration:none;
color:black;
}
</style>
<script>
function showOrHide(name){
	if(name=='c'){
		if(codeListC.style.display!='block')// display 상태가 block이 아니라면 block로 설정 == show
			codeListC.style.display="block";
		else// block라면 none로 설정 == hide
			codeListC.style.display="none";
	}
	else if(name =='java'){
		if(codeListJava.style.display!='block')
			codeListJava.style.display="block";
		else
			codeListJava.style.display="none";
	}
	else if(name=='python'){
		if(codeListPython.style.display!='block')
			codeListPython.style.display="block";
		else
			codeListPython.style.display="none";
	}
	else if(name=='javascript'){
		if(codeListJavascript.style.display!='block')
			codeListJavascript.style.display="block";
		else
			codeListJavascript.style.display="none";
	}
}
</script>
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8"); 
	String user_id=(String)session.getAttribute("id");
	
	codeDAO dao= new codeDAO();
	ArrayList<String> codeListC = new ArrayList<String>(); 
	ArrayList<String> codeListJava = new ArrayList<String>();
	ArrayList<String> codeListPython = new ArrayList<String>();
	ArrayList<String> codeListJavascript = new ArrayList<String>();
	
	codeListC= dao.getCodeListC(user_id);// ArrayList에 codeType별로 codList저장받음
	codeListJava= dao.getCodeListJava(user_id);
	codeListPython = dao.getCodeListPython(user_id);
	codeListJavascript= dao.getCodeListJavascript(user_id);
	
	%>
	<a href="#" onclick="showOrHide('c')">C</a> <!-- list 제목을 나타내는 부분 클릭시 list hide or show 실행 -->
	<table id="codeListC">
	<% for(String i: codeListC){%>
	<tr>
		<td> 
		<form method="post" action="editor.jsp" id='<%=i %>' target="editor"> <!-- codeName별로 form 생성 form id는 CodeName으로 지정하여 유니크값 으로 생성 -->
		<input type="hidden" name="codeName" value=<%=i %>> <!-- codeName의 value를 저장할 부분을 생성하나 사이트상에 표시하지는 않음 -->
		</form>
		<a href="#" onclick="document.getElementById('<%=i %>').submit();"><%=i %> </a> </td> <!-- codeName을 web에 띄워줌과 동시에 링크로 생성해줌 -->
		 <td> drop</td> </tr>
	<% } %>
	</table>
	
	<hr>
	<a href="#" onclick="showOrHide('java')">java</a>
	<table id="codeListJava">
	<% for(String i: codeListJava){%>
		<tr>
		<td> 
		<form method="post" action="editor.jsp" id='<%=i %>' target="editor">
		<input type="hidden" name="codeName" value=<%=i %>>
		</form>
		<a href="#" onclick="document.getElementById('<%=i %>').submit();"><%=i %> </a> </td>
		 <td> drop</td> </tr>
	<% } %>
	</table>
	
	<hr>
	<table id="codeListPython">
	<a href="#" onclick="showOrHide('python')">python</a>
	<% for(String i: codeListPython){%>
		<tr>
		<td> 
		<form method="post" action="editor.jsp" id='<%=i %>' target="editor">
		<input type="hidden" name="codeName" value=<%=i %>>
		</form>
		<a href="#" onclick="document.getElementById('<%=i %>').submit();"><%=i %> </a> </td>
		 <td> drop</td> </tr>
	<% } %>
	</table>
		
	<hr>
	<table id="codeListJavascript">
	<a href="#" onclick="showOrHide('javascript')">javaScript</a>
	<% for(String i: codeListJavascript){%>
		<tr>
		<td> 
		<form method="post" action="editor.jsp" id='<%=i %>' target="editor">
		<input type="hidden" name="codeName" value=<%=i %>>
		</form>
		<a href="#" onclick="document.getElementById('<%=i %>').submit();"><%=i %> </a> </td>
		 <td> drop</td> </tr>
	<% } %>
	</table>
</body>
</html>