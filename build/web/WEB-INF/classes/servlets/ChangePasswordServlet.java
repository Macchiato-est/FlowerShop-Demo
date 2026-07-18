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
import model.HashUtil;
import model.User;



/**
 *
 * @author 06052
 */


@WebServlet("/change-password")
public class ChangePasswordServlet extends HttpServlet {

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
        req.getRequestDispatcher("change-password.jsp").forward(req, resp);
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

        String np = req.getParameter("newpass");
        String rep = req.getParameter("renewpass");

        // Kiểm tra dữ liệu hợp lệ
        if (np == null || np.isBlank()) {
            req.setAttribute("error", "Mật khẩu mới không được để trống");
            req.getRequestDispatcher("change-password.jsp").forward(req, resp);
            return;
        }

        if (!np.equals(rep)) {
            req.setAttribute("error", "Mật khẩu nhập lại không khớp!");
            req.getRequestDispatcher("change-password.jsp").forward(req, resp);
            return;
        }
        
        
        // Hash mật khẩu mới
        String hash = HashUtil.toSHA256(np);

        UserDAO dao = new UserDAO();
        boolean ok = dao.updatePassword(u.getId(), hash);

        if (ok) {
            // Cập nhật vào session
            u.setPasswordHash(hash);

            req.setAttribute("success", "Đổi mật khẩu thành công!");
        } else {
            req.setAttribute("error", "Đổi mật khẩu thất bại. Vui lòng thử lại.");
        }
        CategoryDAO cdao = new CategoryDAO();
        req.setAttribute("categories", cdao.getAll());
        req.getRequestDispatcher("change-password.jsp").forward(req, resp);
    }
}

