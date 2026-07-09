<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.User, com.tap.model.Restaurant, java.util.List, com.tap.DAOImpl.CartDAOImpl" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FreshFetch | Premium Food Delivery</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- FontAwesome Icons -->
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
            --accent-purple: #8b5cf6;
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

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Plus Jakarta Sans', sans-serif;
            scroll-behavior: smooth;
        }

        body {
            background-color: var(--bg-dark);
            color: var(--text-main);
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* Scrollbar styling */
        ::-webkit-scrollbar {
            width: 8px;
        }
        ::-webkit-scrollbar-track {
            background: var(--bg-dark);
        }
        ::-webkit-scrollbar-thumb {
            background: var(--surface-light);
            border-radius: 4px;
        }
        ::-webkit-scrollbar-thumb:hover {
            background: var(--primary);
        }

        /* ================= NAVBAR ================= */
        nav {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 80px;
            background: rgba(250, 249, 246, 0.85);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-bottom: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 6%;
            z-index: 1000;
            transition: all 0.3s ease;
        }

        .logo {
            font-size: 28px;
            font-weight: 800;
            letter-spacing: -1px;
            color: var(--text-main);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .logo span {
            color: var(--primary);
        }

        .nav-links {
            display: flex;
            align-items: center;
            list-style: none;
            gap: 32px;
        }

        .nav-links li a {
            text-decoration: none;
            color: var(--text-muted);
            font-weight: 600;
            font-size: 15px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .nav-links li a:hover,
        .nav-links li a.active {
            color: var(--text-main);
        }

        /* Cart Badge */
        .cart-link {
            position: relative;
        }

        .cart-badge {
            position: absolute;
            top: -8px;
            right: -10px;
            background: var(--primary);
            color: white;
            font-size: 10px;
            font-weight: 800;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 0 10px rgba(240, 79, 95, 0.5);
        }
        @keyframes badgeBump {
            0%   { transform: scale(1); }
            40%  { transform: scale(1.5); }
            70%  { transform: scale(0.9); }
            100% { transform: scale(1); }
        }
        .cart-badge.bump { animation: badgeBump 0.4s ease; }

        /* Session Buttons */
        .session-container {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .btn-login {
            text-decoration: none;
            background: transparent;
            color: var(--text-main);
            border: 1px solid var(--border-color);
            padding: 10px 20px;
            border-radius: 12px;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .btn-login:hover {
            background: rgba(0, 0, 0, 0.05);
            border-color: var(--text-main);
        }

        .btn-signup {
            text-decoration: none;
            background: linear-gradient(135deg, var(--primary) 0%, #d83445 100%);
            color: white;
            padding: 10px 22px;
            border-radius: 12px;
            font-weight: 700;
            font-size: 14px;
            box-shadow: 0 4px 15px rgba(240, 79, 95, 0.3);
            transition: all 0.3s ease;
        }

        .btn-signup:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(240, 79, 95, 0.5);
        }

        /* Profile Dropdown */
        .profile-container {
            position: relative;
            display: none; /* Controlled by JS session simulation */
            align-items: center;
            gap: 12px;
            cursor: pointer;
            padding: 6px 12px;
            border-radius: 12px;
            background: var(--surface-dark);
            border: 1px solid var(--border-color);
            transition: all 0.3s ease;
        }

        .profile-container:hover {
            background: var(--surface-light);
        }

        .profile-avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary) 0%, var(--accent-purple) 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 14px;
            color: white;
        }

        .profile-info {
            display: flex;
            flex-direction: column;
        }

        .profile-name {
            font-size: 13px;
            font-weight: 700;
            color: var(--text-main);
        }

        .profile-role {
            font-size: 10px;
            color: var(--text-muted);
        }

        .profile-dropdown {
            position: absolute;
            top: 55px;
            right: 0;
            width: 200px;
            background: var(--surface-dark);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.5);
            display: none;
            flex-direction: column;
            overflow: hidden;
            z-index: 1001;
        }

        .profile-dropdown a {
            padding: 12px 16px;
            text-decoration: none;
            color: var(--text-muted);
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .profile-dropdown a:hover {
            background: var(--surface-light);
            color: var(--text-main);
        }

        .profile-dropdown .logout-item {
            border-top: 1px solid var(--border-color);
            color: var(--primary);
        }

        /* ================= HERO SECTION ================= */
        .hero {
            margin-top: 132px;
            padding: 70px 6% 50px 6%;
            background: radial-gradient(circle at 70% 30%, rgba(240, 79, 95, 0.08) 0%, transparent 60%),
                        radial-gradient(circle at 10% 80%, rgba(139, 92, 246, 0.05) 0%, transparent 50%);
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }

        .hero h1 {
            font-size: 52px;
            font-weight: 800;
            letter-spacing: -1.5px;
            line-height: 1.1;
            margin-bottom: 20px;
            max-width: 800px;
        }

        .hero h1 span {
            background: linear-gradient(135deg, var(--primary) 0%, #ff8b97 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .hero p {
            color: var(--text-muted);
            font-size: 18px;
            max-width: 600px;
            margin-bottom: 40px;
            font-weight: 400;
        }

        /* Search & Filters */
        .search-container {
            width: 100%;
            max-width: 650px;
            background: var(--surface-dark);
            border: 1px solid var(--border-color);
            padding: 8px 8px 8px 24px;
            border-radius: 100px;
            display: flex;
            align-items: center;
            gap: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            margin-bottom: 40px;
            transition: all 0.3s ease;
        }

        .search-container:focus-within {
            border-color: var(--primary);
            box-shadow: 0 0 20px rgba(240, 79, 95, 0.2);
        }

        .search-container i {
            color: var(--text-muted);
            font-size: 18px;
        }

        .search-container input {
            flex: 1;
            background: transparent;
            border: none;
            outline: none;
            color: var(--text-main);
            font-size: 16px;
            font-weight: 500;
        }

        .search-container input::placeholder {
            color: #626a7a;
        }

        .search-btn {
            background: var(--primary);
            color: white;
            border: none;
            padding: 12px 28px;
            border-radius: 100px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .search-btn:hover {
            background: var(--primary-hover);
        }

        /* Quick Filters */
        .filters-container {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            justify-content: center;
        }

        .filter-btn {
            background: var(--surface-dark);
            border: 1px solid var(--border-color);
            color: var(--text-muted);
            padding: 8px 18px;
            border-radius: 100px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .filter-btn:hover,
        .filter-btn.active {
            background: var(--surface-light);
            color: var(--text-main);
            border-color: var(--text-muted);
        }

        /* ================= RESTAURANT SECTION ================= */
        .main-content {
            padding: 0 6% 80px 6%;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
        }

        .section-title {
            font-size: 26px;
            font-weight: 800;
            letter-spacing: -0.5px;
        }

        .section-subtitle {
            color: var(--text-muted);
            font-size: 14px;
            margin-top: 4px;
        }

        .restaurants-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(310px, 1fr));
            gap: 32px;
        }

        /* Anchor wrappers are direct grid children — must be block so grid places them correctly */
        .restaurants-grid > a {
            display: block;
            text-decoration: none;
            color: inherit;
        }

        /* Card fills its anchor wrapper completely */
        .restaurants-grid > a .restaurant-card {
            height: 100%;
        }

        /* Card Styles */
        .restaurant-card {
            background: var(--surface-dark);
            border-radius: 20px;
            overflow: hidden;
            border: 1px solid var(--border-color);
            transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1);
            position: relative;
            display: flex;
            flex-direction: column;
        }

        .restaurant-card:hover {
            transform: translateY(-6px);
            border-color: rgba(240, 79, 95, 0.3);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.6), 0 0 0 1px rgba(240, 79, 95, 0.1);
        }

        .image-wrapper {
            position: relative;
            width: 100%;
            height: 200px;
            overflow: hidden;
        }

        .image-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.6s ease;
        }

        .restaurant-card:hover .image-wrapper img {
            transform: scale(1.08);
        }

        .badge-promo {
            position: absolute;
            top: 15px;
            left: 15px;
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(8px);
            border: 1px solid var(--border-color);
            color: var(--text-main);
            padding: 6px 12px;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 700;
            z-index: 10;
        }

        .card-body {
            padding: 24px;
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 8px;
        }

        .restaurant-name {
            font-size: 19px;
            font-weight: 700;
            color: var(--text-main);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .cuisine {
            color: var(--text-muted);
            font-size: 14px;
            margin-bottom: 16px;
            font-weight: 500;
        }

        .card-stats {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding-top: 16px;
            border-top: 1px solid var(--border-color);
            margin-bottom: 20px;
        }

        .rating-box {
            background: rgba(0, 177, 115, 0.15);
            color: var(--success);
            padding: 4px 10px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .rating-box.low {
            background: rgba(240, 79, 95, 0.15);
            color: var(--primary);
        }

        .delivery-time {
            font-size: 13px;
            color: var(--text-muted);
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .price-info {
            font-size: 13px;
            color: var(--text-main);
            font-weight: 700;
        }

        .address {
            color: var(--text-muted);
            font-size: 13px;
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .btn-order {
            width: 100%;
            background: var(--surface-light);
            color: var(--text-main);
            border: 1px solid var(--border-color);
            padding: 12px;
            border-radius: 12px;
            font-weight: 700;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            margin-top: auto;
        }

        .btn-order:hover {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
            box-shadow: 0 8px 20px rgba(240, 79, 95, 0.25);
        }

        /* ================= FOOTER ================= */
        footer {
            background-color: var(--surface-dark);
            border-top: 1px solid var(--border-color);
            padding: 60px 6% 30px 6%;
        }

        .footer-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 40px;
            margin-bottom: 40px;
        }

        .footer-brand h2 {
            font-size: 24px;
            font-weight: 800;
            margin-bottom: 16px;
        }

        .footer-brand h2 span {
            color: var(--primary);
        }

        .footer-brand p {
            color: var(--text-muted);
            font-size: 14px;
            line-height: 1.6;
        }

        .footer-column h4 {
            font-size: 16px;
            font-weight: 700;
            margin-bottom: 20px;
            color: var(--text-main);
        }

        .footer-column ul {
            list-style: none;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .footer-column ul li a {
            text-decoration: none;
            color: var(--text-muted);
            font-size: 14px;
            transition: color 0.2s;
        }

        .footer-column ul li a:hover {
            color: var(--text-main);
        }

        .footer-bottom {
            border-top: 1px solid var(--border-color);
            padding-top: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .copyright {
            color: var(--text-muted);
            font-size: 14px;
        }

        .social-icons {
            display: flex;
            gap: 16px;
        }

        .social-icons a {
            color: var(--text-muted);
            font-size: 18px;
            transition: color 0.2s;
        }

        .social-icons a:hover {
            color: var(--primary);
        }

        /* Animations */
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }

        /* ================= PROMO BANNER (TICKER) ================= */
        .promo-banner {
            position: fixed;
            top: 80px;
            left: 0;
            width: 100%;
            background: linear-gradient(90deg, #e8192c 0%, #c0392b 25%, #8b1a1a 50%, #c0392b 75%, #e8192c 100%);
            background-size: 400% 100%;
            animation: bannerShift 8s linear infinite;
            z-index: 999;
            overflow: hidden;
            height: 52px;
            display: flex;
            align-items: center;
            box-shadow: 0 4px 20px rgba(232,25,44,0.4);
        }
        @keyframes bannerShift {
            0%   { background-position: 0% 50%; }
            100% { background-position: 400% 50%; }
        }
        .promo-ticker {
            display: flex;
            white-space: nowrap;
            animation: tickerScroll 35s linear infinite;
            align-items: center;
            gap: 0;
        }
        .promo-ticker:hover { animation-play-state: paused; }
        @keyframes tickerScroll {
            0%   { transform: translateX(0); }
            100% { transform: translateX(-50%); }
        }
        .promo-item {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 0 50px;
            color: white;
            font-size: 14px;
            font-weight: 700;
            letter-spacing: 0.4px;
            border-right: 1px solid rgba(255,255,255,0.2);
        }
        .promo-item .tag {
            background: rgba(255,255,255,0.2);
            border-radius: 4px;
            padding: 3px 10px;
            font-size: 12px;
            letter-spacing: 0.6px;
            text-transform: uppercase;
        }
        .promo-item .dot {
            width: 5px;
            height: 5px;
            background: rgba(255,255,255,0.5);
            border-radius: 50%;
            display: inline-block;
        }

        /* ================= FOOD CATEGORY CARDS ================= */
        .category-section {
            padding: 28px 6% 10px;
            background: var(--bg-dark);
        }
        .category-title {
            font-size: 16px;
            font-weight: 700;
            color: var(--text-muted);
            margin-bottom: 18px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .category-scroll {
            display: flex;
            gap: 18px;
            overflow-x: auto;
            padding-bottom: 12px;
            scrollbar-width: none;
        }
        .category-scroll::-webkit-scrollbar { display: none; }
        .cat-card {
            flex: 0 0 auto;
            width: 130px;
            border-radius: 16px;
            overflow: hidden;
            cursor: pointer;
            position: relative;
            box-shadow: 0 4px 16px rgba(0,0,0,0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: 2px solid transparent;
            text-decoration: none;
        }
        .cat-card:hover {
            transform: translateY(-5px) scale(1.03);
            box-shadow: 0 14px 30px rgba(0,0,0,0.2);
            border-color: var(--primary);
        }
        .cat-card img {
            width: 100%;
            height: 90px;
            object-fit: cover;
            display: block;
            transition: transform 0.4s ease;
        }
        .cat-card:hover img { transform: scale(1.08); }
        .cat-label {
            background: white;
            text-align: center;
            padding: 8px 6px;
            font-size: 13px;
            font-weight: 700;
            color: var(--text-main);
        }
        .cat-card.active-cat {
            border-color: var(--primary);
        }
        .cat-card.active-cat .cat-label {
            background: var(--primary);
            color: white;
        }

        /* ================= FAVORITES ================= */
        .fav-btn {
            position: absolute;
            top: 12px;
            right: 12px;
            width: 36px;
            height: 36px;
            background: rgba(255,255,255,0.9);
            backdrop-filter: blur(8px);
            border: none;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            z-index: 20;
            transition: all 0.25s ease;
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
        }
        .fav-btn:hover { transform: scale(1.15); }
        .fav-btn i {
            font-size: 16px;
            color: #ccc;
            transition: color 0.25s ease, transform 0.25s ease;
        }
        .fav-btn.active i {
            color: #f04f5f;
            transform: scale(1.2);
        }
        .fav-btn.pop { animation: favPop 0.35s ease; }
        @keyframes favPop {
            0%   { transform: scale(1); }
            50%  { transform: scale(1.4); }
            100% { transform: scale(1); }
        }

        /* ================= REVIEW BUTTON & MODAL ================= */
        .btn-review {
            background: none;
            border: 1px solid var(--border-color);
            border-radius: 10px;
            padding: 8px 14px;
            font-size: 13px;
            font-weight: 600;
            color: var(--text-muted);
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            gap: 6px;
            margin-bottom: 10px;
        }
        .btn-review:hover {
            background: var(--surface-light);
            color: var(--text-main);
            border-color: var(--text-main);
        }
        .btn-review .star-preview { color: #f59e0b; font-size: 12px; }

        /* Review Modal */
        .review-modal-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.5);
            backdrop-filter: blur(4px);
            z-index: 2000;
            align-items: center;
            justify-content: center;
        }
        .review-modal-overlay.open { display: flex; }
        .review-modal {
            background: var(--surface-dark);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 32px;
            width: 420px;
            max-width: 95vw;
            box-shadow: 0 30px 80px rgba(0,0,0,0.4);
            animation: slideUp 0.3s ease;
        }
        @keyframes slideUp {
            from { transform: translateY(30px); opacity: 0; }
            to   { transform: translateY(0); opacity: 1; }
        }
        .review-modal h3 { font-size: 20px; font-weight: 800; margin-bottom: 6px; color: var(--text-main); }
        .review-modal .subtitle { color: var(--text-muted); font-size: 14px; margin-bottom: 24px; }
        .star-selector {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        .star-selector i {
            font-size: 32px;
            color: #ddd;
            cursor: pointer;
            transition: all 0.15s ease;
        }
        .star-selector i.lit { color: #f59e0b; }
        .star-selector i:hover { transform: scale(1.2); }
        .review-textarea {
            width: 100%;
            min-height: 100px;
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 12px 16px;
            font-family: inherit;
            font-size: 14px;
            color: var(--text-main);
            background: var(--bg-dark);
            resize: none;
            outline: none;
            margin-bottom: 20px;
            transition: border-color 0.2s;
        }
        .review-textarea:focus { border-color: var(--primary); }
        .review-modal-actions { display: flex; gap: 12px; justify-content: flex-end; }
        .btn-modal-cancel {
            padding: 10px 20px;
            border-radius: 10px;
            border: 1px solid var(--border-color);
            background: none;
            color: var(--text-muted);
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s;
        }
        .btn-modal-cancel:hover { background: var(--surface-light); color: var(--text-main); }
        .btn-modal-submit {
            padding: 10px 24px;
            border-radius: 10px;
            border: none;
            background: linear-gradient(135deg, var(--primary) 0%, #d83445 100%);
            color: white;
            font-weight: 700;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(240,79,95,0.3);
        }
        .btn-modal-submit:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(240,79,95,0.5); }

        /* Toast notification */
        .toast-notification {
            position: fixed;
            bottom: 30px;
            left: 50%;
            transform: translateX(-50%) translateY(20px);
            background: #1a1a1a;
            color: white;
            padding: 12px 24px;
            border-radius: 12px;
            font-weight: 600;
            font-size: 14px;
            z-index: 9999;
            opacity: 0;
            pointer-events: none;
            transition: all 0.35s ease;
            box-shadow: 0 8px 30px rgba(0,0,0,0.4);
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .toast-notification.show {
            opacity: 1;
            transform: translateX(-50%) translateY(0);
        }

        /* ================= RESPONSIVE ================= */
        @media (max-width: 900px) {
            .hero h1 {
                font-size: 40px;
            }
            .nav-links {
                display: none; /* simple responsive fallback */
            }
        }
    </style>
</head>
<body>

    <%
    // Compute cart item count for the badge from the backend DB
    User sessionUser = (User) session.getAttribute("loggedInUser");
    int cartItemCount = 0;
    if (sessionUser != null) {
        CartDAOImpl cartDAO = new CartDAOImpl();
        int cartId = cartDAO.getCartId(sessionUser.getUserId());
        if (cartId != -1) {
            cartItemCount = cartDAO.getCartItemCount(cartId);
        }
    }
    %>

    <!-- PROMO BANNER -->
    <div class="promo-banner" id="promo-banner">
        <div class="promo-ticker">
            <span class="promo-item"><span class="tag">🔥 HOT</span> 50% OFF on your first order — Use code <strong>VELOURAA50</strong> <span class="dot"></span></span>
            <span class="promo-item"><span class="tag">🚀 FAST</span> Free delivery on orders above ₹299 <span class="dot"></span></span>
            <span class="promo-item"><span class="tag">⭐ NEW</span> Try Sushi Kai — Bangalore's top-rated Japanese restaurant <span class="dot"></span></span>
            <span class="promo-item"><span class="tag">🍕 DEAL</span> Buy 1 Get 1 on all pizzas every Tuesday <span class="dot"></span></span>
            <span class="promo-item"><span class="tag">💚 HEALTH</span> 20% off on all salads at The Green Bowl this weekend <span class="dot"></span></span>
            <span class="promo-item"><span class="tag">🍗 KFC</span> 12-piece bucket for just ₹399 — Limited time! <span class="dot"></span></span>
            <!-- Duplicate for seamless loop -->
            <span class="promo-item"><span class="tag">🔥 HOT</span> 50% OFF on your first order — Use code <strong>VELOURAA50</strong> <span class="dot"></span></span>
            <span class="promo-item"><span class="tag">🚀 FAST</span> Free delivery on orders above ₹299 <span class="dot"></span></span>
            <span class="promo-item"><span class="tag">⭐ NEW</span> Try Sushi Kai — Bangalore's top-rated Japanese restaurant <span class="dot"></span></span>
            <span class="promo-item"><span class="tag">🍕 DEAL</span> Buy 1 Get 1 on all pizzas every Tuesday <span class="dot"></span></span>
            <span class="promo-item"><span class="tag">💚 HEALTH</span> 20% off on all salads at The Green Bowl this weekend <span class="dot"></span></span>
            <span class="promo-item"><span class="tag">🍗 KFC</span> 12-piece bucket for just ₹399 — Limited time! <span class="dot"></span></span>
        </div>
    </div>

    <!-- NAVBAR -->
    <nav>
        <a href="<%= request.getContextPath() %>/home" class="logo">
            <span>🍕</span> FreshFetch
        </a>

        <ul class="nav-links">
            <li><a href="<%= request.getContextPath() %>/home" class="active"><i class="fa-solid fa-house"></i> Home</a></li>
            <li><a href="#"><i class="fa-solid fa-compass"></i> Explore</a></li>
            <li><a href="#"><i class="fa-solid fa-percent"></i> Offers</a></li>
            <li>
                <a href="<%= request.getContextPath() %>/cart" class="cart-link" id="cart-nav-link">
                    <i class="fa-solid fa-basket-shopping"></i> Cart
                    <span class="cart-badge" id="cart-counter" style="<%= cartItemCount > 0 ? "display:flex" : "display:none" %>"><%= cartItemCount %></span>
                </a>
            </li>
            <li>
                <a href="#" class="cart-link" id="fav-nav-trigger" title="My Favourites">
                    <i class="fa-regular fa-heart"></i> Saved
                    <span class="cart-badge" id="fav-counter" style="display:none;background:#e11d48">0</span>
                </a>
            </li>
            <li>
                <a href="#" id="theme-toggle" class="cart-link" title="Toggle Theme">
                    <i class="fa-solid fa-moon"></i> Theme
                </a>
            </li>
        </ul>

        <div class="session-container">
            <%
            User user = (User) session.getAttribute("loggedInUser");
            if (user == null) {
            %>
            <!-- Guest Buttons -->
            <div id="guest-controls" style="display: flex; gap: 12px; align-items: center;">
                <a href="<%= request.getContextPath() %>/login.html" class="btn-login">Sign In</a>
                <a href="<%= request.getContextPath() %>/registration.html" class="btn-signup">Sign Up</a>
            </div>
            <%
            } else {
            %>
            <!-- Profile dropdown (real session) -->
            <div class="profile-container" id="profile-controls" style="display: flex;">
                <div class="profile-avatar" id="avatar-letters"><%= user.getUsername().substring(0, Math.min(2, user.getUsername().length())).toUpperCase() %></div>
                <div class="profile-info">
                    <span class="profile-name" id="profile-display-name"><%= user.getUsername() %></span>
                    <span class="profile-role">Premium Member</span>
                </div>
                <i class="fa-solid fa-chevron-down" style="font-size: 10px; color: var(--text-muted);"></i>
                
                <div class="profile-dropdown" id="dropdown-menu">
                    <a href="#"><i class="fa-regular fa-user"></i> My Profile</a>
                    <a href="#"><i class="fa-solid fa-clock-rotate-left"></i> My Orders</a>
                    <a href="#"><i class="fa-regular fa-heart"></i> Favourites</a>
                    <a href="#" class="logout-item" id="logout-btn"><i class="fa-solid fa-right-from-bracket"></i> Sign Out</a>
                </div>
            </div>
            <%
            }
            %>
        </div>
    </nav>

    <!-- HERO SECTION -->
    <section class="hero">
        <h1>Premium Food, Delivered <span>Blazing Fast</span></h1>
        <p>Order from the finest restaurants near you. Handpicked choices, incredible deals, and elite service.</p>
        
        <div class="search-container">
            <i class="fa-solid fa-magnifying-glass"></i>
            <input type="text" id="restaurant-search" placeholder="Search for restaurants, cuisines, or locations...">
            <button class="search-btn" onclick="filterRestaurants()">Find Food</button>
        </div>

        <div class="filters-container">
            <button class="filter-btn active" data-filter="all"><i class="fa-solid fa-border-all"></i> All</button>
            <button class="filter-btn" data-filter="top-rated"><i class="fa-solid fa-star"></i> Top Rated (4.5+)</button>
            <button class="filter-btn" data-filter="fast"><i class="fa-solid fa-bolt"></i> Fast Delivery</button>
            <button class="filter-btn" data-filter="budget"><i class="fa-solid fa-indian-rupee-sign"></i> Budget Friendly</button>
        </div>
    </section>

    <!-- FOOD CATEGORY CARDS (Zomato-style) -->
    <section class="category-section">
        <p class="category-title">🍽️ What's on your mind?</p>
        <div class="category-scroll" id="category-scroll">
            <a class="cat-card" data-cuisine="biryani" onclick="filterByCuisine('biryani', this); return false;" href="#">
                <img src="https://images.unsplash.com/photo-1631515243349-e0cb75fb8d3a?w=300" alt="Biryani" loading="lazy">
                <div class="cat-label">Biryani</div>
            </a>
            <a class="cat-card" data-cuisine="pizza" onclick="filterByCuisine('pizza', this); return false;" href="#">
                <img src="https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=300" alt="Pizza" loading="lazy">
                <div class="cat-label">Pizza</div>
            </a>
            <a class="cat-card" data-cuisine="burger" onclick="filterByCuisine('burger', this); return false;" href="#">
                <img src="https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=300" alt="Burgers" loading="lazy">
                <div class="cat-label">Burgers</div>
            </a>
            <a class="cat-card" data-cuisine="north indian" onclick="filterByCuisine('north indian', this); return false;" href="#">
                <img src="https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=300" alt="North Indian" loading="lazy">
                <div class="cat-label">North Indian</div>
            </a>
            <a class="cat-card" data-cuisine="chicken" onclick="filterByCuisine('chicken', this); return false;" href="#">
                <img src="https://images.unsplash.com/photo-1626645738196-c2a7c87a8f58?w=300" alt="Chicken" loading="lazy">
                <div class="cat-label">Chicken</div>
            </a>
            <a class="cat-card" data-cuisine="south indian" onclick="filterByCuisine('south indian', this); return false;" href="#">
                <img src="https://images.unsplash.com/photo-1610192244261-3f33de3f55e4?w=300" alt="South Indian" loading="lazy">
                <div class="cat-label">South Indian</div>
            </a>
            <a class="cat-card" data-cuisine="sushi" onclick="filterByCuisine('sushi', this); return false;" href="#">
                <img src="https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=300" alt="Sushi" loading="lazy">
                <div class="cat-label">Sushi</div>
            </a>
            <a class="cat-card" data-cuisine="healthy" onclick="filterByCuisine('healthy', this); return false;" href="#">
                <img src="https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=300" alt="Healthy" loading="lazy">
                <div class="cat-label">Healthy</div>
            </a>
            <a class="cat-card" data-cuisine="continental" onclick="filterByCuisine('continental', this); return false;" href="#">
                <img src="https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=300" alt="Continental" loading="lazy">
                <div class="cat-label">Continental</div>
            </a>
            <a class="cat-card" data-cuisine="asian" onclick="filterByCuisine('asian', this); return false;" href="#">
                <img src="https://images.unsplash.com/photo-1563245372-f21724e3856d?w=300" alt="Asian" loading="lazy">
                <div class="cat-label">Asian Bowls</div>
            </a>
        </div>
    </section>

    <!-- RESTAURANT LISTINGS -->
    <main class="main-content">
        <div class="section-header">
            <div>
                <h2 class="section-title">Popular Restaurants in your area</h2>
                <p class="section-subtitle">Discover culinary experiences curated just for you</p>
            </div>
        </div>
        <div class="restaurants-grid" id="restaurants-container">
        
           <%
                     List<Restaurant> allRestaurants = (List<Restaurant>)request.getAttribute("allRestaurants");
                     if (allRestaurants == null) {
                         response.sendRedirect(request.getContextPath() + "/RestaurantServlet");
                         return;
                     }
                                    for (Restaurant restaurant : allRestaurants) 
                                    {
                                    	
                                    	
                                 	   %>
                                 	     
                                 	     
<a href="menu?restaurantId=<%= restaurant.getId() %>">                                 	   
                                 	   
                                 	   
                                 	   
                                 	   <!-- Restaurant Card (Dynamic) -->
                                        <div class="restaurant-card"
                                             data-rating="<%= restaurant.getRating() %>"
                                             data-time="<%= restaurant.getDeliveryTime() %>"
                                             data-price="<%= restaurant.getPriceForTwo() %>"
                                             data-cuisine="<%= restaurant.getCuisineType() %>">
                                            <div class="image-wrapper">
                                                <div class="badge-promo">Free Delivery</div>
                                                <img src="<%= restaurant.getImagePath() %>" alt="<%= restaurant.getName() %>"
                                                     onerror="this.src='<%= request.getContextPath() %>/images/restaurants/pizza_heaven.png'">
                                                <button class="fav-btn" data-id="<%= restaurant.getId() %>" onclick="toggleFavorite(this, <%= restaurant.getId() %>, '<%= restaurant.getName().replace("'", "\\'" ) %>', event)"
                                                        title="Save to Favorites">
                                                    <i class="fa-regular fa-heart"></i>
                                                </button>
                                            </div>
                                           <div class="card-body">
                                               <div class="card-header">
                                                   <h3 class="restaurant-name"><%= restaurant.getName() %></h3>
                                                   <div class="rating-box <%= restaurant.getRating() >= 4.0 ? "" : "low" %>">
                                                       <i class="fa-solid fa-star"></i> <%= restaurant.getRating() %>
                                                   </div>
                                               </div>
                                               <p class="cuisine"><%= restaurant.getCuisineType() %></p>
                                               <p class="address"><i class="fa-solid fa-location-dot"></i> <%= restaurant.getAddress() %></p>
                                               <div class="card-stats">
                                                    <span class="delivery-time"><i class="fa-regular fa-clock"></i> <%= restaurant.getDeliveryTime() %> mins</span>
                                                    <span class="price-info">₹<%= restaurant.getPriceForTwo() %> for two</span>
                                                </div>
                                                <button class="btn-review" onclick="openReviewModal(<%= restaurant.getId() %>, '<%= restaurant.getName().replace("'", "\\'" ) %>', event)">
                                                    <i class="fa-regular fa-star star-preview"></i> Rate & Review
                                                </button>
                                                <button class="btn-order" onclick="addToCart('<%= restaurant.getName() %>', '<%= restaurant.getCuisineType() %>', <%= restaurant.getPriceForTwo() / 2 %>)">
                                                   <i class="fa-solid fa-plus"></i> Order Now
                                               </button>
                                           </div>
                                       </div>

                                	   </a>
                               <% 	   

                    		        }
                    %>   
        
        
        </div><!-- END restaurants-grid -->
            
          
            </main>

    <!-- REVIEW MODAL -->
    <div class="review-modal-overlay" id="review-modal-overlay">
        <div class="review-modal" id="review-modal">
            <h3 id="review-modal-title">Rate Restaurant</h3>
            <p class="subtitle" id="review-modal-subtitle">Share your experience</p>
            <div class="star-selector" id="star-selector">
                <i class="fa-regular fa-star" data-val="1"></i>
                <i class="fa-regular fa-star" data-val="2"></i>
                <i class="fa-regular fa-star" data-val="3"></i>
                <i class="fa-regular fa-star" data-val="4"></i>
                <i class="fa-regular fa-star" data-val="5"></i>
            </div>
            <textarea class="review-textarea" id="review-text" placeholder="Tell others what you think (optional)..."></textarea>
            <div class="review-modal-actions">
                <button class="btn-modal-cancel" onclick="closeReviewModal()">Cancel</button>
                <button class="btn-modal-submit" onclick="submitReview()"><i class="fa-solid fa-paper-plane"></i> Submit Review</button>
            </div>
        </div>
    </div>

    <!-- TOAST NOTIFICATION -->
    <div class="toast-notification" id="toast"></div>



    <!-- FOOTER -->
    <footer>
        <div class="footer-grid">
            <div class="footer-brand">
                <h2>🍕 <span>FreshFetch</span></h2>
                <p>FreshFetch Express delivers your favorite cuisines straight from the finest culinary spaces to your doorstep in minutes. Experience premium food delivery.</p>
            </div>
            <div class="footer-column">
                <h4>Contact Us</h4>
                <ul>
                    <li><a href="#">Help & Support</a></li>
                    <li><a href="#">Partner with us</a></li>
                    <li><a href="#">Ride with us</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h4>Legal</h4>
                <ul>
                    <li><a href="#">Terms & Conditions</a></li>
                    <li><a href="#">Refund & Cancellation</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                    <li><a href="#">Cookie Policy</a></li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom">
            <p class="copyright">&copy; 2026 FreshFetch. All rights reserved.</p>
            <div class="social-icons">
                <a href="#"><i class="fa-brands fa-facebook"></i></a>
                <a href="#"><i class="fa-brands fa-instagram"></i></a>
                <a href="#"><i class="fa-brands fa-x-twitter"></i></a>
            </div>
        </div>
    </footer>

    <!-- INTERACTIVE JAVASCRIPT FOR CART AND SESSIONS -->
    <script>
        // --- Session Management ---
        document.addEventListener('DOMContentLoaded', () => {
            // Sync server session with localStorage
            <% if (session.getAttribute("loggedInUser") != null) { 
                 User u = (User) session.getAttribute("loggedInUser");
            %>
                 const userData = { username: "<%= u.getUsername() %>", email: "<%= u.getEmail() %>" };
                 localStorage.setItem('loggedInUser', JSON.stringify(userData));
            <% } else { %>
                 localStorage.removeItem('loggedInUser');
            <% } %>

            let user = localStorage.getItem('loggedInUser');
            
            const guestControls = document.getElementById('guest-controls');
            const profileControls = document.getElementById('profile-controls');
            const profileDisplayName = document.getElementById('profile-display-name');
            const avatarLetters = document.getElementById('avatar-letters');

            // Click Profile toggles dropdown
            if (profileControls) {
                profileControls.addEventListener('click', (e) => {
                    e.stopPropagation();
                    const dropdown = document.getElementById('dropdown-menu');
                    dropdown.style.display = dropdown.style.display === 'flex' ? 'none' : 'flex';
                });
            }

            // Close dropdown when clicking outside
            document.addEventListener('click', () => {
                const dropdown = document.getElementById('dropdown-menu');
                if(dropdown) dropdown.style.display = 'none';
            });

            if (user) {
                const userData = JSON.parse(user);
                if (profileDisplayName) profileDisplayName.textContent = userData.username || 'User';
                if (avatarLetters) avatarLetters.textContent = (userData.username || 'U').substring(0, 2).toUpperCase();
                if (guestControls) guestControls.style.display = 'none';
                if (profileControls) profileControls.style.display = 'flex';
            } else {
                if (guestControls) guestControls.style.display = 'flex';
                if (profileControls) profileControls.style.display = 'none';
            }
            
            // Sign out action
            const logoutBtn = document.getElementById('logout-btn');
            if (logoutBtn) {
                logoutBtn.addEventListener('click', (e) => {
                    e.preventDefault();
                    // Clear cart on logout
                    localStorage.removeItem('velouraa_cart');
                    // Redirect to login page or handle servlet session logout
                    window.location.href = 'login.html'; 
                });
            }

            // Load Saved Cart and Favorites on page ready
            renderCart();
            loadFavorites();
        });



        // =============================================
        // FAVORITES
        // =============================================
        let favorites = JSON.parse(localStorage.getItem('velouraa_favorites')) || {};

        function toggleFavorite(btn, id, name, e) {
            if (e) { e.preventDefault(); e.stopPropagation(); }
            if (favorites[id]) {
                delete favorites[id];
                btn.classList.remove('active');
                btn.querySelector('i').className = 'fa-regular fa-heart';
                showToast('💔 Removed from favorites');
            } else {
                favorites[id] = { id, name };
                btn.classList.add('active', 'pop');
                btn.querySelector('i').className = 'fa-solid fa-heart';
                showToast('❤️ Saved to favorites!');
                setTimeout(() => btn.classList.remove('pop'), 400);
            }
            localStorage.setItem('velouraa_favorites', JSON.stringify(favorites));
        }

        function loadFavorites() {
            document.querySelectorAll('.fav-btn').forEach(btn => {
                const id = parseInt(btn.dataset.id);
                if (favorites[id]) {
                    btn.classList.add('active');
                    btn.querySelector('i').className = 'fa-solid fa-heart';
                }
            });
        }

        // =============================================
        // REVIEWS
        // =============================================
        let currentReviewRestId = null;
        let selectedRating = 0;

        function openReviewModal(id, name, e) {
            if (e) { e.preventDefault(); e.stopPropagation(); }
            currentReviewRestId = id;
            selectedRating = 0;
            document.getElementById('review-modal-title').textContent = 'Rate ' + name;
            document.getElementById('review-modal-subtitle').textContent = 'Share your experience at ' + name;
            document.getElementById('review-text').value = '';
            resetStars();
            document.getElementById('review-modal-overlay').classList.add('open');
        }

        function closeReviewModal() {
            document.getElementById('review-modal-overlay').classList.remove('open');
            currentReviewRestId = null;
        }

        function resetStars() {
            document.querySelectorAll('#star-selector i').forEach(s => {
                s.className = 'fa-regular fa-star';
                s.classList.remove('lit');
            });
            selectedRating = 0;
        }

        document.querySelectorAll('#star-selector i').forEach(star => {
            star.addEventListener('mouseover', () => {
                const val = parseInt(star.dataset.val);
                document.querySelectorAll('#star-selector i').forEach((s, i) => {
                    if (i < val) { s.className = 'fa-solid fa-star lit'; }
                    else { s.className = 'fa-regular fa-star'; s.classList.remove('lit'); }
                });
            });
            star.addEventListener('mouseout', () => {
                document.querySelectorAll('#star-selector i').forEach((s, i) => {
                    if (i < selectedRating) { s.className = 'fa-solid fa-star lit'; }
                    else { s.className = 'fa-regular fa-star'; s.classList.remove('lit'); }
                });
            });
            star.addEventListener('click', () => {
                selectedRating = parseInt(star.dataset.val);
                document.querySelectorAll('#star-selector i').forEach((s, i) => {
                    if (i < selectedRating) { s.className = 'fa-solid fa-star lit'; }
                    else { s.className = 'fa-regular fa-star'; s.classList.remove('lit'); }
                });
            });
        });

        document.getElementById('review-modal-overlay').addEventListener('click', function(e) {
            if (e.target === this) closeReviewModal();
        });

        function submitReview() {
            if (selectedRating === 0) { showToast('⭐ Please select a rating!'); return; }
            const text = document.getElementById('review-text').value.trim();
            // Store review locally
            let reviews = JSON.parse(localStorage.getItem('velouraa_reviews')) || {};
            if (!reviews[currentReviewRestId]) reviews[currentReviewRestId] = [];
            reviews[currentReviewRestId].push({
                rating: selectedRating,
                text: text,
                date: new Date().toLocaleDateString('en-IN')
            });
            localStorage.setItem('velouraa_reviews', JSON.stringify(reviews));
            closeReviewModal();
            showToast('✅ Thank you for your review!');
        }

        // =============================================
        // TOAST
        // =============================================
        let toastTimer;
        function showToast(msg) {
            const toast = document.getElementById('toast');
            toast.textContent = msg;
            toast.classList.add('show');
            clearTimeout(toastTimer);
            toastTimer = setTimeout(() => toast.classList.remove('show'), 2500);
        }


        // --- Live Search and Filter Logic ---
        const searchInput = document.getElementById('restaurant-search');
        const cards = document.querySelectorAll('.restaurant-card');
        
        let showFavoritesOnly = false;
        
        function filterRestaurants() {
            const query = searchInput.value.toLowerCase().trim();
            const activeFilter = document.querySelector('.filter-btn.active').dataset.filter;

            cards.forEach(card => {
                const name = card.querySelector('.restaurant-name').textContent.toLowerCase();
                const cuisine = card.dataset.cuisine.toLowerCase();
                const rating = parseFloat(card.dataset.rating);
                const time = parseInt(card.dataset.time);
                const price = parseInt(card.dataset.price);
                const restId = parseInt(card.querySelector('.fav-btn').dataset.id);
                // The card is wrapped in an <a> tag which is the direct grid child
                const wrapper = card.closest('a') || card;

                let matchesSearch = name.includes(query) || cuisine.includes(query);
                let matchesFilter = true;

                if (activeFilter === 'top-rated') {
                    matchesFilter = rating >= 4.5;
                } else if (activeFilter === 'fast') {
                    matchesFilter = time <= 25;
                } else if (activeFilter === 'budget') {
                    matchesFilter = price <= 500;
                }
                
                let matchesFavorites = true;
                if (showFavoritesOnly) {
                    matchesFavorites = favorites[restId] !== undefined;
                }

                if (matchesSearch && matchesFilter && matchesFavorites) {
                    // Show both wrapper and inner card
                    wrapper.style.display = '';
                    card.style.display = 'flex';
                } else {
                    // Hide the wrapper so the grid slot is freed up — keeps cards adjacent
                    wrapper.style.display = 'none';
                    card.style.display = 'none';
                }
            });
        }

        searchInput.addEventListener('input', filterRestaurants);

        document.querySelectorAll('.filter-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
                btn.classList.add('active');
                filterRestaurants();
            });
        });

        // --- Category Card Filter ---
        function filterByCuisine(cuisineKeyword, clickedCard) {
            // Toggle: if already active, reset to show all
            if (clickedCard.classList.contains('active-cat')) {
                clickedCard.classList.remove('active-cat');
                cards.forEach(card => {
                    card.closest('a').style.display = '';
                    card.style.display = 'flex';
                });
                searchInput.value = '';
                return;
            }
            // Deactivate all, activate clicked
            document.querySelectorAll('.cat-card').forEach(c => c.classList.remove('active-cat'));
            clickedCard.classList.add('active-cat');
            // Filter restaurant cards
            cards.forEach(card => {
                const cuisine = card.dataset.cuisine.toLowerCase();
                const wrapper = card.closest('a');
                if (cuisine.includes(cuisineKeyword.toLowerCase())) {
                    card.style.display = 'flex';
                    if (wrapper) wrapper.style.display = '';
                } else {
                    card.style.display = 'none';
                    if (wrapper) wrapper.style.display = 'none';
                }
            });
            // Scroll to restaurant section
            document.querySelector('.main-content').scrollIntoView({ behavior: 'smooth' });
        }

        // --- Fav Counter in Navbar ---
        function updateFavCounter() {
            const favCount = Object.keys(favorites).length;
            const favCounter = document.getElementById('fav-counter');
            if (favCounter) {
                favCounter.textContent = favCount;
                favCounter.style.display = favCount > 0 ? 'flex' : 'none';
            }
        }

        // Wire fav-nav-trigger to open a favorites view (scroll to top + show toast listing)
        const favNavTrigger = document.getElementById('fav-nav-trigger');
        if (favNavTrigger) {
            favNavTrigger.addEventListener('click', (e) => {
                e.preventDefault();
                showFavoritesOnly = !showFavoritesOnly;
                
                if (showFavoritesOnly) {
                    favNavTrigger.style.color = '#e11d48';
                    const favList = Object.values(favorites).map(f => f.name).join(', ');
                    if (!favList) {
                        showToast('No favourites saved yet! Click ❤️ on a restaurant.');
                        showFavoritesOnly = false;
                        favNavTrigger.style.color = '';
                        return;
                    }
                    showToast('❤️ Showing your favorite restaurants');
                } else {
                    favNavTrigger.style.color = '';
                    showToast('Showing all restaurants');
                }
                
                filterRestaurants();
                document.querySelector('.main-content').scrollIntoView({ behavior: 'smooth' });
            });
        }
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