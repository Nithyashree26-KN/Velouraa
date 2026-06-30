package com.tap.model;

public class Restaurant {

    private int id;
    private String name;
    private String cuisineType;
    private String address;
    private double rating;
    private int deliveryTime;
    private int priceForTwo;
    private String imagePath;
    private boolean active;

    // ── Constructors ──────────────────────────────────────────────

    public Restaurant() {}

    public Restaurant(int id, String name, String cuisineType, String address,
                      double rating, int deliveryTime, int priceForTwo,
                      String imagePath, boolean active) {
        this.id          = id;
        this.name        = name;
        this.cuisineType = cuisineType;
        this.address     = address;
        this.rating      = rating;
        this.deliveryTime = deliveryTime;
        this.priceForTwo = priceForTwo;
        this.imagePath   = imagePath;
        this.active      = active;
    }

    // ── Getters & Setters ─────────────────────────────────────────

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getCuisineType() { return cuisineType; }
    public void setCuisineType(String cuisineType) { this.cuisineType = cuisineType; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public double getRating() { return rating; }
    public void setRating(double rating) { this.rating = rating; }

    public int getDeliveryTime() { return deliveryTime; }
    public void setDeliveryTime(int deliveryTime) { this.deliveryTime = deliveryTime; }

    public int getPriceForTwo() { return priceForTwo; }
    public void setPriceForTwo(int priceForTwo) { this.priceForTwo = priceForTwo; }

    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }

    @Override
    public String toString() {
        return "Restaurant{" +
               "id=" + id +
               ", name='" + name + '\'' +
               ", cuisineType='" + cuisineType + '\'' +
               ", address='" + address + '\'' +
               ", rating=" + rating +
               ", deliveryTime=" + deliveryTime +
               ", priceForTwo=" + priceForTwo +
               ", imagePath='" + imagePath + '\'' +
               ", active=" + active +
               '}';
    }
}