<%-- 
    Document   : login
    Created on : Nov 6, 2025, 7:28:35 AM
    Author     : 06052
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập | ShopHoa</title>
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
            max-width: 420px;
            background: #ffffff;
            border-radius: 14px;
            box-shadow:
                0 18px 40px rgba(0, 0, 0, 0.15),
                0 2px 4px rgba(0, 0, 0, 0.05);
            padding: 28px 26px 24px;
        }

        .auth-brand {
            font-size: 26px;
            font-weight: 800;
            color: #ff4d8d; /* màu hồng ShopHoa */
            letter-spacing: 0.03em;
        }

        .auth-subtitle {
            font-size: 13px;
            color: #6c757d;
        }

        .auth-card .form-control {
            border-radius: 8px;
            border-color: #dee2e6;
            padding: 10px 12px;
        }

        .auth-card .form-control:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.15rem rgba(13,110,253,0.15);
        }

        .btn-auth-primary {
            width: 100%;
            border-radius: 999px;
            background-color: #0d6efd;
            border-color: #0d6efd;
            color: #ffffff;
            font-weight: 600;
            font-size: 15px;
        }


        .btn-auth-primary:hover {
            background-color: #0b5ed7;
            border-color: #0b5ed7;
        }

        .auth-links {
            font-size: 13px;
        }

        .auth-links a {
            text-decoration: none;
        }

        .auth-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body class="auth-bg">

<div class="auth-card">

    <div class="text-center mb-3">
        <div class="auth-brand">ShopHoa</div>
        <div class="auth-subtitle">
            Đăng nhập để đặt hoa và theo dõi đơn hàng trên ShopHoa.
        </div>
    </div>

    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger py-2">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>

    <form action="login" method="post">
        <div class="mb-3">
            <input type="email"
                   class="form-control"
                   id="email"
                   name="email"
                   placeholder="Email"
                   required>
        </div>

        <div class="mb-3">
            <input type="password"
                   class="form-control"
                   id="password"
                   name="password"
                   placeholder="Mật khẩu"
                   required>
        </div>

        <button type="submit" class="btn btn-auth-primary mb-3">
            Đăng nhập
        </button>

        <div class="text-center mt-2">
                            <a href="contact">Quên mật khẩu?</a>
                            <span class="mx-1">|</span>
                            <a href="register.jsp">Tạo tài khoản mới</a>
                        </div>

        <div class="text-center auth-links">
            <a href="index">← Về trang chủ</a>
        </div>
    </form>

</div>

</body>
</html>
