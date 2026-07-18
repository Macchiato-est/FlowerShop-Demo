<%--  
    Document   : order-success
    Created on : Nov 9, 2025, 7:44:04 PM
    Author     : 06052
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng thành công</title>

    <link rel="stylesheet" href="Css/main.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>
        /* ORDER SUCCESS PAGE */

        .order-success-page .success-box {
            background: #ffffff;
            border-radius: 16px;
            padding: 32px 24px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.08);
            text-align: center;
        }

        .order-success-page h3 {
            font-weight: 700;
            margin-bottom: 12px;
        }

        .order-success-page p {
            margin-bottom: 16px;
        }
    </style>
</head>
<body>

    <jsp:include page="layout/header.jsp" />
    <jsp:include page="layout/banner.jsp" />

    <!-- MAIN -->
    <main class="container py-5 order-success-page">
        <div class="row g-4">

            <!-- LEFT MENU (cột trái) -->
            <div class="col-12 col-md-3">
                <jsp:include page="layout/leftmenu.jsp" />
            </div>

            <!-- NỘI DUNG THÔNG BÁO (cột phải) -->
            <section class="col-12 col-md-9">
                <div class="success-box">
                    <h3 class="text-success mb-3">Đặt hàng thành công!</h3>
                    <p>
                        Mã đơn của bạn:
                        <strong>#${param.id}</strong>
                    </p>
                    <a class="btn btn-primary" href="index">Tiếp tục mua sắm</a>
                </div>
            </section>

        </div><!-- /row -->
    </main>

    <jsp:include page="layout/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
