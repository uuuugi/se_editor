<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
    
<%-- 자바빈 클래스 import --%>      
<%@ page import="member.memberVO" %>  
<%-- DAO import --%>   
<%@ page import="member.memberDAO" %> 
 
<html>
<head>
    <title>회원가입 처리 JSP</title>
    
    <!-- css 파일 분리 -->
    <link href='../../css/join_style.css' rel='stylesheet' style='text/css'/>
    
	<script type="text/javascript">
    	 // 취소 버튼 클릭시 로그인 화면으로 이동
        function goIndex() {
            location.href="index.jsp";
        }
    	        
    </script>
    
</head>
<body>
    <%-- JoinForm.jsp에서 입력한 정보를 넘겨 받아 처리한다. --%>
    <% 
        // 한글 깨짐을 방지하기 위한 인코딩 처리
        request.setCharacterEncoding("UTF-8"); 
    %>

    <%
    
    memberVO vo = new memberVO();
	memberDAO dao = new memberDAO();
	
	String id = request.getParameter("id");
	vo.setId(id);

		
	String pw = request.getParameter("password");
	vo.setPw(pw);
	
	String mail = request.getParameter("mail");
	vo.setMail(mail);
	
	String name = request.getParameter("name");
	vo.setName(name);
	
	String info = request.getParameter("info");
	vo.setInfo(info);
	
	%>
	
	<% dao.dbinsert(vo) ;%> 	<!-- 저장받은 회원가입 정보 db에 입력 -->
    
    <div id="wrap">
        <br><br>
        <b><font size="5" color="gray">회원가입 정보를 확인하세요.</font></b>
        <br><br>
        <font color="blue"><%= name%></font>님 가입을 축하드립니다.
        <br><br>
        
        <%-- 자바빈에서 입력된 값을 추출한다. --%>
        <table>
            <tr>
                <td id="title">아이디</td>
                <td><%=id %></td>
            </tr>
                        
            <tr>
                <td id="title">비밀번호</td>
                <td><%=pw %></td>
            </tr>
                    
            <tr>
                <td id="title">이름</td>
                <td><%=name %></td>
            </tr>

                    
            <tr>
                <td id="title">이메일</td>
                <td>
                    <%=mail %>
                </td>
            </tr>
                    
            <tr>
                <td id="title">자기소개</td>
                <td><%=info %></td>
            </tr>
        </table>
        
        <br>
        <input type="button" value="확인" onclick="goIndex()">
    </div>
</body>
</html>
