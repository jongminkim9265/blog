<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ include file="/WEB-INF/views/includes/00_head.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
</head>
<body>
	<c:choose>
		<c:when test = "${authInfo.name == detail.CREA_ID}">
		<form name = "hiddenform" action='<c:url value = '/boardDeleteOK?idx=${detail.IDX }'/>' method = "post">
		</form>
		<script>
			alert("삭제했습니다.")
			document.hiddenform.submit();
			
		</script>
		
	</c:when>
		<c:otherwise>
			<script>
				alert("권한이 없습니다.")
				history.back()
			</script>
		</c:otherwise>
	</c:choose>
</body>
</html>