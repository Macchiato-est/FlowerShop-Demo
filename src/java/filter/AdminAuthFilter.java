/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package filter;

/**
 *
 * @author 06052
 */


import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebFilter("/admin/*")
public class AdminAuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        HttpSession session = req.getSession();

        // Cho phép không cần đăng nhập
        boolean isLoginPage =
                uri.endsWith("admin-login.jsp") ||
                uri.endsWith("admin-login") ||
                uri.contains("/admin/login"); // phòng trường hợp bạn đổi URL

        // CHẶN truy cập trực tiếp các file .jsp trong /admin/ (trừ login)
        if (uri.startsWith(req.getContextPath() + "/admin/")
            && uri.endsWith(".jsp")
            && !isLoginPage) {

            // Chuyển về dashboard servlet
            resp.sendRedirect(req.getContextPath() + "/admin");
            return;
        }

        // Kiểm tra đăng nhập
        Object admin = session.getAttribute("admin");
        if (admin == null && !isLoginPage) {
            resp.sendRedirect(req.getContextPath() + "/admin-login.jsp");
            return;
        }

        chain.doFilter(request, response);
    }
}
