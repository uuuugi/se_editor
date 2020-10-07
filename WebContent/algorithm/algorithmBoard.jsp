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
div>div {
	display: none;
}

ul li, ul {
	list-style: none;
	padding-left: 0px;
}
</style>
<script>
	function showOrHide(id) {
		var box = document.getElementById(id);
		if (box.style.display != 'block')
			box.style.display = 'block';
		else
			box.style.display = 'none';
	}
	function go() {
		location.href = "./addAlgorithm.jsp"
	}
</script>
</head>
<body>
	<input type="button" onclick="location.href='../index.jsp'" value="홈">

	<%
		request.setCharacterEncoding("UTF-8");

	if ((String) session.getAttribute("authority") == null) //관리자가 아닐경우 index로 돌아감
		response.sendRedirect("../index.jsp");

	algorithmDAO dao = new algorithmDAO();
	ArrayList<algorithmVO> algorithmList1 = new ArrayList<algorithmVO>(dao.getAlgorithmList("level1"));
	ArrayList<algorithmVO> algorithmList2 = new ArrayList<algorithmVO>(dao.getAlgorithmList("level2"));
	ArrayList<algorithmVO> algorithmList3 = new ArrayList<algorithmVO>(dao.getAlgorithmList("level3"));
	ArrayList<algorithmVO> algorithmList4 = new ArrayList<algorithmVO>(dao.getAlgorithmList("level4"));
	%>
	<div>
		<span onclick="showOrHide('list1')">level1</span>
		<!-- 카테고리별로 생성해야함 -->
		<div id="list1">
			<ul>
				<%
					for (int i = 0; i < algorithmList1.size(); i++) {
				%>
				<li><%=algorithmList1.get(i).getName()%>
					<form action="addAlgorithm.jsp" target="_self"
						style="display: inline">
						<input type="hidden" name="algorithmNum"
							value='<%=algorithmList1.get(i).getNum()%>'> <input
							type="submit" value="수정하기">
					</form></li>
				<%
					}
				%>
			</ul>
		</div>
	</div>
	<div>
		<span onclick="showOrHide('list2')">level2</span>
		<!-- 카테고리별로 생성해야함 -->
		<div id="list2">
			<ul>
				<%
					for (int i = 0; i < algorithmList2.size(); i++) {
				%>
				<li><%=algorithmList2.get(i).getName()%>
					<form action="addAlgorithm.jsp" target="_self"
						style="display: inline">
						<input type="hidden" name="algorithmNum"
							value='<%=algorithmList2.get(i).getNum()%>'> <input
							type="submit" value="수정하기">
					</form></li>
				<%
					}
				%>
			</ul>
		</div>
	</div>
	<div>
		<span onclick="showOrHide('list3')">level3</span>
		<!-- 카테고리별로 생성해야함 -->
		<div id="list3">
			<ul>
				<%
					for (int i = 0; i < algorithmList3.size(); i++) {
				%>
				<li><%=algorithmList3.get(i).getName()%>
					<form action="addAlgorithm.jsp" target="_self"
						style="display: inline">
						<input type="hidden" name="algorithmNum"
							value='<%=algorithmList3.get(i).getNum()%>'> <input
							type="submit" value="수정하기">
					</form></li>
				<%
					}
				%>
			</ul>
		</div>
	</div>
	<div>
		<span onclick="showOrHide('list4')">level4</span>
		<!-- 카테고리별로 생성해야함 -->
		<div id="list4">
			<ul>
				<%
					for (int i = 0; i < algorithmList4.size(); i++) {
				%>
				<li><%=algorithmList4.get(i).getName()%>
					<form action="addAlgorithm.jsp" target="_self"
						style="display: inline">
						<input type="hidden" name="algorithmNum"
							value='<%=algorithmList4.get(i).getNum()%>'> <input
							type="submit" value="수정하기">
					</form></li>
				<%
					}
				%>
			</ul>
		</div>
	</div>
	<input type="button" value="알고리즘 추가" onclick="go()">
</body>
</html>