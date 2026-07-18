/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets.admin;

import dao.ProductDAO;
import dao.CategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Product;
import model.Category;
import model.User;

import java.io.IOException;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/admin/products")
public class AdminProductListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        User admin = (User) req.getSession().getAttribute("admin");
        if (admin == null) {
            resp.sendRedirect(req.getContextPath() + "/admin-login.jsp");
            return;
        }

        ProductDAO pdao = new ProductDAO();
        CategoryDAO cdao = new CategoryDAO();

        List<Product> products = pdao.getAll();
        List<Category> categories = cdao.getAll();

        // map id_loai → tên loại
        Map<Integer, String> catMap = new HashMap<>();
        for (Category c : categories) {
            catMap.put(c.getId(), c.getTenLoai());
        }

        req.setAttribute("products", products);
        req.setAttribute("catMap", catMap);
        
        req.getRequestDispatcher("/admin/products.jsp").forward(req, resp);
    }
}
