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

@WebServlet("/admin/product-edit")
@MultipartConfig
public class AdminProductEditServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Check admin đăng nhập
        User admin = (User) req.getSession().getAttribute("admin");
        if (admin == null) {
            resp.sendRedirect(req.getContextPath() + "/admin-login.jsp");
            return;
        }

        String idStr = req.getParameter("id");
        if (idStr == null || idStr.isBlank()) {
            resp.sendRedirect(req.getContextPath() + "/admin/products");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException ex) {
            resp.sendRedirect(req.getContextPath() + "/admin/products");
            return;
        }

        ProductDAO pdao = new ProductDAO();
        Product p = pdao.getById(id);
        if (p == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/products");
            return;
        }

        List<Category> categories = new CategoryDAO().getAll();

        req.setAttribute("product", p);
        req.setAttribute("categories", categories);

        // ❌ KHÔNG set isRecommended ở đây – chỉ đọc từ DB
        req.getRequestDispatcher("/admin/product-edit.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String idStr      = req.getParameter("id");
        String ten        = req.getParameter("ten");
        String maLoaiStr  = req.getParameter("maLoai");
        String giaStr     = req.getParameter("gia");
        String giaGocStr  = req.getParameter("giaGoc");
        String soLuongStr = req.getParameter("soLuong");
        String moTa       = req.getParameter("moTa");
        String oldImage   = req.getParameter("oldImage");

        // Nếu thiếu id thì đá về list
        if (idStr == null || idStr.isBlank()) {
            resp.sendRedirect(req.getContextPath() + "/admin/products");
            return;
        }

        int id, maLoai = 0, soLuong = 0;
        double gia = 0, giaGoc = 0;

        try {
            id = Integer.parseInt(idStr);

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
            // Nếu parse lỗi thì quay lại form (cho đơn giản thì quay lại list)
            resp.sendRedirect(req.getContextPath() + "/admin/products");
            return;
        }

        // Checkbox: có tick thì != null
        boolean isRecommended = (req.getParameter("isRecommended") != null);

        // Xử lý ảnh
        Part imagePart = req.getPart("anh");
        String fileName = oldImage;

        if (imagePart != null && imagePart.getSize() > 0) {
            fileName = imagePart.getSubmittedFileName();

            String uploadPath = req.getServletContext().getRealPath("/images");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            File file = new File(uploadPath, fileName);
            try (InputStream is = imagePart.getInputStream();
                 FileOutputStream fos = new FileOutputStream(file)) {
                is.transferTo(fos);
            }
        }

        // Gán dữ liệu vào model
        Product p = new Product();
        p.setId(id);
        p.setTen(ten);
        p.setMaLoai(maLoai);
        p.setGia(gia);
        p.setGiaGoc(giaGoc);
        p.setSoLuong(soLuong);
        p.setMoTa(moTa);
        p.setHinhAnh(fileName);
        p.setRecommended(isRecommended);

        new ProductDAO().update(p);

        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }
}
