<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="inquiry.*"%>
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
function box(id){
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
	
	ArrayList<inquiryVO> inquiryList = new ArrayList<inquiryVO>(dao.getInquiryList());//문의중 답변이 안달린 것들의 list
	
	for(int i=0; i<inquiryList.size(); i++){%>
		<div class="inquiryBox">
			<span onclick="box('<%=i%>')"> <%=inquiryList.get(i).getTitle() %> || <%=inquiryList.get(i).getId() %></span><!-- 문의제목과 id출력 -->
			<div id='<%=i %>'>
				<%= inquiryList.get(i).getText() %><!-- 문의내용 -->
				<hr>
				<form action="writeInquiryComment.jsp" method="post"><!-- 답변 form -->
					<input type="text" name="title" placeholder="제목"><br>
					<textarea cols="40" rows="8" name = "text"></textarea>
					<input type="hidden" name="inquiryNum" value='<%=inquiryList.get(i).getNum() %>'>
					<input type="submit" value="작성">
				</form>
			</div>
		</div>
		<hr>
	<%} %>
</body>
</html>