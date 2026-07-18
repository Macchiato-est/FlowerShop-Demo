/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/cancel-order")
public class CancelOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        model.User user = (model.User) session.getAttribute("currentUser");

        // --- Kiểm tra đăng nhập ---
        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getId();

        // --- Lấy ID đơn hàng ---
        String idStr = req.getParameter("id");
        int orderId;

        try {
            orderId = Integer.parseInt(idStr);
        } catch (Exception ex) {
            session.setAttribute("msg", "Mã đơn hàng không hợp lệ!");
            resp.sendRedirect("orders");
            return;
        }

        // --- Hủy đơn ---
        OrderDAO dao = new OrderDAO();
        boolean ok = dao.cancelOrder(orderId, userId);

        if (ok) {
            session.setAttribute("msg", "Đã hủy đơn hàng thành công!");
        } else {
            session.setAttribute("msg", "Không thể hủy đơn (đơn đã xử lý hoặc không thuộc quyền sở hữu).");
        }

        // Chuyển về trang lịch sử đơn hàng
        resp.sendRedirect("orders");
    }
}
