<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%
request.setCharacterEncoding("utf-8");

String publicKeyModulus = (String) request.getAttribute("publicKeyModulus");
String publicKeyExponent = (String) request.getAttribute("publicKeyExponent");

 %>
	<title>Login V10</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
	
	<style type="text/css">
	#login_btn{
		text-decoration:none;
	}
	</style>
<title>Insert title here</title>
</head>
<body>
		<div class="container-login100">
			<div class="wrap-login100 p-t-50 p-b-90">
					<span class="login100-form-title p-b-51">
						Login
					</span>
					
					<input type="hidden" id="rsaPublicKeyModulus" value="<%=publicKeyModulus%>" />
            		<input type="hidden" id="rsaPublicKeyExponent" value="<%=publicKeyExponent%>" />
         
						<div class="wrap-input100 validate-input m-b-16" data-validate = "Username is required">
								<label for="username"><input class="input100" type="text" name="username" id="username" placeholder="ID" required /></label>
								<span class="focus-input100"></span>
						</div>
							<div class="wrap-input100 validate-input m-b-16" data-validate = "Password is required">
								<label for="password"><input class="input100" type="password" name="password" id="password" placeholder="pw" required /></label>
								<span class="focus-input100"></span>
							</div>
						<div class="container-login100-form-btn m-t-17">
							 <a href="<%=request.getContextPath()%>/loginFailure.jsp" class="login100-form-btn" type="submit" id="login_btn"onclick="validateEncryptedForm(); return false;">Login</a>
						</div>
					
					<form id="securedLoginForm" name="securedLoginForm" action="<%=request.getContextPath()%>/login" method="post" style="display: none;">
            			<input type="hidden" name="securedUsername" id="securedUsername" value="" />
            			<input type="hidden" name="securedPassword" id="securedPassword" value="" />
        			</form>
					<div class="sign">
					<form method="post">
					<br/>
						<span class="txt1">Let's</span> &nbsp; <a class="txt1" href="join/join.jsp">Sign up</a>          
						<a class="txt2" href='findIdPw/findPw.jsp'> PW</a>
						<a class="txt2" href='findIdPw/findId.jsp'>forget? ID /</a>
					</form>
					</div>
					
			</div>
		</div>
	    <!-- script 태그에서 가져오는 자바스크립트 파일의 순서에 주의해야한다! 순서가 틀릴경우 자바스크립트 오류가 발생한다. -->
        <script type="text/javascript" src="./js/rsa/jsbn.js"></script>
        <script type="text/javascript" src="./js/rsa/rsa.js"></script>
        <script type="text/javascript" src="./js/rsa/prng4.js"></script>
        <script type="text/javascript" src="./js/rsa/rng.js"></script>
        <script type="text/javascript" src="./js/login.js"></script>
</body>
</html>