<%-- 
    Document   : about
    Created on : Nov 23, 2025, 5:31:31 PM
    Author     : 06052
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="dao.CategoryDAO" %>
<%@ page import="java.util.List" %>

<%
    // Lấy danh mục cho leftmenu + phần "Danh mục sản phẩm"
    CategoryDAO cdao = new CategoryDAO();
    request.setAttribute("categories", cdao.getAll());
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Giới thiệu – ShopHoa</title>

    <link rel="stylesheet" href="Css/main.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>
<body>

    <!-- BANNER + HEADER CHUNG -->
    
    <jsp:include page="layout/header.jsp" />
    <jsp:include page="layout/banner.jsp" />

    <!-- MAIN -->
    <main class="container py-4">
        <div class="row g-4 layout-row">

            <!-- LEFT MENU -->
            <div class="col-12 col-md-3">
                <jsp:include page="layout/leftmenu.jsp" />
            </div>

            <!-- CONTENT ABOUT -->
            <section class="col-12 col-md-9 about-content">

                <!-- ẢNH BANNER RIÊNG CHO TRANG GIỚI THIỆU -->
                <div class="mb-4">
                    <img src="images/banner/bannerabt.jpg"
                         alt="Giới thiệu ShopHoa"
                         class="img-fluid rounded-3 shadow-sm">
                </div>

                <!-- PHẦN CHỮ GIỚI THIỆU -->
                <h2 class="mb-4 fw-bold">Lịch sử hình thành và phát triển</h2>

                <p>
                    Shop hoa tươi <strong>ShopHoa</strong> được thành lập với mong muốn trở thành
                    người bạn đồng hành tin cậy trong những dịp gửi tặng yêu thương:
                    sinh nhật, khai trương, kỷ niệm, cưới hỏi hay những lời chúc mừng –
                    chia sẻ đặc biệt trong năm.
                </p>

                <p>
                    Từ những ngày đầu chỉ là một shop hoa nhỏ, ShopHoa dần hoàn thiện quy trình,
                    mở rộng danh mục sản phẩm và dịch vụ đặt hoa online giao tận nơi. Chúng tôi
                    chú trọng từ việc chọn lựa từng bông hoa tươi, phối màu, gói bó đến khâu
                    vận chuyển, để mỗi đơn hàng không chỉ là một bó hoa đẹp mà còn là
                    một lời nhắn gửi trọn vẹn tới người nhận.
                </p>

                <p>
                    Với hệ thống đặt hàng trực tuyến đơn giản, rõ ràng, ShopHoa giúp khách hàng
                    dễ dàng lựa chọn mẫu hoa phù hợp, tiết kiệm thời gian và vẫn đảm bảo
                    chất lượng dịch vụ tận tâm.
                </p>

                <h3 class="mt-5 mb-3 fw-bold">Tầm nhìn và sứ mệnh</h3>

                <p>
                    ShopHoa hướng tới mục tiêu trở thành một trong những địa chỉ đặt hoa online
                    đáng tin cậy tại Việt Nam, nơi khách hàng có thể yên tâm “gửi gắm” thông điệp
                    yêu thương trong mọi khoảnh khắc quan trọng.
                </p>

                <p>
                    Chúng tôi tin rằng hoa không chỉ là món quà tặng, mà còn là cầu nối cảm xúc
                    giữa người gửi và người nhận. Vì vậy, ShopHoa luôn nỗ lực không ngừng để
                    cải thiện chất lượng dịch vụ, đa dạng mẫu mã, cập nhật xu hướng thiết kế
                    bó hoa, giỏ hoa, hộp hoa hiện đại nhưng vẫn giữ được sự tinh tế.
                </p>

                <p>
                    Sứ mệnh của ShopHoa là mang đến cho khách hàng trải nghiệm đặt hoa trực tuyến
                    dễ dàng, nhanh chóng, sản phẩm đúng như hình và dịch vụ hỗ trợ tận tâm,
                    để mỗi đơn hàng đều trở thành một kỷ niệm đẹp.
                </p>

                <h3 class="mt-5 mb-3 fw-bold">Danh mục sản phẩm</h3>

                <p class="mb-2">
                    Tại ShopHoa, bạn có thể lựa chọn nhiều mẫu hoa phù hợp cho từng dịp khác nhau:
                </p>

                <ul>
                    <c:forEach var="c" items="${categories}">
                        <li>${c.tenLoai}</li>
                    </c:forEach>
                </ul>

                <p class="mt-3">
                    Ngoài ra còn nhiều mẫu hoa chúc mừng, hoa sự kiện, hoa theo chủ đề lễ Tết,
                    8/3, 20/10… được cập nhật thường xuyên để đáp ứng nhu cầu của khách hàng.
                </p>

            </section><!-- /col-9 -->
        </div><!-- /row -->
    </main>

    <jsp:include page="layout/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
