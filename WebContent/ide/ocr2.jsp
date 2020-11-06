<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
*{
	color:white;
}
.button1{
	color:black;
}
#image_conteiner{
	width:150px;
	height:150px;
}
</style>
</head>
<body>
	<div id="image_container"></div>
	<form method="post" enctype="multipart/form-data" action="ocr2.jsp" target="ocr" id="image" onchange="setThumbnail(event);">
		<p>
			<input type="file" name="filename"> <br>
			<input type="hidden" name ="isfile" value=1>
		</p>
		<p>
			<input class="button1" type="submit" value="전송">
		</p>
	</form>
<script>	
	function setThumbnail(event) { // 이미지 입력시 미리보기
		var reader = new FileReader(); 
		reader.onload = function(event) { 
			var img = document.createElement("img"); 
			img.setAttribute("src", event.target.result);
			img.setAttribute("width","150px");
			img.setAttribute("height","150px");
			document.querySelector("div#image_container").appendChild(img); 
			};
		reader.readAsDataURL(event.target.files[0]);
	}
</script>

	<%
		request.setCharacterEncoding("UTF-8");
	//apache commons-fileupload를 이용한 request 처리 
		String path = "C:\\Users\\안병욱\\Desktop\\java\\fileUpload2"; // 경로

	String imgFileName = ""; // fileUpload에 사용하는 변수
	String ocrCode = "" , imgUrl = ""; // ocr에 사용하는 변수
	int isfile=0;
	if(request.getParameter("isfile")!=null)
		isfile = Integer.parseInt(request.getParameter("isfile"));
	String fileName = "";    // 업로드한 파일 이름
	
	//request안에 multipart/form-data가 있는지 확인
	
	if(request.getAttribute("ocrCode")!=null) // ocrCode가 있는지 확인
	{
		ocrCode = (String) request.getAttribute("ocrCode");
		imgUrl = (String) request.getAttribute("imgUrl");
		
		%>
		<div class="code">
			<img src="/usr/local/apache/share/<%=imgUrl %>">
			<%=ocrCode%>
		</div>

		<form action="./editor.jsp" target="editor" method="post">
			<input type="hidden" name="ocr" value="1"> 
			<input type="hidden" name="ocrCode" value='<%=ocrCode%>'> 
			<input class="button1" type="submit" value="에디터로 코드 옮기기">
		</form>
	<%
		return ;
		}
	
	else if (isfile==1) { // 사진이 있을경우
	
		int size = 1024 * 1024 * 10; // 파일 사이즈 설정 : 10M
	    String originalFileName = "";    //  서버에 중복된 파일 이름이 존재할 경우 처리하기 위해
	    
	    // cos.jar라이브러리 클래스를 가지고 실제 파일을 업로드하는 과정
	    try{
	        // DefaultFileRenamePolicy 처리는 중복된 이름이 존재할 경우 처리할 때
	        // request, 파일저장경로, 용량, 인코딩타입, 중복파일명에 대한 정책
	        MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());
	        
	        // 전송한 전체 파일이름들을 가져온다.
	        Enumeration files = multi.getFileNames();
	        String str = (String)files.nextElement();
	        
	        //파일명 중복이 발생했을 때 정책에 의해 뒤에 1,2,3 처럼 숫자가 붙어 고유 파일명을 생성한다.
	        // 이때 생성된 이름을 FilesystemName이라고 하여 그 이름 정보를 가져온다. (중복 처리)
	        fileName = multi.getFilesystemName(str);
	        //실제 파일 이름을 가져온다.
	        originalFileName = multi.getOriginalFileName(str);
	        
	    }catch(Exception e){
	        e.printStackTrace();
	    }
				
	%>
	<script>

window.onload = function () {

	 var form = document.createElement("form");//폼 생성
	   	  
	 form.setAttribute("charset", "UTF-8");//인코딩 타입
	 form.setAttribute("method", "Post");  //전송 방식
	 form.setAttribute("action", "Servlet"); //요청 보낼 주소
	   	  
	 var hiddenField = document.createElement("input"); // input 버튼 생성
	 hiddenField.setAttribute("type", "hidden");
	 hiddenField.setAttribute("name", "fileName");
	 hiddenField.setAttribute("value", "<%=fileName%>");
	 form.appendChild(hiddenField);// form에 추가
	   	  
	 document.body.appendChild(form);//form을 body에 생성
	 form.submit(); //submit
	   	
}
</script>
<%} %>
</body>
</html>