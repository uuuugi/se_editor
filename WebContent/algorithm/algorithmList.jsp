<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="algorithm.*" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
a, a:link, a:visited{
text-decoration:none;
color:black;
}
.list>div{
display:none;
}
</style>
<script>
function showOrHide(id){
	var box = document.getElementById(id);
	if(box.style.display!='block')// display 상태가 block이 아니라면 block로 설정 == show
		box.style.display="block";
	else// block라면 none로 설정 == hide
		box.style.display="none";
}
</script>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	algorithmDAO dao = new algorithmDAO();
	ArrayList<algorithmVO> algorithmListA= new ArrayList<algorithmVO>(dao.getAlgorithmList("test"));
	
	%>
	<div class ="list">
	<span onclick="showOrHide('listA')"> listA</span>
	<div id="listA">
	<%
	for(int i=0; i<algorithmListA.size(); i++){%>
		<form action="algorithmList.jsp" target="_self" id='<%= algorithmListA.get(i).getNum()%>'>
		<input type="hidden" name ="num" value='<%=algorithmListA.get(i).getNum() %>'>
		<a href="" onclick="document.getElementById('<%= algorithmListA.get(i).getNum()%>').submit();"><%=algorithmListA.get(i).getName() %></a>
		</form>
		<%}%>
		</div>
	</div>
</body>
</html>