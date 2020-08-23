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
	String id = (String)session.getAttribute("id");
	algorithmDAO dao = new algorithmDAO();
	ArrayList<algorithmVO> algorithmListA= new ArrayList<algorithmVO>(dao.getAlgorithmList("test"));
	
	%>
	<div class ="list">
	<span onclick="showOrHide('listA')"> listA</span>
	<div id="listA">
	<%
	for(int i=0; i<algorithmListA.size(); i++){//코드 리스트 출력
		int result = dao.doesUserTry(id, algorithmListA.get(i).getNum());//시도한적이 있는지 체크
	%>
		<form action="algorithmList.jsp" target="_self" id='<%= algorithmListA.get(i).getNum()%>' method='post'>
		<input type="hidden" name ="num" value='<%=algorithmListA.get(i).getNum() %>'>
		<a href="#" onclick="document.getElementById('<%= algorithmListA.get(i).getNum()%>').submit();"><%=algorithmListA.get(i).getName() %></a>
		<%
			if(result==0)
				out.println("실패");
			else if(result==1)
				out.println("성공");
		%>
		</form>
		<%}%>
		</div>
	</div>
<% 
	int algorithmNum;
	
	if(request.getParameter("num")!=null)
		{//코드 설명 input ouput 출력
			algorithmNum=Integer.parseInt(request.getParameter("num"));
			algorithmVO vo = new algorithmVO();
			vo=dao.getAlgorithm(algorithmNum);
			
			out.println(vo.getName());
			out.println(vo.getExplanation());
			out.println(vo.getInput());
			out.println(vo.getOutput());
			
			// 있다면 결과 출력
			// 코드리스트 출력
		}
	
%>
</body>
</html>