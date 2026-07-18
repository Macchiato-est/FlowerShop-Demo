<%-- 
    Document   : contact
    Created on : Nov 13, 2025
    Author     : 06052
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Liên hệ</title>
    <link rel="stylesheet" href="Css/main.css">
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

    <style>
        /* CONTACT PAGE */

        .contact-page h3 {
            font-weight: 700;
            font-size: 22px;
            margin-bottom: 16px;
        }

        .contact-page .contact-card {
            background: #ffffff;
            border-radius: 12px;
            padding: 20px 22px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.06);
        }

        .contact-page .form-label {
            font-weight: 500;
        }

        .contact-page textarea {
            resize: vertical;
        }
    </style>
</head>

<body>

    
    <jsp:include page="layout/header.jsp" />
    <jsp:include page="layout/banner.jsp" />

    <!-- MAIN: dùng chung layout container + row + leftmenu -->
    <main class="container py-4 contact-page">
        <div class="row g-4">

            <!-- LEFT MENU (bọc col-3 như quy ước) -->
            <div class="col-12 col-md-3">
                <jsp:include page="layout/leftmenu.jsp" />
            </div>

            <!-- NỘI DUNG TRANG (bên phải) -->
            <section class="col-12 col-md-9">

                <div class="contact-card">

                    <h3 class="mb-3">Liên hệ</h3>

                    <!-- Thông báo -->
                    <c:if test="${not empty success}">
                        <div class="alert alert-success">${success}</div>
                    </c:if>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <!-- FORM LIÊN HỆ -->
                    <form method="post" action="contact" novalidate>
                        <div class="row g-3">

                            <div class="col-md-6">
                                <label class="form-label">Họ tên *</label>
                                <input class="form-control" name="name" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Email</label>
                                <input class="form-control" name="email" type="email">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Số điện thoại</label>
                                <input type="tel"
                                       class="form-control"
                                       name="phone"
                                       pattern="0[0-9]{9,10}"
                                       title="Số điện thoại phải bắt đầu bằng 0 và có 10–11 chữ số"
                                       placeholder="Ví dụ: 0912345678">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Tiêu đề *</label>
                                <input class="form-control" name="title"
                                       required maxlength="150">
                            </div>

                            <div class="col-12">
                                <label class="form-label">Nội dung *</label>
                                <textarea class="form-control" rows="5"
                                          name="message" required></textarea>
                            </div>
                        </div>

                        <div class="mt-3">
                            <button class="btn btn-primary">Gửi liên hệ</button>
                            <a href="index" class="btn btn-outline-secondary ms-2">Về trang chủ</a>
                        </div>
                    </form>

                </div><!-- /contact-card -->

            </section><!-- /col-9 -->

        </div><!-- /row -->
    </main>

    <jsp:include page="layout/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
