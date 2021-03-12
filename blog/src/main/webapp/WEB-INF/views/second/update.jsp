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
        <body>
	
	<input type = "hidden" name = "crea_id" value = "${detail.CREA_ID}"/>
	<input type = "hidden" name = "current_user" value = "<%=session.getAttribute("name") %>"/>
	<c:set var = "crea_id" value = "${detail.CREA_ID}"/>
	<c:set var = "current_user" value = "<%=session.getAttribute(\"name\") %>"/>
	<c:choose>
	<c:when test = "${crea_id == current_user }">
	<sec:authorize access="isAuthenticated()">
	
    <form class ="card card-primary"action='<c:url value='/boardUpdate${pageMaker.makeQueryPage(page)}'/>' method="post" enctype = "multipart/form-data">
        <div class="card-header">
			<h3 class = "card-title">글 수정</h3>
		</div>
        <div class="card-body">
            <label for="exampleFormControlInput1">제목</label>
            <input type="text" class="form-control" id="exampleFormControlInput1" name="title" value="${detail.TITLE }">
        </div>
        <div class="card-body">
            <label for="exampleFormControlInput1">작성자</label>
            <input type="text" class="form-control" id="exampleFormControlInput1" name="crea_id" value="${detail.CREA_ID }" readonly>
        </div>
        <div class="card-body">
            <label for="exampleFormControlTextarea1">내용</label>
            <textarea class="form-control" id="exampleFormControlTextarea1" rows="10" name="contents">${detail.CONTENTS }</textarea>
        </div>
        <div id="fileDiv" class = "card-body">
        	<c:forEach var= "row" items="${list }" varStatus="var">
        	<p>
        	<input type ="hidden" id="IDX" name="IDX_${var.index }" value="${row.IDX }">
        	<a href="#this" id="name_${var.index }" name="name_${var.index }">${row.ORIGINAL_FILE_NAME }</a>
        	<input type="file" id="file_${var.index }" name ="file_${var.index }"/>(${row.FILE_SIZE }kb)
        	<a href="#this" class="btn btn-secondary" id="delete_${var.index }" name="delete_${var.index }">삭제</a>
        	</p>
        	</c:forEach>
        </div>
        <input type="hidden" name="idx" value="${detail.IDX }">
        <div class = "card-body">
        <button type="submit" class="btn btn-success float-right">수정하기</button>
        
        <a href='<c:url value = '/boardDetail${pageMaker.makeQueryPage(detail.IDX, page) }'/>' role ="button" class = "btn btn-secondary">뒤로가기</a>
        </div>
    </form>
	</sec:authorize>
	</c:when>
	<c:otherwise>
		<script type="text/javascript">
			alert("권한이 없습니다.");
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