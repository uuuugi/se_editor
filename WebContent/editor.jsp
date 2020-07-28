<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="code.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Editor For C</title>
<link rel="stylesheet" href="cssForIde.css" />
<style>

nav {
	width: 50vw;
	color:white;
	background-color: black;
	padding:1vh;
}

body {
	background-color: black;
	margin: 0;
}


</style>
</head>
<body>
	
	<%	
	request.setCharacterEncoding("utf-8"); 
	String codeName= (String)request.getParameter("codeName");
	%> 
	<nav>
	<input type="button" name="new" value="new" onclick="newFile()" />
	<input type="button" name="save" value="save" onclick="save()" /> 
	<input type="button" name="run" value="Run" onclick="play()" />
	
	<%
	if(codeName==null){ //codeName이 없을경우 == editor를 새로 열었을때
		%> <script type="text/javascript">
		var code ="SE Editor"; 
		var javaCode="// class의 이름을 SELAB으로만 가능\n// 밑의 코드가 Default Code\nclass SELAB {\n\n   public static void main(String[] args) {\n      System.out.println(\"Hello World\");\n\n   }\n}";
		var codeType=null;
		</script>
		
		<input type="text" id="codeName" name="codeName" value= "codeName" />
				
		<select name="selectCodeType" id="selectCodeType" onchange="changeLanguage(this.value)" >
		<option value="c">c</option>
		<option value="java">java</option>
		<option value="python">python</option>
		<option value="javascript">javascript</option>
		</select>
		<%
	}else{// codeName이 있을경우 == workSpaceList를 이용하여 코드를 불러왔을때
		String user_id=(String)session.getAttribute("id");
				
		codeDAO dao= new codeDAO();
		String codeType=dao.getCodeType(user_id,codeName);
		String tmpCode= dao.getCode(user_id,codeName);// code 불러오기
		String code="";
		String javaCode="";		
		String splitCode = "SE_uuugi_jjang_jjang,|SE_uuugi_jjang_jjang";// 이 코드를 기점으로 split 실행
	 	String[] afterSplitCode = tmpCode.split(splitCode);//split해서 라인별로 배열에 저장
				
		for(int i=0; i<afterSplitCode.length; i++){//라인+개행문자를 통해 하나의 변수에 저장
			code += afterSplitCode[i]; 
			code += "\\n";
			}
		javaCode=code;	
			%>
		
		<script>
		var code='<%=code%>' ; /* jsp data 를 js data로 옮김 */
		var javaCode='<%=javaCode%>';
		var codeType='<%= codeType%>';
		
		window.onload = function() {
			changeLanguage(codeType);
			};
		</script>
		<input type="text" id="codeName" name="codeName" value= '<%=codeName %>' />
		<%=codeType %>
		<% } %>
	</nav>
	
	<div id="monacoC" style="height: 90vh;"></div> <!-- 언어별로 div를 생성하여 각각 ide를 넣어줄것이다 -->
	<div id="monacoJava" style="height: 90vh; display:none;"></div>
	<div id="monacoPython" style="height: 90vh; display:none;"></div>
	<div id="monacoJavascript" style="height: 90vh; display: none;"></div>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/require.js/2.3.6/require.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.16.2/min/vs/loader.js"></script>

	<script>

     function changeLanguage(value){ // select box 에서 언어를 변경하면 그에 맞는 ide 창을 보여준다
         if(value=='c'){
             document.getElementById("monacoC").style.display="block";
             document.getElementById("monacoJava").style.display="none";
             document.getElementById("monacoPython").style.display="none";
             document.getElementById("monacoJavascript").style.display="none";
          }
          else if(value == 'java'){
             document.getElementById("monacoC").style.display="none";
             document.getElementById("monacoJava").style.display="block";
             document.getElementById("monacoPython").style.display="none";
             document.getElementById("monacoJavascript").style.display="none";
          }
          else if(value=='python'){
             document.getElementById("monacoC").style.display="none";
             document.getElementById("monacoJava").style.display="none";
             document.getElementById("monacoPython").style.display="block";
             document.getElementById("monacoJavascript").style.display="none";
          }

         else if(value=='javascript'){
             document.getElementById("monacoC").style.display="none";
             document.getElementById("monacoJava").style.display="none";
             document.getElementById("monacoPython").style.display="none";
             document.getElementById("monacoJavascript").style.display="block";
          }

     }
     
    var editorC;
    require.config({ paths: { 'vs': 'https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.16.2/min/vs' }});
    require(['vs/editor/editor.main'], function() {
      editorC = monaco.editor.create(document.getElementById('monacoC'), {
        theme: 'vs-dark',
        fontFamily: 'Nanum Gothic Coding',
        automaticLayout: true,
        EditorFindOptions:true,
        EditorLightbulbOptions:true, //전구
        language: 'c',
        value: [
        	code
        ].join('\n')
      });
    });
    
    var editorJava;
    require.config({ paths: { 'vs': 'https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.16.2/min/vs' }});
    require(['vs/editor/editor.main'], function() {
      editorJava = monaco.editor.create(document.getElementById('monacoJava'), {
        theme: 'vs-dark',
        fontFamily: 'Nanum Gothic Coding',
        automaticLayout: true,
        EditorFindOptions:true,
        EditorLightbulbOptions:true, //전구
        language: 'java',
        value: [
        	javaCode
        ].join('\n')
      });
    }); 
    
    var editorPython;
    require.config({ paths: { 'vs': 'https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.16.2/min/vs' }});
    require(['vs/editor/editor.main'], function() {
    	editorPython = monaco.editor.create(document.getElementById('monacoPython'), {
        theme: 'vs-dark',
        fontFamily: 'Nanum Gothic Coding',
        automaticLayout: true,
        EditorFindOptions:true,
        EditorLightbulbOptions:true, //전구
        language: 'python',
        value: [
        	code
        ].join('\n')
      });
    }); 
    
    var editorJavascript;
    require.config({ paths: { 'vs': 'https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.16.2/min/vs' }});
    require(['vs/editor/editor.main'], function() {
       editorJavascript = monaco.editor.create(document.getElementById('monacoJavascript'), {
        theme: 'vs-dark',
        fontFamily: 'Nanum Gothic Coding',
        automaticLayout: true,
        EditorFindOptions:true,
        EditorLightbulbOptions:true, //전구
        language: 'javascript',
        value: [
           code
        ].join('\n')
      });
    }); 

    function getCodeType()//select box에 있는 codeType을 가져오는 함수
    {
    	if(codeType==null){
    	var target = document.getElementById("selectCodeType");
        codeType= target.options[target.selectedIndex].text;
    	}
        return codeType;
    }
    
    function getCode(){ // 코드를 배열에 저장해서 반환함
    	
    	codeType=getCodeType();
		var code = new Array();
		var splitCode="SE_uuugi_jjang_jjang";// splitcode 이것을 기점으로 나눌예정
		
    	if(codeType=="c"){ // codeType 별로 ide div가 바뀌므로 현재 보고있는 ide의 창에 코드내용을 불러옴
    	var line= editorC.getModel().getLineCount();//라인수
  		 	for(var i=0; i<line; i++)
				code[i]=editorC.getModel().getLineContent(i+1)+splitCode;// 라인별 text에 splitcode 더해서 저장
		}
    	else if(codeType=="java"){
        	var line= editorJava.getModel().getLineCount();
     			for(var i=0; i<line; i++)
   				code[i]=editorJava.getModel().getLineContent(i+1)+splitCode;
    	}
    	else if(codeType=='python'){
        	var line= editorPython.getModel().getLineCount();
     			for(var i=0; i<line; i++)
   				code[i]=editorPython.getModel().getLineContent(i+1)+splitCode;
    	}
        else if(codeType=="javascript"){
            var line= editorJavascript.getModel().getLineCount();
            for(var i=0; i<line; i++)
             code[i]=editorJavascript.getModel().getLineContent(i+1)+splitCode;
        }

		return code;
    }

    function reloadWorkSpaceList()//workSpaceList 새로고침
    {
    	parent.frames.workSpaceList.location.reload();
    }
    
     function save() { // value 전체 가져오는 방법  + post 전송 + test
		var code=getCode();

		var newWinForSave = window.open("save.jsp", "PopUpWin", "width=200,height=200");//저장완료 창을 위한 새창 만들기

        var form = document.createElement("form");
        form.setAttribute("charset", "UTF-8");
        form.setAttribute("method", "Post");  //Post 방식
        form.setAttribute("target", "PopUpWin");//저장이되면 새창 출력
        form.setAttribute("action", "save.jsp"); //요청 보낼 주소
        
        var codeName= document.getElementById("codeName").value;// text창에 있는 value값 가져오기
        var hiddenField = document.createElement("input"); // codeName 넘기기 위해 form 생성
        hiddenField.setAttribute("type", "hidden");
        hiddenField.setAttribute("name", "codeName");
        hiddenField.setAttribute("value", codeName);
        form.appendChild(hiddenField);
        
        codeType=getCodeType();
        var hiddenField = document.createElement("input");// codeType 넘기기 위해 form 생성
        hiddenField.setAttribute("type", "hidden");
        hiddenField.setAttribute("name", "codeType");
        hiddenField.setAttribute("value", codeType);
        form.appendChild(hiddenField);
	
        var hiddenField = document.createElement("input"); //code 넘기기 위해 form 생성
        hiddenField.setAttribute("type", "hidden");
        hiddenField.setAttribute("name", "code");
        hiddenField.setAttribute("value", code);
        form.appendChild(hiddenField);
        
        document.body.appendChild(form);
        form.submit(); 
				
    }
   
	function play(){
		var code= getCode();
        codeType=getCodeType();
            
		
        var form = document.createElement("form");
        form.setAttribute("charset", "UTF-8");
        form.setAttribute("method", "Post");  //Post 방식
        form.setAttribute("action", "run.jsp"); //요청 보낼 주소1
/*         if(codeType=='c')
        	form.setAttribute("action", "run.jsp"); //요청 보낼 주소1
        else if(codeType=='c')
            form.setAttribute("action", "run.jsp"); //요청 보낼 주소2
        else(codeType=='c')
            form.setAttribute("action", "run.jsp"); //요청 보낼 주소3 */
        form.setAttribute("target", "run");

        var codeName= document.getElementById("codeName").value;
		var hiddenField = document.createElement("input"); // codeName 넘기기 위해 form 생성
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "codeName");
		hiddenField.setAttribute("value", codeName);
		form.appendChild(hiddenField);

		
		var hiddenField = document.createElement("input");// codeType 넘기기 위해 form 생성
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "codeType");
		hiddenField.setAttribute("value", codeType);
		form.appendChild(hiddenField);

		var hiddenField = document.createElement("input"); //code 넘기기 위해 form 생성
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "code");
		hiddenField.setAttribute("value", code);
		form.appendChild(hiddenField);

		document.body.appendChild(form);
		form.submit();

		}
	</script>
</body>
</html>
