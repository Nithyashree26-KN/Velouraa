<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.User" %>
<%
User loggedInUser = (User) session.getAttribute("loggedInUser");
String orderIdStr = request.getParameter("orderId");
int orderId = (orderIdStr != null) ? Integer.parseInt(orderIdStr) : 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Order Confirmed – FreshFetch</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
:root {
    --bg-dark: #faf9f6;
    --surface-dark: #ffffff;
    --surface-light: #f0f0f0;
    --primary: #f04f5f;
    --primary-hover: #ff6b7b;
    --text-main: #1a1a1a;
    --text-muted: #6b7280;
    --border-color: rgba(0, 0, 0, 0.08);
    --success: #059669;
}

body.dark-mode {
    --bg-dark: #0a0a0c;
    --surface-dark: #121318;
    --surface-light: #1c1e26;
    --primary: #f04f5f;
    --primary-hover: #ff6b7b;
    --text-main: #ffffff;
    --text-muted: #9ca3af;
    --border-color: rgba(255, 255, 255, 0.1);
}

* { margin: 0; padding: 0; box-sizing: border-box; }

body {
    font-family: 'Plus Jakarta Sans', sans-serif;
    background-color: var(--bg-dark);
    color: var(--text-main);
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    overflow-x: hidden;
    transition: background-color 0.3s, color 0.3s;
}

/* ── Top Navbar ─────────────────────────────────────── */
.top-nav {
    position: fixed;
    top: 0; left: 0;
    width: 100%;
    height: 70px;
    background: rgba(250,249,246,0.9);
    backdrop-filter: blur(20px);
    border-bottom: 1px solid var(--border-color);
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 5%;
    z-index: 1000;
    box-shadow: 0 2px 20px rgba(0,0,0,0.05);
}
body.dark-mode .top-nav {
    background: rgba(10,10,12,0.9);
}
.nav-logo {
    font-size: 24px;
    font-weight: 800;
    color: var(--text-main);
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
    color: var(--text-muted);
    font-size: 14px;
    font-weight: 600;
    padding: 8px 14px;
    border-radius: 10px;
    border: 1px solid var(--border-color);
    transition: all 0.2s ease;
}
.nav-icon-btn:hover {
    background: rgba(240,79,95,0.06);
    color: #f04f5f;
    border-color: rgba(240,79,95,0.2);
}

/* ── Success Card Container ─────────────────────────── */
.success-container {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 100px 20px 40px;
}

.success-card {
    background: var(--surface-dark);
    border: 1px solid var(--border-color);
    border-radius: 24px;
    width: 100%;
    max-width: 540px;
    padding: 48px 40px;
    text-align: center;
    box-shadow: 0 10px 40px rgba(0,0,0,0.04);
    animation: slideUp 0.6s cubic-bezier(0.16, 1, 0.3, 1) forwards;
}

