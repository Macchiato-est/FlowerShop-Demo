/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import dao.CategoryDAO;
import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.Order;
import model.OrderItem;
import model.User;

@WebServlet("/order-detail")
public class OrderDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String idStr = req.getParameter("id");
        int orderId;
        try {
            orderId = Integer.parseInt(idStr);
        } catch (Exception ex) {
            resp.sendRedirect("order-history");
            return;
        }

        OrderDAO dao = new OrderDAO();
        Order order = dao.getByIdForUser(orderId, currentUser.getId());
        if (order == null) {
            resp.sendRedirect("order-history");
            return;
        }

        List<OrderItem> items = dao.getItems(orderId);
        req.setAttribute("order", order);
        req.setAttribute("items", items);
        
        CategoryDAO cdao = new CategoryDAO();
        req.setAttribute("categories", cdao.getAll());
        req.getRequestDispatcher("order-detail.jsp").forward(req, resp);
    }
}