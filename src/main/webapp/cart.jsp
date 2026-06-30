<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.tap.model.CartItem, com.tap.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Cart – Velouraa</title>
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

/* ── Top Navbar ──────────────────────────────────────── */
.top-nav {
    position: fixed; top: 0; left: 0;
    width: 100%; height: 70px;
    background: rgba(250,249,246,0.9);
    backdrop-filter: blur(20px);
    border-bottom: 1px solid rgba(0,0,0,0.08);
    display: flex; align-items: center; justify-content: space-between;
    padding: 0 5%; z-index: 1000;
    box-shadow: 0 2px 20px rgba(0,0,0,0.05);
}
.nav-logo { font-size: 24px; font-weight: 800; color: #1a1a1a; text-decoration: none; letter-spacing: -1px; display: flex; align-items: center; gap: 8px; }
.nav-logo span { color: #f04f5f; }
.nav-right { display: flex; align-items: center; gap: 20px; }
.nav-icon-btn {
    position: relative; display: flex; align-items: center; gap: 6px;
    text-decoration: none; color: #4b5563; font-size: 14px; font-weight: 600;
    padding: 8px 14px; border-radius: 10px; transition: all 0.2s ease;
    border: 1px solid rgba(0,0,0,0.08);
}
.nav-icon-btn:hover { background: rgba(240,79,95,0.06); color: #f04f5f; }
.nav-badge {
    background: #f04f5f; color: white; font-size: 10px; font-weight: 800;
    border-radius: 50%; width: 18px; height: 18px; display: none;
    align-items: center; justify-content: center;
    position: absolute; top: -6px; right: -6px;
    box-shadow: 0 0 8px rgba(240,79,95,0.5);
}
.nav-badge.vis { display: flex; }

/* ── Header ─────────────────────────────────────────── */
.page-header {
    margin-top: 70px;
    background: linear-gradient(135deg, #ff6b35 0%, #f7931e 100%);
    padding: 28px 32px;
    display: flex;
    align-items: center;
    gap: 20px;
    position: relative;
    overflow: hidden;
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

.header-title {
    color: #fff;
    font-size: 28px;
    font-weight: 700;
}

/* ── Layout ──────────────────────────────────────────── */
.cart-layout {
    max-width: 1140px;
    margin: 36px auto 60px;
    padding: 0 20px;
    display: grid;
    grid-template-columns: 1fr 360px;
    gap: 28px;
    align-items: start;
}

@media (max-width: 820px) {
    .cart-layout { grid-template-columns: 1fr; }
}

/* ── Cart Items Panel ────────────────────────────────── */
.cart-panel {
    background: #fff;
    border-radius: 20px;
    box-shadow: 0 4px 24px rgba(0,0,0,0.07);
    overflow: hidden;
}

.panel-heading {
    padding: 22px 28px;
    border-bottom: 1px solid #f0ede9;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.panel-heading h2 {
    font-size: 20px;
    font-weight: 700;
    color: #1a1a1a;
}

.item-count-badge {
    background: #fff4ee;
    color: #ff6b35;
    font-size: 13px;
    font-weight: 600;
    padding: 4px 12px;
    border-radius: 20px;
}

/* ── Cart Item Row ───────────────────────────────────── */
.cart-item {
    display: flex;
    align-items: center;
    gap: 18px;
    padding: 20px 28px;
    border-bottom: 1px solid #f7f4f1;
    transition: background 0.2s;
}

.cart-item:last-child { border-bottom: none; }
.cart-item:hover      { background: #fffaf7; }

.item-img {
    width: 80px;
    height: 80px;
    border-radius: 12px;
    object-fit: cover;
    flex-shrink: 0;
    background: #f0ede9;
}

.item-info { flex: 1; min-width: 0; }

.item-name {
    font-size: 16px;
    font-weight: 600;
    color: #1a1a1a;
    margin-bottom: 4px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.item-category {
    font-size: 12px;
    color: #ff6b35;
    font-weight: 500;
    background: #fff4ee;
    display: inline-block;
    padding: 2px 8px;
    border-radius: 10px;
    margin-bottom: 6px;
    text-transform: uppercase;
    letter-spacing: 0.4px;
}

.item-unit-price {
    font-size: 13px;
    color: #999;
}

/* ── Qty Controls ────────────────────────────────────── */
.qty-controls {
    display: flex;
    align-items: center;
    gap: 0;
    background: #f7f3ef;
    border-radius: 10px;
    overflow: hidden;
    flex-shrink: 0;
}

.qty-btn {
    width: 36px;
    height: 36px;
    border: none;
    background: transparent;
    font-size: 18px;
    font-weight: 600;
    color: #ff6b35;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: background 0.15s;
    font-family: 'Outfit', sans-serif;
}

.qty-btn:hover { background: #ffe8dc; }

.qty-value {
    width: 36px;
    text-align: center;
    font-size: 16px;
    font-weight: 600;
    color: #1a1a1a;
}

/* ── Item Subtotal & Remove ──────────────────────────── */
.item-right {
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    gap: 10px;
    flex-shrink: 0;
}

.item-subtotal {
    font-size: 18px;
    font-weight: 700;
    color: #1a1a1a;
}

.remove-btn {
    background: none;
    border: none;
    color: #ccc;
    font-size: 18px;
    cursor: pointer;
    transition: color 0.2s;
    padding: 4px;
    border-radius: 6px;
}

.remove-btn:hover { color: #e74c3c; background: #fff0ef; }

/* ── Order Summary ───────────────────────────────────── */
.summary-panel {
    background: #fff;
    border-radius: 20px;
    box-shadow: 0 4px 24px rgba(0,0,0,0.07);
    padding: 28px;
    position: sticky;
    top: 20px;
}

.summary-panel h2 {
    font-size: 20px;
    font-weight: 700;
    color: #1a1a1a;
    margin-bottom: 24px;
}

.summary-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 14px;
    font-size: 15px;
    color: #555;
}

.summary-row.total {
    font-size: 20px;
    font-weight: 700;
    color: #1a1a1a;
    border-top: 2px solid #f0ede9;
    padding-top: 16px;
    margin-top: 6px;
}

.summary-row .label { font-weight: 500; }
.summary-row .value { font-weight: 600; }
.summary-row.total .value { color: #ff6b35; }

.delivery-note {
    font-size: 12px;
    color: #bbb;
    margin-bottom: 24px;
}

.checkout-btn {
    width: 100%;
    padding: 16px;
    background: linear-gradient(135deg, #ff6b35 0%, #f7931e 100%);
    color: #fff;
    border: none;
    border-radius: 14px;
    font-size: 16px;
    font-weight: 700;
    font-family: 'Outfit', sans-serif;
    cursor: pointer;
    text-decoration: none;
    display: block;
    text-align: center;
    transition: opacity 0.2s ease, transform 0.15s ease;
    box-shadow: 0 6px 20px rgba(255,107,53,0.35);
}

.checkout-btn:hover {
    opacity: 0.9;
    transform: translateY(-2px);
}

/* ── Empty Cart ──────────────────────────────────────── */
.empty-cart {
    padding: 80px 20px;
    text-align: center;
    color: #bbb;
}

.empty-cart .icon { font-size: 64px; display: block; margin-bottom: 20px; }
.empty-cart h2    { font-size: 22px; font-weight: 600; color: #888; margin-bottom: 12px; }
.empty-cart p     { font-size: 15px; margin-bottom: 28px; }

.browse-btn {
    display: inline-block;
    padding: 14px 28px;
    background: linear-gradient(135deg, #ff6b35, #f7931e);
    color: #fff;
    border-radius: 12px;
    text-decoration: none;
    font-size: 15px;
    font-weight: 600;
    transition: opacity 0.2s;
}

.browse-btn:hover { opacity: 0.88; }

</style>
</head>
<body>

<%
List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
int cartId = (cartItems != null) ? (int) request.getAttribute("cartId") : -1;

double subtotal = 0;
if (cartItems != null) {
    for (CartItem ci : cartItems) subtotal += ci.getSubtotal();
}
double deliveryFee = cartItems != null && !cartItems.isEmpty() ? 30.0 : 0.0;
double total = subtotal + deliveryFee;
int totalQty = 0;
if (cartItems != null) {
    for (CartItem ci : cartItems) totalQty += ci.getQuantity();
}

User loggedInUser = (User) session.getAttribute("loggedInUser");
Integer restaurantIdObj = (Integer) session.getAttribute("restaurantId");
int restaurantId = restaurantIdObj != null ? restaurantIdObj : 0;
%>


<!-- TOP NAVBAR -->
<nav class="top-nav">
    <a href="<%= request.getContextPath() %>/home" class="nav-logo"><span>🍕</span> Velouraa</a>
    <div class="nav-right">
        <a href="<%= request.getContextPath() %>/home" class="nav-icon-btn"><i class="fa-solid fa-house"></i> Home</a>
        <a href="#" class="nav-icon-btn" title="Favourites"><i class="fa-regular fa-heart"></i> Saved <span class="nav-badge" id="cart-fav-badge">0</span></a>
    </div>
</nav>

<div class="page-header">
    <a href="<%= restaurantId > 0 ? "menu?restaurantId=" + restaurantId : "home" %>" class="back-btn"><i class="fa-solid fa-arrow-left"></i> Back to Menu</a>
    <h1 class="header-title">🛒 My Cart</h1>
</div>

<div class="cart-layout">

    <!-- Items Panel -->
    <div class="cart-panel">
        <div class="panel-heading">
            <h2>Cart Items</h2>
            <span class="item-count-badge"><%= totalQty %> item<%= totalQty != 1 ? "s" : "" %></span>
        </div>

        <%
        if (cartItems == null || cartItems.isEmpty()) {
        %>
        <div class="empty-cart">
            <span class="icon">🛒</span>
            <h2>Your cart is empty</h2>
            <p>Looks like you haven't added anything yet.</p>
            <a href="home" class="browse-btn">Browse Restaurants</a>
        </div>
        <%
        } else {
            for (CartItem item : cartItems) {
                String imgSrc = item.getImagePath();
                if (imgSrc == null || imgSrc.trim().isEmpty()) {
                    imgSrc = "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=300";
                }
                boolean isExternal = imgSrc.startsWith("http://") || imgSrc.startsWith("https://");
                String finalSrc = isExternal ? imgSrc : (request.getContextPath() + "/" + imgSrc);
        %>
        <div class="cart-item" id="cartItem-<%= item.getCartItemId() %>">
            <img src="<%= finalSrc %>"
                 alt="<%= item.getItemName() %>"
                 class="item-img"
                 onerror="this.src='https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=300'">

            <div class="item-info">
                <div class="item-name"><%= item.getItemName() %></div>
                <div class="item-category"><%= item.getCategory() %></div>
                <div class="item-unit-price">₹<%= (int) item.getPrice() %> each</div>
            </div>

            <!-- Quantity Controls -->
            <div class="qty-controls">
                <button class="qty-btn"
                        onclick="changeQty(<%= item.getCartItemId() %>, <%= item.getQuantity() - 1 %>)">−</button>
                <span class="qty-value" id="qty-<%= item.getCartItemId() %>"><%= item.getQuantity() %></span>
                <button class="qty-btn"
                        onclick="changeQty(<%= item.getCartItemId() %>, <%= item.getQuantity() + 1 %>)">+</button>
            </div>

            <div class="item-right">
                <span class="item-subtotal" id="sub-<%= item.getCartItemId() %>">
                    ₹<%= (int) item.getSubtotal() %>
                </span>
                <form method="post" action="cart" style="margin:0;">
                    <input type="hidden" name="action" value="remove">
                    <input type="hidden" name="cartItemId" value="<%= item.getCartItemId() %>">
                    <button type="submit" class="remove-btn" title="Remove item">🗑️</button>
                </form>
            </div>
        </div>
        <%
            }
        }
        %>
    </div>

    <!-- Summary Panel -->
    <div class="summary-panel">
        <h2>Order Summary</h2>

        <div class="summary-row">
            <span class="label">Subtotal</span>
            <span class="value" id="summarySubtotal">₹<%= (int) subtotal %></span>
        </div>
        <div class="summary-row">
            <span class="label">Delivery Fee</span>
            <span class="value">₹<%= (int) deliveryFee %></span>
        </div>
        <p class="delivery-note">Free delivery on orders above ₹500 coming soon!</p>
        <div class="summary-row total">
            <span class="label">Total</span>
            <span class="value" id="summaryTotal">₹<%= (int) total %></span>
        </div>

        <%
        if (cartItems != null && !cartItems.isEmpty()) {
        %>
        <a href="checkout" class="checkout-btn">Proceed to Checkout →</a>
        <%
        } else {
        %>
        <a href="home" class="checkout-btn" style="background: #ccc; box-shadow: none;">Browse Menu</a>
        <%
        }
        %>
    </div>

</div>

<!-- Hidden form for quantity update -->
<form id="qtyForm" method="post" action="cart" style="display:none;">
    <input type="hidden" name="action" value="update">
    <input type="hidden" name="cartItemId" id="qtyFormItemId">
    <input type="hidden" name="quantity" id="qtyFormQty">
</form>

<script>
function changeQty(cartItemId, newQty) {
    if (newQty < 1) {
        if (!confirm('Remove this item from your cart?')) return;
        const removeForm = document.createElement('form');
        removeForm.method = 'post';
        removeForm.action = 'cart';
        removeForm.innerHTML =
            '<input type="hidden" name="action" value="remove">' +
            '<input type="hidden" name="cartItemId" value="' + cartItemId + '">';
        document.body.appendChild(removeForm);
        removeForm.submit();
        return;
    }
    document.getElementById('qtyFormItemId').value = cartItemId;
    document.getElementById('qtyFormQty').value    = newQty;
    document.getElementById('qtyForm').submit();
}

// Update fav badge from localStorage
document.addEventListener('DOMContentLoaded', () => {
    const favs = JSON.parse(localStorage.getItem('velouraa_favorites')) || {};
    const count = Object.keys(favs).length;
    const badge = document.getElementById('cart-fav-badge');
    if (badge) {
        badge.textContent = count;
        badge.className = count > 0 ? 'nav-badge vis' : 'nav-badge';
        badge.style.background = '#e11d48';
    }
});
</script>

</body>
</html>
