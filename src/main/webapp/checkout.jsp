<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.tap.model.CartItem, com.tap.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Checkout – Velouraa</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>

* { margin: 0; padding: 0; box-sizing: border-box; }

body {
    font-family: 'Plus Jakarta Sans', sans-serif;
    background: #f7f3ef;
    min-height: 100vh;
}

/* ── Navbar ───────────────────── */
.top-nav {
    position: fixed; top: 0; left: 0; width: 100%; height: 70px;
    background: rgba(250,249,246,0.9); backdrop-filter: blur(20px);
    border-bottom: 1px solid rgba(0,0,0,0.08);
    display: flex; align-items: center; justify-content: space-between;
    padding: 0 5%; z-index: 1000; box-shadow: 0 2px 20px rgba(0,0,0,0.05);
}
.nav-logo { font-size: 24px; font-weight: 800; color: #1a1a1a; text-decoration: none; letter-spacing: -1px; display: flex; align-items: center; gap: 8px; }
.nav-logo span { color: #f04f5f; }
.nav-right { display: flex; align-items: center; gap: 16px; }
.nav-icon-btn {
    display: flex; align-items: center; gap: 6px; text-decoration: none; color: #4b5563;
    font-size: 14px; font-weight: 600; padding: 8px 14px; border-radius: 10px;
    border: 1px solid rgba(0,0,0,0.08); transition: all 0.2s;
}
.nav-icon-btn:hover { background: rgba(240,79,95,0.06); color: #f04f5f; }

/* ── Header ─────────────────────────────────────────── */
.page-header {
    margin-top: 70px;
    background: linear-gradient(135deg, #ff6b35 0%, #f7931e 100%);
    padding: 28px 32px;
    display: flex;
    align-items: center;
    gap: 20px;
    overflow: hidden;
    position: relative;
}

.page-header::before {
    content: '';
    position: absolute;
    width: 260px; height: 260px;
    background: rgba(255,255,255,0.07);
    border-radius: 50%;
    top: -80px; right: -50px;
    pointer-events: none;
}

.back-btn {
    display: flex;
    align-items: center;
    gap: 8px;
    color: rgba(255,255,255,0.9);
    text-decoration: none;
    font-size: 14px;
    font-weight: 500;
    background: rgba(255,255,255,0.15);
    border: 1.5px solid rgba(255,255,255,0.35);
    padding: 8px 16px;
    border-radius: 50px;
    transition: background 0.2s;
    backdrop-filter: blur(6px);
    flex-shrink: 0;
}

.back-btn:hover { background: rgba(255,255,255,0.25); }

.header-title { color: #fff; font-size: 28px; font-weight: 700; }

/* ── Layout ──────────────────────────────────────────── */
.checkout-layout {
    max-width: 1100px;
    margin: 36px auto 60px;
    padding: 0 20px;
    display: grid;
    grid-template-columns: 1fr 380px;
    gap: 28px;
    align-items: start;
}

@media (max-width: 820px) {
    .checkout-layout { grid-template-columns: 1fr; }
}

/* ── Panels ──────────────────────────────────────────── */
.panel {
    background: #fff;
    border-radius: 20px;
    box-shadow: 0 4px 24px rgba(0,0,0,0.07);
    padding: 28px;
}

.panel h2 {
    font-size: 19px;
    font-weight: 700;
    color: #1a1a1a;
    margin-bottom: 22px;
    padding-bottom: 14px;
    border-bottom: 1px solid #f0ede9;
}

/* ── Delivery Form ───────────────────────────────────── */
.form-group { margin-bottom: 20px; }

.form-group label {
    display: block;
    font-size: 13px;
    font-weight: 600;
    color: #555;
    margin-bottom: 8px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.form-group input,
.form-group textarea,
.form-group select {
    width: 100%;
    padding: 13px 16px;
    border: 2px solid #f0ede9;
    border-radius: 12px;
    font-size: 15px;
    font-family: 'Outfit', sans-serif;
    color: #1a1a1a;
    background: #fafaf9;
    outline: none;
    transition: border-color 0.2s ease, background 0.2s ease;
    resize: vertical;
}

.form-group input:focus,
.form-group textarea:focus,
.form-group select:focus {
    border-color: #ff6b35;
    background: #fff;
}

/* ── Payment Method ──────────────────────────────────── */
.payment-options {
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.payment-option {
    display: flex;
    align-items: center;
    gap: 14px;
    padding: 14px 18px;
    border: 2px solid #f0ede9;
    border-radius: 12px;
    cursor: pointer;
    transition: border-color 0.2s, background 0.2s;
    position: relative;
}

.payment-option:hover { border-color: #ff6b35; background: #fffaf7; }

.payment-option input[type="radio"] {
    width: 18px; height: 18px;
    accent-color: #ff6b35;
    flex-shrink: 0;
}

.payment-option.selected {
    border-color: #ff6b35;
    background: #fff4ee;
}

.payment-icon { font-size: 24px; }

.payment-label { font-size: 15px; font-weight: 600; color: #1a1a1a; }
.payment-sublabel { font-size: 12px; color: #999; }

/* ── Order Summary ───────────────────────────────────── */
.order-items-list { margin-bottom: 20px; }

.order-item-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 0;
    border-bottom: 1px solid #f7f4f1;
    gap: 12px;
}

.order-item-row:last-child { border-bottom: none; }

.order-item-name {
    font-size: 14px;
    font-weight: 500;
    color: #333;
    flex: 1;
}

.order-item-qty {
    font-size: 13px;
    color: #999;
    white-space: nowrap;
}

.order-item-price {
    font-size: 14px;
    font-weight: 600;
    color: #1a1a1a;
    white-space: nowrap;
}

.summary-divider {
    height: 1px;
    background: #f0ede9;
    margin: 16px 0;
}

.summary-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10px;
    font-size: 14px;
    color: #666;
}

.summary-row.total-row {
    font-size: 20px;
    font-weight: 700;
    color: #1a1a1a;
    margin-top: 12px;
    padding-top: 12px;
    border-top: 2px solid #f0ede9;
}

.summary-row.total-row .val { color: #ff6b35; }

/* ── Place Order Button ──────────────────────────────── */
.place-order-btn {
    width: 100%;
    margin-top: 24px;
    padding: 17px;
    background: linear-gradient(135deg, #ff6b35 0%, #f7931e 100%);
    color: #fff;
    border: none;
    border-radius: 14px;
    font-size: 17px;
    font-weight: 700;
    font-family: 'Outfit', sans-serif;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
    box-shadow: 0 6px 20px rgba(255,107,53,0.35);
    transition: opacity 0.2s ease, transform 0.15s ease;
}

.place-order-btn:hover {
    opacity: 0.9;
    transform: translateY(-2px);
}

.secure-note {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 6px;
    margin-top: 12px;
    font-size: 12px;
    color: #bbb;
}

</style>
</head>
<body>

<%
List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
User loggedInUser = (User) session.getAttribute("loggedInUser");
Integer restaurantIdObj = (Integer) session.getAttribute("restaurantId");
int restaurantId = restaurantIdObj != null ? restaurantIdObj : 0;

double subtotal = 0;
if (cartItems != null) {
    for (CartItem ci : cartItems) subtotal += ci.getSubtotal();
}
double deliveryFee = 30.0;
double total = subtotal + deliveryFee;
%>


<!-- TOP NAVBAR -->
<nav class="top-nav">
    <a href="<%= request.getContextPath() %>/home" class="nav-logo"><span>🍕</span> Velouraa</a>
    <div class="nav-right">
        <a href="<%= request.getContextPath() %>/home" class="nav-icon-btn"><i class="fa-solid fa-house"></i> Home</a>
        <a href="<%= request.getContextPath() %>/cart" class="nav-icon-btn"><i class="fa-solid fa-basket-shopping"></i> Cart</a>
    </div>
</nav>

<div class="page-header">
    <a href="cart" class="back-btn"><i class="fa-solid fa-arrow-left"></i> Back to Cart</a>
    <h1 class="header-title">💳 Checkout</h1>
</div>

<div class="checkout-layout">

    <!-- Left: Delivery + Payment -->
    <div>
        <!-- Delivery Details -->
        <div class="panel" style="margin-bottom: 24px;">
            <h2>🏠 Delivery Details</h2>
            <form id="checkoutForm" method="post" action="checkout">
                <input type="hidden" name="restaurantId" value="<%= restaurantId %>">

                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="fullName"
                           value="<%= loggedInUser != null ? loggedInUser.getUsername() : "" %>"
                           placeholder="Enter your full name" required>
                </div>

                <div class="form-group">
                    <label>Delivery Address</label>
                    <textarea name="deliveryAddress" rows="3"
                              placeholder="House/flat no., street, area, city..."
                              required><%= loggedInUser != null && loggedInUser.getAddress() != null ? loggedInUser.getAddress() : "" %></textarea>
                </div>

                <div class="form-group">
                    <label>Phone Number</label>
                    <input type="tel" name="phone" placeholder="Enter mobile number" required>
                </div>
        </div>

        <!-- Payment Method -->
        <div class="panel">
            <h2>💳 Payment Method</h2>
            <div class="payment-options">

                <label class="payment-option selected" id="opt-cod">
                    <input type="radio" name="paymentMethod" value="COD" checked
                           onchange="selectPayment('opt-cod')">
                    <span class="payment-icon">💵</span>
                    <div>
                        <div class="payment-label">Cash on Delivery</div>
                        <div class="payment-sublabel">Pay when your order arrives</div>
                    </div>
                </label>

                <label class="payment-option" id="opt-upi">
                    <input type="radio" name="paymentMethod" value="UPI"
                           onchange="selectPayment('opt-upi')">
                    <span class="payment-icon">📱</span>
                    <div>
                        <div class="payment-label">UPI Payment</div>
                        <div class="payment-sublabel">Google Pay, PhonePe, Paytm</div>
                    </div>
                </label>

                <label class="payment-option" id="opt-card">
                    <input type="radio" name="paymentMethod" value="Card"
                           onchange="selectPayment('opt-card')">
                    <span class="payment-icon">💳</span>
                    <div>
                        <div class="payment-label">Credit / Debit Card</div>
                        <div class="payment-sublabel">All major cards accepted</div>
                    </div>
                </label>

            </div>
            </form><!-- close form here so button is inside -->
        </div>
    </div>

    <!-- Right: Order Summary -->
    <div class="panel">
        <h2>🧾 Order Summary</h2>

        <div class="order-items-list">
        <%
        if (cartItems != null) {
            for (CartItem item : cartItems) {
        %>
            <div class="order-item-row">
                <span class="order-item-name"><%= item.getItemName() %></span>
                <span class="order-item-qty">× <%= item.getQuantity() %></span>
                <span class="order-item-price">₹<%= (int) item.getSubtotal() %></span>
            </div>
        <%
            }
        }
        %>
        </div>

        <div class="summary-divider"></div>

        <div class="summary-row">
            <span>Subtotal</span>
            <span>₹<%= (int) subtotal %></span>
        </div>
        <div class="summary-row">
            <span>Delivery Fee</span>
            <span>₹<%= (int) deliveryFee %></span>
        </div>
        <div class="summary-row total-row">
            <span>Total</span>
            <span class="val">₹<%= (int) total %></span>
        </div>

        <button type="submit" form="checkoutForm" class="place-order-btn" id="placeOrderBtn">
            🎉 Place Order
        </button>

        <div class="secure-note">
            🔒 Secure &amp; encrypted checkout
        </div>
    </div>

</div>

<script>
function selectPayment(optId) {
    document.querySelectorAll('.payment-option').forEach(el => el.classList.remove('selected'));
    document.getElementById(optId).classList.add('selected');
}

document.getElementById('placeOrderBtn').addEventListener('click', function() {
    this.textContent = '⏳ Placing Order...';
    this.disabled = true;
});
</script>

</body>
</html>
