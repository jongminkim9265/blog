<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ include file="/WEB-INF/views/includes/00_head.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri = "http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
</head>

<body>
<%
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    Object principal = auth.getPrincipal();
 
    String name = "";
    if(principal != null) {
        name = auth.getName();
    }
%>
	<sec:authorize access = "isAnonymous()">
            		<script>
            			alert("로그인을 해주세요.")
            			history.back()
            		</script>
    </sec:authorize>
    <sec:authorize access="isAuthenticated()"> 
	<form action='<c:url value='/boardInsert?${_csrf.parameterName}=${_csrf.token}'/>' method="post" enctype="multipart/form-data">
        <div class="form-group">
              <label for="exampleFormControlInput1">제목</label>
            <input type="text" class="form-control" id="exampleFormControlInput1" name="title" placeholder="제목을 작성해주세요.">
          </div>
        <div class="form-group">
            <label for="exampleFormControlInput1">작성자</label>
            <input type="text" class="form-control" id="exampleFormControlInput1" name="crea_id" value="<%=name %>" readonly>
          </div>
          <div class="form-group">
            <label for="exampleFormControlTextarea1">내용</label>
            <textarea class="form-control" id="exampleFormControlTextarea1" name="contents" rows="10"></textarea>
          </div>
         <div class="form-group" id="file-list">
         	<div id="fileDiv"> <p> 
         		<input type="file" id="file" name="file_0"> 
         		<a href="#this" class="btn" id="delete" name="delete">삭제</a>
         		 </p> 
            </div>
         	</div>
        <a href = "#this" class = "btn-btn-info" id = "addFile">파일추가</a>
        <button type="submit" class="btn btn-info">등록하기</button>
        <button type="button" class="btn btn-info" onclick = "history.back(-1); return false;">목록으로</button>
    </form>
    </sec:authorize>
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
    		var str = "<p><input type='file' name='file_"+(gfv_count++)+"'><a href='#this' class='btn' name='delete'>삭제</a></p>";
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
</body>
</html>