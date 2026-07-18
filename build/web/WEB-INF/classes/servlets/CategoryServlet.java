/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import dao.CategoryDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Product;

import java.io.IOException;
import java.util.List;

/**
 *
 * @author 06052
 */
@WebServlet("/category")
public class CategoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        ProductDAO dao = new ProductDAO();
        List<Product> products = null;
        
        String cat = req.getParameter("cat");
        String type = req.getParameter("type");

        try {
            if (cat != null) {
                // Lấy theo danh mục
                int categoryId = Integer.parseInt(cat);
                products = dao.getByCategory(categoryId, 20);   
            }
            else if ("new".equals(type)) {
                // Sản phẩm mới
                products = dao.getNewest(40);
            }
            else if ("bestseller".equals(type)) {
                // Bán chạy
                products = dao.getBestSeller(40);
            }
            else if ("recommend".equals(type)) {
                // Gợi ý hôm nay
                products = dao.getRecommended(40);
            }
            else if ("sale".equals(type)) {
                // Giảm giá
                products = dao.getDiscounted(40);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        CategoryDAO cdao = new CategoryDAO();
        req.setAttribute("categories", cdao.getAll());

        req.setAttribute("products", products);
        req.getRequestDispatcher("category.jsp").forward(req, resp);
    }
}
