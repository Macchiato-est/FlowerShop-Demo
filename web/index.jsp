<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn"  uri="jakarta.tags.functions" %>
<%@ page import="dao.BannerDAO" %>
<%@ page import="model.Banner" %>
<%@ page import="java.util.List" %>

<%
    BannerDAO bdao = new BannerDAO();
    List<Banner> banners = bdao.getAll();
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Shop Hoa - Trang chủ</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Swiper CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css" />

    <!-- Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <!-- Main CSS -->
    <link rel="stylesheet" href="Css/main.css">
</head>

<body>
<jsp:include page="layout/header.jsp" />
<jsp:include page="layout/banner.jsp" />

<!-- MAIN -->
<main class="container my-4">
    <div class="row g-4 layout-row">

        <!-- LEFT MENU -->
        <div class="col-12 col-md-3 col-left">
            <jsp:include page="layout/leftmenu.jsp" />
        </div>

        <!-- CONTENT -->
        <section class="col-12 col-md-9">

            <!-- BANNER SLIDER -->
            <div class="swiper mySwiper"
                 style="width:100%; height:400px; border-radius:12px; overflow:hidden;">
                <div class="swiper-wrapper">
                    <% for (Banner b : banners) {
                           if ("SHOW".equals(b.getTrangThai())) { %>
                        <div class="swiper-slide">
                            <img src="images/banner/<%= b.getHinhAnh() %>"
                                 style="width:100%; height:100%; object-fit:cover;">
                        </div>
                    <% }} %>
                </div>

                <div class="swiper-button-next"></div>
                <div class="swiper-button-prev"></div>
                <div class="swiper-pagination"></div>
            </div>

            <!-- USP SECTION -->
            <section class="usp-wrapper mt-5">
                <div class="usp-title text-center mb-4">
                    <h3>LỢI ÍCH KHI SỬ DỤNG DỊCH VỤ TẠI ĐÂY</h3>
                    <div class="usp-underline"></div>
                </div>

                <div class="usp-container">
                    <div class="usp-item">
                        <i class="bi bi-truck"></i>
                        <div>
                            <h4>MIỄN PHÍ GIAO HÀNG</h4>
                            <p>Free shipping (nội thành)</p>
                        </div>
                    </div>

                    <div class="usp-item">
                        <i class="bi bi-headset"></i>
                        <div>
                            <h4>PHỤC VỤ 24/24</h4>
                            <p>24-7 service</p>
                        </div>
                    </div>

                    <div class="usp-item">
                        <i class="bi bi-receipt"></i>
                        <div>
                            <h4>GIÁ ĐÃ GỒM 8% VAT</h4>
                            <p>Price include VAT</p>
                        </div>
                    </div>
                </div>
            </section>

            <!-- ĐANG GIẢM GIÁ — SLIDER -->
            <section class="mt-4">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4 class="mb-0">Đang giảm giá</h4>
                    <a href="category?type=sale"
                       class="text-decoration-none fw-bold text-primary">Xem thêm ></a>
                </div>

                <c:if test="${empty discounted}">
                    <div class="alert alert-light border">Chưa có sản phẩm giảm giá.</div>
                </c:if>

                <c:if test="${not empty discounted}">
                    <div class="swiper saleSwiper">
                        <div class="swiper-wrapper">

                            <c:forEach var="p" items="${discounted}">
                                <div class="swiper-slide">
                                    <div class="card h-100 product-card">

                                        <!-- Badge giảm giá -->
                                        <c:if test="${p.giaGoc > p.gia}">
                                            <c:set var="discount"
                                                   value="${(p.giaGoc - p.gia) / p.giaGoc * 100}" />
                                            <span class="badge text-bg-danger discount-badge">
                                                -<c:out value='${fn:substringBefore(discount, ".")}'/>%
                                            </span>
                                        </c:if>

                                        <img class="card-img-top"
                                             src="images/${p.hinhAnh}" alt="${p.ten}">

                                        <div class="card-body">
                                            <h6 class="card-title">${p.ten}</h6>
                                            <div class="price">
                                                <strong>
                                                    <fmt:formatNumber value='${p.gia}' type='number'/> đ
                                                </strong>
                                                <c:if test="${p.giaGoc > p.gia}">
                                                    <del>
                                                        <fmt:formatNumber value='${p.giaGoc}' type='number'/> đ
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

                        <div class="swiper-button-next"></div>
                        <div class="swiper-button-prev"></div>
                    </div>
                </c:if>
            </section>

            <!-- DANH MỤC NỔI BẬT -->
            <section class="category-highlight mt-5">
                <h4 class="mb-4 text-center">DANH MỤC NỔI BẬT</h4>

                <div class="cat-grid">
                    <c:forEach var="c" items="${categories}" begin="0" end="4">
                        <a href="index?cat=${c.id}#products-section" class="cat-item">
                            <div class="cat-icon">
                                <i class="bi bi-flower1"></i>
                            </div>
                            <span>${c.tenLoai}</span>
                        </a>
                    </c:forEach>
                </div>
            </section>

            <!-- GỢI Ý HÔM NAY -->
            <section class="mt-5">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4 class="mb-0">Gợi ý hôm nay</h4>
                    <a href="category?type=recommend"
                       class="text-decoration-none fw-bold text-primary">Xem thêm ></a>
                </div>

                <c:if test="${empty recommended}">
                    <div class="alert alert-light border">Hiện chưa có gợi ý.</div>
                </c:if>

                <c:if test="${not empty recommended}">
                    <div class="swiper recommendSwiper">
                        <div class="swiper-wrapper">

                            <c:forEach var="p" items="${recommended}">
                                <div class="swiper-slide" style="width:260px;">
                                    <div class="card h-100 product-card">

                                        <c:if test="${p.giaGoc > p.gia}">
                                            <c:set var="discount"
                                                   value="${(p.giaGoc - p.gia) / p.giaGoc * 100}" />
                                            <span class="badge text-bg-danger discount-badge">
                                                -<c:out value='${fn:substringBefore(discount, ".")}'/>%
                                            </span>
                                        </c:if>

                                        <img class="card-img-top"
                                             src="images/${p.hinhAnh}" alt="${p.ten}">

                                        <div class="card-body">
                                            <h6 class="card-title">${p.ten}</h6>
                                            <div class="price">
                                                <strong>
                                                    <fmt:formatNumber value='${p.gia}' type='number'/> đ
                                                </strong>
                                                <c:if test="${p.giaGoc > p.gia}">
                                                    <del>
                                                        <fmt:formatNumber value='${p.giaGoc}' type='number'/> đ
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

                        <div class="swiper-button-next"></div>
                        <div class="swiper-button-prev"></div>
                    </div>
                </c:if>
            </section>

            <!-- SẢN PHẨM MỚI (SLIDER) – khi không chọn danh mục -->
            <c:if test="${empty activeCat}">
                <section id="products-section" class="mt-5">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h4 class="mb-0">Sản phẩm mới</h4>
                        <a href="category?type=new"
                           class="text-decoration-none fw-bold text-primary">Xem thêm ></a>
                    </div>

                    <div class="swiper newestSwiper">
                        <div class="swiper-wrapper">

                            <c:forEach var="p" items="${mainProducts}">
                                <div class="swiper-slide" style="width:260px;">
                                    <div class="card h-100 product-card">

                                        <c:if test="${p.giaGoc > p.gia}">
                                            <c:set var="discount"
                                                   value="${(p.giaGoc - p.gia) / p.giaGoc * 100}" />
                                            <span class="badge text-bg-danger discount-badge">
                                                -<c:out value='${fn:substringBefore(discount, ".")}'/>%
                                            </span>
                                        </c:if>

                                        <img class="card-img-top"
                                             src="images/${p.hinhAnh}" alt="${p.ten}">

                                        <div class="card-body">
                                            <h6 class="card-title">${p.ten}</h6>
                                            <div class="price">
                                                <strong>
                                                    <fmt:formatNumber value='${p.gia}' type='number'/> đ
                                                </strong>
                                                <c:if test="${p.giaGoc > p.gia}">
                                                    <del>
                                                        <fmt:formatNumber value='${p.giaGoc}' type='number'/> đ
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

                        <div class="swiper-button-next"></div>
                        <div class="swiper-button-prev"></div>
                    </div>
                </section>
            </c:if>

            <!-- SẢN PHẨM THEO DANH MỤC (GRID) – khi chọn danh mục -->
            <c:if test="${not empty activeCat}">
                <section id="products-section" class="mt-5">
                    <h4 class="mb-3">Sản phẩm theo danh mục</h4>

                    <c:if test="${empty mainProducts}">
                        <div class="alert alert-light border">Chưa có sản phẩm phù hợp.</div>
                    </c:if>

                    <c:if test="${not empty mainProducts}">
                        <div class="row g-3">
                            <c:forEach var="p" items="${mainProducts}">
                                <div class="col-6 col-lg-3">
                                    <div class="card h-100 product-card">

                                        <c:if test="${p.giaGoc > p.gia}">
                                            <c:set var="discount"
                                                   value="${(p.giaGoc - p.gia) / p.giaGoc * 100}" />
                                            <span class="badge text-bg-danger discount-badge">
                                                -<c:out value='${fn:substringBefore(discount, ".")}'/>%
                                            </span>
                                        </c:if>

                                        <img class="card-img-top"
                                             src="images/${p.hinhAnh}" alt="${p.ten}">

                                        <div class="card-body">
                                            <h6 class="card-title">${p.ten}</h6>
                                            <div class="price">
                                                <strong>
                                                    <fmt:formatNumber value='${p.gia}' type='number'/> đ
                                                </strong>
                                                <c:if test="${p.giaGoc > p.gia}">
                                                    <del>
                                                        <fmt:formatNumber value='${p.giaGoc}' type='number'/> đ
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
                    </c:if>
                </section>
            </c:if>

            <!-- SẢN PHẨM BÁN CHẠY -->
            <section class="mt-5">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4 class="mb-0">Sản phẩm bán chạy</h4>
                    <a href="category?type=bestseller"
                       class="text-decoration-none fw-bold text-primary">Xem thêm ></a>
                </div>

                <c:if test="${empty bestSeller}">
                    <div class="alert alert-light border">Chưa có dữ liệu bán chạy.</div>
                </c:if>

                <c:if test="${not empty bestSeller}">
                    <div class="swiper bestSwiper">
                        <div class="swiper-wrapper">

                            <c:forEach var="p" items="${bestSeller}">
                                <div class="swiper-slide" style="width:260px;">
                                    <div class="card h-100 product-card">

                                        <c:if test="${p.giaGoc > p.gia}">
                                            <c:set var="discount"
                                                   value="${(p.giaGoc - p.gia) / p.giaGoc * 100}" />
                                            <span class="badge text-bg-danger discount-badge">
                                                -<c:out value='${fn:substringBefore(discount, ".")}'/>%
                                            </span>
                                        </c:if>

                                        <img class="card-img-top"
                                             src="images/${p.hinhAnh}" alt="${p.ten}">

                                        <div class="card-body">
                                            <h6 class="card-title">${p.ten}</h6>
                                            <div class="price">
                                                <strong>
                                                    <fmt:formatNumber value='${p.gia}' type='number'/> đ
                                                </strong>
                                                <c:if test="${p.giaGoc > p.gia}">
                                                    <del>
                                                        <fmt:formatNumber value='${p.giaGoc}' type='number'/> đ
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

                        <div class="swiper-button-next"></div>
                        <div class="swiper-button-prev"></div>
                    </div>
                </c:if>
            </section>
            
            <!-- KHÁCH HÀNG TIÊU BIỂU -->
            <section class="mt-5 home-clients">
                <h4 class="mb-4 text-center">KHÁCH HÀNG TIÊU BIỂU</h4>

                <div class="client-logos">
                    <a href="https://www.fpt.edu.vn" target="_blank" class="client-logo-item">
                        <img src="images/clients/dhfpt.jpg" alt="FPT University" class="client-logo-img">
                    </a>
                 
                    <a href="https://www.vietravel.com" target="_blank" class="client-logo-item">
                        <img src="images/clients/viettravel.jpg" alt="Vietravel" class="client-logo-img">
                    </a>

                    <a href="https://everon.com" target="_blank" class="client-logo-item">
                        <img src="images/clients/everon.jpg" alt="Everon" class="client-logo-img">
                    </a>

                    <a href="https://www.daikin.com.vn/" target="_blank" class="client-logo-item">
                        <img src="images/clients/daikin.png" alt="Daikin" class="client-logo-img">
                    </a>

                    <a href="https://pnj.com.vn" target="_blank" class="client-logo-item">
                        <img src="images/clients/pnj.png" alt="PNJ" class="client-logo-img">
                    </a>


                </div>
            </section>

                
            <!-- HỆ THỐNG CỬA HÀNG -->
            <section class="store-section">
                <h4>Hệ thống cửa hàng ShopHoa</h4>
                <p class="mb-3 small text-muted">
                    ShopHoa hiện có nhiều chi nhánh trên toàn quốc, giúp khách hàng dễ dàng
                    đặt hoa online và nhận hoa nhanh chóng.
                </p>

                <div class="row g-4">
                    <!-- CƠ SỞ CHÍNH -->
                    <div class="col-md-4">
                        <h6>Cơ sở chính</h6>
                        <ul>
                            <li><strong>Hà Nội:</strong> 123 Đường Hoa Đào, Quận Hai Bà Trưng</li>
                            <li><strong>TP. HCM:</strong> 45 Hoa Lan, Quận Phú Nhuận</li>
                            <li><strong>Đà Nẵng:</strong> 89 Nguyễn Văn Linh, Quận Hải Châu</li>
                        </ul>
                    </div>

                    <!-- CƠ SỞ KHÁC -->
                    <div class="col-md-4">
                        <h6>Cơ sở khác</h6>
                        <ul>
                            <li><strong>Hải Phòng:</strong> 20B Tô Hiệu, Quận Lê Chân</li>
                            <li><strong>Cần Thơ:</strong> 68 CMT8, Quận Ninh Kiều</li>
                            <li><strong>Nha Trang:</strong> 92 Lê Hồng Phong, Phước Trung</li>
                        </ul>
                    </div>

                    <!-- CHI NHÁNH ONLINE / GỢI Ý -->
                    <div class="col-md-4">
                        <h6>Dịch vụ & chi nhánh online</h6>
                        <ul>
                            <li>Giao hoa nhanh nội thành trong 2 giờ</li>
                            <li>Nhận đơn đặt hoa toàn quốc qua website</li>
                            <li>Tư vấn chọn hoa theo từng dịp đặc biệt 8/3, 20/10, ngày cưới...</li>
                        </ul>
                    </div>
                </div>
            </section>

        </section><!-- /CONTENT col-md-9 -->
    </div><!-- /row -->
