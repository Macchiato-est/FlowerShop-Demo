/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets.admin;

import dao.BannerDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 *
 * @author 06052
 */


@WebServlet("/admin/banner-delete")
public class AdminBannerDeleteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        BannerDAO dao = new BannerDAO();
        dao.delete(id);   // ❗ Chỉ xóa trong database, không đụng vào file ảnh

        resp.sendRedirect(req.getContextPath() + "/admin/banners");
    }
}
