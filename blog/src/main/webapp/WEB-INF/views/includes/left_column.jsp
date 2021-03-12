<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="sec" uri = "http://www.springframework.org/security/tags" %>

   <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    
    <!-- Sidebar -->
    <div class="sidebar">
    	<!-- Brand Logo -->
		<a href="${pageContext.request.contextPath }" class="brand-link"> <img
		src="dist/img/AdminLTELogo.png" alt="AdminLTE Logo"
		class="brand-image img-circle elevation-3" style="opacity: .8">
		<span class="brand-text font-weight-light">Hello</span>
		</a>
    	
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
		  
		  <sec:authorize access = "isAnonymous()">
		  <a href="${pageContext.request.contextPath }/loginPage" class="brand-link">
		  <i class="fas fa-user"> 
		  <span class="brand-text font-weight-light">Please login</span>
		  </i></a>
		  </sec:authorize>
		  <sec:authorize access = "isAuthenticated()">
		  <a href="${pageContext.request.contextPath }" class="brand-link">
		  <i class="fas fa-user">
		  <span class="brand-text font-weight-light"><%=session.getAttribute("name") %>님, My page</span>
		  </i></a>
		  </sec:authorize>  
         
        </div>
      </div>

      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
          <li class="nav-item has-treeview menu-open">
            <a href="#" class="nav-link active">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                Pages
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="#" class="nav-link active">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Active Page</p>
                </a>
              </li>
            </ul>
          </li>
          <li class="nav-item">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-th"></i>
              <p>
                Simple Link
                <span class="right badge badge-danger">New</span>
              </p>
            </a>
            <ul class="nav nav-treeview">
            	<li class = "nav-item">
            	<a  href="${pageContext.request.contextPath }/boardList" class="nav-link">
            		<i class="fas fa-comment-alt"></i>
            		<p> Board</p>
            	</a>
            	</li>
            </ul>
          </li>
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>