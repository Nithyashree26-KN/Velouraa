package com.tap.model;

public class CartItem {

    private int    cartItemId;
    private int    cartId;
    private int    menuId;
    private int    quantity;

    // Populated via JOIN when fetching from DB — not stored in cart_items table
    private String itemName;
    private double price;
    private String imagePath;
    private String category;

    public CartItem() {}

    public CartItem(int cartItemId, int cartId, int menuId, int quantity) {
        this.cartItemId = cartItemId;
        this.cartId     = cartId;
        this.menuId     = menuId;
        this.quantity   = quantity;
    }

    // ── Core getters/setters ──────────────────────────────────

    public int getCartItemId()                     { return cartItemId; }
    public void setCartItemId(int cartItemId)      { this.cartItemId = cartItemId; }

    public int getCartId()                         { return cartId; }
    public void setCartId(int cartId)              { this.cartId = cartId; }

    public int getMenuId()                         { return menuId; }
    public void setMenuId(int menuId)              { this.menuId = menuId; }

    public int getQuantity()                       { return quantity; }
    public void setQuantity(int quantity)          { this.quantity = quantity; }

    // ── Display helpers (joined from menu table) ──────────────

    public String getItemName()                    { return itemName; }
    public void setItemName(String itemName)       { this.itemName = itemName; }

    public double getPrice()                       { return price; }
    public void setPrice(double price)             { this.price = price; }

    public String getImagePath()                   { return imagePath; }
    public void setImagePath(String imagePath)     { this.imagePath = imagePath; }

    public String getCategory()                    { return category; }
    public void setCategory(String category)       { this.category = category; }

    /** Convenience: price × quantity */
    public double getSubtotal()                    { return price * quantity; }

    @Override
    public String toString() {
        return "CartItem{cartItemId=" + cartItemId + ", menuId=" + menuId
               + ", qty=" + quantity + ", name=" + itemName + "}";
    }
}
