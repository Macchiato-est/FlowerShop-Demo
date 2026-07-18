<%--  
    Document   : order
    Created on : Nov 13, 2025, 8:45:12 AM
    Author     : 06052
--%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lịch sử đơn hàng</title>

    <link rel="stylesheet" href="Css/main.css">
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

    <style>
        /* ORDER HISTORY PAGE */

        .order-page h2 {
            font-weight: 700;
            font-size: 22px;
            margin-bottom: 20px;
        }

        .order-page .table {
            background: #ffffff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0,0,0,0.06);
        }

        .order-page .table thead tr {
            background: #f8f9fb;
        }

        .order-page .table th,
        .order-page .table td {
            padding-top: 12px;
            padding-bottom: 12px;
            vertical-align: middle;
            font-size: 14px;
        }

        .order-page .badge {
            font-size: 12px;
            padding: 6px 10px;
            border-radius: 999px;
        }

        .order-page .btn-sm {
            font-size: 13px;
            padding: 5px 10px;
        }
    </style>
</head>
<body>


<jsp:include page="layout/header.jsp" />
<jsp:include page="layout/banner.jsp" />

<!-- MAIN -->
<main class="container mt-5 order-page">
    <div class="row g-4">

        <!-- LEFT MENU bọc col-3 như mày yêu cầu -->
        <div class="col-12 col-md-3">
            <jsp:include page="layout/leftmenu.jsp" />
        </div>

        <!-- CONTENT bên phải -->
        <section class="col-12 col-md-9">

            <h2 class="mb-4">📦 Lịch sử đơn hàng</h2>

            <c:if test="${empty orders}">
                <div class="alert alert-info">
                    Bạn chưa có đơn hàng nào.
                </div>
            </c:if>

            <c:if test="${not empty orders}">
                <table class="table table-bordered table-hover align-middle">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Người nhận</th>
                        <th>SĐT</th>
                        <th>Địa chỉ</th>
                        <th>Ngày lập</th>
                        <th>Trạng thái</th>
                        <th class="text-end">Tổng tiền</th>
                        <th></th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach var="o" items="${orders}">
                        <tr>
                            <td>${o.id}</td>
                            <td>${o.hoTenNhan}</td>
                            <td>${o.dienThoaiNhan}</td>
                            <td>${o.diaChiNhan}</td>
                            <td>
                                <fmt:formatDate value="${o.ngayLap}" pattern="dd/MM/yyyy HH:mm"/>
                            </td>

                            <td>
                                <c:choose>
                                    <c:when test="${o.trangThai == 'PENDING'}">
                                        <span class="badge bg-warning text-dark">PENDING</span>
                                    </c:when>
                                    <c:when test="${o.trangThai == 'SHIPPING'}">
                                        <span class="badge bg-info text-dark">SHIPPING</span>
                                    </c:when>
                                    <c:when test="${o.trangThai == 'DONE'}">
                                        <span class="badge bg-success">DONE</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">${o.trangThai}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td class="text-end">
                                <fmt:formatNumber value="${o.tongTien}" type="number"/> đ
                            </td>

                            <td class="text-center">
                                <a href="order-detail?id=${o.id}"
                                   class="btn btn-sm btn-primary">
                                    Xem
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <c:if test="${not empty sessionScope.msg}">
                    <script>alert('${sessionScope.msg}');</script>
                    <c:remove var="msg" scope="session"/>
                </c:if>
            </c:if>

            <a href="index" class="btn btn-outline-secondary mt-3">
                ← Về trang chủ
            </a>

        </section><!-- /col-9 -->

    </div><!-- /row -->
</main>

<jsp:include page="layout/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
