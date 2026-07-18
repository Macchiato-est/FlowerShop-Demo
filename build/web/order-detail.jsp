<%-- 
    Document   : orderdetail
    Created on : Nov 13, 2025, 8:45:38 AM
    Author     : 06052
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng – ShopHoa</title>

    <link rel="stylesheet" href="Css/main.css">
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

    <style>
        /* ORDER DETAIL PAGE */

        .order-detail-page h3 {
            font-weight: 700;
            font-size: 22px;
            margin-bottom: 16px;
        }

        .order-detail-page h5 {
            font-weight: 600;
            margin-bottom: 10px;
        }

        .order-detail-page .summary-card {
            background: #ffffff;
            border-radius: 12px;
            padding: 16px 18px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.06);
            margin-bottom: 20px;
        }

        .order-detail-page .table {
            background: #ffffff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0,0,0,0.06);
        }

        .order-detail-page .table thead tr {
            background: #f8f9fb;
        }

        .order-detail-page .table th,
        .order-detail-page .table td {
            padding-top: 12px;
            padding-bottom: 12px;
            vertical-align: middle;
            font-size: 14px;
        }

        .order-detail-page .badge {
            font-size: 12px;
            padding: 6px 10px;
            border-radius: 999px;
        }

        .order-detail-page .product-thumb {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 8px;
        }
    </style>
</head>
<body>

    <!-- BANNER + HEADER -->
    
    <jsp:include page="layout/header.jsp" />
    <jsp:include page="layout/banner.jsp" />

    <!-- MAIN -->
    <main class="container py-4 order-detail-page">
        <div class="row g-4">

            <!-- LEFT MENU (cột trái) -->
            <div class="col-12 col-md-3">
                <jsp:include page="layout/leftmenu.jsp" />
            </div>

            <!-- CONTENT (cột phải) -->
            <section class="col-12 col-md-9">

                <div class="d-flex justify-content-between align-items-center mb-3">
                    <a href="index" class="navbar-brand fw-bold fs-4 text-danger">ShopHoa</a>
                    <div>
                        <a href="orders" class="btn btn-outline-secondary me-2">← Đơn hàng của tôi</a>
                        <a href="index" class="btn btn-outline-secondary">Về trang chủ</a>
                    </div>
                </div>

                <h3 class="mb-3">Chi tiết đơn hàng #${order.id}</h3>

                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="summary-card">
                            <h5>Thông tin đơn hàng</h5>
                            <p>
                                <strong>Ngày đặt:</strong>
                                <fmt:formatDate value="${order.ngayLap}" pattern="dd/MM/yyyy HH:mm" />
                            </p>

                            <p>
                                <strong>Trạng thái:</strong>
                                <span class="badge bg-secondary">${order.trangThai}</span>
                            </p>

                            <c:if test="${order.trangThai == 'PENDING'}">
                                <p class="mt-3 mb-1">
                                    <a href="cancel-order?id=${order.id}"
                                       class="btn btn-danger btn-sm"
                                       onclick="return confirm('Bạn chắc chắn muốn hủy đơn hàng này?');">
                                        Hủy đơn hàng
                                    </a>
                                </p>
                            </c:if>

                            <p class="mb-0">
                                <strong>Địa chỉ giao:</strong> ${order.diaChiNhan}
                            </p>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="summary-card">
                            <h5>Tổng tiền</h5>
                            <p class="fs-4 text-danger fw-bold mb-0">
                                <fmt:formatNumber value="${order.tongTien}"
                                                  type="number"
                                                  groupingUsed="true"/> đ
                            </p>
                        </div>
                    </div>
                </div>

                <h5 class="mb-3">Sản phẩm trong đơn</h5>
                <table class="table table-bordered align-middle">
                    <thead>
                    <tr>
                        <th>Sản phẩm</th>
                        <th class="text-center">Số lượng</th>
                        <th class="text-end">Đơn giá</th>
                        <th class="text-end">Thành tiền</th>
                    </tr>
                    </thead>
                    <tbody>

                    <c:forEach var="item" items="${items}">
                        <tr>
                            <td>
                                <div class="d-flex align-items-center">
                                    <img src="images/${item.image}"
                                         alt="${item.productName}"
                                         class="me-2 product-thumb">
                                    <span>${item.productName}</span>
                                </div>
                            </td>

                            <td class="text-center">${item.soLuong}</td>

                            <td class="text-end">
                                <fmt:formatNumber value="${item.donGia}"
                                                  type="number"
                                                  groupingUsed="true"/> đ
                            </td>

                            <td class="text-end">
                                <fmt:formatNumber value="${item.thanhTien}"
                                                  type="number"
                                                  groupingUsed="true"/> đ
                            </td>
                        </tr>
                    </c:forEach>

                    </tbody>
                </table>

            </section><!-- /col-9 -->

        </div><!-- /row -->
    </main>

    <!-- FOOTER -->
    <jsp:include page="layout/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
