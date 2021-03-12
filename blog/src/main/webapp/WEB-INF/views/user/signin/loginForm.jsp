<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="/WEB-INF/views/includes/00_head.jsp" %>
    <title>Sign In </title>
</head>
<body class="signup-pages">

    <div class="signup-box">
        <div class="signup-logo">
            <a href="${pageContext.request.contextPath }/"><b>Hello</b></a>
        </div>

        <div class="signup-box-body">
            <p class="box-msg">Please Sign In</p>

            <form class ="form"  action='<c:url value ="/login"/>' method="post">
                <div class="form-group has-feedback">
                    <input type="text" class="form-control" placeholder="ID" name = "loginId" value="${loginId }"/>
                    <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                    <form:errors path="id" class="signup-errors"/>
                </div>
                <div class="form-group has-feedback">
                    <input type="password" class="form-control" placeholder="PASSWORD" name = "loginPwd" value= "${loginPwd }"/>
                    <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                    <form:errors path="pw" class="signup-errors"/>
                </div>
                <div class = "col-xs-3">
                    <c:if test="${not empty ERRORMSG }">
                    	<font color = "red">
                    	<p>${ERRORMSG }</p>
                    	</font>
                    </c:if>
                    </div>
                <div class="row">
                    <div class="col-xs-8">
                        <label class="btn">
                            <input type ="checkbox" path="rememberId"/> 아이디 기억하기
                        </label>
                    </div>
                    
                    <div class="col-xs-3">
                    	<input type = "hidden" name = "${_csrf.parameterName}"  value = "${_csrf.token }"/>
                        <button type="submit" class="btn btn-style">sign in</button>
                    </div>
                </div>
            </form>
            
        </div>
    </div>

</body>
</html>