<%-- 
    Document   : user-edit
    Created on : Nov 19, 2025, 5:22:14 PM
    Author     : 06052
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.User" %>

<%
    User u = (User) request.getAttribute("user");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Sửa người dùng</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css">
</head>

<body>
<div class="content-wrapper p-4">

    <h3>Sửa người dùng</h3>

    <form action="<%=request.getContextPath()%>/admin/user-edit" method="post"
          class="card p-4">

        <input type="hidden" name="id" value="<%=u.getId()%>">

        <div class="form-group mb-3">
            <label>Họ tên</label>
            <input type="text" class="form-control" name="ten"
                   value="<%=u.getName()%>" required>
        </div>

        <div class="form-group mb-3">
    <label>Email</label>
    <input type="email" class="form-control" name="email"
           value="<%=u.getEmail()%>" required>

        <% 
            Object errObj = request.getAttribute("error");
            if (errObj != null) {
                String err = errObj.toString();

                if (err.contains("Email")) { 
        %>
                    <small class="text-danger"><%= err %></small>
        <%      }
            }
        %>
    </div>


        <div class="form-group mb-3">
            <label>SĐT</label>
            <input type="tel"
                   class="form-control"
                   name="dien_thoai"
                   pattern="0[0-9]{9,10}"
                   maxlength="11"
                   title="Số điện thoại phải bắt đầu bằng 0 và có 10–11 chữ số"
                   placeholder="Ví dụ: 0912345678"
                   value="<%= u.getPhone() %>">
        </div>


        <div class="form-group mb-3">
            <label>Địa chỉ</label>
            <input type="text" class="form-control" name="dia_chi"
                   value="<%=u.getAddress()%>">
        </div>

        <div class="form-group mb-3">
            <label>Quyền</label>
            <select name="quyen" class="form-control">
                <option value="khachhang" <%=u.getRole().equals("khachhang")?"selected":""%>>Khách hàng</option>
                <option value="admin" <%=u.getRole().equals("admin")?"selected":""%>>Admin</option>
            </select>
        </div>

        <div class="form-group mb-3">
            <label>Mật khẩu mới (để trống nếu không đổi)</label>
            <input type="password" name="mat_khau" class="form-control">
        </div>

        <button class="btn btn-primary">Cập nhật</button>
        <a href="<%=request.getContextPath()%>/admin/users"
           class="btn btn-secondary">Quay lại</a>
    </form>

</div>
</body>
</html>
