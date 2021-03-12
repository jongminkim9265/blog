<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/includes/00_head.jsp" %>
	<title>step2</title>
<meta charset="UTF-8">

</head>
<body class = "signup-pages">
	<div class="panel-body">
    <div class="row">
        <div class="col-lg-6">
            <form:form role="form" commandName="registerRequest" action="${pageContext.request.contextPath }/register/step3" method="post">
            	<div class="signup-box">
                <div class="signup-box-body">
                <h3> 회원가입 </h3>
                <br>
                <b>아이디 :</b>
                    <span class="input-group-addon"><i class="fa fa-check"></i></span>
                    <form:input type="text" class="form-control" placeholder="ID" path="id"/>
                    <form:errors path="id"/>
                </div>
                
                <div class="signup-box-body">
                <b>이름 :</b>
                    <span class="input-group-addon"><i class="fa fa-user"></i></span>
                    <form:input type="text" class="form-control" placeholder="Name" path="name"/>
                    <form:errors path="name"/>
                </div>
                <div class="signup-box-body">
                <b>비밀번호 :</b>
                    <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                    <form:password class="form-control" placeholder="Password" path="pw"/>
                    <form:errors path="pw"/>
                </div>
                
                <div class="signup-box-body">
                <b>비밀번호 확인:</b>
                    <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                    <form:password class="form-control" placeholder="Password Check" path="checkPw"/>
                    <form:errors path="checkPw"/>
                </div>
                <div class="signup-box-body">
                <input type = "hidden" name = "${_csrf.parameterName}"  value = "${_csrf.token }"/>
                <button type="submit" class="btn btn-default">가입하기</button>
                <button type="reset" class="btn btn-default">취소하기</button>
                </div>
                <div class = "signup-box-body">
                <a href="${pageContext.request.contextPath }" class = "btn btn-default"> 돌아가기</a>
                </div>
            </form:form>
        	</div>
    	</div>
    	</div>
	</div>
</div>
</body>
</html>