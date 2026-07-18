/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets.admin;

import dao.BannerDAO;
import model.Banner;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
/**
 *
 * @author 06052
 */


@WebServlet("/admin/banner-add")
@MultipartConfig
public class AdminBannerAddServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("/admin/banner/banner-add.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String tieuDe = req.getParameter("tieu_de");
        String trangThai = req.getParameter("trang_thai");

        Part filePart = req.getPart("hinh_anh");

        if (filePart == null || filePart.getSize() == 0) {
            req.setAttribute("error", "Vui lòng chọn ảnh!");
            req.getRequestDispatcher("/admin/banner/banner-add.jsp").forward(req, resp);
            return;
        }

        // Lấy tên file
        String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();

        // Thư mục lưu ảnh banner
        
        String uploadPath = "D:/ShopHoaUploads/banner/";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        // Ghi file
        filePart.write(uploadPath + fileName);

        // Lưu vào DB
        Banner b = new Banner();
        b.setTieuDe(tieuDe);
        b.setHinhAnh(fileName);
        b.setTrangThai(trangThai);

        BannerDAO dao = new BannerDAO();
        dao.insert(b);

        resp.sendRedirect(req.getContextPath() + "/admin/banners");
    }
}
