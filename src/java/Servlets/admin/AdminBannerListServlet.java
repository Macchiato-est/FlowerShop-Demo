/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets.admin;

import dao.BannerDAO;
import model.Banner;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/banners")
public class AdminBannerListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Banner> list = new BannerDAO().getAll();
        req.setAttribute("banners", list);

        req.setAttribute("pageTitle", "Quản lý Banner");
        req.setAttribute("contentPage", "/admin/banner/banner-content.jsp");

        req.getRequestDispatcher("/admin/layout/admin-layout.jsp")
                .forward(req, resp);
    }
}
