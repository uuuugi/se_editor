<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
	Spectral by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
	<script>
		function logOut(){
		location.href="logout.jsp";
		alert("Logout success!");
		}
		</script>
		
		<title>SE_editor</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="./css/assets/css/main.css" />
		<link rel="stylesheet" href="./css/assets/css/noscript.css" />
	</head>
	<body class="landing is-preload">
	<% request.setCharacterEncoding("utf-8"); %>
		<!-- Page Wrapper -->
			<div id="page-wrapper">

				<!-- Header -->
					<header id="header" class="alt">
						<h1><a href="index.jsp">UP</a></h1>
						<nav id="nav">
							<ul>
								<li class="special">
									<a href="#menu" class="menuToggle"><span>Menu</span></a>
									<div id="menu">
										<ul>
											<li><a href="index.jsp">Home</a></li>
											<li><a href="ide/IDE.jsp" target="_blank">SE IDE</a></li>
											<li><a href="algorithm/algorithm.jsp" target="_blank">Algorithm</a></li>
											<li><a href="bulletinBoard/bulletinBoardList.jsp">BulletinBoard</a></li>
											<li><a href="inquiry/inquiry.jsp">inquiry</a></li>
											<% 	
											if("master".equals( (String)session.getAttribute("authority")) ){%>
											<li><a href="inquiry/inquiryMasterMode.jsp">문의 답변</a></li>
											<li><a href="algorithm/algorithmBoard.jsp">알고리즘 추가</a></li>
											<li><a href="./log.jsp">로그 보기</a></li>
											<%}if( session.getAttribute("id")==null){
												%>
											<li><a href="LoginFormServlet">Login</a></li>
											<% }else{ %>
											<li><a href="userInfo/pwCheckForModify.jsp">Modifycation</a></li>
											<li><a href="#" onclick="logOut()">logout</a></li>
											<%} %>
										</ul>
									</div>
								</li>
							</ul>
						</nav>
					</header>

				<!-- Banner -->
					<section id="banner">
						<div class="inner">
							<h2>WORKSPACE</h2>
							<p>This is your workplace<br />
							This site is available in several languages<br />
							Let's coding now!</p>
							<ul class="actions special">
								<li><a href="ide/IDE.jsp" class="button primary">Go WorkSpace</a></li>
							</ul>
						</div>
						<a href="#one" class="more scrolly">This site?</a>
					</section>

				<!-- One -->
					<section id="one" class="wrapper style1 special">
						<div class="inner">
							<header class="major">
								<h2>This site for <br />coding on the web</h2>
								<p> It will be very effective if you want to code without programming<br />
								This site supports java, c, javascript, and python.<br />
								We hope this site is useful to you
								</p>
							</header>
							<ul class="icons major">
								<li><span class="icon fa-gem major style1"><span class="label">Lorem</span></span></li>
								<li><span class="icon fa-heart major style2"><span class="label">Ipsum</span></span></li>
								<li><span class="icon solid fa-code major style3"><span class="label">Dolor</span></span></li>
							</ul>
						</div>
					</section>

				<!-- Two -->
					<section id="two" class="wrapper alt style2">
						<section class="spotlight">
							<div class="image"><img src="./css/images/pic01.jpg" alt="" /></div><div class="content">
								<h2>SE LAB</h2>
								<p>ì´ ì¬ì´í¸ë  SE LAB ííì´ì§ì <br/> ë¶ê°ì ì¸ ê¸°ë¥ì´ë¤.<br /> 
								ííì´ì§ììë SE LABì ë¤ìí <br />ì ë³´ ë° ìì ë¡ì´ íê²½ì ì ê³µíë¤.<br />
								ì¬ë¬ ê²ìíë¤ì ì´ì©íì¬<br /> SEë´ì ë¤ìí ì ë³´ë¥¼ ì ê³µíë¤</p>
							</div>
						</section>
						<section class="spotlight">
							<div class="image"><img src="./css/images/pic02.jpg" alt="" /></div><div class="content">
								<h2>Web Coding Site</h2>
								<p>ì´ ì¬ì´í¸ë ê°ì ê°ì¸ì <br /> workspaceë¥¼ ì ê³µíë¤.<br />
								WORKSPACEë MONACO <br />EDITORì ì´ì©íì¬ ë§ë¤ì´ì¡ì¼ë©°,
								<br />C, JAVA, PYTHON, JS 
								<br />ë±ì ì¸ì´ë¤ì ì¬ì©íì¬ ìì±í ì½ëë¥¼ ì ì¥ ë° ì¤ííë¤.</p>
							</div>
						</section>
						<section class="spotlight">
							<div class="image"><img src="./css/images/pic03.jpg" alt="" /></div><div class="content">
								<h2>BulletinBoard</h2>
								<p>ì´ ì¬ì´í¸ë¥¼ ì´ì©íë ì¸ìì´<br/> ìíµí ì ìë ê²ìíì ì ê³µíë¤.
								ì½ë©ì ì¬ì©íë¤ ë°ìíë ë¬¸ì , í¹ì <br/> íìí ë´ì©ë¤ì ìíµê°ë¥íê² íê³ ì íë¤.</p>
							</div>
						</section>
					</section>

				<!-- CTA -->
					<section id="cta" class="wrapper style4">
						<div class="inner">
							<header>
								<h2>GO SE LAB</h2>
								<p>SE ííì´ì§ì ë¤ìí ê¸°ë¥ì ì¬ì©íê¸°ë¥¼ ìíë¤ë©´?</p>
							</header>
							<ul class="actions stacked">
								<li><a href="#" class="button fit primary">GO</a></li>
								<li><a href="#" class="button fit">SE_LOGIN</a></li>
							</ul>
						</div>
					</section>

				<!-- Footer -->
					<footer id="footer">
						<ul class="icons">
							<li><a href="#" class="icon brands fa-dribbble"><span class="label">SE</span></a></li>
							<li><a href="#" class="icon brands fa-twitter"><span class="label">Twitter</span></a></li>
							<li><a href="#" class="icon brands fa-facebook-f"><span class="label">Facebook</span></a></li>
							<li><a href="#" class="icon brands fa-instagram"><span class="label">Instagram</span></a></li>
							<li><a href="#" class="icon solid fa-envelope"><span class="label">Hanshin</span></a></li>
						</ul>
						
						<ul class="copyright">
							<li>&copy; SE LAB</li><li>GO HOME: <a href="http://html5up.net">SE</a></li>
						</ul>
					</footer>

			</div>

		<!-- Scripts -->
			<script src="./css/assets/js/jquery.min.js"></script>
			<script src="./css/assets/js/jquery.scrollex.min.js"></script>
			<script src="./css/assets/js/jquery.scrolly.min.js"></script>
			<script src="./css/assets/js/browser.min.js"></script>
			<script src="./css/assets/js/breakpoints.min.js"></script>
			<script src="./css/assets/js/util.js"></script>
			<script src="./css/assets/js/main.js"></script>

	</body>
</html>