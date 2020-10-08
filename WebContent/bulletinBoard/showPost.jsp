<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="bulletinBoard.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<form action="star.jsp" method="post">
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
</body>
</html>