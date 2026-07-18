/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets.admin;

import dao.ContactDAO;
import dao.OrderDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;
import java.util.List;
import model.TopProductStats;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/admin")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // ========== 1) Kiểm tra đăng nhập ==========
        User admin = (User) req.getSession().getAttribute("admin");
        if (admin == null) {
            resp.sendRedirect(req.getContextPath() + "/admin-login.jsp");
            return;
        }

        // ========== 2) DAO ==========
        OrderDAO orderDAO = new OrderDAO();
        ContactDAO contactDAO = new ContactDAO();
        ProductDAO productDAO = new ProductDAO();

        // ========== 3) Thống kê cơ bản ==========
        Map<String, Integer> stats = new HashMap<>();
        stats.put("newOrders", orderDAO.countOrdersByStatus("PENDING"));
        stats.put("shipping", orderDAO.countOrdersByStatus("SHIPPING"));
        stats.put("cancelled", orderDAO.countOrdersByStatus("CANCELLED"));
        stats.put("products", productDAO.countAllProducts());
        stats.put("newContacts", contactDAO.countNewContacts());

        req.setAttribute("stats", stats);

        // ========== 4) DOANH THU ==========
        Map<String, Double> dailyRevenue = orderDAO.getRevenueByDay();
        Map<String, Double> monthlyRevenue = orderDAO.getRevenueByMonth();

        req.setAttribute("dailyRevenue", dailyRevenue);
        req.setAttribute("monthlyRevenue", monthlyRevenue);

        // ========== 5) TOP SẢN PHẨM ==========
        List<TopProductStats> topProducts30Days =
                orderDAO.getTopProductsLast30Days(5);
        List<TopProductStats> topRevenueProducts =
                orderDAO.getTopProductsByRevenue(5);

        req.setAttribute("topProducts30Days", topProducts30Days);
        req.setAttribute("topRevenueProducts", topRevenueProducts);

        // ========== 6) Load layout ==========
        req.setAttribute("pageTitle", "Dashboard");
        req.setAttribute("contentPage", "/admin/dashboard-content.jsp");

        req.getRequestDispatcher("/admin/layout/admin-layout.jsp")
                .forward(req, resp);
    }
}
