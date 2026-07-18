<%-- 
    Document   : categories
    Created on : Nov 20, 2025, 8:45:51 PM
    Author     : 06052
--%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn"  uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh mục sản phẩm</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="Css/main.css">
    <style>
        /* CATEGORY PAGE – GRID SẢN PHẨM */
.category-page h3 {
    font-weight: 700;
    font-size: 22px;
    margin-bottom: 20px;
}

.category-page .row.g-4 .card {
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 4px 12px rgba(0,0,0,0.06);
    transition: 0.25s ease;
}

.category-page .row.g-4 .card:hover {
    transform: translateY(-4px);
    box-shadow: 0 8px 20px rgba(0,0,0,0.10);
}

.category-page .row.g-4 .card-img-top {
    height: 260px;          /* chỉnh số này nếu muốn cao/thấp hơn */
    object-fit: cover;
    display: block;
}

.category-page .row.g-4 .card-body {
    padding: 14px 16px;
}
    </style>
</head>

<body>

    
    <jsp:include page="layout/header.jsp" />
    <jsp:include page="layout/banner.jsp" />

<main class="container my-5 category-page">
    <div class="row g-4">
        <div class="col-12 col-md-3">
            <jsp:include page="layout/leftmenu.jsp" />
        </div>
    <section class="col-12 col-md-9">
        <h3 class="mb-4">
            <c:choose>
                <c:when test="${param.type == 'new'}">Sản phẩm mới</c:when>
                <c:when test="${param.type == 'bestseller'}">Sản phẩm bán chạy</c:when>
                <c:when test="${param.type == 'recommend'}">Gợi ý hôm nay</c:when>
                <c:otherwise>Sản phẩm theo danh mục</c:otherwise>
            </c:choose>
        </h3>

        <c:if test="${empty products}">
            <div class="alert alert-info">Chưa có sản phẩm nào.</div>
        </c:if>
            
        <div class="row g-4">
            <c:forEach var="p" items="${products}">
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="card h-100 product-card position-relative">

                        <!-- BADGE GIẢM GIÁ -->
                        <c:if test="${p.giaGoc > p.gia}">
                            <c:set var="discount" value="${(p.giaGoc - p.gia) / p.giaGoc * 100}" />
                            <span class="badge text-bg-danger discount-badge">
                                -<c:out value="${fn:substringBefore(discount, '.')}"/>%
                            </span>
                        </c:if>

                        <img src="images/${p.hinhAnh}"
                             class="card-img-top category-thumb"
                             alt="${p.ten}">

                        <div class="card-body">
                            <h6 class="card-title">${p.ten}</h6>

                            <div class="price">
                                <strong>
                                    <fmt:formatNumber value="${p.gia}" type="number"/> đ
                                </strong>
                                <c:if test="${p.giaGoc > p.gia}">
                                    <del>
                                        <fmt:formatNumber value="${p.giaGoc}" type="number"/> đ
                                    </del>
                                </c:if>
                            </div>
                        </div>

                        <div class="card-footer bg-white border-0">
                            <a href="product-detail?id=${p.id}"
                               class="btn btn-sm btn-outline-primary w-100">
                                Xem chi tiết
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>


    </section>
    </div>

</main>
<jsp:include page="layout/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
