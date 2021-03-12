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
        <div class="container">
        <%@ include file="/WEB-INF/views/includes/03_header.jsp" %>
        <div class="row marketing">
              <table class="table">
              <tbody>
                 
              <!-- choose : 조건 분기  -->
                  <c:choose>
                      <c:when test="${fn:length(list) > 0 }">
                          <c:forEach items="${list }" var="bList">
                              <tr>
                              <th scope="row">${bList.IDX }</th>
                              <td><a href='<c:url value='/boardDetail${pageMaker.makeQueryPage(bList.IDX, pageMaker.cri.page) }'/>'>${bList.TITLE }</a></td>
                              <td>${bList.TITLE }</td>
                              <td>${bList.CREA_ID }</td>
                              <td>${bList.CREA_DATE }</td>
                              <td>${bList.HIT_CNT }</td>
                            </tr>
                          </c:forEach>
                      </c:when>
                      <c:otherwise>
                          <tr>
                              <td colspan="5">조회된 결과가 없습니다.</td>
                          </tr>
                      </c:otherwise>
                  </c:choose>
                
              </tbody>
            </table>
          </div>
          
          <ul class = "pagination justify-content-between">
          			<li class ="col-4 pt-1">
          				<a href="${pageContext.request.contextPath }/boardWrite">Write</a>				
            		
            		</ul>
           <ul class = "pagination justify-content-end">
           			<c:if test="${pageMaker.prev }">
            		<li class ="page-item">
            			<a class="page-link" href='<c:url value="/boardList${pageMaker.makeQueryPage(pageMaker.startPage-1) }"/>' >이전</a>           	
            		</li>
            		</c:if>
            		<c:forEach begin="${pageMaker.startPage }" end= "${pageMaker.endPage }" var = "pageNum">
            		<li class = "page-item justify-content-end align-items-center">
            			<a class="page-link " href='<c:url value="/boardList${pageMaker.makeQueryPage(pageNum) }"/>'>${pageNum }</a>
            		</c:forEach>
            		<c:if test="${pageMaker.next && pageMaker.endPage >0 }">
            		<li class = "page-item justify-content-end align-items-center">
            			<a class="page-link" href='<c:url value="/boardList${pageMaker.makeQueryPage(pageMaker.endPage+1) }"/>'>다음</a>
            		</li>
            		</c:if>
            		
            	</ul>
        </div>
 
</body>
</html>
