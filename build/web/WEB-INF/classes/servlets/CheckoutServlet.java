/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import dao.CategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Cart;
import model.User;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {

    HttpSession session = req.getSession();
    User currentUser = (User) session.getAttribute("currentUser");

    if (currentUser == null) {
        resp.sendRedirect("login.jsp");
        return;
    }

    Cart cart = (Cart) session.getAttribute("cart");
    if (cart == null || cart.getItems().isEmpty()) {
        resp.sendRedirect("cart");
        return;
    }
    CategoryDAO cdao = new CategoryDAO();
    req.setAttribute("categories", cdao.getAll());

    req.getRequestDispatcher("checkout.jsp").forward(req, resp);
}
}
