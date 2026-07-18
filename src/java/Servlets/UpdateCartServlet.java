package servlets;

import dao.ProductDAO;
import model.Cart;
import model.Product;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import java.io.IOException;

@WebServlet("/cart-update")
public class UpdateCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Cart cart = (Cart) req.getSession().getAttribute("cart");
        if (cart == null) { resp.sendRedirect("cart"); return; }

        String[] ids  = req.getParameterValues("pid");
        String[] qtys = req.getParameterValues("qty");
        if (ids != null && qtys != null && ids.length == qtys.length) {
            ProductDAO dao = new ProductDAO();
            for (int i = 0; i < ids.length; i++) {
                try {
                    int pid = Integer.parseInt(ids[i]);
                    int q   = Integer.parseInt(qtys[i]);

                    Product p = dao.getById(pid);
                    if (p == null) continue;

                    q = Math.min(Math.max(q, 0), p.getSoLuong()); // [0..tồn]
                    cart.update(pid, q);
                } catch (Exception ignored) {}
            }
        }
        
        resp.sendRedirect("cart");
    }
}