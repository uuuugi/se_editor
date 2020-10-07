<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="log.*" %>
<%@ page import="member.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.log, .userInfo{
display: inline-block;
width:49%;
}
.log input, .userInfo input{
display: inline-block;
}
</style>
</head>
<body>
<%
	
	request.setCharacterEncoding("UTF-8");

	if((String)session.getAttribute("authority")==null)//관리자가 아닐경우 index로 돌아감
		response.sendRedirect("./index.jsp");

	LogDAO Ldao = new LogDAO();
%>

<input type="button" onclick="location.href='index.jsp'" value="홈"> 
<br>

<div class="log">
<form action="log.jsp" method="post" target="_self">
<input type="hidden" name="logAll" value="1">
<input type="submit" value="로그 전체보기">
</form>

<form action="log.jsp" method="post" target="_self">
<input type="text" name="logId" >
<input type="submit" value="id로 로그보기">
</form>


<form action="log.jsp" method="post" target="_self">
<input type="date" name="logDate">
<input type="submit" value="날짜로 로그보기">
</form>

<form action= "log.jsp" method="post" target="_self">
	<select name="logLanguage" class="sel">
		<option value="c">c</option>
		<option value="java">java</option>
		<option value="python">python</option>
		<option value="javascript">javascript</option>
		</select>
<input type="submit" value="언어별 로그보기">
</form>
</div>

<div class="userInfo">

<form action="log.jsp" method="post" target="_self">
<input type="hidden" name="infoAll" value=1 >
<input type="submit" value="유저리스트 전체 출력">
</form>

<form action="log.jsp" method="post" target="_self">
<input type="text" name="infoId" >
<input type="submit" value="id로 유저 검색">
</form>

<form action="log.jsp" method="post" target="_self">
<input type="text" name="infoName" >
<input type="submit" value="이름으로 유저 검색">
</form>

</div>
<hr>
<%
ArrayList<LogVO> logList = new ArrayList<LogVO>();
int logCheck=0;

//로그부분
if(request.getParameter("logAll")!=null){// 전체저장
	logCheck++;
	logList = Ldao.getLogAll();
}

if(request.getParameter("logDate")!=null){// 날짜별 저장
	String date="";
	
	date=request.getParameter("logDate");
	date = Ldao.changeDate(date);
	
	logList = Ldao.getLogByDate(date);
	
	logCheck++;
}

if(request.getParameter("logId")!=null){// id별로 저장
	String id = (String)request.getParameter("logId");
	logList = Ldao.getLogById(id);
	
	logCheck++;
}

if(request.getParameter("logLanguage")!=null){//언어별로 저장
	String language=(String)request.getParameter("logLanguage");
	logList = Ldao.getLogByLanguage(language);
	
	logCheck++;
}

if(logCheck==1)
	out.print(" id /  ip  /  최초 세션 생성 시각    /    최근 세션 접근 시각    /    container_id    / language /  Result <br>");

for(int i=0; i<logList.size(); i++){
	out.print(logList.get(i).getId());
	out.print(logList.get(i).getId2());
	out.print(logList.get(i).getSession1());
	out.print(logList.get(i).getSession2());
	out.print(logList.get(i).getContainerId());
	out.print(logList.get(i).getLanguage());
	out.print(logList.get(i).getResult());
	out.println("<br>");
} 




//info부분
ArrayList <memberVO> memberList = new ArrayList<memberVO>();
memberDAO mdao = new memberDAO();
int memberCheck=0;

if(request.getParameter("infoAll")!=null){// 전체저장
	memberList = mdao.getIdListAll();
	
	memberCheck++;
}

if(request.getParameter("infoId")!=null){// id별로 저장
	String id = (String) request.getParameter("infoId");
	memberList = mdao.getIdListById(id);
	
	memberCheck++;
}

if(request.getParameter("infoName")!=null){// 이름별로 저장
	String name = (String)request.getParameter("infoName");
	memberList = mdao.getIdListByName(name);
	
	memberCheck++;
}

if(memberCheck==1)
	out.print("id | 이름 | email<br>");

for(int i=0; i<memberList.size(); i++){
	out.print(memberList.get(i).getId()+" | ");
	out.print(memberList.get(i).getName()+" | ");
	out.print(memberList.get(i).getMail()+"<br>");
}

%>

</body>
</html>