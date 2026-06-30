package com.tap.servlet;

import com.tap.DAOImpl.CartDAOImpl;
import com.tap.DAOImpl.OrderDAOImpl;
import com.tap.model.CartItem;
import com.tap.model.Order;
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
 * GET  /checkout → displays the checkout form with cart summary
 * POST /checkout → places the order, clears the cart, redirects to order history
 */
@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

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

        if (cartItems.isEmpty()) {
            resp.sendRedirect("cart");
            return;
        }

        req.setAttribute("cartItems", cartItems);
        req.setAttribute("cartId", cartId);

        RequestDispatcher rd = req.getRequestDispatcher("checkout.jsp");
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

        User user = (User) session.getAttribute("loggedInUser");
        String deliveryAddress = req.getParameter("deliveryAddress");

        // Fetch cart items
        CartDAOImpl cartDAO = new CartDAOImpl();
        int cartId = cartDAO.getOrCreateCart(user.getUserId());
        List<CartItem> cartItems = cartDAO.getCartItems(cartId);

        if (cartItems.isEmpty()) {
            resp.sendRedirect("cart");
            return;
        }

        // Determine restaurantId — stored in session when user first added to cart
        int restaurantId = 0;
        Object rId = session.getAttribute("restaurantId");
        if (rId != null) {
            restaurantId = (int) rId;
        } else if (req.getParameter("restaurantId") != null) {
            restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
        }

        // Calculate total (items subtotal + ₹30 delivery fee)
        double subtotal = cartItems.stream().mapToDouble(CartItem::getSubtotal).sum();
        double total    = subtotal + 30.0;

        // Build and persist order
        Order order = new Order();
        order.setUserId(user.getUserId());
        order.setRestaurantId(restaurantId);
        order.setTotalAmount(total);
        order.setStatus("Confirmed");
        order.setDeliveryAddress(deliveryAddress);

        OrderDAOImpl orderDAO = new OrderDAOImpl();
        int orderId = orderDAO.placeOrder(order);
        orderDAO.addOrderItems(orderId, cartItems);

        // Clear cart after successful order
        cartDAO.clearCart(cartId);

        // Show success toast via redirect with query param
        resp.sendRedirect("orderHistory?success=true");
    }
}
