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


@WebServlet("/admin/banner-edit")
@MultipartConfig
public class AdminBannerEditServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        BannerDAO dao = new BannerDAO();

        Banner b = dao.getById(id);
        req.setAttribute("banner", b);

        req.getRequestDispatcher("/admin/banner/banner-edit.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        int id = Integer.parseInt(req.getParameter("id"));
        String tieuDe = req.getParameter("tieu_de");
        String trangThai = req.getParameter("trang_thai");

        BannerDAO dao = new BannerDAO();
        Banner b = dao.getById(id);

        Part filePart = req.getPart("hinh_anh");
        String fileName = b.getHinhAnh(); // giữ tên ảnh cũ nếu không upload ảnh mới

        if (filePart != null && filePart.getSize() > 0) {
            String newName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();

            String uploadPath = getServletContext().getRealPath("/images/banner/");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            filePart.write(uploadPath + "/" + newName);
            fileName = newName;
        }

        b.setTieuDe(tieuDe);
        b.setHinhAnh(fileName);
        b.setTrangThai(trangThai);

        dao.update(b);

        resp.sendRedirect(req.getContextPath() + "/admin/banners");
    }
}
