<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.UUID"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItem"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	//apache commons-fileupload를 이용한 request 처리 
	
	String imgFileName="";
	//사용자의 요청이 익스플로러 계열인지 확인하기
	String agent = request.getHeader("User-Agent");
	boolean ieBrowser = (agent.indexOf("MSIE") > -1) || (agent.indexOf("Trident") > -1) || (agent.indexOf("Edge") > -1);

	//request안에 multipart/form-data가 있는지 확인
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);

	if (isMultipart) {
		//factory생성 
		DiskFileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);

		//업로드 가능한 사이즈 지정
		upload.setSizeMax(2000 * 1024);

		//사용자의 요청 중 일반요소(Form field)와 file로 온 것 분리
		List<FileItem> items = upload.parseRequest(request);
	
		//해석된 구문 처리하기 
		Iterator<FileItem> iter = items.iterator();
		while (iter.hasNext()) {
			FileItem item = iter.next();

				String fieldName = item.getFieldName();
				//익스계열인 경우 fileName이 파일이 있었던 경로까지 포함해서 설정됨 
				//fileName저장시 경로를 떼어내고 저장하기
				String fileName = null;
				
				if (ieBrowser) {
					int pos = item.getName().lastIndexOf("\\");
					fileName = item.getName().substring(pos + 1);
				} 
				else {
				fileName = item.getName();
				}
			long sizeInBytes = item.getSize();

			//파일저장
			UUID id = UUID.randomUUID();
			File uploadfile = new File("C:\\Users\\안병욱\\Desktop\\test\\" + id + "_" + fileName);// 파일 저장 경로
			
			imgFileName=id+"_"+fileName;
			
			item.write(uploadfile);
		}
	}
%>
<script>
window.onload = function () {

	 var form = document.createElement("form");//폼 생성
	   	  
	 form.setAttribute("charset", "UTF-8");//인코딩 타입
	 form.setAttribute("method", "Post");  //전송 방식
	 form.setAttribute("target", "_self");//타겟의 이름
	 form.setAttribute("action", actionURL); //요청 보낼 주소
	   	  
	 var hiddenField = document.createElement("input"); // input 버튼 생성
	 hiddenField.setAttribute("type", "hidden");
	 hiddenField.setAttribute("name", "fileName");
	 hiddenField.setAttribute("value", '<%=imgFileName%>');
	 form.appendChild(hiddenField);// form에 추가
	   	  
	 document.body.appendChild(form);//form을 body에 생성
	 form.submit(); //submit
	   	
}
</script>
</body>
</html>