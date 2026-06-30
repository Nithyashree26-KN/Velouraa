package com.tap.DAOImpl;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.OrderDAO;
import com.tap.model.CartItem;
import com.tap.model.Order;
import com.tap.model.OrderItem;
import com.tap.utility.DBConnection;

public class OrderDAOImpl implements OrderDAO {

    @Override
    public int placeOrder(Order order) {
        String sql = "INSERT INTO orders (UserID, RestaurantID, TotalAmount, Status, DeliveryAddress) " +
                     "VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, order.getUserId());
            ps.setInt(2, order.getRestaurantId());
            ps.setDouble(3, order.getTotalAmount());
            ps.setString(4, order.getStatus() != null ? order.getStatus() : "Pending");
            ps.setString(5, order.getDeliveryAddress());
            ps.executeUpdate();

            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("OrderDAOImpl.placeOrder error: " + e.getMessage());
            e.printStackTrace();
        }
        return -1;
    }

    @Override
    public void addOrderItems(int orderId, List<CartItem> items) {
        String sql = "INSERT INTO order_items (OrderID, MenuID, Quantity, Price) VALUES (?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            for (CartItem item : items) {
                ps.setInt(1, orderId);
                ps.setInt(2, item.getMenuId());
                ps.setInt(3, item.getQuantity());
                ps.setDouble(4, item.getPrice());
                ps.addBatch();
            }
            ps.executeBatch();
        } catch (SQLException e) {
            System.err.println("OrderDAOImpl.addOrderItems error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public List<Order> getOrdersByUser(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, r.Name AS RestaurantName " +
                     "FROM orders o " +
                     "LEFT JOIN restaurant r ON o.RestaurantID = r.RestaurantID " +
                     "WHERE o.UserID = ? " +
                     "ORDER BY o.OrderedAt DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setOrderId(rs.getInt("OrderID"));
                    order.setUserId(rs.getInt("UserID"));
                    order.setRestaurantId(rs.getInt("RestaurantID"));
                    order.setTotalAmount(rs.getDouble("TotalAmount"));
                    order.setStatus(rs.getString("Status"));
                    order.setDeliveryAddress(rs.getString("DeliveryAddress"));
                    order.setOrderedAt(rs.getTimestamp("OrderedAt"));
                    order.setRestaurantName(rs.getString("RestaurantName"));
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            System.err.println("OrderDAOImpl.getOrdersByUser error: " + e.getMessage());
            e.printStackTrace();
        }
        return orders;
    }

    @Override
    public List<OrderItem> getOrderItems(int orderId) {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT oi.*, m.ItemName " +
                     "FROM order_items oi " +
                     "JOIN menu m ON oi.MenuID = m.MenuID " +
                     "WHERE oi.OrderID = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderItem item = new OrderItem();
                    item.setOrderItemId(rs.getInt("OrderItemID"));
                    item.setOrderId(rs.getInt("OrderID"));
                    item.setMenuId(rs.getInt("MenuID"));
                    item.setQuantity(rs.getInt("Quantity"));
                    item.setPrice(rs.getDouble("Price"));
                    item.setItemName(rs.getString("ItemName"));
                    items.add(item);
                }
            }
        } catch (SQLException e) {
            System.err.println("OrderDAOImpl.getOrderItems error: " + e.getMessage());
            e.printStackTrace();
        }
        return items;
    }
}
