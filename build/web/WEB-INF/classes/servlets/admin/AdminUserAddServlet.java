/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets.admin;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.HashUtil;
import model.User;

import java.io.IOException;

@WebServlet("/admin/user-add")
public class AdminUserAddServlet extends HttpServlet {

    // ==============================
    //  HIỂN THỊ FORM (GET)
    // ==============================
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/admin/user-add.jsp").forward(req, resp);
    }

    // ==============================
    //  XỬ LÝ SUBMIT FORM (POST)
    // ==============================
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String ten = req.getParameter("ten");
        String email = req.getParameter("email");
        String matKhau = req.getParameter("mat_khau");
        String dienThoai = req.getParameter("dien_thoai");
        String diaChi = req.getParameter("dia_chi");
        String quyen = req.getParameter("quyen");

        UserDAO dao = new UserDAO();

        // Check email trùng
        if (dao.isEmailExists(email)) {
            req.setAttribute("error", "Email đã tồn tại!");
            req.getRequestDispatcher("/admin/user-add.jsp").forward(req, resp);
            return;
        }

        // Tạo User object
        User u = new User();
        u.setName(ten);
        u.setEmail(email);
        u.setPasswordHash(HashUtil.toSHA256(matKhau)); // mã hóa SHA256
        u.setPhone(dienThoai);
        u.setAddress(diaChi);
        u.setRole(quyen);

        dao.registerUser(u);

        // Quay lại danh sách user
        resp.sendRedirect(req.getContextPath() + "/admin/users");
    }
}
