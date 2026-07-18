<%-- 
    Document   : register
    Created on : Nov 6, 2025, 7:25:51 AM
    Author     : 06052
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký | ShopHoa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body.auth-bg {
            min-height: 100vh;
            margin: 0;
            font-family: "Segoe UI", system-ui, -apple-system, BlinkMacSystemFont, sans-serif;

            background: #f9f1f5 url("images/b3.jpg") center/cover no-repeat fixed;

            display: flex;
            align-items: center;
            justify-content: center;
        }

        .auth-card {
            width: 100%;
            max-width: 650px;
            background: #ffffff;
            border-radius: 16px;
            box-shadow:
                0 12px 28px rgba(0, 0, 0, 0.15),
                0 2px 4px rgba(0, 0, 0, 0.05);
            padding: 28px 26px 24px;
        }

        .auth-brand {
            font-size: 26px;
            font-weight: 800;
            color: #ff4d8d;
            letter-spacing: 0.03em;
        }

        .auth-subtitle {
            font-size: 13px;
            color: #6c757d;
        }

        .auth-card .form-control {
            border-radius: 8px;
            padding: 10px 12px;
            border-color: #dddfe2;
        }

        .auth-card .form-control:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.15rem rgba(13, 110, 253, 0.15);
        }

        .btn-register {
            background-color: #0d6efd;
            border-color: #0d6efd;
            color: #ffffff;
            font-weight: 600;
            font-size: 15px;
            width: 100%;
            border-radius: 999px;
        }

        .btn-register:hover {
            background-color: #0b5ed7;
            border-color: #0b5ed7;
            color: #ffffff;
        }

        .small-links {
            font-size: 13px;
        }

        .small-links a {
            text-decoration: none;
        }

        .small-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body class="auth-bg">

<div class="auth-card">

    <div class="mb-3 text-center">
        <div class="auth-brand mb-1">ShopHoa</div>
        <p class="auth-subtitle mb-0">
            Tạo tài khoản để đặt hoa và theo dõi đơn hàng trên ShopHoa.
        </p>
    </div>

    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>

    <form action="register" method="post">
        <div class="mb-3">
            <label for="name" class="form-label">Họ tên</label>
            <input type="text"
                   class="form-control"
                   id="name"
                   name="name"
                   required>
        </div>

        <div class="mb-3">
            <label for="email" class="form-label">Địa chỉ Email</label>
            <input type="email"
                   class="form-control"
                   id="email"
                   name="email"
                   required>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Mật khẩu</label>
            <input type="password"
                   class="form-control"
                   id="password"
                   name="password"
                   required>
        </div>

        <div class="mb-3">
            <label for="confirm" class="form-label">Nhập lại mật khẩu</label>
            <input type="password"
                   class="form-control"
                   id="confirm"
                   name="confirm"
                   required>
        </div>

        <div class="mb-3">
            <label for="phone" class="form-label">Số điện thoại</label>
            <input type="tel"
                   class="form-control"
                   id="phone"
                   name="phone"
                   pattern="0[0-9]{9,10}"
                   title="Số điện thoại phải bắt đầu bằng 0 và có 10–11 chữ số"
                   placeholder="Ví dụ: 0912345678">
        </div>

        <div class="mb-3">
            <label for="address" class="form-label">Địa chỉ</label>
            <input type="text"
                   class="form-control"
                   id="address"
                   name="address">
        </div>

        <button type="submit" class="btn btn-register mt-2">
            Đăng ký
        </button>
    </form>

    <div class="text-center mt-3 small-links">
        <span>Đã có tài khoản? </span>
        <a href="login">Về trang đăng nhập</a>
    </div>

</div>

</body>
</html>
