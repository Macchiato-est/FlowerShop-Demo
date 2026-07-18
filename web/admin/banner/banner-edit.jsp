<%-- 
    Document   : banner-edit
    Created on : Nov 20, 2025, 12:37:14 PM
    Author     : 06052
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Banner" %>

<%
    Banner b = (Banner) request.getAttribute("banner");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sửa banner</title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css">
</head>

<body class="hold-transition">

<div class="container mt-4" style="max-width:600px;">
    <h3 class="mb-3">Sửa Banner</h3>

    <!-- Lỗi -->
    <c:if test="${not empty error}">
        <p class="text-danger"><i class="fas fa-exclamation-circle"></i> ${error}</p>
    </c:if>

    <form action="${pageContext.request.contextPath}/admin/banner-edit"
          method="post" enctype="multipart/form-data">

        <input type="hidden" name="id" value="<%=b.getId()%>">

        <div class="form-group mb-3">
            <label>Tiêu đề</label>
            <input type="text" name="tieu_de" class="form-control"
                   value="<%=b.getTieuDe()%>" required>
        </div>

        <div class="form-group mb-3">
            <label>Ảnh hiện tại:</label><br>
            <img src="${pageContext.request.contextPath}/images/banner/<%=b.getHinhAnh()%>"
                 style="height:80px;border-radius:6px;">
        </div>

        <div class="form-group mb-3">
            <label>Đổi ảnh (không bắt buộc)</label>
            <input type="file" name="hinh_anh" class="form-control" accept="image/*">
        </div>

        <div class="form-group mb-3">
            <label>Trạng thái</label>
            <select name="trang_thai" class="form-control">
                <option value="SHOW" <%= b.getTrangThai().equals("SHOW")?"selected":"" %>>Hiển thị</option>
                <option value="HIDE" <%= b.getTrangThai().equals("HIDE")?"selected":"" %>>Ẩn</option>
            </select>
        </div>

        <button class="btn btn-primary">Lưu thay đổi</button>
        <a href="${pageContext.request.contextPath}/admin/banners" class="btn btn-secondary">Hủy</a>

    </form>
</div>

</body>
</html>
