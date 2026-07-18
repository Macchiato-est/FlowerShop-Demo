<%-- 
    Document   : blog
    Created on : Nov 23, 2025, 5:34:55 PM
    Author     : 06052
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="dao.CategoryDAO" %>
<%@ page import="java.util.List" %>

<%
    CategoryDAO cdao = new CategoryDAO();
    request.setAttribute("categories", cdao.getAll());
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Blog – ShopHoa</title>

    <link rel="stylesheet" href="Css/main.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>
<body>


    <jsp:include page="layout/header.jsp" />
    <jsp:include page="layout/banner.jsp" />

    <main class="container py-4">
        <div class="row g-4 layout-row">

            <!-- LEFT MENU -->
            <div class="col-12 col-md-3">
                <jsp:include page="layout/leftmenu.jsp" />
            </div>

            <!-- CONTENT BLOG -->
            <section class="col-12 col-md-9">
                <h2 class="mb-3 fw-bold">Blog hoa tươi</h2>
                <p class="text-muted mb-4">
                    Nơi chia sẻ những mẹo chọn hoa, bảo quản hoa và gợi ý quà tặng theo từng dịp
                    để bạn dễ dàng gửi trọn yêu thương đến người nhận.
                </p>

                <div class="row g-4">

                    <!-- BÀI VIẾT 1 -->
                    <div class="col-md-6">
                        <div class="card h-100 shadow-sm border-0">
                            <img src="images/blog/sinhnhatblog.png"
                                 class="card-img-top blog-thumb"
                                 alt="5 gợi ý chọn hoa sinh nhật tinh tế">
                            <div class="card-body">
                                <div class="text-muted small mb-2">
                                    12/11/2025 • Chia sẻ kinh nghiệm
                                </div>
                                <h5 class="card-title">
                                    5 gợi ý chọn hoa sinh nhật tinh tế cho người thân
                                </h5>
                                <p class="card-text small text-muted">
                                    Chọn hoa sinh nhật đôi khi không chỉ là chọn loại hoa đẹp,
                                    mà còn là chọn màu sắc, ý nghĩa phù hợp với người nhận...
                                </p>
                                <a href="https://dalathasfarm.com/blog/goi-y-5-loai-hoa-tang-sinh-nhat-dep/" class="btn btn-sm btn-outline-primary">
                                    Đọc tiếp
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- BÀI VIẾT 2 -->
                    <div class="col-md-6">
                        <div class="card h-100 shadow-sm border-0">
                            <img src="images/blog/chamhoa.webp"
                                 class="card-img-top blog-thumb"
                                 alt="Mẹo giữ hoa tươi lâu hơn tại nhà">
                            <div class="card-body">
                                <div class="text-muted small mb-2">
                                    08/11/2025 • Bí quyết chăm hoa
                                </div>
                                <h5 class="card-title">
                                    Mẹo giữ hoa tươi lâu hơn tại nhà chỉ với vài bước đơn giản
                                </h5>
                                <p class="card-text small text-muted">
                                    Sau khi nhận hoa, chỉ cần thêm vài thao tác nhỏ như cắt vát cành,
                                    thay nước đúng cách, bạn đã có thể giữ hoa tươi lâu hơn...
                                </p>
                                <a href="https://mrhoa.com/tu-van/cach-bao-quan-hoa-tuoi-lau/" class="btn btn-sm btn-outline-primary">
                                    Đọc tiếp
                                </a>
                            </div>
                        </div>
                    </div>

                </div><!-- /row g-4 -->
            </section>

        </div><!-- /row -->
    </main>

    <jsp:include page="layout/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
    </script>
</body>
</html>
