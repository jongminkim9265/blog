<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<%@ taglib prefix="sec" uri = "http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<html>

<%--head.jsp--%>
<%@ include file="/WEB-INF/views/includes/head.jsp" %>

<body class="sidebar-mini layout-fixed vsc-initialized sidebar-collapse">
<div class="wrapper">

    <%--main_header.jsp--%>
    <%-- Main Header --%>
    <%@ include file="/WEB-INF/views/includes/main_header.jsp" %>

    <%--left_column.jsp--%>
    <%-- Left side column. contains the logo and sidebar --%>
    <%@ include file="/WEB-INF/views/includes/left_column.jsp" %>
    
    <%-- Content Wrapper. Contains page content --%>
        <%-- Content Header (Page header) --%>
        
        <div class="content-wrapper">
        <%-- Content Header (Page header) --%>
        	<section class="content-header">
            <h1> 게시판 
            <small>목록</small>
            </h1>
       <ol class="breadcrumb">
                <li class = "breadcrumb-item"><a href="${pageContext.request.contextPath }/boardList"><i class="fa fa-dashboard"></i> 게시판</a></li>
                <li class="breadcrumb-item active"> 일반</li>
                
            </ol>
        </section> 
        <sec:authorize access = "isAnonymous()">
            		<script>
            			alert("로그인을 해주세요.")
            			history.back()
            		</script>
    </sec:authorize>
    <sec:authorize access="isAuthenticated()"> 
	<form class = "card card-primary" action='<c:url value='/boardInsert?${_csrf.parameterName}=${_csrf.token}'/>' method="post" enctype="multipart/form-data">
		<div class="card-header">
			<h3 class = "card-title">글 작성</h3>
		</div>
        <div class="card-body">
              <label for="exampleFormControlInput1">제목</label>
            <input type="text" class="form-control" id="exampleFormControlInput1" name="title" placeholder="제목을 작성해주세요.">
          </div>
        <div class="card-body">
            <label for="exampleFormControlInput1">작성자</label>
            <input type="text" class="form-control" id="exampleFormControlInput1" name="crea_id" value="<%=session.getAttribute("name") %>" readonly>
          </div>
          <div class="card-body">
            <label for="exampleFormControlTextarea1">내용</label>
            <textarea class="form-control" id="exampleFormControlTextarea1" name="contents" rows="10"></textarea>
          </div>
         <div class="card-body" id="file-list">
         	<div id="fileDiv"> <p> 
         		<input type="file" id="file" name="file_0"> 
         		<a href="#this" class="btn btn-secondary" id="delete" name="delete">삭제</a>
         		<a href = "#this" class = "btn btn-success float-right" id = "addFile">파일추가</a>
         		 </p>
            </div>
         	</div>
        
        <div class="card-body">
        <input type="submit" class="btn btn-success float-right" value = "등록하기"/>
        <input type="button" class="btn btn-secondary" onclick = "history.back(-1);" value = "목록으로"/>
        </div>
    </form>
    </sec:authorize>
    </div>
    
    <%@ include file = "/WEB-INF/views/includes/include-body.jspf" %>
    <script type="text/javascript">
    	var gfv_count = '${fn:length(list)+1}';
    	$(document).ready(function() {
    		$("#addFile").on("click", function(e){
    			e.preventDefault();
    			fn_addFile();
    		});
    		
    		$("a[name='delete']").on("click", function(e) {
    			e.preventDefault();
    			fn_deleteFile($(this));
    		});
    	});
    
    function fn_addFile() {
    		var str = "<p><input type='file' name='file_"+(gfv_count++)+"'><a href='#this' class='btn btn-secondary' name='delete'>삭제</a></p>";
    		$("#file-list").append(str);
    		$("a[name='delete']").on("click",function(e) {
    			e.preventDefault();
    			fn_deleteFile($(this));
    		});
    	}
    function fn_deleteFile(obj) {
    	if (gfv_count < 1 )
    		obj.remove();
    	obj.parent().remove();
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