/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets.admin;

import dao.OrderDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;
import model.OrderItem;

@WebServlet("/admin/order-update")
public class AdminOrderUpdateServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idStr = req.getParameter("id");
        String action = req.getParameter("action"); // confirm, ship, done, cancel

        if (idStr == null || action == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/orders");
            return;
        }

        int id = Integer.parseInt(idStr);

        String newStatus;
        switch (action) {
            case "confirm":
                // Trừ số lượng trong kho
                OrderDAO dao2 = new OrderDAO();
                List<OrderItem> items = dao2.getItems(id);

                ProductDAO pdao = new ProductDAO();
                for (OrderItem it : items) {
                    pdao.reduceStock(it.getIdHoa(), it.getSoLuong());
                }

                newStatus = "CONFIRMED";
                break;

            case "ship":
                newStatus = "SHIPPING";
                break;
            case "done":
                newStatus = "DONE";
                break;
            case "cancel":
                newStatus = "CANCELLED";
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/admin/orders");
                return;
        }

        OrderDAO dao = new OrderDAO();
        dao.updateStatus(id, newStatus);

        // Quay lại danh sách đơn hoặc chi tiết đơn, tuỳ bạn thích
        String from = req.getParameter("from"); // "detail" hoặc null
        if ("detail".equals(from)) {
            resp.sendRedirect(req.getContextPath() + "/admin/order-detail?id=" + id);
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/orders");
        }
    }
}