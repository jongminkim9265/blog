<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/views/includes/00_head.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class = "container col-md-6">
		<div class="card">
			<div class="card-body">
				<h4 class ="card-title mb-3">${map.TITLE}</h4>
				<h6 class ="card-subtitle-text-muted mb-4">
					<ion-icon name="person-outline"></ion-icon>
					${map.CREA_ID }
					<ion-icon name="time-outline"></ion-icon>
					${map.CREA_DATE }
					<ion-icon name="checkmark-outline"></ion-icon>
					${map.HIT_CNT}
				</h6>
				<p class="card-text">${map.CONTENTS }</p>
			</div>

			<div class="card-body">
					<a href='<c:url value='/boardUpdate${pageMaker.makeQueryPage(map.IDX, page) }'/>' >수정</a>
				<p> </p>
					<a href='<c:url value='/boardDelete${pageMaker.makeQueryPage(map.IDX, page) }'/>' >삭제</a>
			</div>
			<div class="card-body">
				<a href = '<c:url value = '/boardList${pageMaker.makeQueryPage(page) }'/>' class ="btn btn-info" role = "button">목록으로</a>
			</div>
			<c:choose>
    <c:when test="${fn:length(list) > 0 }">
        <ul>
        <c:forEach items="${list }" var="file">
            <li> 
                <div class="card-body">
                	<input type = "hidden" id = "IDX" value = "${file.IDX }"/>
                    <a href = "#this" name = "file">${file.ORIGINAL_FILE_NAME } </a>
                    
                   ${file.FILE_SIZE }kb
                </div>
            </li>
        </c:forEach>
        </ul>
    	</c:when>
	</c:choose>
		</div>
	</div>	
	<%@ include file="/WEB-INF/views/includes/include-body.jspf" %>
	 <script type="text/javascript"> 
	 $(document).ready(function(){ 
		 
		 $("a[name='file']").on("click", function(e){
			 //파일 이름 
			 e.preventDefault();
			 fn_downloadFile($(this));
			 });
		 function fn_downloadFile(obj){
			 var idx = obj.parent().find("#IDX").val();
			 var comSubmit = new ComSubmit();
			 comSubmit.setUrl("<c:url value='/downloadFile' />");

			 if(gfn_isNull($("[name='IDX']").val())==false){
			 $("[name='IDX']").remove();
			 }
			 
			 comSubmit.addParam("IDX",idx);
			 comSubmit.submit();
			 
			 }
	 });
	 
	 
	 
	 </script>


</body>
</html>