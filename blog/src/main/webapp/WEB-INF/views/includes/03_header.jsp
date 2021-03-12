<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/views/includes/00_head.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri = "http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>

<%
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    Object principal = auth.getPrincipal();
 
    String name = "";
    if(principal != null) {
        name = auth.getName();
    }
%>
        <div class="header">
           <a class="nav-link" href="${pageContext.request.contextPath }/"><h3><b>Hello</b></h3></a>
               <ul class="nav justify-content-end">
                  		  <sec:authorize access = "isAnonymous()">
                            <li class="nav-item">
                            	<a class="nav-link" href="${pageContext.request.contextPath }/loginPage">Sign in</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath }/register/step1">Sign up</a>
                            </li>
                           </sec:authorize>
                  			<sec:authorize access="isAuthenticated()">          
                                   <li class="nav-item">
                                     <a class="nav-link" href="#"><%=name %>님, 반갑습니다.</a>
                                   </li>
                                   <li class="nav-item">
                                   <a class="nav-link" href="#" onclick="document.getElementById('logout-form').submit();">Sign out</a>
                                   	<form id="logout-form" action='<c:url value='/logout'/>' method = "POST" >
                                   		<input name="${_csrf.parameterName}" type = "hidden" value="${_csrf.token }"/>
                                   	</form>
                                   </li>
                            </sec:authorize>
                     </ul>
                     </div>