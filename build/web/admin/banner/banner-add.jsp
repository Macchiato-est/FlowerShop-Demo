<%-- 
    Document   : banner-add
    Created on : Nov 20, 2025, 12:33:55 PM
    Author     : 06052
--%>

<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm banner</title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css">
</head>

<body class="hold-transition">

<div class="container mt-4" style="max-width:600px;">
    <h3 class="mb-3">Thêm Banner</h3>

    <!-- THÔNG BÁO LỖI -->
    <c:if test="${not empty error}">
        <p class="text-danger"><i class="fas fa-exclamation-circle"></i> ${error}</p>
    </c:if>

    <!-- FORM THÊM -->
    <form action="${pageContext.request.contextPath}/admin/banner-add"
          method="post" enctype="multipart/form-data">

        <div class="form-group mb-3">
            <label>Tiêu đề banner</label>
            <input type="text" name="tieu_de" class="form-control" required>
        </div>

        <div class="form-group mb-3">
            <label>Hình ảnh</label>
            <input type="file" name="hinh_anh" class="form-control" accept="image/*" required>
        </div>

        <div class="form-group mb-3">
            <label>Trạng thái</label>
            <select name="trang_thai" class="form-control">
                <option value="SHOW">Hiển thị</option>
                <option value="HIDE">Ẩn</option>
            </select>
        </div>

        <button class="btn btn-primary">Thêm Banner</button>
        <a href="${pageContext.request.contextPath}/admin/banners"
           class="btn btn-secondary">Hủy</a>

    </form>

</div>

</body>
</html>
