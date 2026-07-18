/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import dao.CategoryDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.User;
import util.ValidatorUtil;   

@WebServlet("/profile-edit")
public class ProfileEditServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        User u = (User) req.getSession().getAttribute("currentUser");
        if (u == null) {
            resp.sendRedirect("login");
            return;
        }

        CategoryDAO cdao = new CategoryDAO();
        req.setAttribute("categories", cdao.getAll());
        req.getRequestDispatcher("profile-edit.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        User u = (User) req.getSession().getAttribute("currentUser");
        if (u == null) {
            resp.sendRedirect("login");
            return;
        }

        String name    = req.getParameter("name");
        String phone   = req.getParameter("phone");
        String address = req.getParameter("address");

        if (name != null)    name = name.trim();
        if (phone != null)   phone = phone.trim();
        if (address != null) address = address.trim();

        String error = null;

        // 1. Kiểm tra tên
        if (name == null || name.isBlank()) {
            error = "Tên không được để trống";
        }

        // 2. SĐT: không bắt buộc, nhưng nếu nhập thì phải đúng định dạng
        if (error == null && phone != null && !phone.isBlank()
                && !ValidatorUtil.isValidPhone(phone)) {
            error = "Số điện thoại không hợp lệ (bắt đầu bằng 0 và có 10–11 chữ số).";
        }

        CategoryDAO cdao = new CategoryDAO();
        req.setAttribute("categories", cdao.getAll());

        if (error != null) {
            req.setAttribute("error", error);
            // không cập nhật user nếu có lỗi
            req.getRequestDispatcher("profile-edit.jsp").forward(req, resp);
            return;
        }

        // Không lỗi -> cập nhật object User trong session
        u.setName(name);
        u.setPhone(phone != null ? phone : "");
        u.setAddress(address != null ? address : "");

        UserDAO dao = new UserDAO();
        boolean ok = dao.update(u);

        if (ok) {
            req.setAttribute("success", "Cập nhật tài khoản thành công!");
        } else {
            req.setAttribute("error", "Cập nhật thất bại. Vui lòng thử lại.");
        }

        req.getRequestDispatcher("profile-edit.jsp").forward(req, resp);
    }
}
