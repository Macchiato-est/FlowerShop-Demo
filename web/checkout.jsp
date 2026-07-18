<%-- 
    Document   : Checkout
    Created on : Nov 9, 2025, 7:34:10 PM
    Author     : 06052
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng</title>

    <link rel="stylesheet" href="Css/main.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>
        /* CHECKOUT PAGE */

        .checkout-page h3 {
            font-weight: 700;
            font-size: 22px;
            margin-bottom: 16px;
        }

        .checkout-page .form-label {
            font-weight: 500;
        }

        .checkout-page textarea {
            resize: vertical;
        }

        .checkout-page .order-summary-card {
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0,0,0,0.06);
        }

        .checkout-page .order-summary-card .card-header {
            font-weight: 600;
        }

        .checkout-page .order-line {
            font-size: 14px;
        }
    </style>
</head>
<body>

    <!-- BANNER + HEADER -->
    
    <jsp:include page="layout/header.jsp" />
    <jsp:include page="layout/banner.jsp" />

    <!-- MAIN -->
    <main class="container py-4 checkout-page">
        <div class="row g-4">

            <!-- LEFT MENU (cột trái) -->
            <div class="col-12 col-md-3">
                <jsp:include page="layout/leftmenu.jsp" />
            </div>

            <!-- CONTENT (cột phải) -->
            <section class="col-12 col-md-9">

                <h3 class="mb-3">Thông tin đặt hàng</h3>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>

                <c:set var="cart" value="${sessionScope.cart}"/>

                <div class="row g-4">
                    <!-- FORM THÔNG TIN -->
                    <div class="col-lg-7">
                        <form method="post" action="place-order">
                            <div class="mb-3">
                                <label class="form-label">Họ tên *</label>
                                <input class="form-control"
                                       name="name"
                                       value="${sessionScope.currentUser != null ? sessionScope.currentUser.name : ''}"
                                       required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Email</label>
                                <input class="form-control"
                                       type="email"
                                       name="email"
                                       value="${sessionScope.currentUser != null ? sessionScope.currentUser.email : ''}">
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
                                       value="${sessionScope.currentUser != null ? sessionScope.currentUser.phone : ''}">
                            </div>


                            <div class="mb-3">
                                <label class="form-label">Địa chỉ nhận hàng *</label>
                                <textarea class="form-control"
                                          name="address"
                                          rows="3"
                                          required><c:out value="${sessionScope.currentUser != null ? sessionScope.currentUser.address : ''}"/></textarea>
                            </div>

                            <button class="btn btn-success">Đặt hàng</button>
                            <a class="btn btn-outline-secondary ms-2" href="cart">Quay lại giỏ</a>
                        </form>
                    </div>

                    <!-- TÓM TẮT ĐƠN HÀNG -->
                    <div class="col-lg-5">
                        <div class="card order-summary-card">
                            <div class="card-header">Tóm tắt đơn hàng</div>
                            <div class="card-body">

                                <c:if test="${cart != null && not empty cart.items}">
                                    <c:forEach var="e" items="${cart.items}">
                                        <c:set var="ci" value="${e.value}"/>
                                        <div class="d-flex justify-content-between order-line mb-1">
                                            <div>${ci.product.ten} × ${ci.qty}</div>
                                            <div>
                                                <fmt:formatNumber value="${ci.lineTotal}" type="number"/> đ
                                            </div>
                                        </div>
                                    </c:forEach>

                                    <hr>

                                    <div class="d-flex justify-content-between">
                                        <strong>Tổng tiền</strong>
                                        <strong class="text-danger">
                                            <fmt:formatNumber value="${cart.totalAmount}" type="number"/> đ
                                        </strong>
                                    </div>
                                </c:if>

                                <c:if test="${cart == null || empty cart.items}">
                                    <div class="text-muted small">
                                        Giỏ hàng đang trống. Vui lòng quay lại giỏ hàng để thêm sản phẩm.
                                    </div>
                                </c:if>

                            </div>
                        </div>
                    </div>
                </div>

            </section><!-- /col-9 -->

        </div><!-- /row -->
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <jsp:include page="layout/footer.jsp" />
</body>
</html>
