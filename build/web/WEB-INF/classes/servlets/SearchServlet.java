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

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String keyword = req.getParameter("keyword");
        if (keyword != null) {
            keyword = keyword.trim();
        }

        ProductDAO dao = new ProductDAO();
        List<Product> results = dao.searchByKeyword(keyword);

        req.setAttribute("keyword", keyword);
        req.setAttribute("results", results);
        
        CategoryDAO cdao = new CategoryDAO();
        req.setAttribute("categories", cdao.getAll());
        req.getRequestDispatcher("search.jsp").forward(req, resp);
    }
}