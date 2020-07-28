<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="code.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");

	String id, codeName;
	id= ((String) session.getAttribute("id"));
	codeName= request.getParameter("codeName");

	//if(vo.getCode()==null)// ide에서 save.jsp가 두번 호출된다. 첫번째 호출을 무시하기 위한 부분
		//return;
	
	codeDAO dao= new codeDAO();
	dao.del(id,codeName);
 %>
삭제 완료
 <script>
 window.onunload = function () {// 페이지를 닫을때 실행되는 함수 내용은 workspaceList.jsp를 초기화 시킴
	    opener.reloadWorkSpaceList();
	};
 </script>
</body>
</html>