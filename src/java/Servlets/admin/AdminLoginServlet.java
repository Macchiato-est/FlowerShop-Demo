/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets.admin;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;

import java.io.IOException;
import model.HashUtil;

@WebServlet("/admin-login")
public class AdminLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        // dùng hash pass
        String hash = HashUtil.toSHA256(password);

        UserDAO dao = new UserDAO();
        User user = dao.loginAdmin(email, hash);

        // Sai tài khoản hoặc không phải admin
        if (user == null || !"admin".equals(user.getRole())) {
            req.getSession().setAttribute("admin_error",
                    "Sai tài khoản hoặc bạn không có quyền admin!");
            resp.sendRedirect(req.getContextPath() + "/admin-login.jsp");
            return;
        }

        // Lưu thông tin admin vào session
        req.getSession().setAttribute("admin", user);

        // Đưa admin vào dashboard servlet (không dùng JSP trực tiếp)
        resp.sendRedirect(req.getContextPath() + "/admin/index.jsp");
    }
}
