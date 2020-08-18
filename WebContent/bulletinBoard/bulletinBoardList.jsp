<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="bulletinBoard.*" %>
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
</style>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");

	int pageNum=1;
	if(request.getParameter("pageNum")!=null)
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	
	bulletinBoardDAO dao = new bulletinBoardDAO();
	ArrayList<forPostList> postList	= new ArrayList <forPostList> ( dao.getPostList() ); // 게시글 목록을 불러옴
%>
	<table id="postList">
	<% 
	int i= pageNum*10-10;
	for(; i<pageNum*10; i++){
		if(i==postList.size())
			break;
	%>
	<tr>
		<td> 
		<form method="post" action="showPost.jsp" id='<%="t"+postList.get(i).getNum()%>'> <!-- postName별로 form 생성 form id는 postNum으로 지정하여 유니크값 으로 생성  앞에 t를 붙여주는 이유는 아래의 pageNum과 구분하기 위함-->
		<input type="hidden" name="postNum" value=<%="t"+postList.get(i).getNum()%>> <!-- postNum의 value를 저장할 부분을 생성하나 사이트상에 표시하지는 않음 -->
		</form>
		<a href="#" onclick="document.getElementById('<%="t"+postList.get(i).getNum()%>').submit();"><%=postList.get(i).getName() %> </a></td> <!-- 클릭시 page 이동하여 text 출력 -->
	<% } %>
	</table>
	<hr>
	<table id="pageNum">
	<tr>
	<% 
	int j=pageNum;
	if(j<5)// j=pageNum이면 pageNum보다 작은 page로는 돌아갈 수 없기때문에 j를 조절한다.
		j=1;
	else
		j-=4;
	for(; j<pageNum+10; j++){ // 글의 갯수만큼만 pageNum생성
		if(j-2>=postList.size()/10)
			break;
	%>
		<td> 
		<form method="post" action="bulletinBoardList.jsp" id='<%=j %>'> <!-- postName별로 form 생성 form id는 postName으로 지정하여 유니크값 으로 생성 -->
		<input type="hidden" name="pageNum" value=<%=j %>> <!-- postName의 value를 저장할 부분을 생성하나 사이트상에 표시하지는 않음 -->
		</form>
		<a href="#" onclick="document.getElementById('<%=j %>').submit();"><%=j %> </a></td> <!-- 클릭시 page 이동하여 text 출력 -->
	<% } %>
	</tr>
	</table>
</body>
</html>