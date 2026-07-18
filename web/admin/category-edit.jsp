<%-- 
    Document   : category-edit
    Created on : Nov 19, 2025, 4:56:53 PM
    Author     : 06052
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Category" %>

<%
    Category c = (Category) request.getAttribute("cat");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Sửa loại hoa</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css">
</head>

<body>
<div class="content-wrapper p-4">

    <h3>Sửa loại hoa</h3>

    <form action="<%=request.getContextPath()%>/admin/category-edit" method="post"
          class="card p-4">

        <input type="hidden" name="id" value="<%=c.getId()%>">

        <div class="form-group mb-3">
            <label>Tên loại</label>
            <input type="text" class="form-control" name="tenLoai"
                   value="<%=c.getTenLoai()%>" required>
        </div>

        <button class="btn btn-primary">Cập nhật</button>
        <a href="<%=request.getContextPath()%>/admin/categories"
           class="btn btn-secondary">Hủy</a>

    </form>

</div>
</body>
</html>