</main>

    <!-- SLOGAN -->
    <section class="home-slogan">
        <p class="slogan-main">Hoa tươi mỗi ngày – Giao nhanh trong 2 giờ nội thành.</p>
        <p class="slogan-sub">
            Cam kết 100% hoa tươi, hỗ trợ đổi mẫu nếu hoa héo, tư vấn miễn phí theo từng dịp tặng.
        </p>
    </section>

<!-- FOOTER -->
<jsp:include page="layout/footer.jsp" />

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>

<!-- Swiper Init -->
<script>
var swiper = new Swiper(".mySwiper", {
    loop: true,
    autoplay: { delay: 3000, disableOnInteraction: false },
    pagination: { el: ".swiper-pagination", clickable: true },
    navigation: { nextEl: ".swiper-button-next", prevEl: ".swiper-button-prev" },
    speed: 800
});

var saleSwiper = new Swiper(".saleSwiper", {
    slidesPerView: 4,
    spaceBetween: 20,
    loop: true,
    navigation: {
        nextEl: ".saleSwiper .swiper-button-next",
        prevEl: ".saleSwiper .swiper-button-prev"
    },
    breakpoints: {
        320:{slidesPerView:1},
        576:{slidesPerView:2},
        768:{slidesPerView:3},
        1200:{slidesPerView:4}
    }
});

