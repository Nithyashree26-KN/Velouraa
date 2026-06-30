package com.tap.servlet;

import com.tap.DAOImpl.OrderDAOImpl;
import com.tap.model.Order;
import com.tap.model.OrderItem;
import com.tap.model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * GET /orderHistory → loads all orders for the logged-in user
 * and passes them + their items to orderHistory.jsp
 */
@WebServlet("/orderHistory")
public class OrderHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            resp.sendRedirect("login.html");
            return;
        }

        User user = (User) session.getAttribute("loggedInUser");
        OrderDAOImpl orderDAO = new OrderDAOImpl();
        List<Order> orders = orderDAO.getOrdersByUser(user.getUserId());

        // Pre-fetch all order items, keyed by orderId for easy JSP access
        Map<Integer, List<OrderItem>> orderItemsMap = new LinkedHashMap<>();
        for (Order order : orders) {
            List<OrderItem> items = orderDAO.getOrderItems(order.getOrderId());
            orderItemsMap.put(order.getOrderId(), items);
        }

        req.setAttribute("orders", orders);
        req.setAttribute("orderItemsMap", orderItemsMap);

        RequestDispatcher rd = req.getRequestDispatcher("orderHistory.jsp");
        rd.forward(req, resp);
    }
}
