<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="algorithm.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Editor For C</title>
<link rel="stylesheet" href="cssForIde.css" />
<style>
header {
	width: 50vw;
	color: white;
	background-color: black;
	padding: 1vh;
}
body {
	background-color: black;
	margin: 0;
}
</style>

<script>
	var editor;
    
    function createEdtior(){
        var language=getCodeType(); // codeType 가져오기 codeType에 따라 editor의 언어 설정이 바뀜
        
        if(language=='c')
        	code= "//SE Edtior\n//제목에 공백을 입력하지 말아주세요 \n#include <stdio.h>\n\nint main(void)\n{\n	printf(\"Hello World\");\n	return 0;\n}"; 
        else if(language=='java')
        	code= "// SE Editor\n//제목에 공백을 입력하지 말아주세요 \n//class의 이름을 SELAB으로만 가능\n// 밑의 코드가 Default Code\nclass SELAB {\n\n   public static void main(String[] args) {\n      System.out.println(\"Hello World\");\n\n   }\n}";
        else if(language=='python')
        	code= "#SE Edtior\n#제목에 공백을 입력하지 말아주세요 \nprint('Hello World')";
        else if(language=='javascript')
        	code= "//SE Editor\n//제목에 공백을 입력하지 말아주세요 \nconsol.log(\"Hello World\")";
        	
		var remove = document.getElementById('editorDiv');
		if(remove!=null)// 만약 editor div가 있다면 삭제
			document.body.removeChild(remove);
		
   	    var newDiv = document.createElement('div');
   	    newDiv.style.height= '90vh';
   	 	newDiv.id= "editorDiv";
   	    document.body.appendChild(newDiv);// editor div를 동적으로 생성
   	    // editor
        require.config({ paths: { 'vs': 'https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.16.2/min/vs' }});
        require(['vs/editor/editor.main'], function() {
          editor = monaco.editor.create(document.getElementById('editorDiv'), {
            theme: 'vs-dark',
            fontFamily: 'Nanum Gothic Coding',
            automaticLayout: true,
            language: language,
            value: [
              code
            ].join('\n')
          });
        });
    }
    
    function createEdtiorInSelect(){// 셀렉트에서 editor 바꿀경우 바뀌지 않는 버그 수정을 위해 codeType을 초기화 시켜주는 함수를 하나 더 만듬
    	codeType=null;
    	createEdtior();
    }
   function createForm(){//form 생성 및 submit
   	  var form = document.createElement("form");//폼 생성
   	  
   	  form.setAttribute("charset", "UTF-8");//인코딩 타입
   	  form.setAttribute("method", "Post");  //전송 방식
   	  form.setAttribute("target", "run");//타겟의 이름
   	  form.setAttribute("action", actionURL); //요청 보낼 주소
   	  
   	  var hiddenField = document.createElement("input"); // input 버튼 생성
   	  hiddenField.setAttribute("type", "hidden");
   	  hiddenField.setAttribute("name", "codeName");
   	  hiddenField.setAttribute("value", codeName);
   	  form.appendChild(hiddenField);// form에 추가
   	  
   	  var hiddenField = document.createElement("input");
   	  hiddenField.setAttribute("type", "hidden");
   	  hiddenField.setAttribute("name", "codeType");
   	  hiddenField.setAttribute("value", codeType);
   	  form.appendChild(hiddenField);
   	  
   	  if(codeType=="c")
   		form.setAttribute("action", urlForc); //요청 보낼 주소
   	  else if(codeType=="java")
     	form.setAttribute("action", urlForJava); //요청 보낼 주소
      else if(codeType=="python")
        form.setAttribute("action", urlForPython); //요청 보낼 주소
      else if(codeType=="javascript")
        form.setAttribute("action", urlForJavascript); //요청 보낼 주소
   		 
   	  code=getCode();
   	  var hiddenField = document.createElement("input");
   	  hiddenField.setAttribute("type", "hidden");
   	  hiddenField.setAttribute("name", "code");
   	  hiddenField.setAttribute("value", code);
   	  form.appendChild(hiddenField);
   	  
   	  document.body.appendChild(form);//form을 body에 생성
   	  form.submit(); //submit
   	}
	function play(){
		createForm();
	}
   function getCodeType(){  //select box에 있는 codeType을 가져오는 함수
   	if(codeType==null){
   	var target = document.getElementById("selectCodeType");
       codeType= target.options[target.selectedIndex].text;
   	}
       return codeType;
   }
   function getCode(){ // 코드를 배열에 저장해서 반환함
		var code = new Array();
		var splitCode="SE_uuugi_jjang_jjang";// splitcode 이것을 기점으로 나눌예정
		
		var line= editor.getModel().getLineCount();//라인수
 		 	for(var i=0; i<line; i++)
				code[i]=editor.getModel().getLineContent(i+1)+splitCode;// 라인별 text에 splitcode 더해서 저장 
		return code;
   }
   function reloadWorkSpaceList(value){   //workSpaceList 새로고침
   	parent.frames.workSpaceList.location.reload();
   	if(value=='true')
   		alert("저장 완료");
   	else
   		alert("error :: 관리자에게 문의주세요");
   }
	</script>

</head>
<body>
<% request.setCharacterEncoding("utf-8"); %>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/require.js/2.3.6/require.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.16.2/min/vs/loader.js"></script>

	<header>
		<input type="button" name="run" value="Run" onclick="play()" />

		<% if (request.getParameter("codeNum")!=null) //codeNum이 null이 아닐때 == 코드를 불러왔을때
		{ 
		
		int codeNum = Integer.parseInt(request.getParameter("codeNum"));
		
		String user_id = (String) session.getAttribute("id");
		algorithmDAO dao = new algorithmDAO();
		userAlgorithmCodeVO vo = new userAlgorithmCodeVO();
		vo = dao.getAlgorithmCode(user_id, codeNum);
		String codeType = vo.getCodeType();
		String tmpCode = vo.getCode();// code 불러오기
		String code = "";
		String splitCode = "SE_uuugi_jjang_jjang,|SE_uuugi_jjang_jjang";// 이 코드를 기점으로 split 실행
		String[] afterSplitCode = tmpCode.split(splitCode);//split해서 라인별로 배열에 저장
		for (int i = 0; i < afterSplitCode.length; i++) {//라인+개행문자를 통해 하나의 변수에 저장
			code += afterSplitCode[i];
			code += "\\n";
		} %>

		<script>
		var code='<%=code%>';
		var codeType= '<%=codeType%>';
			window.onload = function() {// 불러온 언어에 맞게 editor변경
				createEdtior();
			};
		</script>
		
		<% } else {%>
		<script type="text/javascript">
		var code;
		var codeType=null;
		
		window.onload = function() {// defualt editor 생성 
			createEdtior();
			};
		</script>
<% } %>

		<select name="selectCodeType" id="selectCodeType" onchange="createEdtiorInSelect()">
			<option value="c">c</option>
			<option value="java">java</option>
			<option value="python">python</option>
			<option value="javascript">javascript</option>
		</select>
		
	</header>
</body>
</html>