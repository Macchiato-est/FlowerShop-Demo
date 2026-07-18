/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets.admin;

import dao.ProductDAO;
import dao.CategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Product;
import model.Category;
import model.User;

import java.io.*;
import java.util.List;

@WebServlet("/admin/product-add")
@MultipartConfig
public class AdminProductAddServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        User admin = (User) req.getSession().getAttribute("admin");
        if (admin == null) {
            resp.sendRedirect(req.getContextPath() + "/admin-login.jsp");
            return;
        }

        List<Category> categories = new CategoryDAO().getAll();
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/admin/product-add.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String ten        = req.getParameter("ten");
        String maLoaiStr  = req.getParameter("maLoai");
        String giaStr     = req.getParameter("gia");
        String giaGocStr  = req.getParameter("giaGoc");
        String soLuongStr = req.getParameter("soLuong");
        String moTa       = req.getParameter("moTa");

        int maLoai   = 0;
        int soLuong  = 0;
        double gia   = 0;
        double giaGoc = 0;

        try {
            if (maLoaiStr != null && !maLoaiStr.isBlank()) {
                maLoai = Integer.parseInt(maLoaiStr);
            }
            if (soLuongStr != null && !soLuongStr.isBlank()) {
                soLuong = Integer.parseInt(soLuongStr);
            }
            if (giaStr != null && !giaStr.isBlank()) {
                gia = Double.parseDouble(giaStr);
            }
            if (giaGocStr != null && !giaGocStr.isBlank()) {
                giaGoc = Double.parseDouble(giaGocStr);
            }
        } catch (NumberFormatException ex) {
            // Nếu có lỗi parse thì quay lại list (hoặc có thể forward lại form + báo lỗi nếu muốn)
            resp.sendRedirect(req.getContextPath() + "/admin/products");
            return;
        }

        // Checkbox gợi ý: có tick thì != null
        boolean isRecommended = (req.getParameter("isRecommended") != null);

        // xử lý upload ảnh
        Part imagePart = req.getPart("anh");
        String fileName = null;
        if (imagePart != null && imagePart.getSize() > 0) {
            fileName = imagePart.getSubmittedFileName();

            String uploadPath = req.getServletContext().getRealPath("/images");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            File file = new File(uploadDir, fileName);
            try (InputStream is = imagePart.getInputStream();
                 FileOutputStream fos = new FileOutputStream(file)) {
                is.transferTo(fos);
            }
        }

        Product p = new Product();
        p.setTen(ten);
        p.setMaLoai(maLoai);
        p.setGia(gia);
        p.setGiaGoc(giaGoc);
        p.setSoLuong(soLuong);
        p.setMoTa(moTa);
        p.setHinhAnh(fileName != null ? fileName : "no-image.png");
        p.setRecommended(isRecommended);   // ← set trước khi insert

        new ProductDAO().insert(p);

        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }
}
