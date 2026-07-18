<%-- 
    Document   : change-password
    Created on : Nov 20, 2025, 11:41:51 PM
    Author     : 06052
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đổi mật khẩu</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- CSS chính -->
    <link rel="stylesheet" href="Css/main.css">
</head>

<body>

    <!-- BANNER + HEADER -->
    
    <jsp:include page="layout/header.jsp" />
    <jsp:include page="layout/banner.jsp" />

    <!-- MAIN -->
    <main class="container my-4">
        <div class="row g-4 layout-row">

            <!-- LEFT MENU (col-3) -->
            <div class="col-12 col-md-3 col-left">
                <jsp:include page="layout/leftmenu.jsp" />
            </div>

            <!-- CONTENT (col-9) -->
            <section class="col-12 col-md-9 col-main">

                <h3 class="mb-3">Đổi mật khẩu</h3>

                <!-- Thông báo -->
                <c:if test="${not empty success}">
                    <div class="alert alert-success">${success}</div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>

                <!-- FORM ĐỔI MẬT KHẨU -->
                <form action="change-password" method="post">

                    <div class="mb-3">
                        <label class="form-label">Mật khẩu mới *</label>
                        <input type="password"
                               class="form-control"
                               required
                               name="newpass">
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Xác nhận mật khẩu *</label>
                        <input type="password"
                               class="form-control"
                               required
                               name="renewpass">
                    </div>

                    <button class="btn btn-primary">Đổi mật khẩu</button>
                    <a href="index" class="btn btn-outline-secondary ms-2">Quay lại</a>

                </form>

            </section>
        </div>
    </main>

    <!-- FOOTER -->
    <jsp:include page="layout/footer.jsp" />

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
