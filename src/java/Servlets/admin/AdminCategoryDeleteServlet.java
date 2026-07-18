/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets.admin;

import dao.CategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/category-delete")
public class AdminCategoryDeleteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        CategoryDAO dao = new CategoryDAO();

        boolean success = dao.delete(id);

        if (!success) {
            req.setAttribute("error",
                "Không thể xóa loại hoa vì vẫn còn sản phẩm thuộc loại này!");
        } else {
            req.setAttribute("success",
                "Đã xóa loại hoa thành công!");
        }

        //  Load lại danh sách trước khi forward
        req.setAttribute("categories", dao.getAll());

        req.getRequestDispatcher("/admin/categories.jsp").forward(req, resp);
    }
}