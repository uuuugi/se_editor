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
div>div{
	display:none;
}
</style>
<script>
function showOrHide(id){
	var box= document.getElementById(id);
	if(box.style.display!='block')
		box.style.display='block';
	else
		box.style.display='none';		
}
</script>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	
	algorithmDAO dao = new algorithmDAO();
	ArrayList<algorithmVO> algorithmListA = new ArrayList<algorithmVO>(dao.getAlgorithmList("test"));
	
	%>
	<div>  
	<span onclick="showOrHide('listA')">ListA</span> <!-- 카테고리별로 생성해야함 -->
	<div id="listA">
	<% for(int i=0; i<algorithmListA.size(); i++){%>
			<%=algorithmListA.get(i).getName() %>
			<form action="addAlgorithm.jsp" target="_self" style="display:inline">
				<input type="hidden" name="algorithmNum" value='<%=algorithmListA.get(i).getNum() %>'>
				<input type="submit" value="수정하기">
			</form>
	<%} %>
	</div>
	</div>
</body>
</html>