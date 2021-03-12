<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/views/includes/00_head.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
</head>
<body>
	<div class = "container col-md-6">
		<div class="card">
			<div class="card-body">
				<h4 class ="card-title mb-3">${detail.TITLE}</h4>
				<h6 class ="card-subtitle-text-muted mb-4">
					<ion-icon name="person-outline"></ion-icon>
					${detail.CREA_ID }
					<ion-icon name="time-outline"></ion-icon>
					${detail.CREA_DATE }
					<ion-icon name="checkmark-outline"></ion-icon>
					${detail.HIT_CNT}
				</h6>
				<p class="card-text">${detail.CONTENTS }</p>
			</div>
			<c:choose>
		    <c:when test="${fn:length(file) > 0 }">
		    <div class="blog-file">
		        <ul>
		        <c:forEach items="${file }" var="file">
		            <li> 
		                <span class="file-img"></span>
		                <div class="file-info">
		                    <a href='#'><i class="fa fa-camera"></i> ${file.ORG_FILE_NAME }</a>
		                    <span>${file.FILE_SIZE }kb</span>
		                </div>
		            </li>
				        </c:forEach>
				        </ul>
				    </div>
				    </c:when>
				</c:choose>

			<div class="card-body">
					<a href='<c:url value='/boardUpdate${pageMaker.makeQueryPage(detail.IDX, page) }'/>' >수정</a>
				<p> </p>
					<a href='<c:url value='/boardDelete${pageMaker.makeQueryPage(detail.IDX, page) }'/>' >삭제</a>
			</div>
			<div class="card-body">
				<a href = '<c:url value = '/boardList${pageMaker.makeQueryPage(page) }'/>' class ="btn btn-info" role = "button">목록으로</a>
			</div>
		</div>
	</div>
</body>
</html>