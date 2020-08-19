<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="bulletinBoard.*" %>
<%@ page import ="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#comment{
	display:none;
}
</style>
<script>
	function createForm(url, postNum){
		var form = document.createElement("form");//폼 생성
		
	   	  form.setAttribute("charset", "UTF-8");//인코딩 타입
	   	  form.setAttribute("method", "Post");  //전송 방식
	   	  form.setAttribute("target", "_self");//타겟의 이름
	   	  form.setAttribute("action", url); //요청 보낼 주소
	   	  
	   	  var hiddenField = document.createElement("input"); // input 버튼 생성
	   	  hiddenField.setAttribute("type", "hidden");
	   	  hiddenField.setAttribute("name", "postNum");
	   	  hiddenField.setAttribute("value", postNum);
	   	  form.appendChild(hiddenField);// form에 추가
	   	  
	   	  document.body.appendChild(form);//form을 body에 생성
	   	  form.submit(); //submit
	}
	function del(postNum)
	{
		createForm("postDel.jsp", postNum);
	}
	function update(postNum){
		createForm("postUpdate.jsp", postNum);
	}
	function openComment(){
		var comment = document.getElementById("comment");
		if(comment.style.display=='none')
			comment.style.display="block";
		else
			comment.style.display="none";
	}
</script>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	bulletinBoardVO vo = new bulletinBoardVO();
	bulletinBoardDAO dao = new bulletinBoardDAO();
	
	int postNum= Integer.parseInt( (String)request.getParameter("postNum").substring(1) );
	String id = (String)session.getAttribute("id");
	vo = dao.getPost(postNum);
	
%>
<h2><%= vo.getName() %></h2>
<hr>
작성자: <%= vo.getId() %> 
 글 번호:<%= vo.getNum() %>
<form action="star.jsp" method="post" >
<input type="hidden" name="postNum" value='<%=postNum %>'>
<input type="submit" value="star" onclick="star()"> <%= vo.getStar() %>
</form>
<%
	if(id!=null)
		if(id.equals( vo.getId() ) ){
%>
	<input type="button" value = "삭제" onclick="del('<%=vo.getNum()%>')">
	<input type="button" value = "수정" onclick="update('<%=vo.getNum()%>')">
	
<%} %>
<hr>
<%= vo.getText() %>

<hr>
<%if(id!=null){%>
	<form action="comment.jsp" method="post">
	<textarea cols="40" rows="4" name ="comment" placeholder="댓글을 입력하세요."></textarea>
	<input type="hidden" name="postNum" value='<%=postNum %>'> 
	<input type="submit" value="작성">
	</form>
<% }%>

<hr>
<%
	commentDAO cdao = new commentDAO();
	ArrayList<forCommentList> commentList = new ArrayList<forCommentList>(cdao.getCommentList(postNum));
	
	for(int i=0; i<commentList.size(); i++){
		out.print(commentList.get(i).getId());
		if(id.equals(commentList.get(i).getId()))
		{%>
			<form action="delComment.jsp" method="post" style="display:inline">
				<input type="hidden" name ="commentNum" value='<%=commentList.get(i).getCommentNum() %>'>
				<input type="hidden" name="postNum" value='<%=postNum %>'>
				<input type="submit" value="삭제">
			</form>
		<%} %>
	<br>
	<%=commentList.get(i).getText() %>
	<br>
	<input type="button" value="댓글달기" onclick="openComment()">
	<div id="comment">
	<form action="comment2.jsp" method="post">
		<textarea cols="40" rows="4" placeholder="대댓글을 입력해주세요"></textarea>
		<input type="submit" value="작성">
	</form>
	</div>
<%} %>
</body>
</html>