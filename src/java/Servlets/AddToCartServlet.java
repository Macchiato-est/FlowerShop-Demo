package servlets;

import dao.ProductDAO;
import model.Cart;
import model.Product;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import java.io.IOException;

@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {
    private Cart getCart(HttpSession s) {
        Cart c = (Cart) s.getAttribute("cart");
        if (c == null) { c = new Cart(); s.setAttribute("cart", c); }
        return c;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idStr  = req.getParameter("id");
        String qtyStr = req.getParameter("qty");
        if (idStr == null || !idStr.matches("\\d+")) { resp.sendRedirect("index"); return; }

        int id  = Integer.parseInt(idStr);
        int qty = 1;
        try { qty = Integer.parseInt(qtyStr); } catch (Exception ignored) {}

        ProductDAO dao = new ProductDAO();
        Product p = dao.getById(id);
        if (p == null || p.getSoLuong() <= 0) {
            resp.sendRedirect("product-detail?id="+id+"&out=1"); return;
        }

        int addQty = Math.max(1, Math.min(qty, p.getSoLuong())); // kẹp theo tồn
        getCart(req.getSession()).add(p, addQty);

        String back = req.getParameter("back");
        resp.sendRedirect("cart".equals(back) ? "cart" : ("product-detail?id="+id+"&added=1"));
    }
}