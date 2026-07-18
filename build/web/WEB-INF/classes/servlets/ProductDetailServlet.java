/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import dao.CategoryDAO;
import dao.ProductDAO;
import model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/product-detail")
public class ProductDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idParam = req.getParameter("id");
        if (idParam == null || !idParam.matches("\\d+")) {
            resp.sendRedirect("index");
            return;
        }

        int id = Integer.parseInt(idParam);
        ProductDAO dao = new ProductDAO();
        Product p = dao.getById(id);
        if (p == null) {
            resp.sendRedirect("index");
            return;
        }

        req.setAttribute("p", p);
        // gợi ý sản phẩm cùng danh mục
        List<Product> related = dao.getRelated(p.getMaLoai(), p.getId(), 8);
        req.setAttribute("related", related);
        
        CategoryDAO cdao = new CategoryDAO();
        req.setAttribute("categories", cdao.getAll());
        
        req.getRequestDispatcher("product-detail.jsp").forward(req, resp);
    }
}