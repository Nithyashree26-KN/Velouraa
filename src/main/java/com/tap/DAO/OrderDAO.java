package com.tap.DAO;

import java.util.List;
import com.tap.model.Order;
import com.tap.model.CartItem;
import com.tap.model.OrderItem;

public interface OrderDAO {

    /**
     * Insert a new order into the orders table.
     * Returns the generated OrderID.
     */
    int placeOrder(Order order);

    /**
     * Insert order items from the cart into order_items.
     */
    void addOrderItems(int orderId, List<CartItem> items);

    /**
     * Retrieve all orders for a given user (newest first),
     * with restaurantName populated via JOIN.
     */
    List<Order> getOrdersByUser(int userId);

    /**
     * Retrieve all items for a given order, with itemName populated via JOIN.
     */
    List<OrderItem> getOrderItems(int orderId);
}
