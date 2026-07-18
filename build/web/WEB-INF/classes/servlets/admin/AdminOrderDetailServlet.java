/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets.admin;

import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Order;
import model.OrderItem;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/order-detail")
public class AdminOrderDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        User admin = (User) req.getSession().getAttribute("admin");
        if (admin == null) {
            resp.sendRedirect(req.getContextPath() + "/admin-login.jsp");
            return;
        }

        String idStr = req.getParameter("id");
        if (idStr == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/orders");
            return;
        }

        int id = Integer.parseInt(idStr);

        OrderDAO dao = new OrderDAO();
        Order order = dao.getById(id);
        if (order == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/orders");
            return;
        }

        List<OrderItem> items = dao.getItems(id);

        req.setAttribute("order", order);
        req.setAttribute("items", items);

        req.getRequestDispatcher("/admin/order-detail.jsp").forward(req, resp);
    }
}