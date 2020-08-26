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
#comment2Box{
	background-color:gray;
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
	//게시글을 보여주는 페이지
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
<form action="star.jsp" method="post" ><!-- 추천하기 form -->
<input type="hidden" name="postNum" value='<%=postNum %>'>
<input type="submit" value="star" onclick="star()"> <%= vo.getStar() %>
</form>
<%
	if(id!=null)
		if(id.equals( vo.getId() ) ){ // 작성자가 해당 게시글을 클릭했을 경우 삭제 or 수정버튼 출력
%>
	<input type="button" value = "삭제" onclick="del('<%=vo.getNum()%>')">
	<input type="button" value = "수정" onclick="update('<%=vo.getNum()%>')">
	
<%} %>
<hr>
<%= vo.getText() %> <!-- 내용 출력 -->

<hr>
<%if(id!=null){ //로그인 했을경우 댓글달기 form 상생 %>
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
	
	for(int i=0; i<commentList.size(); i++){//댓글 출력 loop
		out.print(commentList.get(i).getId());//id출력
		if(id.equals(commentList.get(i).getId()))//댓글 작성자만 삭제버튼 생성
		{%>
			<form action="delComment.jsp" method="post" style="display:inline">
				<input type="hidden" name ="commentNum" value='<%=commentList.get(i).getCommentNum() %>'>
				<input type="hidden" name="postNum" value='<%=postNum %>'>
				<input type="submit" value="삭제">
			</form>
		<%} %>
	<br>
	<%=commentList.get(i).getText() %> <!-- 댓글 내용 출력 -->
	<br>
	<%
		 for(int j=0; j<commentList.get(i).getComment2List().size(); j++) // 대댓글이 있을경우
		 {%>
			<div id="comment2Box">
			 <%=commentList.get(i).getComment2List().get(j).getId() %><!-- 대댓글 작성자 id 출력 -->
			<% if(id.equals(commentList.get(i).getComment2List().get(j).getId())) { // 대댓글 작성자만 삭제버튼 생성 %>
			<form action="delComment2.jsp" method="post" style="display:inline">
				<input type="hidden" name ="comment2Num" value='<%=commentList.get(i).getComment2List().get(j).getComment2Num() %>'>
				<input type="hidden" name="postNum" value='<%=postNum %>'>
				<input type="submit" value="삭제">
			</form>
				<%}%>
			<br>
			<%=commentList.get(i).getComment2List().get(j).getText() %> <!-- 대댓글 내용 출력 -->
			</div>
		<%} %>
		<!-- 대댓글 달기 버튼 -->
			<input type="button" value="댓글달기" onclick="showOrHide('<%=commentList.get(i).getCommentNum() %>')">
			<br><br>
			<div id ='<%=commentList.get(i).getCommentNum()%>' style="display:none">
			<form action="comment2.jsp" method="post">
				<textarea cols="40" rows="4" name="comment2"placeholder="대댓글을 입력해주세요"></textarea>
				<input type="hidden" name ="commentNum" value='<%=commentList.get(i).getCommentNum() %>'>
				<input type="hidden" name="postNum" value='<%=postNum %>'>
				<input type="submit" value="작성">
			</form>
		</div>
<%} %>
</body>
</html>