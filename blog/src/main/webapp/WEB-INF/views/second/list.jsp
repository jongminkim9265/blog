<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>

<%--head.jsp--%>
<%@ include file="/WEB-INF/views/includes/head.jsp" %>

<body class="sidebar-mini layout-fixed vsc-initialized sidebar-collapse">
<div class="wrapper">

    <%--main_header.jsp--%>
    <%-- Main Header --%>
    <%@ include file="/WEB-INF/views/includes/main_header.jsp" %>

    <%--left_column.jsp--%>
    <%-- Left side column. contains the logo and sidebar --%>
    <%@ include file="/WEB-INF/views/includes/left_column.jsp" %>
    
    <%-- Content Wrapper. Contains page content --%>
        <%-- Content Header (Page header) --%>
        
        <div class="content-wrapper">
        <%-- Content Header (Page header) --%>
        	<section class="content-header">
            <h1> 게시판 
            <small>목록</small>
            </h1>
       <ol class="breadcrumb">
                <li class = "breadcrumb-item"><a href="${pageContext.request.contextPath }/boardList"><i class="fa fa-dashboard"></i> 게시판</a></li>
                <li class="breadcrumb-item active"> 일반</li>
                
            </ol>
        </section> 
        <div class="card">
                <div class="card-body">
                    <div class="box-header with-border">
                    <br>
                    <h4 class="box-title">게시글 목록 (${pageMaker.totalCount})</h4>
                    
                    </div>
                    <div class="box-body">   
                    <div>
        <table class="table table-bordered">
        <tbody>
        <th>번호</th>
        <th>제목</th>
        <th>작성자</th>
        <th>작성 일시</th>
        <th>조회수</th>
    <!-- choose : 조건 분기  -->
    			  
                  <c:choose>
                      <c:when test="${fn:length(list) > 0 }">
                          <c:forEach items="${list }" var="bList" varStatus="status">
                              <tr>
                              <th scope="row">${bList.IDX }</th>
                              <td><a href='<c:url value='/boardDetail${pageMaker.makeQueryPage(bList.IDX, pageMaker.cri.page) }'/>'>${bList.TITLE }</a>
                              	<span title="reply_cnt" class= "badge badge-primary">${cnt[status.index] }</span>
                              </td>
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
         </div>
          <div class="card-body">
          <ul class = "pagination pagination-sm m-0 float-left">
          			<li class = "page-item">
          				<a class="page-link" href="${pageContext.request.contextPath }/boardWrite"><i class="fas fa-edit"> Write</i></a>				
            		</li>
            		</ul>
           <ul class = "pagination pagination-sm m-0 float-right ">
           			<c:if test="${pageMaker.prev }">
            		<li class = "page-item">
            			<a class="page-link" href='<c:url value="/boardList${pageMaker.makeQueryPage(pageMaker.startPage-1) }"/>' >이전</a>           	
            		</li>
            		</c:if>
            		<c:forEach begin="${pageMaker.startPage }" end= "${pageMaker.endPage }" var = "pageNum">
            		<li class = "page-item">
            			<a class="page-link" href='<c:url value="/boardList${pageMaker.makeQueryPage(pageNum) }"/>'>${pageNum }</a>
            		</c:forEach>
            		<c:if test="${pageMaker.next && pageMaker.endPage >0 }">
            		<li class = "page-item">
            			<a class="page-link" href='<c:url value="/boardList${pageMaker.makeQueryPage(pageMaker.endPage+1) }"/>'>다음</a>
            		</li>
            		</c:if>
           </ul>
          	
        
        </div>
        </div>
        </div>
        </div>
        
        <%-- /.content-wrapper --%>

	    <%--main_footer.jsp--%>
	    <%-- Main Footer --%>
	    <%@ include file="/WEB-INF/views/includes/main_footer.jsp" %>
        </div>
		<%-- ./wrapper --%>

		<%--plugin_js.jsp--%>
		<%@ include file="/WEB-INF/views/includes/plugin_js.jsp" %>
		        
        </body>
        </html>
 