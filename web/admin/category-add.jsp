<%-- 
    Document   : category-add
    Created on : Nov 19, 2025, 4:56:28 PM
    Author     : 06052
--%>

<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Thêm loại hoa</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css">
</head>

<body>
<div class="content-wrapper p-4">

    <h3>Thêm loại hoa</h3>

    <form action="<%=request.getContextPath()%>/admin/category-add" method="post"
          class="card p-4">

        <div class="form-group mb-3">
            <label>Tên loại</label>
            <input type="text" class="form-control" name="tenLoai" required>
        </div>

        <button class="btn btn-primary">Lưu</button>
        <a href="<%=request.getContextPath()%>/admin/categories"
           class="btn btn-secondary">Hủy</a>
    </form>

</div>
</body>
</html>
