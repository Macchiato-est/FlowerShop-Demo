/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servlets;

import dao.CategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Order;

@WebServlet("/order-success")
public class OrderSuccessServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idStr = req.getParameter("id");
        Order order = null;

        if (idStr != null) {
            try {
                int orderId = Integer.parseInt(idStr);
                req.setAttribute("order", order);
            } catch (NumberFormatException ex) {
                // id lỗi thì thôi, vẫn cho vào trang success bình thường
            }
        }

        // load danh mục cho leftmenu
        CategoryDAO cdao = new CategoryDAO();
        req.setAttribute("categories", cdao.getAll());

        req.getRequestDispatcher("order-success.jsp").forward(req, resp);
    }
}
