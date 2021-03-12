<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ include file="/WEB-INF/views/includes/00_head.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	
	<input type = "hidden" name = "current_user" value = "<%=name %>"/>
	<c:set var = "current_user" value = "<%=name %>"/>
	<c:choose>
		<c:when test = "${current_user == detail.CREA_ID}">
		
		<form name = "hiddenform" action='<c:url value = '/boardDeleteOK?idx=${detail.IDX }'/>' method = "post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }"/>
		</form>
		<script>
			alert("삭제했습니다.")
			document.hiddenform.submit();
			
		</script>
		
	</c:when>
		<c:otherwise>
			<script>
				alert(authInfo.name)
				history.back()
			</script>
		</c:otherwise>
	</c:choose>
	
</body>
</html>