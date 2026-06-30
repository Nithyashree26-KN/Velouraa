package com.tap.DAO;

import com.tap.model.Menu;
import java.util.List;

public interface MenuDAO {

    List<Menu> getAllMenusByRestaurant(int restaurantId);
}
