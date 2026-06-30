package com.tap.model;

public class Menu {

    private int id;
    private int restaurantId;
    private String itemName;
    private String description;
    private double price;
    private String category;
    private String imagePath;
    private boolean available;

    // ── Constructors ──────────────────────────────────────────────

    public Menu() {}

    public Menu(int id, int restaurantId, String itemName, String description,
                double price, String category, String imagePath, boolean available) {
        this.id           = id;
        this.restaurantId = restaurantId;
        this.itemName     = itemName;
        this.description  = description;
        this.price        = price;
        this.category     = category;
        this.imagePath    = imagePath;
        this.available    = available;
    }

    // ── Getters & Setters ─────────────────────────────────────────

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getRestaurantId() { return restaurantId; }
    public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }

    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }

    public boolean isAvailable() { return available; }
    public void setAvailable(boolean available) { this.available = available; }

    // ── toString ──────────────────────────────────────────────────

    @Override
    public String toString() {
        return "Menu{" +
               "id=" + id +
               ", restaurantId=" + restaurantId +
               ", itemName='" + itemName + '\'' +
               ", description='" + description + '\'' +
               ", price=" + price +
               ", category='" + category + '\'' +
               ", imagePath='" + imagePath + '\'' +
               ", available=" + available +
               '}';
    }
}
