package servlets;

import dao.OrderDAO;
import dao.CategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import model.Cart;
import model.CartItem;
import model.Order;
import model.OrderItem;
import model.User;
import util.ValidatorUtil;   // dùng class validate chung

@WebServlet("/place-order")
public class PlaceOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            resp.sendRedirect("login.jsp");   // hoặc "login" nếu dùng servlet
            return;
        }

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            req.setAttribute("error", "Giỏ hàng trống.");
            req.setAttribute("categories", new CategoryDAO().getAll());
            req.getRequestDispatcher("checkout.jsp").forward(req, resp);
            return;
        }

        String hoTen     = req.getParameter("name");
        String email     = req.getParameter("email");
        String dienThoai = req.getParameter("phone");
        String diaChi    = req.getParameter("address");

        if (hoTen != null)     hoTen = hoTen.trim();
        if (email != null)     email = email.trim();
        if (dienThoai != null) dienThoai = dienThoai.trim();
        if (diaChi != null)    diaChi = diaChi.trim();

        String error = null;

        // 1. Bắt buộc: họ tên, SĐT, địa chỉ
        if (hoTen == null || hoTen.isBlank()
                || dienThoai == null || dienThoai.isBlank()
                || diaChi == null || diaChi.isBlank()) {
            error = "Vui lòng nhập đầy đủ thông tin bắt buộc.";
        }

        // 2. Email: bắt buộc và đúng định dạng
        if (error == null && !ValidatorUtil.isValidEmail(email)) {
            error = "Email không hợp lệ.";
        }

        // 3. SĐT: phải đúng định dạng 0 + 9–10 số
        if (error == null && !ValidatorUtil.isValidPhone(dienThoai)) {
            error = "Số điện thoại không hợp lệ (bắt đầu bằng 0 và có 10–11 chữ số).";
        }

        if (error != null) {
            req.setAttribute("error", error);
            req.setAttribute("categories", new CategoryDAO().getAll());
            req.getRequestDispatcher("checkout.jsp").forward(req, resp);
            return;
        }

        double tongTien = cart.getTotalAmount();

        Order order = new Order();
        order.setIdNguoiDung(currentUser.getId());
        order.setHoTenNhan(hoTen);
        order.setDienThoaiNhan(dienThoai);
        order.setDiaChiNhan(diaChi);
        order.setEmail(email);
        order.setNgayLap(new Timestamp(System.currentTimeMillis()));
        order.setTrangThai("PENDING");
        order.setTongTien(tongTien);

        List<OrderItem> orderItems = new ArrayList<>();
        for (CartItem ci : cart.getItems().values()) {
            OrderItem item = new OrderItem();
            item.setIdHoa(ci.getProduct().getId());
            item.setSoLuong(ci.getQty());
            item.setDonGia(ci.getProduct().getGia());
            orderItems.add(item);
        }
        order.setItems(orderItems);

        OrderDAO dao = new OrderDAO();
        int orderId = dao.create(order);

        if (orderId <= 0) {
            req.setAttribute("error", "Có lỗi khi đặt hàng, vui lòng thử lại.");
            req.setAttribute("categories", new CategoryDAO().getAll());
            req.getRequestDispatcher("checkout.jsp").forward(req, resp);
            return;
        }

        dao.addOrderItems(orderId, order.getItems());

        cart.clear();

        resp.sendRedirect("order-success?id=" + orderId);

    }
}
