package com.tap.model;

import java.sql.Timestamp;

public class Order {

    private int       orderId;
    private int       userId;
    private int       restaurantId;
    private double    totalAmount;
    private String    status;
    private String    deliveryAddress;
    private Timestamp orderedAt;

    // Display helper
    private String    restaurantName;

    public Order() {}

    public Order(int orderId, int userId, int restaurantId,
                 double totalAmount, String status,
                 String deliveryAddress, Timestamp orderedAt) {
        this.orderId         = orderId;
        this.userId          = userId;
        this.restaurantId    = restaurantId;
        this.totalAmount     = totalAmount;
        this.status          = status;
        this.deliveryAddress = deliveryAddress;
        this.orderedAt       = orderedAt;
    }

    public int getOrderId()                          { return orderId; }
    public void setOrderId(int orderId)              { this.orderId = orderId; }

    public int getUserId()                           { return userId; }
    public void setUserId(int userId)                { this.userId = userId; }

    public int getRestaurantId()                     { return restaurantId; }
    public void setRestaurantId(int restaurantId)    { this.restaurantId = restaurantId; }

    public double getTotalAmount()                   { return totalAmount; }
    public void setTotalAmount(double totalAmount)   { this.totalAmount = totalAmount; }

    public String getStatus()                        { return status; }
    public void setStatus(String status)             { this.status = status; }

    public String getDeliveryAddress()               { return deliveryAddress; }
    public void setDeliveryAddress(String addr)      { this.deliveryAddress = addr; }

    public Timestamp getOrderedAt()                  { return orderedAt; }
    public void setOrderedAt(Timestamp orderedAt)    { this.orderedAt = orderedAt; }

    public String getRestaurantName()                { return restaurantName; }
    public void setRestaurantName(String name)       { this.restaurantName = name; }

    @Override
    public String toString() {
        return "Order{orderId=" + orderId + ", userId=" + userId
               + ", total=" + totalAmount + ", status=" + status + "}";
    }
}
