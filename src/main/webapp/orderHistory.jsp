<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Map, com.tap.model.Order, com.tap.model.OrderItem, com.tap.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Order History – FreshFetch</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<style>

* { margin: 0; padding: 0; box-sizing: border-box; }

body {
    font-family: 'Outfit', sans-serif;
    background: #f7f3ef;
    min-height: 100vh;
}

/* ── Header ─────────────────────────────────────────── */
.page-header {
    background: linear-gradient(135deg, #ff6b35 0%, #f7931e 100%);
    padding: 28px 32px 60px;
    position: relative;
    overflow: hidden;
    display: flex;
    align-items: flex-start;
    justify-content: space-between;
    flex-wrap: wrap;
    gap: 16px;
}

.page-header::before {
    content: '';
    position: absolute;
    width: 320px; height: 320px;
    background: rgba(255,255,255,0.07);
    border-radius: 50%;
    top: -100px; right: -60px;
    pointer-events: none;
}

.header-left h1 {
    color: #fff;
    font-size: 34px;
    font-weight: 800;
    letter-spacing: -0.5px;
    position: relative;
}

.header-left p {
    color: rgba(255,255,255,0.82);
    font-size: 15px;
    margin-top: 6px;
    position: relative;
}

.header-nav {
    display: flex;
    gap: 12px;
    align-items: center;
    position: relative;
}

.nav-btn {
    display: flex;
    align-items: center;
    gap: 8px;
    color: rgba(255,255,255,0.9);
    text-decoration: none;
    font-size: 14px;
    font-weight: 500;
    background: rgba(255,255,255,0.15);
    border: 1.5px solid rgba(255,255,255,0.35);
    padding: 10px 18px;
    border-radius: 50px;
    transition: background 0.2s;
    backdrop-filter: blur(6px);
    white-space: nowrap;
}

.nav-btn:hover { background: rgba(255,255,255,0.25); }

/* ── Main Content ────────────────────────────────────── */
.main-content {
    max-width: 960px;
    margin: -30px auto 60px;
    padding: 0 20px;
}

/* ── Success Toast ───────────────────────────────────── */
.success-banner {
    background: linear-gradient(135deg, #22c55e, #16a34a);
    color: #fff;
    padding: 16px 24px;
    border-radius: 14px;
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 24px;
    box-shadow: 0 6px 20px rgba(34,197,94,0.3);
    animation: slideDown 0.4s ease;
}

@keyframes slideDown {
    from { opacity: 0; transform: translateY(-16px); }
    to   { opacity: 1; transform: translateY(0); }
}

.success-icon { font-size: 26px; }

.success-text h3 { font-size: 17px; font-weight: 700; }
.success-text p  { font-size: 14px; opacity: 0.85; }

/* ── Stats Bar ───────────────────────────────────────── */
.stats-bar {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 16px;
    margin-bottom: 28px;
}

.stat-card {
    background: #fff;
    border-radius: 16px;
    padding: 20px 22px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.06);
    display: flex;
    align-items: center;
    gap: 16px;
}

.stat-icon {
    width: 48px; height: 48px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 22px;
    flex-shrink: 0;
}

.stat-icon.orange { background: #fff4ee; }
.stat-icon.green  { background: #f0fdf4; }
.stat-icon.blue   { background: #eff6ff; }

.stat-value {
    font-size: 24px;
    font-weight: 800;
    color: #1a1a1a;
    line-height: 1;
}

.stat-label {
    font-size: 13px;
    color: #999;
    font-weight: 500;
    margin-top: 3px;
}

/* ── Orders Section ──────────────────────────────────── */
.section-title {
    font-size: 18px;
    font-weight: 700;
    color: #1a1a1a;
    margin-bottom: 16px;
}

/* ── Order Card ──────────────────────────────────────── */
.order-card {
    background: #fff;
    border-radius: 18px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.07);
    margin-bottom: 20px;
    overflow: hidden;
    transition: box-shadow 0.2s;
}

.order-card:hover { box-shadow: 0 8px 30px rgba(0,0,0,0.11); }

/* ── Order Header ────────────────────────────────────── */
.order-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 20px 24px;
    border-bottom: 1px solid #f0ede9;
    flex-wrap: wrap;
    gap: 12px;
    cursor: pointer;
    user-select: none;
}

.order-header:hover .toggle-icon { color: #ff6b35; }

.order-id-block { display: flex; align-items: center; gap: 14px; }

.order-icon {
    width: 44px; height: 44px;
    background: linear-gradient(135deg, #ff6b35, #f7931e);
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 20px;
    flex-shrink: 0;
}

.order-id { font-size: 16px; font-weight: 700; color: #1a1a1a; }
.order-restaurant { font-size: 13px; color: #999; margin-top: 2px; }

.order-meta { display: flex; align-items: center; gap: 16px; flex-wrap: wrap; }

.order-date {
    font-size: 13px;
    color: #aaa;
    display: flex;
    align-items: center;
    gap: 5px;
}

/* ── Status Badge ────────────────────────────────────── */
.status-badge {
    padding: 5px 14px;
    border-radius: 50px;
    font-size: 12px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.status-confirmed  { background: #f0fdf4; color: #16a34a; }
.status-pending    { background: #fffbeb; color: #d97706; }
.status-delivered  { background: #eff6ff; color: #2563eb; }
.status-cancelled  { background: #fef2f2; color: #dc2626; }

.order-total {
    font-size: 20px;
    font-weight: 800;
    color: #ff6b35;
    white-space: nowrap;
}

.toggle-icon {
    font-size: 18px;
    color: #ccc;
    transition: transform 0.25s, color 0.2s;
}

.order-card.open .toggle-icon { transform: rotate(180deg); color: #ff6b35; }

/* ── Order Items Table ───────────────────────────────── */
.order-items {
    display: none;
    padding: 0 24px 20px;
    animation: fadeIn 0.25s ease;
}

.order-card.open .order-items { display: block; }

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(-6px); }
    to   { opacity: 1; transform: translateY(0); }
}

.items-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 16px;
}

.items-table th {
    text-align: left;
    font-size: 12px;
    font-weight: 600;
    color: #aaa;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    padding: 8px 12px;
    border-bottom: 1px solid #f0ede9;
}

.items-table td {
    padding: 12px 12px;
    font-size: 14px;
    color: #333;
    border-bottom: 1px solid #f7f4f1;
    vertical-align: middle;
}

.items-table tr:last-child td { border-bottom: none; }

.items-table td.item-name-col { font-weight: 600; color: #1a1a1a; }
.items-table td.qty-col       { color: #888; }
.items-table td.price-col     { text-align: right; font-weight: 600; color: #ff6b35; }

.delivery-addr {
    display: flex;
    align-items: flex-start;
    gap: 8px;
    margin-top: 12px;
    padding: 12px 14px;
    background: #f7f3ef;
    border-radius: 10px;
    font-size: 13px;
    color: #666;
}

.delivery-addr .addr-icon { flex-shrink: 0; margin-top: 1px; }

/* ── Empty State ─────────────────────────────────────── */
.empty-state {
    background: #fff;
    border-radius: 20px;
    padding: 80px 20px;
    text-align: center;
    box-shadow: 0 4px 20px rgba(0,0,0,0.06);
}

.empty-state .icon { font-size: 64px; display: block; margin-bottom: 20px; }
.empty-state h2    { font-size: 22px; font-weight: 700; color: #555; margin-bottom: 10px; }
.empty-state p     { font-size: 15px; color: #aaa; margin-bottom: 28px; }

.order-now-btn {
    display: inline-block;
    padding: 14px 30px;
    background: linear-gradient(135deg, #ff6b35, #f7931e);
    color: #fff;
    border-radius: 12px;
    text-decoration: none;
    font-size: 15px;
    font-weight: 700;
    box-shadow: 0 6px 18px rgba(255,107,53,0.3);
    transition: opacity 0.2s, transform 0.15s;
}

.order-now-btn:hover { opacity: 0.88; transform: translateY(-2px); }

@media (max-width: 640px) {
    .stats-bar { grid-template-columns: 1fr 1fr; }
    .stat-card:last-child { grid-column: 1 / -1; }
    .order-header { padding: 16px; }
    .order-items  { padding: 0 16px 16px; }
}

</style>
</head>
<body>

<%
List<Order> orders = (List<Order>) request.getAttribute("orders");
Map<Integer, List<OrderItem>> orderItemsMap =
    (Map<Integer, List<OrderItem>>) request.getAttribute("orderItemsMap");
User loggedInUser = (User) session.getAttribute("loggedInUser");
boolean showSuccess = "true".equals(request.getParameter("success"));

// Compute stats
int totalOrders = orders != null ? orders.size() : 0;
double totalSpent = 0;
if (orders != null) {
    for (Order o : orders) totalSpent += o.getTotalAmount();
}
String lastOrderStatus = (orders != null && !orders.isEmpty()) ? orders.get(0).getStatus() : "—";
%>

<div class="page-header">
    <div class="header-left">
        <h1>📋 Order History</h1>
        <p>Hello, <%= loggedInUser != null ? loggedInUser.getUsername() : "Guest" %>! Here are all your orders.</p>
    </div>
    <div class="header-nav">
        <a href="home" class="nav-btn">🏠 Restaurants</a>
        <a href="cart" class="nav-btn">🛒 Cart</a>
    </div>
</div>

<div class="main-content">

    <!-- Success Banner -->
    <%
    if (showSuccess) {
    %>
    <div class="success-banner" id="successBanner">
        <span class="success-icon">🎉</span>
        <div class="success-text">
            <h3>Order Placed Successfully!</h3>
            <p>Your food is being prepared and will reach you soon.</p>
        </div>
    </div>
    <%
    }
    %>

    <!-- Stats Bar -->
    <div class="stats-bar">
        <div class="stat-card">
            <div class="stat-icon orange">📦</div>
            <div>
                <div class="stat-value"><%= totalOrders %></div>
                <div class="stat-label">Total Orders</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon green">💰</div>
            <div>
                <div class="stat-value">₹<%= (int) totalSpent %></div>
                <div class="stat-label">Total Spent</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon blue">⚡</div>
            <div>
                <div class="stat-value" style="font-size:16px;"><%= lastOrderStatus %></div>
                <div class="stat-label">Latest Status</div>
            </div>
        </div>
    </div>

    <!-- Orders List -->
    <%
    if (orders == null || orders.isEmpty()) {
    %>
    <div class="empty-state">
        <span class="icon">📭</span>
        <h2>No orders yet</h2>
        <p>You haven't placed any orders. Start exploring restaurants!</p>
        <a href="home" class="order-now-btn">Order Now</a>
    </div>
    <%
    } else {
    %>
    <div class="section-title">Your Orders (<%= totalOrders %>)</div>

    <%
    for (Order order : orders) {
        List<OrderItem> items = orderItemsMap.get(order.getOrderId());
        String statusClass = "status-pending";
        if ("Confirmed".equalsIgnoreCase(order.getStatus()))  statusClass = "status-confirmed";
        else if ("Delivered".equalsIgnoreCase(order.getStatus())) statusClass = "status-delivered";
        else if ("Cancelled".equalsIgnoreCase(order.getStatus())) statusClass = "status-cancelled";
    %>
    <div class="order-card" id="order-<%= order.getOrderId() %>">

        <div class="order-header" onclick="toggleOrder(<%= order.getOrderId() %>)">
            <div class="order-id-block">
                <div class="order-icon">🍽️</div>
                <div>
                    <div class="order-id">#ORD<%= String.format("%04d", order.getOrderId()) %></div>
                    <div class="order-restaurant">
                        <%= order.getRestaurantName() != null ? order.getRestaurantName() : "Restaurant" %>
                    </div>
                </div>
            </div>

            <div class="order-meta">
                <span class="order-date">
                    📅 <%= order.getOrderedAt() != null
                            ? new java.text.SimpleDateFormat("dd MMM yyyy, hh:mm a").format(order.getOrderedAt())
                            : "—" %>
                </span>
                <span class="status-badge <%= statusClass %>"><%= order.getStatus() %></span>
                <span class="order-total">₹<%= (int) order.getTotalAmount() %></span>
                <span class="toggle-icon">▼</span>
            </div>
        </div>

        <div class="order-items">
            <table class="items-table">
                <thead>
                    <tr>
                        <th>Item</th>
                        <th>Qty</th>
                        <th style="text-align:right;">Price</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    if (items != null) {
                        for (OrderItem oi : items) {
                    %>
                    <tr>
                        <td class="item-name-col"><%= oi.getItemName() %></td>
                        <td class="qty-col">× <%= oi.getQuantity() %></td>
                        <td class="price-col">₹<%= (int) oi.getSubtotal() %></td>
                    </tr>
                    <%
                        }
                    }
                    %>
                </tbody>
            </table>

            <%
            if (order.getDeliveryAddress() != null && !order.getDeliveryAddress().trim().isEmpty()) {
            %>
            <div class="delivery-addr">
                <span class="addr-icon">📍</span>
                <span><%= order.getDeliveryAddress() %></span>
            </div>
            <%
            }
            %>
        </div>

    </div>
    <%
    }
    }
    %>

</div>

<script>
function toggleOrder(orderId) {
    const card = document.getElementById('order-' + orderId);
    card.classList.toggle('open');
}

// Auto-open first order if it just came in
<% if (showSuccess && orders != null && !orders.isEmpty()) { %>
document.addEventListener('DOMContentLoaded', function() {
    toggleOrder(<%= orders.get(0).getOrderId() %>);
    // Auto-hide success banner after 5 seconds
    setTimeout(() => {
        const banner = document.getElementById('successBanner');
        if (banner) {
            banner.style.transition = 'opacity 0.5s ease';
            banner.style.opacity = '0';
            setTimeout(() => banner.remove(), 500);
        }
    }, 5000);
});
<% } %>
</script>

</body>
</html>
