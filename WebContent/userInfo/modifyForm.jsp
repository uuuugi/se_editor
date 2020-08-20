<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="member.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function checkValue()
{    
    // 비밀번호와 비밀번호 확인에 입력된 값이 동일한지 확인
    if(document.modifyForm.password.value != document.modifyForm.passwordcheck.value ){
        alert("비밀번호를 동일하게 입력하세요.");
        return false;
    }
}</script>
</head>
<body>
	<%
		memberVO vo = new memberVO();
	memberDAO dao = new memberDAO();
	vo.setId((String) session.getAttribute("id"));
	vo.setPw((String) request.getParameter("pw"));

	String loginResult = dao.dologin(vo);

	if ("pwMiss".equals(loginResult)) {
	%>
	out.println("<script>alert('비밀번호가 틀렸습니다.'); history.back();</script>");
	<%
		} else if("idMiss".equals(loginResult)){
			out.println("<script>alert('아이디가 틀렸습니다.'); history.back();</script>");
		}
		else{
	vo = dao.getMemberVO(vo.getId());
	%>
	<form action="doModify.jsp" name="modifyForm" method="post" onsubmit="return checkValue()">
	이름
	<input type="text" name ="name" value="<%=vo.getName()%>"><br>
	메일주소
	<input type="text" name="mail" value="<%=vo.getMail()%>"><br>
	자기소개
	<input type="text" name="info" value="<%=vo.getInfo()%>"><br>
	비밀번호
	<input type="password" name="password" maxlength="50">
	비밀번호 확인
	<input type="password" name="passwordcheck" maxlength="50">
	<br>
	<input type="submit" value="정보 수정">
	</form>
	<%	}
	%>
</body>
</html>