var newestSwiper = new Swiper(".newestSwiper", {
    slidesPerView: 4,
    spaceBetween: 20,
    loop: true,
    navigation: {
        nextEl: ".newestSwiper .swiper-button-next",
        prevEl: ".newestSwiper .swiper-button-prev"
    },
    breakpoints: {
        320:{ slidesPerView: 1 },
        576:{ slidesPerView: 2 },
        768:{ slidesPerView: 3 },
        1200:{ slidesPerView: 4 }
    }
});

var bestSwiper = new Swiper(".bestSwiper", {
    slidesPerView: 4,
    spaceBetween: 20,
    loop: true,
    navigation: {
        nextEl: ".bestSwiper .swiper-button-next",
        prevEl: ".bestSwiper .swiper-button-prev"
    },
    breakpoints: {
        320:{ slidesPerView: 1 },
        576:{ slidesPerView: 2 },
        768:{ slidesPerView: 3 },
        1200:{ slidesPerView: 4 }
    }
});

var recommendSwiper = new Swiper(".recommendSwiper", {
    slidesPerView: 4,
    spaceBetween: 20,
    loop: true,
    navigation: {
        nextEl: ".recommendSwiper .swiper-button-next",
        prevEl: ".recommendSwiper .swiper-button-prev"
    },
    breakpoints: {
        320:{ slidesPerView: 1 },
        576:{ slidesPerView: 2 },
        768:{ slidesPerView: 3 },
        1200:{ slidesPerView: 4 }
    }
});
</script>

</body>
</html>
