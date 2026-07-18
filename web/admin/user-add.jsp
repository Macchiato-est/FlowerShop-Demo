<%-- 
    Document   : user-add
    Created on : Nov 19, 2025, 11:38:51 PM
    Author     : 06052
--%>

<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Thêm người dùng</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css">
</head>

<body class="hold-transition sidebar-mini">

<div class="wrapper">

    <div class="content-wrapper p-4">

        <h3 class="mb-4">Thêm người dùng mới</h3>

        <form action="<%=request.getContextPath()%>/admin/user-add" method="post">

            <div class="form-group">
                <label>Họ tên</label>
                <input type="text" name="ten" class="form-control" required>
            </div>

            <div class="form-group">
                <label>Email (dùng để đăng nhập)</label>
                <input type="email" name="email" class="form-control" required>
            </div>

            <c:if test="${not empty error}">
                <small class="text-danger">${error}</small>
            </c:if>

            <div class="form-group">
                <label>Mật khẩu</label>
                <input type="password" name="mat_khau" class="form-control" required>
            </div>

            <div class="form-group">
                <label>Số điện thoại</label>
                <input type="tel"
                       name="dien_thoai"
                       class="form-control"
                       pattern="0[0-9]{9,10}"
                       maxlength="11"
                       title="Số điện thoại phải bắt đầu bằng 0 và có 10–11 chữ số"
                       placeholder="Ví dụ: 0912345678">
            </div>


            <div class="form-group">
                <label>Địa chỉ</label>
                <input type="text" name="dia_chi" class="form-control">
            </div>

            <div class="form-group">
                <label>Quyền</label>
                <select name="quyen" class="form-control">
                    <option value="khachhang">Khách hàng</option>
                    <option value="admin">Admin</option>
                </select>
            </div>

            <button class="btn btn-primary mt-3">Thêm người dùng</button>
            
            <a href="<%=request.getContextPath()%>/admin/users" class="btn btn-secondary mt-3">Quay lại</a>

        </form>

    </div>

</div>

</body>
</html>
