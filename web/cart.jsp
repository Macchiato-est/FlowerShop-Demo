
<%-- 
    Document   : cart
    Created on : Nov 9, 2025, 6:56:17 PM
    Author     : 06052
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Giỏ hàng</title>

    <link rel="stylesheet" href="Css/main.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* CART PAGE – Áp dụng cho <div class="container py-4 cart-page"> */

    .cart-page .thumb {
        width: 72px;
        height: 72px;
        object-fit: cover;
        border-radius: 8px;
    }

    .cart-page h3 {
        font-weight: 700;
        font-size: 22px;
        margin-bottom: 20px;
    }

    .cart-page .table {
        background: #ffffff;
        border-radius: 12px;
        overflow: hidden;
    }

    .cart-page .table thead tr {
        background: #f8f9fb;
    }

    .cart-page .table th,
    .cart-page .table td {
        vertical-align: middle;
        padding-top: 14px;
        padding-bottom: 14px;
    }

    .cart-page input[type="number"] {
        max-width: 90px;
    }

    /* Tổng cộng + nút dưới */
    .cart-page .cart-summary {
        text-align: right;
    }

    .cart-page .cart-summary .total-label {
        font-size: 15px;
        color: #555;
    }

    .cart-page .cart-summary .total-value {
        font-size: 20px;
        color: #e53935;
        font-weight: 700;
    }
    </style>
</head>
<body>

    <!-- BANNER + HEADER -->

    <jsp:include page="layout/header.jsp" />
    <jsp:include page="layout/banner.jsp" />

    <!-- MAIN -->
    <main class="container py-4 cart-page">
        <div class="row g-4">

            <!-- LEFT MENU (cột trái) -->
            <div class="col-12 col-md-3">
                <jsp:include page="layout/leftmenu.jsp" />
            </div>

            <!-- CONTENT (cột phải) -->
            <div class="col-12 col-md-9">

                <h3 class="mb-4">Giỏ hàng</h3>

                <!-- Lấy cart từ session -->
                <c:set var="cart" value="${sessionScope.cart}" />

                <c:choose>
                    <%-- Trường hợp giỏ hàng trống --%>
                    <c:when test="${cart == null or empty cart.items}">
                        <div class="alert alert-light border">Giỏ hàng đang trống.</div>
                        <a class="btn btn-primary" href="index">Tiếp tục mua sắm</a>
                    </c:when>

                    <%-- Có sản phẩm trong giỏ --%>
                    <c:otherwise>

                        <!-- Form cập nhật số lượng -->
                        <form action="cart-update" method="post">
                            <div class="table-responsive">
                                <table class="table align-middle">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>Sản phẩm</th>
                                            <th class="text-end">Đơn giá</th>
                                            <th style="width:120px">Số lượng</th>
                                            <th class="text-end">Thành tiền</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="e" items="${cart.items}">
                                            <c:set var="ci" value="${e.value}"/>
                                            <tr>
                                                <td>
                                                    <img class="thumb"
                                                         src="images/${ci.product.hinhAnh}"
                                                         alt="${ci.product.ten}">
                                                </td>
                                                <td>
                                                    <div class="fw-semibold">${ci.product.ten}</div>
                                                    <div class="text-muted small">Mã: ${ci.product.id}</div>
                                                </td>
                                                <td class="text-end">
                                                    <fmt:formatNumber value="${ci.product.gia}" type="number"/> đ
                                                </td>
                                                <td>
                                                    <!-- inputs cho cập nhật -->
                                                    <input type="hidden"
                                                           name="pid"
                                                           value="${ci.product.id}">

                                                    <input type="number"
                                                           min="0"
                                                           max="${ci.product.soLuong}"
                                                           class="form-control"
                                                           name="qty"
                                                           value="${ci.qty}">

                                                    <c:if test="${ci.qty > ci.product.soLuong}">
                                                        <div class="text-danger small mt-1">
                                                            Vượt tồn (còn ${ci.product.soLuong}). Vui lòng giảm số lượng.
                                                        </div>
                                                    </c:if>
                                                </td>
                                                <td class="text-end">
                                                    <fmt:formatNumber value="${ci.lineTotal}" type="number"/> đ
                                                </td>
                                                <td class="text-end">
                                                    <!-- Nút xóa: gửi POST sang /cart-remove ngay trong form -->
                                                    <input type="hidden" name="id" value="${ci.product.id}">
                                                    <button type="submit"
                                                            class="btn btn-sm btn-outline-danger"
                                                            formaction="cart-remove"
                                                            formmethod="post">
                                                        Xóa
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <div class="d-flex justify-content-between align-items-center mt-3">
                                <a class="btn btn-outline-secondary" href="index">Tiếp tục mua sắm</a>

                                <div class="text-end">
                                    <div class="mb-2">
                                        Tổng cộng:
                                        <strong class="fs-5 text-danger">
                                            <fmt:formatNumber value="${cart.totalAmount}" type="number"/> đ
                                        </strong>
                                    </div>
                                    <div class="d-flex gap-2 justify-content-end">
                                        <button class="btn btn-outline-primary">Cập nhật</button>
                                        <a class="btn btn-success" href="checkout">Đặt hàng</a>
                                    </div>
                                </div>
                            </div>
                        </form>

                    </c:otherwise>
                </c:choose>

            </div><!-- /col-9 -->

        </div><!-- /row -->
    </main>

    <!-- FOOTER -->
    <jsp:include page="layout/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
