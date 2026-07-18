/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import dao.UserDAO;
import model.User;
import model.HashUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

// dùng class validate chung
import util.ValidatorUtil;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String name     = request.getParameter("name");
        String email    = request.getParameter("email");
        String password = request.getParameter("password");
        String confirm  = request.getParameter("confirm");
        String phone    = request.getParameter("phone");
        String address  = request.getParameter("address");

        // trim tránh khoảng trắng đầu/cuối
        if (name != null)    name = name.trim();
        if (email != null)   email = email.trim();
        if (phone != null)   phone = phone.trim();
        if (address != null) address = address.trim();

        String error = null;

        // 1. Bắt buộc nhập các trường chính
        if (name == null || name.isEmpty()
                || email == null || email.isEmpty()
                || password == null || password.isEmpty()
                || confirm == null || confirm.isEmpty()) {
            error = "Vui lòng nhập đầy đủ thông tin.";
        }

        // 2. Email phải đúng định dạng
        if (error == null && !ValidatorUtil.isValidEmail(email)) {
            error = "Email không hợp lệ.";
        }

        // 3. Mật khẩu nhập lại phải khớp
        if (error == null && !password.equals(confirm)) {
            error = "Mật khẩu nhập lại không khớp.";
        }

        // 4. Số điện thoại: không bắt buộc, nhưng nếu nhập thì phải đúng định dạng
        if (error == null && phone != null && !phone.isBlank()
                && !ValidatorUtil.isValidPhone(phone)) {
            error = "Số điện thoại không hợp lệ (bắt đầu bằng 0 và có 10–11 chữ số).";
        }

        if (error == null) {
            UserDAO dao = new UserDAO();
            if (dao.isEmailExists(email)) {
                error = "Email đã tồn tại.";
            } else {
                User user = new User();
                user.setName(name);
                user.setEmail(email);
                user.setPasswordHash(HashUtil.toSHA256(password));
                user.setPhone(phone);
                user.setAddress(address);
                user.setRole("khachhang");

                boolean success = dao.registerUser(user);
                if (success) {
                    // có thể đổi thành "login" nếu đang dùng LoginServlet map /login
                    response.sendRedirect("login.jsp");
                    return;
                } else {
                    error = "Đăng ký thất bại, thử lại sau.";
                }
            }
        }

        request.setAttribute("error", error);
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }
}
