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
	<div class="container col-md-6">
    <form action='<c:url value='/boardUpdate${pageMaker.makeQueryPage(page)}'/>' method="post">
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
        <input type="hidden" name="idx" value="${detail.IDX }">
        <button type="submit" class="btn btn-info">수정하기</button>
        
        <a href='<c:url value = '/boardDetail${pageMaker.makeQueryPage(detail.IDX, page) }'/>' role ="button" >뒤로가기</a>
    </form>
	</div>
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