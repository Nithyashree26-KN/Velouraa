<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List,com.tap.model.Menu,com.tap.model.User,com.tap.DAOImpl.CartDAOImpl" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Restaurant Menu – Velouraa</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>

* { margin: 0; padding: 0; box-sizing: border-box; }

body {
    font-family: 'Plus Jakarta Sans', sans-serif;
    background: #faf9f6;
    min-height: 100vh;
}

/* ── Top Navbar ─────────────────────────────────────── */
.top-nav {
    position: fixed;
    top: 0; left: 0;
    width: 100%;
    height: 70px;
    background: rgba(250,249,246,0.9);
    backdrop-filter: blur(20px);
    border-bottom: 1px solid rgba(0,0,0,0.08);
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 5%;
    z-index: 1000;
    box-shadow: 0 2px 20px rgba(0,0,0,0.05);
}
.nav-logo {
    font-size: 24px;
    font-weight: 800;
    color: #1a1a1a;
    text-decoration: none;
    letter-spacing: -1px;
    display: flex; align-items: center; gap: 8px;
}
.nav-logo span { color: #f04f5f; }
.nav-right {
    display: flex;
    align-items: center;
    gap: 20px;
}
.nav-icon-btn {
    position: relative;
    display: flex;
    align-items: center;
    gap: 6px;
    text-decoration: none;
    color: #4b5563;
    font-size: 14px;
    font-weight: 600;
    padding: 8px 14px;
    border-radius: 10px;
    transition: all 0.2s ease;
    border: 1px solid rgba(0,0,0,0.08);
}
.nav-icon-btn:hover { background: rgba(240,79,95,0.06); color: #f04f5f; border-color: rgba(240,79,95,0.2); }
.nav-badge {
    background: #f04f5f;
    color: white;
    font-size: 10px;
    font-weight: 800;
    border-radius: 50%;
    width: 18px; height: 18px;
    display: none;
    align-items: center; justify-content: center;
    position: absolute;
    top: -6px; right: -6px;
    box-shadow: 0 0 8px rgba(240,79,95,0.5);
}
.nav-badge.vis { display: flex; }
.nav-back-bar {
    margin-top: 70px;
    background: linear-gradient(135deg, #f04f5f 0%, #ff8b97 100%);
    padding: 28px 5% 50px;
    position: relative;
    overflow: hidden;
    display: flex;
    align-items: center;
    justify-content: space-between;
}
.nav-back-bar::before {
    content: '';
    position: absolute;
    width: 280px; height: 280px;
    background: rgba(255,255,255,0.08);
    border-radius: 50%;
    top: -80px; right: -50px;
    pointer-events: none;
}
.back-link {
    display: flex; align-items: center; gap: 8px;
    color: rgba(255,255,255,0.9);
    text-decoration: none;
    font-size: 14px; font-weight: 600;
    background: rgba(255,255,255,0.15);
    border: 1.5px solid rgba(255,255,255,0.35);
    padding: 8px 18px;
    border-radius: 50px;
    transition: background 0.2s;
    backdrop-filter: blur(6px);
}
.back-link:hover { background: rgba(255,255,255,0.25); }
.bar-title { color: #fff; font-size: 30px; font-weight: 700; }

/* ── Grid ────────────────────────────────────────────── */
.menu-container {
    width: 92%;
    max-width: 1280px;
    margin: -30px auto 50px;
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(270px, 1fr));
    gap: 24px;
}

/* ── Skeleton placeholder ─────────────────────────────── */
.skeleton-img {
    width: 100%;
    height: 210px;
    background: linear-gradient(90deg, #ececec 25%, #f5f5f5 50%, #ececec 75%);
    background-size: 200% 100%;
    animation: shimmer 1.4s infinite;
    display: block;
}

@keyframes shimmer {
    0%   { background-position: 200% 0; }
    100% { background-position: -200% 0; }
}

/* ── Card ─────────────────────────────────────────────── */
.card {
    background: #ffffff;
    border-radius: 20px;
    overflow: hidden;
    border: 1px solid rgba(0, 0, 0, 0.08);
    box-shadow: 0 4px 20px rgba(0,0,0,0.04);
    transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1);
    position: relative;
}

.card:hover {
    transform: translateY(-8px);
    box-shadow: 0 14px 35px rgba(0,0,0,0.1);
    border-color: rgba(240, 79, 95, 0.3);
}

.img-wrapper {
    position: relative;
    width: 100%;
    height: 210px;
    overflow: hidden;
    background: #ececec;
}

.img-wrapper img {
    position: absolute;
    top: 0; left: 0;
    width: 100%; height: 100%;
    object-fit: cover;
    opacity: 0;
    transition: opacity 0.4s ease;
}

.img-wrapper img.loaded { opacity: 1; }

/* ── Category badge ───────────────────────────────────── */
.badge {
    position: absolute;
    top: 14px; left: 14px;
    background: rgba(255,255,255,0.92);
    color: #f04f5f;
    font-size: 11px;
    font-weight: 700;
    padding: 6px 12px;
    border-radius: 8px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    backdrop-filter: blur(8px);
    border: 1px solid rgba(0,0,0,0.08);
}

/* ── Card body ────────────────────────────────────────── */
.card-body { padding: 18px 20px 20px; }

.card-body h3 {
    color: #1a1a1a;
    font-size: 18px;
    font-weight: 600;
    margin-bottom: 6px;
}

.description {
    color: #888;
    font-size: 13.5px;
    line-height: 1.6;
    margin-bottom: 16px;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

.card-footer {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 12px;
}

.price {
    color: #f04f5f;
    font-size: 22px;
    font-weight: 800;
}

/* ── Add to Cart Button ──────────────────────────────── */
.add-btn {
    padding: 10px 20px;
    background: #f04f5f;
    color: #fff;
    border: none;
    border-radius: 12px;
    font-size: 14px;
    font-weight: 600;
    font-family: 'Outfit', sans-serif;
    cursor: pointer;
    transition: all 0.3s ease;
    white-space: nowrap;
}

.add-btn:hover {
    background: #ff6b7b;
    transform: scale(1.04);
    box-shadow: 0 8px 20px rgba(240, 79, 95, 0.25);
}

.add-btn.added {
    background: #22c55e;
    animation: pop 0.3s ease;
}

@keyframes pop {
    0%   { transform: scale(1); }
    50%  { transform: scale(1.12); }
    100% { transform: scale(1); }
}

/* ── Empty state ──────────────────────────────────────── */
.empty-state {
    text-align: center;
    padding: 80px 20px;
    color: #aaa;
    grid-column: 1 / -1;
}

.empty-state span { font-size: 56px; display: block; margin-bottom: 16px; }
.empty-state h2   { font-size: 22px; color: #666; font-weight: 600; }

/* ── Toast notification ───────────────────────────────── */
.toast {
    position: fixed;
    bottom: 30px;
    left: 50%;
    transform: translateX(-50%) translateY(80px);
    background: #1a1a1a;
    color: #fff;
    padding: 14px 24px;
    border-radius: 12px;
    font-size: 15px;
    font-weight: 500;
    box-shadow: 0 8px 30px rgba(0,0,0,0.25);
    opacity: 0;
    transition: opacity 0.3s ease, transform 0.3s ease;
    z-index: 999;
    white-space: nowrap;
}

.toast.show {
    opacity: 1;
    transform: translateX(-50%) translateY(0);
}

/* ── Responsive ───────────────────────────────────────── */
@media (max-width: 600px) {
    .header-left h1 { font-size: 26px; }
    .menu-container  { width: 96%; gap: 16px; }
    .cart-btn        { padding: 10px 16px; font-size: 14px; }
}

</style>
</head>
<body>

<%
// Compute cart item count for the badge
User loggedInUser = (User) session.getAttribute("loggedInUser");
int cartItemCount = 0;
if (loggedInUser != null) {
    CartDAOImpl cartDAO = new CartDAOImpl();
    int cartId = cartDAO.getCartId(loggedInUser.getUserId());
    if (cartId != -1) {
        cartItemCount = cartDAO.getCartItemCount(cartId);
    }
}

List<Menu> allMenusByRestaurant = (List<Menu>) request.getAttribute("allMenusByRestaurant");
int restaurantId = 0;
if (allMenusByRestaurant != null && !allMenusByRestaurant.isEmpty()) {
    restaurantId = allMenusByRestaurant.get(0).getRestaurantId();
}
%>


<!-- TOP NAVBAR -->
<nav class="top-nav">
    <a href="<%= request.getContextPath() %>/home" class="nav-logo"><span>🍕</span> Velouraa</a>
    <div class="nav-right">
        <a href="#" class="nav-icon-btn" id="menu-fav-btn" title="Favourites">
            <i class="fa-regular fa-heart"></i> Saved
            <span class="nav-badge" id="menu-fav-badge">0</span>
        </a>
        <a href="<%= request.getContextPath() %>/cart" class="nav-icon-btn" title="My Cart">
            <i class="fa-solid fa-basket-shopping"></i> Cart
            <span class="nav-badge" id="menu-cart-badge" style="<%= cartItemCount > 0 ? "display:flex" : "display:none" %>"><%= cartItemCount %></span>
        </a>
        <%
        User loggedInUser2 = (User) session.getAttribute("loggedInUser");
        if (loggedInUser2 != null) { %>
        <span style="font-size:13px;font-weight:700;color:#1a1a1a;"><i class="fa-regular fa-user" style="color:#f04f5f"></i> <%= loggedInUser2.getUsername() %></span>
        <% } else { %>
        <a href="<%= request.getContextPath() %>/login.html" style="background:#f04f5f;color:white;padding:8px 18px;border-radius:10px;text-decoration:none;font-weight:700;font-size:14px;">Sign In</a>
        <% } %>
    </div>
</nav>

<!-- BACK BAR / HERO -->
<div class="nav-back-bar">
    <a href="<%= request.getContextPath() %>/home" class="back-link"><i class="fa-solid fa-arrow-left"></i> All Restaurants</a>
    <h1 class="bar-title">🍽️ Our Menu</h1>
    <span style="width:140px"></span>
</div>

<div class="menu-container">

<%
if (allMenusByRestaurant != null && !allMenusByRestaurant.isEmpty()) {
    for (Menu menu : allMenusByRestaurant) {
        String imgSrc = menu.getImagePath();
        if (imgSrc == null || imgSrc.trim().isEmpty()) {
            imgSrc = "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=600";
        }
        boolean isExternal = imgSrc.startsWith("http://") || imgSrc.startsWith("https://");
        String finalSrc = isExternal ? imgSrc : (request.getContextPath() + "/" + imgSrc);
%>

<div class="card">
    <div class="img-wrapper">
        <span class="skeleton-img"></span>
        <img
            src="<%= finalSrc %>"
            alt="<%= menu.getItemName() %>"
            loading="lazy"
            onload="this.classList.add('loaded'); this.previousElementSibling.style.display='none';"
            onerror="this.src='https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=600'; this.classList.add('loaded'); this.previousElementSibling.style.display='none';">
    </div>

    <span class="badge"><%= menu.getCategory() %></span>

    <div class="card-body">
        <h3><%= menu.getItemName() %></h3>
        <p class="description"><%= menu.getDescription() != null ? menu.getDescription() : "" %></p>
        <div class="card-footer">
            <span class="price">₹<%= (int) menu.getPrice() %></span>
            <form method="post" action="addToCart" style="margin:0;" onsubmit="handleAddToCart(event, this)">
                <input type="hidden" name="menuId" value="<%= menu.getId() %>">
                <input type="hidden" name="restaurantId" value="<%= menu.getRestaurantId() %>">
                <button type="submit" class="add-btn" id="btn-<%= menu.getId() %>">Add to Cart</button>
            </form>
        </div>
    </div>
</div>

<%
    }
} else {
%>

<div class="empty-state">
    <span>🍽️</span>
    <h2>No menu items found for this restaurant.</h2>
</div>

<% } %>

</div>

<!-- Toast notification -->
<div class="toast" id="toast">🛒 Added to cart!</div>

<script>
function handleAddToCart(event, form) {
    event.preventDefault();
    const btn = form.querySelector('.add-btn');
    btn.classList.add('added');
    btn.textContent = '✓ Added!';
    
    showToast('🛒 Added to cart!');
    
    // Immediately submit to the backend without local storage hack
    setTimeout(() => { form.submit(); }, 400);
}

function updateMenuFavBadge() {
    const favs = JSON.parse(localStorage.getItem('velouraa_favorites')) || {};
    const count = Object.keys(favs).length;
    const badge = document.getElementById('menu-fav-badge');
    if (badge) {
        badge.textContent = count;
        badge.className = count > 0 ? 'nav-badge vis' : 'nav-badge';
        badge.style.background = '#e11d48';
    }
}

function showToast(message) {
    const toast = document.getElementById('toast');
    toast.textContent = message;
    toast.classList.add('show');
    setTimeout(() => toast.classList.remove('show'), 2500);
}

document.addEventListener('DOMContentLoaded', () => {
    updateMenuFavBadge();
    updateMenuFavBadge();
});
</script>

</body>
</html>