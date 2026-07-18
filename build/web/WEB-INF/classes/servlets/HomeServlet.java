/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import dao.CategoryDAO;
import dao.ProductDAO;
import model.Category;
import model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/index")
public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        CategoryDAO categoryDAO = new CategoryDAO();
        ProductDAO productDAO  = new ProductDAO();

        // Left menu
        List<Category> categories = categoryDAO.getAll();
        req.setAttribute("categories", categories);

        // Lọc theo loại (nếu có) hoặc lấy mới nhất
        String catParam = req.getParameter("cat");
        List<Product> mainProducts;
        if (catParam != null && catParam.matches("\\d+")) {
            int catId = Integer.parseInt(catParam);
            mainProducts = productDAO.getByCategory(catId, 12);
            req.setAttribute("activeCat", catId);
        } else {
            mainProducts = productDAO.getNewest(12);
        }
        req.setAttribute("mainProducts", mainProducts);
        
        // Bestseller
        List<Product> bestSeller = productDAO.getBestSeller(8);
        req.setAttribute("bestSeller", bestSeller);
        
        // Recommended
        List<Product> recommended = productDAO.getRecommended(10);
        req.setAttribute("recommended", recommended);
        
        // Khối “Đang giảm giá”
        List<Product> discounted = productDAO.getDiscounted(8);
        req.setAttribute("discounted", discounted);
        
        req.getRequestDispatcher("index.jsp").forward(req, resp);
    }
}
