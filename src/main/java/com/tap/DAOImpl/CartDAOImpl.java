package com.tap.DAOImpl;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.CartDAO;
import com.tap.model.CartItem;
import com.tap.utility.DBConnection;

public class CartDAOImpl implements CartDAO {

    @Override
    public int getOrCreateCart(int userId) {
        int cartId = getCartId(userId);
        if (cartId != -1) return cartId;

        String sql = "INSERT INTO cart (UserID) VALUES (?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, userId);
            ps.executeUpdate();

            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("CartDAOImpl.getOrCreateCart error: " + e.getMessage());
            e.printStackTrace();
        }
        return -1;
    }

    @Override
    public int getCartId(int userId) {
        String sql = "SELECT CartID FROM cart WHERE UserID = ? ORDER BY CreatedAt DESC LIMIT 1";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt("CartID");
            }
        } catch (SQLException e) {
            System.err.println("CartDAOImpl.getCartId error: " + e.getMessage());
            e.printStackTrace();
        }
        return -1;
    }

    @Override
    public void addOrUpdateItem(int cartId, int menuId, int qty) {
        // Check if item already exists in cart
        String checkSql = "SELECT CartItemID, Quantity FROM cart_items WHERE CartID = ? AND MenuID = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement checkPs = con.prepareStatement(checkSql)) {

            checkPs.setInt(1, cartId);
            checkPs.setInt(2, menuId);

            try (ResultSet rs = checkPs.executeQuery()) {
                if (rs.next()) {
                    // Item exists — update quantity
                    int newQty = rs.getInt("Quantity") + qty;
                    String updateSql = "UPDATE cart_items SET Quantity = ? WHERE CartItemID = ?";
                    try (PreparedStatement upPs = con.prepareStatement(updateSql)) {
                        upPs.setInt(1, newQty);
                        upPs.setInt(2, rs.getInt("CartItemID"));
                        upPs.executeUpdate();
                    }
                } else {
                    // Item does not exist — insert
                    String insertSql = "INSERT INTO cart_items (CartID, MenuID, Quantity) VALUES (?, ?, ?)";
                    try (PreparedStatement inPs = con.prepareStatement(insertSql)) {
                        inPs.setInt(1, cartId);
                        inPs.setInt(2, menuId);
                        inPs.setInt(3, qty);
                        inPs.executeUpdate();
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("CartDAOImpl.addOrUpdateItem error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public List<CartItem> getCartItems(int cartId) {
        List<CartItem> items = new ArrayList<>();
        String sql = "SELECT ci.CartItemID, ci.CartID, ci.MenuID, ci.Quantity, " +
                     "m.ItemName, m.Price, m.ImageURL, m.Category " +
                     "FROM cart_items ci " +
                     "JOIN menu m ON ci.MenuID = m.MenuID " +
                     "WHERE ci.CartID = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cartId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CartItem item = new CartItem();
                    item.setCartItemId(rs.getInt("CartItemID"));
                    item.setCartId(rs.getInt("CartID"));
                    item.setMenuId(rs.getInt("MenuID"));
                    item.setQuantity(rs.getInt("Quantity"));
                    item.setItemName(rs.getString("ItemName"));
                    item.setPrice(rs.getDouble("Price"));
                    item.setImagePath(rs.getString("ImageURL"));
                    item.setCategory(rs.getString("Category"));
                    items.add(item);
                }
            }
        } catch (SQLException e) {
            System.err.println("CartDAOImpl.getCartItems error: " + e.getMessage());
            e.printStackTrace();
        }
        return items;
    }

    @Override
    public void updateQuantity(int cartItemId, int quantity) {
        if (quantity <= 0) {
            removeItem(cartItemId);
            return;
        }
        String sql = "UPDATE cart_items SET Quantity = ? WHERE CartItemID = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, quantity);
            ps.setInt(2, cartItemId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("CartDAOImpl.updateQuantity error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public void removeItem(int cartItemId) {
        String sql = "DELETE FROM cart_items WHERE CartItemID = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cartItemId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("CartDAOImpl.removeItem error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public void clearCart(int cartId) {
        String sql = "DELETE FROM cart_items WHERE CartID = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cartId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("CartDAOImpl.clearCart error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public int getCartItemCount(int cartId) {
        String sql = "SELECT COALESCE(SUM(Quantity), 0) FROM cart_items WHERE CartID = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cartId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("CartDAOImpl.getCartItemCount error: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }
}
