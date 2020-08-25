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
	function openText(id){ // 문의 내용을 show or hidden으로 바꿔주는 함수
		var box= document.getElementById(id);
		if(box.style.display!='block')
			box.style.display='block';
		else
			box.style.display='none';		
	}
</script>
</head>
<body>
<input type="button" value="home" onclick="location.href='../index.jsp'">
<%
	//문의하기 페이지 자신이 문의한 내용 및 답변보기 , 문의하기 기능이 있다
	request.setCharacterEncoding("UTF-8");
	
	String id = (String)session.getAttribute("id");
	inquiryDAO dao = new inquiryDAO();
	inquiryCommentVO vo = new inquiryCommentVO();
	
	ArrayList <inquiryVO> inquiryList= new ArrayList<inquiryVO>(dao.getInquiryList(id));
	
	for(int i=0; i<inquiryList.size(); i++){//본인이 문의한 질문들 출력%>
		<div class ="inquiryBox" onclick="openText('<%=inquiryList.get(i).getNum() %>')">
			제목: <%=inquiryList.get(i).getTitle() %> 
			<% if(inquiryList.get(i).getComment()==1) //답변이 있다면 제목옆에 답변완료라고 출력
				out.print("답변완료");
			%>
			<div id='<%=inquiryList.get(i).getNum() %>'>
				<%=inquiryList.get(i).getText() %> <!-- 문의내용 출력 -->
				<hr>
				<% if(inquiryList.get(i).getComment()==1){// 답변이 있다면
					vo=dao.getInquiryComment(inquiryList.get(i).getNum());
				%>
					<%=vo.getTitle() %> || id: <%= vo.getId() %> <!-- 답변제목과 답변자의 id출력 -->
					<hr>
					<%= vo.getText() %><!-- 답변내용 출력 -->
				 <%}%>
			</div>
		</div>
		<hr>
<%} %>
	<form action="writeInquiry.jsp"> <!-- 문의하기 form -->
		<input type="text" name="title" placeholder="제목">
		<br>
		<textarea name ="text" name ="text" cols="40" rows="8"></textarea>
		<input type="submit" value="작성">
	</form>
</body>
</html>