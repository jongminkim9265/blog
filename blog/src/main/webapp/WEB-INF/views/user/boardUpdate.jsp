<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ include file="/WEB-INF/views/includes/00_head.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
</head>
	<% 
	 Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    Object principal = auth.getPrincipal();
 
    String name = "";
    if(principal != null) {
        name = auth.getName();
    }
    %>
<body>
	
	<input type = "hidden" name = "crea_id" value = "${detail.CREA_ID}"/>
	<input type = "hidden" name = "current_user" value = "<%=name %>"/>
	<c:set var = "crea_id" value = "${detail.CREA_ID}"/>
	<c:set var = "current_user" value = "<%=name %>"/>
	<c:choose>
	<c:when test = "${crea_id == current_user }">
	<sec:authorize access="isAuthenticated()">
	<div class="container col-md-6">
    <form action='<c:url value='/boardUpdate${pageMaker.makeQueryPage(page)}'/>' method="post" enctype = "multipart/form-data">
        <div class="form-group">
            <label for="exampleFormControlInput1">제목</label>
            <input type="text" class="form-control" id="exampleFormControlInput1" name="title" value="${detail.TITLE }">
        </div>
        <div class="form-group">
            <label for="exampleFormControlInput1">작성자</label>
            <input type="text" class="form-control" id="exampleFormControlInput1" name="crea_id" value="${detail.CREA_ID }" readonly>
        </div>
        <div class="form-group">
            <label for="exampleFormControlTextarea1">내용</label>
            <textarea class="form-control" id="exampleFormControlTextarea1" rows="10" name="contents">${detail.CONTENTS }</textarea>
        </div>
        <div id="fileDiv" class = "form-group">
        	<c:forEach var= "row" items="${list }" varStatus="var">
        	<p>
        	<input type ="hidden" id="IDX" name="IDX_${var.index }" value="${row.IDX }">
        	<a href="#this" id="name_${var.index }" name="name_${var.index }">${row.ORIGINAL_FILE_NAME }</a>
        	<input type="file" id="file_${var.index }" name ="file_${var.index }"/>(${row.FILE_SIZE }kb)
        	<a href="#this" class="btn" id="delete_${var.index }" name="delete_${var.index }">삭제</a>
        	</p>
        	</c:forEach>
        </div>
        <input type="hidden" name="idx" value="${detail.IDX }">
        <button type="submit" class="btn btn-info">수정하기</button>
        
        <a href='<c:url value = '/boardDetail${pageMaker.makeQueryPage(detail.IDX, page) }'/>' role ="button" >뒤로가기</a>
    </form>
	</div>
	</sec:authorize>
	</c:when>
	<c:otherwise>
		<script type="text/javascript">
			alert("권한이 없습니다. ")
			history.back(1)
		</script>
	</c:otherwise>
	</c:choose>
			<%@ include file = "/WEB-INF/views/includes/include-body.jspf" %>
			<script type ="text/javascript">
				var gfv_count = '${fn:length(list)+1}';
				$("#addFile").on("click", function(e){
					e.preventDefault();
					fn_addFile();
				});
				$("a[name^='delete']").on("click", function(e){
					e.preventDefault();
					fn_deleteFile($(this));
				});
				function fn_addFile(){
					var str = "<p>" + "<input type='file' id='file_"+(gfv_count)+"' name='file_"+(gfv_count)+"'>"+ "<a href='#this' class='btn' id='delete_"+(gfv_count)+"' name='delete_"+(gfv_count)+"'>삭제</a>" + "</p>";
					$("#fileDiv").append(str);
					$("#delete_"+(gfv_count++)).on("click",function(e){
						e.preventDefault();
						fn_deleteFile($(this));
					})
				}
				function fn_deleteFile(obj){
					obj.parent().remove();
				}
			</script>
		
</body>
</html> 