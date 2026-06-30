package com.tap.DAO;

import java.util.List;
import com.tap.model.CartItem;

public interface CartDAO {

    /** Get the existing active cart ID for the user, or create one and return its ID. */
    int getOrCreateCart(int userId);

    /** Get the cart ID for the user (returns -1 if none exists). */
    int getCartId(int userId);

    /**
     * Add a menu item to the cart.
     * If the item is already in the cart, increment its quantity by qty.
     */
    void addOrUpdateItem(int cartId, int menuId, int qty);

    /** Retrieve all cart items for a given cart, with name/price joined from menu. */
    List<CartItem> getCartItems(int cartId);

    /** Set the quantity of a specific cart item (removes if qty == 0). */
    void updateQuantity(int cartItemId, int quantity);

    /** Remove a specific item from the cart. */
    void removeItem(int cartItemId);

    /** Delete all items from the cart (call after placing an order). */
    void clearCart(int cartId);

    /** Count total number of items (sum of quantities) in the cart. */
    int getCartItemCount(int cartId);
}
