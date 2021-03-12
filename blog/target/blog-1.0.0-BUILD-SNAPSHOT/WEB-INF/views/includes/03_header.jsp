<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/views/includes/00_head.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <div class="header">
           <a class="nav-link" href="${pageContext.request.contextPath }/"><h3><b>Hello</b></h3></a>
               <ul class="nav justify-content-end">
                  <c:catch>
                     <c:choose>
                         <c:when test="${empty authInfo }">
                            <li class="nav-item">
                            	<a class="nav-link" href="${pageContext.request.contextPath }/login">Sign in</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath }/register/step1">Sign up</a>
                            </li>
                         </c:when>
                         <c:otherwise>
                            <c:choose>
                               <c:when test="${authInfo.grade eq 1 }">
                                   <li class="nav-item">
                                     <a class="nav-link" href="#">관리자 ${authInfo.name }님, 안녕하세요.</a>
                                   </li>
                                    <li class="nav-item">
                                     <a class="nav-link" href="${pageContext.request.contextPath }/signout">Sign out</a>
                                   </li>
                               </c:when>
                               <c:otherwise>
                                   <li class="nav-item">
                                     <a class="nav-link" href="#">${authInfo.name }님, 반갑습니다.</a>
                                   </li>
                                   <li class="nav-item">
                                     <a class="nav-link" href="${pageContext.request.contextPath }/signout">Sign out</a>
                                   </li>
                                    
                               </c:otherwise>
                            </c:choose>
                         </c:otherwise>
                     </c:choose>
                     </c:catch>
                     </ul>
                     </div>