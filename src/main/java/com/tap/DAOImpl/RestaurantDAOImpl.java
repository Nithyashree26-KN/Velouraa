package com.tap.DAOImpl;

import com.tap.DAO.RestaurantDAO;
import com.tap.model.Restaurant;
import com.tap.utility.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RestaurantDAOImpl implements RestaurantDAO {

    @Override
    public List<Restaurant> getAllRestaurants() {

        List<Restaurant> list = new ArrayList<>();
        String sql = "SELECT RestaurantID AS id, name, cuisine, address, rating, delivery_time, price_for_two, image_url, active FROM restaurant";

        Connection con = DBConnection.getConnection();

        if (con == null) {
            System.err.println("RestaurantDAOImpl: DB connection is null.");
            return list;
        }

        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Restaurant r = new Restaurant();
                r.setId(rs.getInt("id"));
                r.setName(rs.getString("name"));
                r.setCuisineType(rs.getString("cuisine"));
                r.setAddress(rs.getString("address"));
                r.setRating(rs.getDouble("rating"));
                r.setDeliveryTime(rs.getInt("delivery_time"));
                r.setPriceForTwo(rs.getInt("price_for_two"));
                r.setImagePath(rs.getString("image_url"));
                r.setActive(rs.getBoolean("active"));
                list.add(r);
            }

        } catch (SQLException e) {
            System.err.println("RestaurantDAOImpl: Error fetching restaurants - " + e.getMessage());
            e.printStackTrace();
        }

        return list;
    }
}