@keyframes slideUp {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* Animated Success Checkmark */
.checkmark-wrapper {
    width: 100px;
    height: 100px;
    margin: 0 auto 30px;
    background: rgba(5, 150, 105, 0.1);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    animation: scaleIn 0.5s cubic-bezier(0.34, 1.56, 0.64, 1) forwards;
}

.checkmark-icon {
    font-size: 48px;
    color: var(--success);
    animation: popIn 0.3s 0.3s cubic-bezier(0.34, 1.56, 0.64, 1) both;
}

@keyframes scaleIn {
    from { transform: scale(0); opacity: 0; }
    to { transform: scale(1); opacity: 1; }
}

@keyframes popIn {
    from { transform: scale(0); opacity: 0; }
    to { transform: scale(1); opacity: 1; }
}

/* Typography */
.success-card h1 {
    font-size: 28px;
    font-weight: 800;
    margin-bottom: 12px;
    color: var(--text-main);
    letter-spacing: -0.5px;
}

.success-card p.subtitle {
    color: var(--text-muted);
    font-size: 15px;
    line-height: 1.6;
    margin-bottom: 32px;
}

/* Info Details */
.order-details-box {
    background: var(--surface-light);
    border-radius: 16px;
    padding: 20px 24px;
    margin-bottom: 36px;
    text-align: left;
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.detail-row {
    display: flex;
    justify-content: space-between;
    font-size: 14px;
}

.detail-label {
    color: var(--text-muted);
    font-weight: 500;
}

.detail-value {
    color: var(--text-main);
    font-weight: 700;
}

.detail-value.order-id {
    color: var(--primary);
}

/* Action Buttons */
.action-buttons {
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.btn-primary {
    background: linear-gradient(135deg, var(--primary) 0%, #d83445 100%);
    color: #fff;
    border: none;
    padding: 16px;
    border-radius: 14px;
    font-weight: 700;
    font-size: 16px;
    cursor: pointer;
    text-decoration: none;
    box-shadow: 0 4px 15px rgba(240, 79, 95, 0.3);
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
}

.btn-primary:hover {
    box-shadow: 0 6px 20px rgba(240, 79, 95, 0.5);
    transform: translateY(-2px);
}

.btn-secondary {
    background: transparent;
    color: var(--text-main);
    border: 1px solid var(--border-color);
    padding: 16px;
    border-radius: 14px;
    font-weight: 700;
    font-size: 16px;
    cursor: pointer;
    text-decoration: none;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
}

.btn-secondary:hover {
    background: var(--surface-light);
}

/* ── Footer ─────────────────────────────────────────── */
footer {
    text-align: center;
    padding: 30px;
    border-top: 1px solid var(--border-color);
    background: var(--surface-dark);
    font-size: 14px;
    color: var(--text-muted);
}
</style>
</head>
<body>

    <!-- TOP NAVBAR -->
    <nav class="top-nav">
        <a href="<%= request.getContextPath() %>/home" class="nav-logo"><span>🍕</span> FreshFetch</a>
        <div class="nav-right">
            <a href="<%= request.getContextPath() %>/home" class="nav-icon-btn"><i class="fa-solid fa-house"></i> Home</a>
            <a href="#" id="theme-toggle" class="nav-icon-btn" title="Toggle Theme"><i class="fa-solid fa-moon"></i> Theme</a>
        </div>
    </nav>

    <!-- MAIN CONTAINER -->
    <div class="success-container">
        <div class="success-card">
            <div class="checkmark-wrapper">
                <i class="fa-solid fa-circle-check checkmark-icon"></i>
            </div>
            <h1>Order Placed Successfully!</h1>
            <p class="subtitle">Your tasty meal is on its way. Sit back and relax while our kitchen handles the magic!</p>

            <div class="order-details-box">
                <% if (orderId > 0) { %>
                <div class="detail-row">
                    <span class="detail-label">Order Number</span>
                    <span class="detail-value order-id">#<%= orderId %></span>
                </div>
                <% } %>
                <div class="detail-row">
                    <span class="detail-label">Estimated Delivery</span>
                    <span class="detail-value">30 - 45 Mins</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Payment Status</span>
                    <span class="detail-value">Cash on Delivery</span>
                </div>
            </div>

            <div class="action-buttons">
                <a href="<%= request.getContextPath() %>/orderHistory" class="btn-primary">
                    <i class="fa-solid fa-clock-rotate-left"></i> View Order History
                </a>
                <a href="<%= request.getContextPath() %>/home" class="btn-secondary">
                    <i class="fa-solid fa-basket-shopping"></i> Continue Browsing
                </a>
            </div>
        </div>
    </div>

    <!-- FOOTER -->
    <footer>
        <p>&copy; 2026 FreshFetch Express. Delivering happiness to your doorstep.</p>
    </footer>

    <script>
        // --- Theme Toggle Logic ---
        const themeToggleBtn = document.getElementById('theme-toggle');
        const themeIcon = themeToggleBtn.querySelector('i');
        
        function toggleTheme(e) {
            if(e) e.preventDefault();
            document.body.classList.toggle('dark-mode');
            const isDark = document.body.classList.contains('dark-mode');
            localStorage.setItem('velouraa_theme', isDark ? 'dark' : 'light');
            themeIcon.className = isDark ? 'fa-solid fa-sun' : 'fa-solid fa-moon';
        }
        
        themeToggleBtn.addEventListener('click', toggleTheme);
        
        // Load saved theme
        if(localStorage.getItem('velouraa_theme') === 'dark') {
            document.body.classList.add('dark-mode');
            themeIcon.className = 'fa-solid fa-sun';
        }
    </script>
</body>
</html>
