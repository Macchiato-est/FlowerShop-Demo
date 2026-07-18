<%-- 
    Document   : admin-login
    Created on : Nov 18, 2025, 9:18:38 AM
    Author     : 06052
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Admin Login - ShopHoa</title>

    <!-- Google Font -->
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700">

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/plugins/fontawesome-free/css/all.min.css">

    <!-- AdminLTE -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css">
    
    <style>
    body.auth-bg {
        min-height: 100vh;
        margin: 0;
        font-family: "Segoe UI", system-ui, -apple-system, BlinkMacSystemFont, sans-serif;

        background: #f9f1f5 url("images/b3.jpg") center/cover no-repeat fixed;

        display: flex;
        align-items: center;
        justify-content: center;
    }
</style>

</head>
<body class="hold-transition login-page auth-bg">


<div class="login-box">
    <div class="login-logo">
        <a href="#"><b>Admin</b> ShopHoa</a>
    </div>

    <div class="card">
        <div class="card-body login-card-body">

            <p class="login-box-msg">Đăng nhập quản trị</p>

            <!-- Hiện thông báo lỗi -->
            <%
                String error = (String) session.getAttribute("admin_error");
                if (error != null) {
            %>
                <div class="alert alert-danger py-2"><%= error %></div>
            <%
                    session.removeAttribute("admin_error");
                }
            %>

            <form action="${pageContext.request.contextPath}/admin-login" method="post">

                <div class="input-group mb-3">
                    <input type="email" name="email" class="form-control"
                           placeholder="Email quản trị" required>
                    <div class="input-group-append">
                        <div class="input-group-text"><span class="fas fa-envelope"></span></div>
                    </div>
                </div>

                <div class="input-group mb-3">
                    <input type="password" name="password" class="form-control"
                           placeholder="Mật khẩu" required>
                    <div class="input-group-append">
                        <div class="input-group-text"><span class="fas fa-lock"></span></div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-12">
                        <button type="submit"
                                class="btn btn-primary btn-block">Đăng nhập</button>
                    </div>
                </div>

            </form>

        </div>
    </div>
</div>

<!-- AdminLTE JS -->
<script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2/plugins/jquery/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/js/adminlte.min.js"></script>

</body>
</html>