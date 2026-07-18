<%-- 
    Document   : product-detail
    Created on : Nov 9, 2025, 6:44:24 PM
    Author     : 06052
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${p.ten}</title>

    <link rel="stylesheet" href="Css/main.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        /* PRODUCT DETAIL PAGE */

        .product-page h3 {
            font-weight: 700;
            font-size: 22px;
            margin-bottom: 12px;
        }

        .product-page .price del {
            color: #888;
            margin-left: .5rem;
        }

        /* Ảnh chính bên trái */
        .product-page .thumb-wrapper {
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 4px 16px rgba(0,0,0,0.10);
        }

        .product-page .thumb {
            width: 100%;
            height: 380px;
            object-fit: cover;
            display: block;
        }

        .product-page .stock {
            font-size: 14px;
        }

        .product-page form.add-to-cart {
            margin-bottom: 16px;
        }

        .product-page form.add-to-cart input[type="number"] {
            max-width: 110px;
        }

        .product-page p.description {
            line-height: 1.6;
        }

        /* Sản phẩm liên quan */
        .product-page .related-card {
            border-radius: 14px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0,0,0,0.06);
            transition: 0.25s ease;
        }

        .product-page .related-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.10);
        }

        .product-page .related-card .card-img-top {
            height: 180px;
            object-fit: cover;
        }
    </style>
</head>
<body>

    <!-- BANNER + HEADER -->
    <jsp:include page="layout/header.jsp" />
    <jsp:include page="layout/banner.jsp" />

    <!-- MAIN -->
    <main class="container py-4 product-page">
        <div class="row g-4">

            <!-- LEFT MENU (cột trái, dùng chung layout) -->
            <div class="col-12 col-md-3">
                <jsp:include page="layout/leftmenu.jsp" />
            </div>

            <!-- CONTENT (cột phải) -->
            <section class="col-12 col-md-9">


                <div class="row g-4">
                    <!-- Ảnh sản phẩm -->
                    <div class="col-12 col-md-5">
                        <div class="thumb-wrapper">
                            <img class="thumb" src="images/${p.hinhAnh}" alt="${p.ten}">
                        </div>
                    </div>

                    <!-- Thông tin + nút mua -->
                    <div class="col-12 col-md-7">
                        <h3>${p.ten}</h3>

                        <div class="mb-3 price">
                            <strong class="fs-4 text-danger">
                                <fmt:formatNumber value='${p.gia}' type='number'/> đ
                            </strong>
                            <c:if test="${p.giaGoc > p.gia}">
                                <del><fmt:formatNumber value='${p.giaGoc}' type='number'/> đ</del>
                            </c:if>
                        </div>

                        <div class="mb-2 text-muted stock">
                            <c:choose>
                                <c:when test="${p.soLuong > 0}">
                                    Còn hàng: ${p.soLuong}
                                </c:when>
                                <c:otherwise>
                                    <span class="text-danger">Hết hàng</span>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <form action="add-to-cart" method="post"
                              class="d-flex gap-2 add-to-cart">
                            <input type="hidden" name="id" value="${p.id}">
                            <input type="number"
                                   name="qty"
                                   min="1"
                                   max="${p.soLuong}"
                                   value="1"
                                   class="form-control"
                                   ${p.soLuong == 0 ? "disabled" : ""} />

                            <button type="submit"
                                    class="btn btn-primary"
                                    ${p.soLuong == 0 ? "disabled" : ""}
                                    onclick="alert('Đã thêm sản phẩm vào giỏ hàng!');">
                                Thêm vào giỏ
                            </button>
                        </form>

                        <p class="mb-4 description">
                            <c:out value="${p.moTa}"/>
                        </p>
                    </div>
                </div>

                <hr class="my-4">

                <!-- SẢN PHẨM LIÊN QUAN -->
                <h5 class="mb-3">Sản phẩm liên quan</h5>
                <div class="row g-3">
                    <c:forEach var="r" items="${related}">
                        <div class="col-6 col-md-3">
                            <div class="card h-100 related-card">
                                <img src="images/${r.hinhAnh}"
                                     class="card-img-top"
                                     alt="${r.ten}">
                                <div class="card-body">
                                    <div class="small">${r.ten}</div>
                                    <div class="price">
                                        <strong>
                                            <fmt:formatNumber value='${r.gia}' type='number'/> đ
                                        </strong>
                                        <c:if test="${r.giaGoc > r.gia}">
                                            <del>
                                                <fmt:formatNumber value='${r.giaGoc}' type='number'/> đ
                                            </del>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="card-footer bg-white border-0">
                                    <a class="btn btn-sm btn-outline-primary w-100"
                                       href="product-detail?id=${r.id}">
                                        Xem
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

            </section><!-- /col-9 -->

        </div><!-- /row -->
    </main>

    <!-- FOOTER -->
    <jsp:include page="layout/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
