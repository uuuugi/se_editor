<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="inquiry.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.inquiryBox>div{
display:none;
}
</style>
<script>
	function openText(id){
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
	
	String id = (String)session.getAttribute("id");
	inquiryDAO dao = new inquiryDAO();
	inquiryCommentVO vo = new inquiryCommentVO();
	
	ArrayList <inquiryVO> inquiryList= new ArrayList<inquiryVO>(dao.getInquiryList(id));
	
	for(int i=0; i<inquiryList.size(); i++){%>
		<div class ="inquiryBox" onclick="openText('<%=inquiryList.get(i).getNum() %>')">
			제목: <%=inquiryList.get(i).getTitle() %> || id: <%=inquiryList.get(i).getId() %>
			<div id='<%=inquiryList.get(i).getNum() %>'>
				<%=inquiryList.get(i).getText() %>
				<hr>
				<% if(inquiryList.get(i).getComment()==1){
					vo=dao.getInquiryComment(inquiryList.get(i).getNum());
				%>
					<%=vo.getTitle() %> || id: <%= vo.getId() %>
					<hr>
					<%= vo.getText() %>
				 <%}%>
			</div>
		</div>
		<hr>
<%} %>
	<form action="writeInquiry.jsp">
		<input type="text" name="title" placeholder="제목">
		<br>
		<textarea name ="text" name ="text" cols="40" rows="8"></textarea>
		<input type="submit" value="작성">
	</form>
</body>
</html>