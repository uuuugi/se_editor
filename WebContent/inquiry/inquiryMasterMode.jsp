<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="inquiry.*"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.inquiryBox>div {
	display: none;
}
</style>
<script>
	function showOrHide(id) {
		var box = document.getElementById(id);
		if (box.style.display != 'block')// display 상태가 block이 아니라면 block로 설정 == show
			box.style.display = "block";
		else
			// block라면 none로 설정 == hide
			box.style.display = "none";
	}
</script>
</head>
<body>
	<input type="button" value="home" onclick="location.href='../index.jsp'">
	
	<form action="inquiryMasterMode.jsp" target="_self" method="post">
		<input type="hidden" name="type" value="normal"> 
		<input type="submit" value="답변안된 리스트 출력">
	</form>
	
	<form action="inquiryMasterMode.jsp" target="_self" method="post">
		<input type="hidden" name="type" value="sId">
		<input type="text" name="text"> 
		<input type="submit" value="id검색">
	</form>
	
	<form action="inquiryMasterMode.jsp" target="_self" method="post">
		<input type="hidden" name="type" value="all"> 
		<input type="submit" value="전체 출력">
	</form>
	
	<hr>
	<%
		request.setCharacterEncoding("UTF-8");
		inquiryDAO dao = new inquiryDAO();

	if ((String) session.getAttribute("authority") == null)//관리자가 아닐경우 index로 돌아감
		response.sendRedirect("../index.jsp");
		String id = (String) session.getAttribute("id");

	if (request.getParameter("type") != null)
		if ("normal".equals(request.getParameter("type"))) {
			ArrayList<inquiryVO> inquiryList = new ArrayList<inquiryVO>(dao.getInquiryList());//문의중 답변이 안달린 것들의 list

			for (int i = 0; i < inquiryList.size(); i++) {
	%>
	<div class="inquiryBox">
		<span onclick="showOrHide('<%=i%>')"> <%=inquiryList.get(i).getTitle()%> || <%=inquiryList.get(i).getId()%>
		<% if(inquiryList.get(i).getComment()==1)
			out.print("&nbsp; <span style='color:green'>O</span>");
		else
			out.print("&nbsp; <span style='color:red'>X</span>"); %>
		</span>
		<!-- 문의제목과 id출력 -->
		<div id='<%=i%>'>
			<%=inquiryList.get(i).getText()%><!-- 문의내용 -->
			<hr>
			<form action="writeInquiryComment.jsp" method="post">
				<!-- 답변 form -->
				<input type="text" name="title" placeholder="제목"><br>
				<textarea cols="40" rows="8" name="text"></textarea>
				<input type="hidden" name="inquiryNum" value='<%=inquiryList.get(i).getNum()%>'> <input type="submit" value="작성">
			</form>
		</div>
	</div>
	<hr>
	<%
		}
	}
		else if("sId".equals(request.getParameter("type"))){
			String sId = (String)request.getParameter("text");
			
			ArrayList <inquiryVO> inquiryList = new ArrayList<inquiryVO> (dao.getInquiryList(sId));
			
			for(int i=0; i<inquiryList.size(); i++){ %>
				
			<div class="inquiryBox">
				<span onclick="showOrHide('<%=i %>')"> <%=inquiryList.get(i).getTitle() %> || <%=inquiryList.get(i).getId() %>
				<% if(inquiryList.get(i).getComment()==1)
					out.print("&nbsp; <span style='color:green'>O</span>");
				else
					out.print("&nbsp; <span style='color:red'>X</span>"); %>
				 </span>
				<!-- 문의제목과 id 출력 -->
					<div id='<%=i %>'>
					<%=inquiryList.get(i).getText()%><!-- 문의내용 -->
					<hr>
					<% if(inquiryList.get(i).getComment()==1){ // 답변이 있을경우 답변 출력
						inquiryCommentVO vo = new inquiryCommentVO();
						vo = dao.getInquiryComment(inquiryList.get(i).getNum()); %>
					
						<%= vo.getTitle() %> || <%= vo.getId() %><br> <!-- 답변제목과 답변자 id출력 -->
						<%= vo.getText() %>
					<%} else{%>
						<form action="writeInquiryComment.jsp" method="post">
						<!-- 답변 form -->
						<input type="text" name="title" placeholder="제목"><br>
						<textarea cols="40" rows="8" name="text"></textarea>
						<input type="hidden" name="inquiryNum" value='<%=inquiryList.get(i).getNum()%>'> <input type="submit" value="작성">
					</form>
					<% }%> 
					</div>
			</div>
			<% }
		}
		else if ("all".equals(request.getParameter("type"))){
			ArrayList <inquiryVO> inquiryList = new ArrayList<inquiryVO> (dao.getInquiryListAll());
			for(int i=0; i<inquiryList.size(); i++){ %>
			
			<div class="inquiryBox">
				<span onclick="showOrHide('<%=i %>')"> <%=inquiryList.get(i).getTitle() %> || <%=inquiryList.get(i).getId() %> 
				<% if(inquiryList.get(i).getComment()==1)
					out.print("&nbsp; <span style='color:green'>O</span>");
				else
					out.print("&nbsp; <span style='color:red'>X</span>"); %>
				</span>
				<!-- 문의제목과 id 출력 -->
					<div id='<%=i %>'>
					<%=inquiryList.get(i).getText()%><!-- 문의내용 -->
					<hr>
					<% if(inquiryList.get(i).getComment()==1){ // 답변이 있을경우 답변 출력
						inquiryCommentVO vo = new inquiryCommentVO();
						vo = dao.getInquiryComment(inquiryList.get(i).getNum()); %>
					
						<%= vo.getTitle() %> || <%= vo.getId() %><br> <!-- 답변제목과 답변자 id출력 -->
						<%= vo.getText() %>
					<%} else{%>
						<form action="writeInquiryComment.jsp" method="post">
						<!-- 답변 form -->
						<input type="text" name="title" placeholder="제목"><br>
						<textarea cols="40" rows="8" name="text"></textarea>
						<input type="hidden" name="inquiryNum" value='<%=inquiryList.get(i).getNum()%>'> <input type="submit" value="작성">
					</form>
					<% }%> 
					</div>
			</div>
			<% }
		}
	%>
</body>
</html>