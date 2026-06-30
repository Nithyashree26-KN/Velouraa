package com.tap.servlet;

import com.tap.DAOImpl.CartDAOImpl;
import com.tap.model.CartItem;
import com.tap.model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

/**
 * GET  /cart  → shows the cart page
 * POST /cart  → handles quantity update or item removal, then redirects to GET /cart
 */
@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            resp.sendRedirect("login.html");
            return;
        }

        User user = (User) session.getAttribute("loggedInUser");
        CartDAOImpl cartDAO = new CartDAOImpl();
        int cartId = cartDAO.getOrCreateCart(user.getUserId());
        List<CartItem> cartItems = cartDAO.getCartItems(cartId);

        req.setAttribute("cartItems", cartItems);
        req.setAttribute("cartId", cartId);

        RequestDispatcher rd = req.getRequestDispatcher("cart.jsp");
        rd.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            resp.sendRedirect("login.html");
            return;
        }

        String action = req.getParameter("action");
        CartDAOImpl cartDAO = new CartDAOImpl();

        if ("update".equals(action)) {
            int cartItemId = Integer.parseInt(req.getParameter("cartItemId"));
            int quantity   = Integer.parseInt(req.getParameter("quantity"));
            cartDAO.updateQuantity(cartItemId, quantity);

        } else if ("remove".equals(action)) {
            int cartItemId = Integer.parseInt(req.getParameter("cartItemId"));
            cartDAO.removeItem(cartItemId);
        }

        resp.sendRedirect("cart");
    }
}
