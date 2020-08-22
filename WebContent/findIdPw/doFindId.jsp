<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="member.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	// DB에서 이름과 email이 일치하는 id를 찾아 뒤의 세자리를 *로 바꾼후 출력해준다
	memberVO vo = new memberVO();
	vo.setName(request.getParameter("name"));
	vo.setMail(request.getParameter("email"));
	
	memberDAO dao = new memberDAO();
	String id = dao.findId(vo);
	
	if("fail".equals(id))
		out.println("<script>alert('입력하신 정보와 일치하는 id가 없습니다.'); history.back();</script>"); // 입력한 정보와 같은 id가 없으면 알림창 출력 후 되돌아감
	else{
		%>
		회원님의 id는 <%=id.substring(0, id.length()-3) %>*** 입니다. <!-- 입력한 정보와 일치하는 id가 있으면 뒤의 세자리를 *로 바꾼 후 출력 -->
	<% } %>
</body>
</html>