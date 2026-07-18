<%-- 
    Document   : profile-edit
    Created on : Nov 20, 2025, 11:40:27 PM
    Author     : 06052
--%>


<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa tài khoản</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Main CSS -->
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

                <h3 class="mb-3">Thông tin tài khoản</h3>

                <!-- Thông báo -->
                <c:if test="${not empty success}">
                    <div class="alert alert-success">${success}</div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>

                <!-- FORM CHỈNH SỬA -->
                <form action="profile-edit" method="post">

                    <div class="mb-3">
                        <label class="form-label">Họ tên *</label>
                        <input class="form-control"
                               required
                               name="name"
                               value="${sessionScope.currentUser.name}">
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input class="form-control"
                               readonly
                               value="${sessionScope.currentUser.email}">
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Số điện thoại *</label>
                        <input type="tel"
                               class="form-control"
                               name="phone"
                               required
                               pattern="0[0-9]{9,10}"
                               maxlength="11"
                               title="Số điện thoại phải bắt đầu bằng 0 và có 10–11 chữ số"
                               placeholder="Ví dụ: 0912345678"
                               value="${sessionScope.currentUser.phone}">
                    </div>


                    <div class="mb-3">
                        <label class="form-label">Địa chỉ</label>
                        <input class="form-control"
                               name="address"
                               value="${sessionScope.currentUser.address}">
                    </div>

                    <button class="btn btn-primary">Lưu thay đổi</button>
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
