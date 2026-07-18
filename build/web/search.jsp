<%-- 
    Document   : search
    Created on : Nov 13, 2025, 8:17:52 AM
    Author     : 06052
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tìm kiếm – ShopHoa</title>

    <link rel="stylesheet" href="Css/main.css">
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

    <style>
        /* SEARCH PAGE */

        .search-page h4 {
            font-weight: 700;
            font-size: 20px;
            margin-bottom: 16px;
        }

        .search-page .card {
            border-radius: 14px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0,0,0,0.06);
            transition: 0.25s ease;
        }

        .search-page .card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.10);
        }

        .search-page .card-img-top {
            height: 220px;
            object-fit: cover;
        }

        .search-page .badge {
            font-size: 12px;
            padding: 4px 8px;
            border-radius: 999px;
        }
    </style>
</head>
<body>

<jsp:include page="layout/header.jsp" />
<jsp:include page="layout/banner.jsp" />

<!-- MAIN: dùng chung layout container + row + leftmenu -->
<main class="container py-3 search-page">
    <div class="row g-4">

        <!-- LEFT MENU (bọc col-3) -->
        <div class="col-12 col-md-3">
            <jsp:include page="layout/leftmenu.jsp" />
        </div>

        <!-- NỘI DUNG KẾT QUẢ TÌM KIẾM (bên phải) -->
        <section class="col-12 col-md-9">

            <h4 class="mb-3">
                Kết quả tìm kiếm
                <c:if test="${not empty keyword}">
                    cho "<span class="text-primary">${keyword}</span>"
                </c:if>
            </h4>

            <c:choose>
                <c:when test="${empty results}">
                    <div class="alert alert-info">
                        Không tìm thấy sản phẩm phù hợp.
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="row row-cols-1 row-cols-md-3 row-cols-lg-4 g-4">
                        <c:forEach var="p" items="${results}">
                            <div class="col">
                                <div class="card h-100">
                                    <div class="position-relative">
                                        <img src="images/${p.hinhAnh}"
                                             class="card-img-top"
                                             alt="${p.ten}">
                                        <c:if test="${p.gia < p.giaGoc}">
                                            <span class="badge bg-danger position-absolute top-0 start-0 m-2">
                                                -<fmt:formatNumber
                                                    value="${(p.giaGoc - p.gia) * 100 / p.giaGoc}"
                                                    maxFractionDigits="0"/>%
                                            </span>
                                        </c:if>
                                    </div>

                                    <div class="card-body d-flex flex-column">
                                        <h6 class="card-title">${p.ten}</h6>

                                        <div class="mt-auto">
                                            <div class="fw-bold text-danger">
                                                <fmt:formatNumber value="${p.gia}"
                                                                  type="number"
                                                                  groupingUsed="true"/> đ
                                            </div>
                                            <c:if test="${p.gia < p.giaGoc}">
                                                <small class="text-muted text-decoration-line-through">
                                                    <fmt:formatNumber value="${p.giaGoc}"
                                                                      type="number"
                                                                      groupingUsed="true"/> đ
                                                </small>
                                            </c:if>

                                            <a href="product-detail?id=${p.id}"
                                               class="btn btn-sm btn-outline-primary w-100 mt-2">
                                                Xem chi tiết
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>

            <div class="mt-4">
                <a href="index" class="btn btn-outline-secondary">← Về trang chủ</a>
            </div>

        </section><!-- /col-9 -->

    </div><!-- /row -->
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<jsp:include page="layout/footer.jsp" />

</body>
</html>
