<%-- 
    Document   : admin-layout
    Created on : Nov 20, 2025, 11:50:37 AM
    Author     : 06052
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.User" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>

    <!-- AdminLTE -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css">

    <!-- FontAwesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

</head>

<body class="hold-transition sidebar-mini">

<div class="wrapper">
    
    <!-- TOP NAVBAR -->
    <nav class="main-header navbar navbar-expand navbar-white navbar-light border-bottom">

        <ul class="navbar-nav ml-auto">

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/admin-logout"
                   class="btn btn-outline-danger btn-sm">
                    <i class="fas fa-sign-out-alt"></i> Đăng xuất
                </a>
            </li>

        </ul>

    </nav>

    <!-- Sidebar -->
    <aside class="main-sidebar sidebar-dark-primary elevation-4">

        <a href="${pageContext.request.contextPath}/admin"
           class="brand-link text-center">
            <span class="brand-text font-weight-light">Admin ShopHoa</span>
        </a>

        <div class="sidebar">
            <div class="user-panel mt-3 pb-3 mb-3 d-flex">
                <div class="info text-white">
                    Xin chào, <b>${sessionScope.admin.name}</b>
                </div>
            </div>

            <nav class="mt-2">
                <ul class="nav nav-pills nav-sidebar flex-column">

                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin"
                           class="nav-link">
                            <i class="nav-icon fas fa-tachometer-alt"></i>
                            <p>Dashboard</p>
                        </a>
                    </li>
                    
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/banners" class="nav-link">
                            <i class="nav-icon fas fa-image"></i>
                            <p>Banner</p>
                        </a>
                    </li>

                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/products"
                           class="nav-link">
                            <i class="nav-icon fas fa-seedling"></i>
                            <p>Sản phẩm</p>
                        </a>
                    </li>
                    
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/orders"
                           class="nav-link">
                            <i class="nav-icon fas fa-shopping-cart"></i>
                            <p>Đơn hàng</p>
                        </a>
                    </li>

                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/categories"
                           class="nav-link">
                            <i class="nav-icon fas fa-tags"></i>
                            <p>Loại hoa</p>
                        </a>
                    </li>

                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/contacts"
                           class="nav-link">
                            <i class="nav-icon fas fa-envelope"></i>
                            <p>Liên hệ khách hàng</p>
                        </a>
                    </li>

                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/users"
                           class="nav-link">
                            <i class="nav-icon fas fa-user"></i>
                            <p>Người dùng</p>
                        </a>
                    </li>

                </ul>
            </nav>
        </div>
    </aside>

    <!-- MAIN CONTENT (load file content) -->
    <div class="content-wrapper p-4">
        <jsp:include page="${contentPage}" />
    </div>

</div>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2/plugins/jquery/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/js/adminlte.min.js"></script>

</body>
</html>
