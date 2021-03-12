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
            	<c:when test = "${empty authInfo}">
            		<script>
            			alert("로그인을 해주세요.")
            			history.back()
            		</script>
            	</c:when>
    <c:otherwise>
	<form action='<c:url value='/boardInsert'/>' method="post" enctype="multipart/form-data">
        <div class="form-group">
              <label for="exampleFormControlInput1">제목</label>
            <input type="text" class="form-control" id="exampleFormControlInput1" name="title" placeholder="제목을 작성해주세요.">
          </div>
        <div class="form-group">
            <label for="exampleFormControlInput1">작성자</label>
            <input type="text" class="form-control" id="exampleFormControlInput1" name="crea_id" value="${authInfo.name}" readonly>
          </div>
          <div class="form-group">
            <label for="exampleFormControlTextarea1">내용</label>
            <textarea class="form-control" id="exampleFormControlTextarea1" name="contents" rows="10"></textarea>
          </div>
         <div class="form-group" id="file-list">
         	<a href = "#this" onclick="addFile()">파일추가</a>
         	<div class = 'file-group'>
         		<input type = "file" name = "file"><a href='#this' name='file-delete'>삭제</a>
         	</div>
         	</div>
        <button type="submit" class="btn btn-info">등록하기</button>
        <button type="button" class="btn btn-info" onclick = "location.href='/boardList'">목록으로</button>
    </form>
    <script type="text/javascript">
    	$(document).ready(function() {
    		$("a[name='file-delete']").on("click", function(e) {
    			e.perventDefault();
    			deleteFile($(this));
    		})
    	})
    
    function addFile() {
    		var str = "<div calss='file-group'><input type = 'file' name = 'file'><a href='#this' name='file=delete'>삭제</a></div>";
    		$("#file-list").append(str);
    		$("a[name='file-delete']").on("click",function(e) {
    			e.preventDefault();
    			deleteFile($(this));
    		});
    	}
    function deleteFile(obj) {
    	obj.parent().remove();
    }
    </script>
    </c:otherwise>
    </c:choose>
</body>
</html>