package com.tap.servlet;

import com.tap.DAOImpl.CartDAOImpl;
import com.tap.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * POST /addToCart
 * Adds one unit of a menu item to the logged-in user's cart.
 * If the item already exists, increments quantity by 1.
 * Redirects back to the menu page on success.
 */
@WebServlet("/addToCart")
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            resp.sendRedirect("login.html");
            return;
        }

        User user = (User) session.getAttribute("loggedInUser");
        int userId = user.getUserId();

        // Parameters from the menu form
        int menuId       = Integer.parseInt(req.getParameter("menuId"));
        int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));

        CartDAOImpl cartDAO = new CartDAOImpl();
        int cartId = cartDAO.getOrCreateCart(userId);
        cartDAO.addOrUpdateItem(cartId, menuId, 1);

        // Store restaurantId in session for use on checkout
        session.setAttribute("restaurantId", restaurantId);

        // Redirect back to the menu page they came from
        resp.sendRedirect("menu?restaurantId=" + restaurantId);
    }
}
