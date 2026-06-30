package com.tap.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.MenuDAO;
import com.tap.model.Menu;
import com.tap.utility.DBConnection;

public class MenuDAOImpl implements MenuDAO {

    @Override
    public List<Menu> getAllMenusByRestaurant(int restaurantId) {

        List<Menu> menuList = new ArrayList<>();

        String query = "SELECT * FROM menu WHERE RestaurantID = ?";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement pstmt = con.prepareStatement(query);

            pstmt.setInt(1, restaurantId);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {

                Menu menu = new Menu();

                menu.setId(rs.getInt("MenuID"));
                menu.setRestaurantId(rs.getInt("RestaurantID"));
                menu.setItemName(rs.getString("ItemName"));
                menu.setDescription(rs.getString("Description"));
                menu.setPrice(rs.getDouble("Price"));
                menu.setCategory(rs.getString("Category"));
                menu.setImagePath(rs.getString("ImageURL"));
                menu.setAvailable(rs.getBoolean("IsAvailable"));

                menuList.add(menu);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return menuList;
    }
}