<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 합쳐지고 최소화된 최신 CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


    <!-- 부가적인 테마 -->
   
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style-signup.css">

    <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/common.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/ionicons@5.2.3/dist/ionicons.js"></script>
<script language="javascript"> 
 $(window).bind('beforeunload', function() {
    if ((event.clientY < 0) ||(event.altKey) ||(event.ctrlKey)||((event.clientY < 129) && (event.clientY>107))) { 
   $.ajax({
    url : "logout"  //스프링시큐리티 에서 적용시켜놓은 custom logout url
   }); 
        }
 }); 
</script>


 