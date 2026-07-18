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
import model.HashUtil;
import util.ValidatorUtil;   // dùng class validate chung

import java.io.IOException;

@WebServlet("/admin/user-edit")
public class AdminUserEditServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        UserDAO dao = new UserDAO();
        User u = dao.getById(id);

        req.setAttribute("user", u);
        req.getRequestDispatcher("/admin/user-edit.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        int id = Integer.parseInt(req.getParameter("id"));
        String ten    = req.getParameter("ten");
        String email  = req.getParameter("email");
        String dt     = req.getParameter("dien_thoai");
        String diachi = req.getParameter("dia_chi");
        String quyen  = req.getParameter("quyen");
        String pass   = req.getParameter("mat_khau");

        if (ten != null)    ten = ten.trim();
        if (email != null)  email = email.trim();
        if (dt != null)     dt = dt.trim();
        if (diachi != null) diachi = diachi.trim();
        if (quyen != null)  quyen = quyen.trim();
        if (pass != null)   pass = pass.trim();

        UserDAO dao = new UserDAO();
        User u = dao.getById(id);

        String error = null;

        // 1. Bắt buộc: tên, email, quyền
        if (ten == null || ten.isEmpty()
                || email == null || email.isEmpty()
                || quyen == null || quyen.isEmpty()) {
            error = "Vui lòng nhập đầy đủ thông tin bắt buộc.";
        }

        // 2. Email hợp lệ
        if (error == null && !ValidatorUtil.isValidEmail(email)) {
            error = "Email không hợp lệ.";
        }

        // 3. SĐT (nếu có) đúng định dạng
        if (error == null && dt != null && !dt.isBlank()
                && !ValidatorUtil.isValidPhone(dt)) {
            error = "Số điện thoại không hợp lệ (bắt đầu bằng 0 và có 10–11 chữ số).";
        }

        // 4. Nếu đổi email thì kiểm tra trùng
        if (error == null
                && u != null
                && !email.equalsIgnoreCase(u.getEmail())
                && dao.isEmailExists(email)) {
            error = "Email đã tồn tại.";
        }

        // Nếu có lỗi -> trả lại form
        if (error != null) {
            // cập nhật object để form hiển thị giá trị mới người dùng vừa nhập
            if (u != null) {
                u.setName(ten);
                u.setEmail(email);
                u.setPhone(dt);
                u.setAddress(diachi);
                u.setRole(quyen);
            }

            req.setAttribute("error", error);
            req.setAttribute("user", u);
            req.getRequestDispatcher("/admin/user-edit.jsp").forward(req, resp);
            return;
        }

        // Không lỗi -> cập nhật DB
        u.setName(ten);
        u.setEmail(email);
        u.setPhone(dt);
        u.setAddress(diachi);
        u.setRole(quyen);

        // Nếu admin nhập mật khẩu mới → hash lại
        if (pass != null && !pass.isEmpty()) {
            u.setPasswordHash(HashUtil.toSHA256(pass));
        }

        dao.update(u);

        resp.sendRedirect(req.getContextPath() + "/admin/users");
    }
}
