<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<%--head.jsp--%>
<%@ include file="/WEB-INF/views/includes/head.jsp" %>
<%
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    Object principal = auth.getPrincipal();
 	int count = 0;
    String name = "";
    if(principal != null) {
    	name = auth.getName();
    	session.setAttribute("name", name);
        
    }
    else{
    	session.setAttribute("name", "익명");
    }
    
%>
<body class="sidebar-mini layout-fixed vsc-initialized sidebar-collapse">
<div class="wrapper">

    <%--main_header.jsp--%>
    <%-- Main Header --%>
    <%@ include file="/WEB-INF/views/includes/main_header.jsp" %>

    <%--left_column.jsp--%>
    <%-- Left side column. contains the logo and sidebar --%>
    <%@ include file="/WEB-INF/views/includes/left_column.jsp" %>
     
    <%-- Content Wrapper. Contains page content --%>
    <div class="content-wrapper">
        <%-- Content Header (Page header) --%>
        <section class="content-header">
        <ol class="breadcrumb">
                <li><a href="#"><i class="fas fa-dashboard"></i> HOME</a></li>
        </ol>
        <br>
            <h2>
                개인 프로젝트
                <small>김종민</small>
            </h2>
            
        </section>
		<sec:authorize access = "isAuthenticated()">
<!-- <button type = "button" class = "btn btn-app" data-target="#layerpop" data-toggle="modal" onclick = "openSocket();"> -->
   <div class = "card card-prirary cardutline direct-chat direct-chat-primary">
   <div class = "card-header">
   	<h3 class = "card-header"> 1:1 대화방</h3>   	
   	<button type="button" class="btn btn-tool" data-card-widget="remove"><i class="fas fa-times"></i>
    </button>    
    </div>
    <div id = "messages" class = "card-body">
    
    </div>
	<div class="card-footer">
	<div class="input-group">
    <input type="text" id="sender" value="<%=name %>" style="display: none;">
        <input type="text" id="messageinput" onkeyup="enterkey()" class="form-control">
        <button type="button" class="btn btn-primary" onclick="send();" >Send</button>
        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="closeSocket();">닫기</button>
    </div>
    </div>
   	
   
   </div>
   </sec:authorize>
        <%-- Main content --%>
        <section class="content container-fluid">
        	<div class ="card">
        		<div class ="card-header">
        		<h4 class="card-title">개인 프로젝트 메인 페이지입니다.</h4>
        		</div>
        		<br>
        		<div class = "card-title">
        		<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
				<sec:authorize access = "isAuthenticated()">
        		<button type = "button" class = "btn btn-app" data-target="#layerpop" data-toggle="modal" onclick = "openSocket();">
        		<span class="badge bg-purple">new</span>
        		<i class = "fa fa-users">
        		</i>
        		채팅방 입장
        		</button><br/>
        		</sec:authorize>
        		</div> 
        	</div>
        	<div class="modal fade" id="layerpop" >
   
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- header -->
      <div class="modal-header">
      	<h4 class="modal-title">채팅방 입장</h4>
        <!-- 닫기(x) 버튼 -->
        <button type="button" class="close" data-dismiss="modal">×</button>
        <!-- header title -->
        
      </div>
      <!-- body -->
      <div id="messages" class="modal-body">
      
      </div>
      <div class="modal-body">
        
    
      </div>
      <!-- Footer -->
      <div class="modal-footer">
      <div class="input-group">
      	<input type="text" id="sender" value="<%=name %>" style="display: none;">
        <input type="text" id="messageinput" onkeyup="enterkey()">
        <button type="button" class="btn btn-default" onclick="send();" >Send</button>
        <button type="button" class="btn btn-default" data-dismiss="modal" onclick="closeSocket();">닫기</button>
      </div>
    </div>
  </div>
</div>
        </section>
    </div>
<script type = "text/javascript">
    var ws;
    var messages=document.getElementById("messages");
    var count = 0;
    function openSocket(){
    	
        if(ws!==undefined && ws.readyState!==WebSocket.CLOSED){
            return;
        }
        //웹소켓 객체 만드는 코드
        ws=new WebSocket("ws://localhost:8080/blog/echo.do");
        
        ws.onopen=function(event){
        	count += 1;
            if(event.data===undefined)
            	 writeResponse("채팅방 입장");
            return;
           
        };
        ws.onmessage=function(event){
        	 writeResponse(event.data);
        };
        ws.onclose=function(event){
            writeResponse(document.getElementById("sender").value + "님이 퇴장하셨습니다.");
        }
    }
    
    function send(){
        var text=document.getElementById("messageinput").value+","+document.getElementById("sender").value;
        ws.send(text);
    }
    
    function closeSocket(){
    	count -= 1;
        ws.close();
    }
    function writeResponse(text){
        messages.innerHTML+="<br/>"+text.split(",")[0];
    }
	function enterkey() {
		if (window.event.keyCode == 13){
			send();
		}
		
	
	}
	
	
</script>
    <%-- /.content-wrapper --%>

    <%--main_footer.jsp--%>
    <%-- Main Footer --%>
    <%@ include file="/WEB-INF/views/includes/main_footer.jsp" %>

</div>
<%-- ./wrapper --%>

<%--plugin_js.jsp--%>
<%@ include file="/WEB-INF/views/includes/plugin_js.jsp" %>

</body>
</html>