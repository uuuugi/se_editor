<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="algorithm.*"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
a, a:link, a:visited {
	text-decoration: none;
	color: black;
}

body {
	margin-left: 0;
	margin-top: 0;
}

.listbutton {
	
}

.list {
	display: none;
}

#menu {
	margin: 0;
	padding: 0;
	width: 40vw;
	height: 100vw;
	background-color: red;
	display: none;
}

.sidenav {
  height: 100%;
  width: 0;
  position: fixed;
  z-index: 1;
  top: 0;
  left: 0;
  background-color: #111;
  overflow-x: hidden;
  transition: 0.5s;
  padding-top: 60px;
}

.sidenav a {
  padding: 8px 8px 8px 32px;
  text-decoration: none;
  font-size: 25px;
  color: #818181;
  display: block;
  transition: 0.3s;
}

.sidenav a:hover {
  color: #f1f1f1;
}

.sidenav .closebtn {
  position: absolute;
  top: 0;
  right: 25px;
  font-size: 36px;
  margin-left: 50px;
}

@media screen and (max-height: 450px) {
  .sidenav {padding-top: 15px;}
  .sidenav a {font-size: 18px;}
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
	function openNav() {
		  document.getElementById("mySidenav").style.width = "500px";
		}

		function closeNav() {
		  document.getElementById("mySidenav").style.width = "0";
		}
</script>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	String id = (String) session.getAttribute("id");
	algorithmDAO dao = new algorithmDAO();
	ArrayList<algorithmVO> algorithmListA = new ArrayList<algorithmVO>(dao.getAlgorithmList("test"));
	%>



<div id="mySidenav" class="sidenav">
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
  <a href="#" onclick ="showOrHide('listA')">About</a>
  <div id="listA" class="list">
			<%
				for (int i = 0; i < algorithmListA.size(); i++) {//코드 리스트 출력
				int result = dao.doesUserTry(id, algorithmListA.get(i).getNum());//시도한적이 있는지 체크
			%>
			<form action="algorithmList.jsp" target="_self"
				id='list<%=algorithmListA.get(i).getNum()%>' method='post'>
				<input type="hidden" name="num"
					value='<%=algorithmListA.get(i).getNum()%>'> <a href="#"
					onclick="document.getElementById('list<%=algorithmListA.get(i).getNum()%>').submit();"><%=algorithmListA.get(i).getName()%></a>
				<%
					if (result == 0)
					out.println("실패");
				else if (result == 1)
					out.println("성공");
				%>
			</form>
			<%
				}
			%>
		</div>
			
  <a href="#">Services</a>
  <a href="#">Clients</a>
  <a href="#">Contact</a>
</div>

<span style="font-size:30px;cursor:pointer" onclick="openNav()">&#9776; open</span>

	<%
		int algorithmNum;

	if (request.getParameter("num") != null) {//코드 설명 input ouput 출력
		algorithmNum = Integer.parseInt(request.getParameter("num"));
		algorithmVO vo = new algorithmVO();
		vo = dao.getAlgorithm(algorithmNum);
	%>

	<div>
		<!-- 알고리즘 설명 div -->
		<%=vo.getName()%>
		<%=vo.getExplanation()%>
		<%=vo.getExInput()%>
		<%=vo.getExOutput()%>

		<form action="editorForAlgorithm.jsp" target="editor" method="post">
			<input type="hidden" name="algorithmNum" value='<%=algorithmNum%>'>
			<input type="submit" value="도전">
		</form>
	</div>

	<%
		if (dao.doesUserTry(id, algorithmNum) != -1) // user가 시도한적이 있다면 작성했었던 코드리스트 출력
	{
		ArrayList<userAlgorithmCodeVO> userCodeList = new ArrayList<userAlgorithmCodeVO>();
		userCodeList = dao.getAlgorithmCodeList(id, algorithmNum);

		for (int i = 0; i < userCodeList.size(); i++) {
	%>
	<div class="list">
		<!-- 소스보기 옆에 결과를 같이 출력해줌 소스보기 클릭시 코드내용 출력 -->
		<span onclick="showOrHide('<%=userCodeList.get(i).getCodeNum()%>')">
			소스보기 </span>
		<%
			if (userCodeList.get(i).getResult() == 1)
			out.println("성공");
		else
			out.println("실패");
		%>
		<div id='<%=userCodeList.get(i).getCodeNum()%>'>
			사용언어 :
			<%=userCodeList.get(i).getCodeType()%>
			<br>
			<%=userCodeList.get(i).getCode()%>
			<form action="editorForAlgorithm.jsp" target="editor" method="post">
				<input type="hidden" name="codeNum"
					value='<%=userCodeList.get(i).getCodeNum()%>'> <input
					type="submit" value="에디터로 옮기기">
			</form>
		</div>
	</div>
	<%
		}
	}
}
	%>
	
</body>
</html>