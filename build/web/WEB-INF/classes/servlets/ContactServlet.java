/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package servlets;

import dao.CategoryDAO;
import dao.ContactDAO;
import model.ContactMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import util.ValidatorUtil;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        CategoryDAO cdao = new CategoryDAO();
        req.setAttribute("categories", cdao.getAll());
        req.getRequestDispatcher("contact.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String name  = req.getParameter("name");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String title = req.getParameter("title");
        String body  = req.getParameter("message");

        String error = null;

        // 1. Bắt buộc: họ tên, tiêu đề, nội dung
        if (name == null || name.isBlank()
                || title == null || title.isBlank()
                || body == null || body.isBlank()) {
            error = "Vui lòng nhập họ tên, tiêu đề và nội dung.";
        }

        // 2. Email bắt buộc và đúng định dạng
        if (error == null && !ValidatorUtil.isValidEmail(email)) {
            error = "Email không hợp lệ.";
        }

        // 3. Số điện thoại: không bắt buộc, nhưng nếu nhập thì phải đúng định dạng
        if (error == null && phone != null && !phone.isBlank()
                && !ValidatorUtil.isValidPhone(phone.trim())) {
            error = "Số điện thoại không hợp lệ (bắt đầu bằng 0 và có 10–11 chữ số).";
        }


        // Luôn load lại danh mục
        CategoryDAO cdao = new CategoryDAO();
        req.setAttribute("categories", cdao.getAll());

        // Nếu có lỗi -> quay lại form
        if (error != null) {
            req.setAttribute("error", error);
            req.getRequestDispatcher("contact.jsp").forward(req, resp);
            return;
        }

        // Không lỗi -> lưu vào DB
        ContactMessage m = new ContactMessage();
        m.setHoTen(name.trim());
        m.setEmail(email == null ? null : email.trim());
        m.setSoDienThoai(phone == null ? null : phone.trim());
        m.setTieuDe(title.trim());
        m.setNoiDung(body.trim());

        boolean ok = new ContactDAO().insert(m);

        if (ok) {
            req.setAttribute("success", "Đã gửi liên hệ! Chúng tôi sẽ phản hồi sớm.");
        } else {
            req.setAttribute("error", "Gửi liên hệ thất bại, vui lòng thử lại.");
        }

        req.getRequestDispatcher("contact.jsp").forward(req, resp);
    }

}
