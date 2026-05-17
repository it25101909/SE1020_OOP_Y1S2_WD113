<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | Zip SL</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #f97316;
            --primary-hover: #ea580c;
            --bg-dark: #08080a;
            --text-main: #f8fafc;
            --text-muted: #94a3b8;
            --glass-bg: rgba(255,255,255,0.05);
            --glass-border: rgba(255,255,255,0.1);
            --glass-hover: rgba(255,255,255,0.08);
            --card-bg: rgba(20,20,25,0.6);
        }
        /* ===== LIGHT THEME ===== */
        [data-theme="light"] {
            --text-main: #1a1a2e;
            --text-muted: #4a5568;
            --glass-bg: rgba(255,255,255,0.75);
            --glass-border: rgba(0,0,0,0.12);
            --glass-hover: rgba(255,255,255,0.95);
            --card-bg: rgba(255,255,255,0.78);
        }
        [data-theme="light"] body { background: #dde3f0; color: #1a1a2e; }
        [data-theme="light"] .nav-card { background: var(--card-bg); border-color: rgba(0,0,0,0.13); color: #1a1a2e; }
        [data-theme="light"] .nav-card:hover { background: rgba(255,255,255,0.97); }
        [data-theme="light"] .nav-card p { color: #4a5568; }
        [data-theme="light"] .header h1 { background: linear-gradient(90deg,#1a1a2e,#2d3a6e); -webkit-background-clip:text; -webkit-text-fill-color:transparent; }
        [data-theme="light"] .header p { color: #4a5568; }
        [data-theme="light"] .logout-btn { background:rgba(239,68,68,0.1); color:#c53030; border-color:rgba(239,68,68,0.3); }
        [data-theme="light"] .contact-btn { background:rgba(249,115,22,0.1); color:#ea580c; border-color:rgba(249,115,22,0.3); }
        [data-theme="light"] .bg-night { opacity: 0; pointer-events: none; }
        [data-theme="light"] .bg-light { opacity: 1 !important; }
        .bg-light {
            position: fixed; inset: 0; z-index: 0; pointer-events: none; overflow: hidden;
            opacity: 0; transition: opacity 0.5s ease;
        }
        .bg-night {
            position: fixed; inset: 0; z-index: 0; pointer-events: none; overflow: hidden;
            opacity: 1; transition: opacity 0.5s ease;
        }
        [data-theme="dark"] .bg-light { opacity: 0; pointer-events: none; }
        [data-theme="light"] .orb-1 { background: #fb923c; opacity: 0.15; }
        [data-theme="light"] .orb-2 { background: #818cf8; opacity: 0.15; }
        /* ===== THEME TOGGLE BUTTON ===== */
        #theme-toggle {
            position: fixed;
            top: 18px;
            right: 22px;
            z-index: 9999;
            background: var(--card-bg);
            border: 1px solid var(--glass-border);
            backdrop-filter: blur(12px);
            border-radius: 50px;
            padding: 8px 16px;
            font-size: 1rem;
            cursor: pointer;
            color: var(--text-main);
            font-family: 'Outfit', sans-serif;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 16px rgba(0,0,0,0.25);
        }
        #theme-toggle:hover { transform: scale(1.06); border-color: var(--primary); }

        body {
            font-family: 'Outfit', sans-serif;
            background: #08080a;
            min-height: 100vh;
            margin: 0;
            padding: 0 20px 40px;
            color: var(--text-main);
            display: flex;
            flex-direction: column;
            align-items: center;
            overflow-x: hidden;
            position: relative;
        }

        /* Ambient Orbs */
        .orb {
            position: fixed;
            border-radius: 50%;
            filter: blur(100px);
            opacity: 0.35;
            z-index: 0;
            animation: float 15s infinite ease-in-out alternate;
            pointer-events: none;
        }
        .orb-1 {
            width: 500px; height: 500px;
            background: var(--primary);
            top: -15%; left: -15%;
        }
        .orb-2 {
            width: 600px; height: 600px;
            background: #4338ca;
            bottom: -15%; right: -15%;
            animation-delay: -5s;
        }
        .orb-3 {
            width: 300px; height: 300px;
            background: #0ea5e9;
            top: 50%; left: 50%;
            opacity: 0.12;
            animation-delay: -10s;
        }

        .header {
            text-align: center;
            margin-bottom: 50px;
            z-index: 10;
            animation: fadeInDown 0.6s ease;
        }

        .header h1 {
            font-size: 3rem;
            margin-bottom: 10px;
            font-weight: 700;
            background: linear-gradient(90deg, #fff, #cbd5e1);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .header p {
            color: var(--text-muted);
            font-size: 1.2rem;
            font-weight: 300;
        }

        .dashboard-container {
            display: flex;
            gap: 30px;
            flex-wrap: wrap;
            justify-content: center;
            max-width: 1100px;
            width: 100%;
            z-index: 10;
        }

        .nav-card {
            background: rgba(20, 20, 25, 0.6);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            padding: 40px 30px;
            width: 280px;
            text-align: center;
            text-decoration: none;
            color: var(--text-main);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            animation: fadeInUp 0.6s ease backwards;
        }

        .nav-card:nth-child(1) { animation-delay: 0.1s; }
        .nav-card:nth-child(2) { animation-delay: 0.2s; }
        .nav-card:nth-child(3) { animation-delay: 0.3s; }
        .nav-card:nth-child(4) { animation-delay: 0.4s; }

        .nav-card:hover {
            transform: translateY(-10px);
            background: rgba(255, 255, 255, 0.08);
            border-color: var(--primary);
            box-shadow: 0 20px 40px rgba(249, 115, 22, 0.15);
        }

        .nav-card .card-image {
            width: 100%;
            height: 140px;
            border-radius: 14px;
            margin-bottom: 20px;
            overflow: hidden;
        }

        .nav-card .card-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.4s ease;
        }

        .nav-card:hover .card-image img {
            transform: scale(1.1);
        }

        .nav-card h3 {
            margin: 0 0 12px 0;
            font-size: 1.4rem;
            font-weight: 600;
        }

        .nav-card p {
            margin: 0;
            color: var(--text-muted);
            font-size: 0.95rem;
            line-height: 1.5;
        }

        .logout-btn {
            margin-top: 60px;
            padding: 12px 35px;
            background: rgba(239, 68, 68, 0.1);
            color: #fca5a5;
            border: 1px solid rgba(239, 68, 68, 0.3);
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s;
            z-index: 10;
        }

        .logout-btn:hover {
            background: #ef4444;
            color: white;
            box-shadow: 0 10px 20px rgba(239, 68, 68, 0.3);
            transform: translateY(-2px);
        }

        .contact-btn {
            margin-top: 60px;
            padding: 12px 35px;
            background: rgba(249, 115, 22, 0.1);
            color: #ffedd5;
            border: 1px solid rgba(249, 115, 22, 0.3);
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s;
            z-index: 10;
        }

        .contact-btn:hover {
            background: var(--primary);
            color: white;
            box-shadow: 0 10px 20px rgba(249, 115, 22, 0.3);
            transform: translateY(-2px);
        }

        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes float {
            0% { transform: translate(0, 0); }
            100% { transform: translate(50px, 50px); }
        }        #theme-toggle {
            position: fixed;
            top: 18px;
            right: 22px;
            z-index: 9999;
            background: var(--card-bg);
            border: 1px solid var(--glass-border);
            backdrop-filter: blur(12px);
            border-radius: 50px;
            padding: 8px 16px;
            font-size: 0.9rem;
            cursor: pointer;
            color: var(--text-main);
            font-family: 'Outfit', sans-serif;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        #theme-toggle:hover { transform: translateY(-2px) scale(1.05); border-color: var(--primary); }
    </style>
    <script>
        function updateToggleButton(theme) {
            const btn = document.getElementById('theme-toggle');
            if (btn) {
                btn.innerHTML = theme === 'light' ? '☀️ Light' : '🌙 Dark';
            }
        }

        function toggleTheme(){
            const html = document.documentElement;
            const currentTheme = html.getAttribute('data-theme') || 'dark';
            const next = currentTheme === 'dark' ? 'light' : 'dark';
            
            html.setAttribute('data-theme', next);
            localStorage.setItem('theme', next);
            updateToggleButton(next);
        }

        // Apply theme on load
        (function() {
            const savedTheme = localStorage.getItem('theme') || 'dark';
            document.documentElement.setAttribute('data-theme', savedTheme);
            window.addEventListener('DOMContentLoaded', () => updateToggleButton(savedTheme));
        })();
    </script>
</head>
<body>

    <!-- Theme toggle button -->
    <button id="theme-toggle" onclick="toggleTheme()">🌙 Dark</button>

    <!-- ============ TAXI BACKGROUND DESIGN ============ -->

    <!-- Dynamic Backgrounds -->
    <div class="bg-night">
        <img src="${pageContext.request.contextPath}/images/bg-dark.png" alt="" style="width:100%;height:100%;object-fit:cover;">
        <div style="position:absolute;inset:0;background:linear-gradient(rgba(8,8,10,0.4),rgba(8,8,10,0.4));"></div>
    </div>
    <div class="bg-light">
        <img src="${pageContext.request.contextPath}/images/bg-light.png" alt="" style="width:100%;height:100%;object-fit:cover;">
        <div style="position:absolute;inset:0;background:linear-gradient(rgba(255,255,255,0.2),rgba(255,255,255,0.2));"></div>
    </div>
    <!-- ============ END BACKGROUND ============ -->


    <!-- Gradient Hero Header -->
    <div style="width: 100%; padding: 60px 20px 80px; text-align: center; position: relative; z-index: 10; background: radial-gradient(ellipse at 50% 0%, rgba(249,115,22,0.18) 0%, transparent 70%);">
        <div class="header" style="margin: 0;">
            <h1>Welcome back, <span style="-webkit-text-fill-color: var(--primary); background: none;">${loggedInUser.name}!</span></h1>
            <p>Your personal Zip SL Dashboard</p>
        </div>
    </div>

    <div class="dashboard-container">
        
        <c:if test="${loggedInUser.role == 'Passenger'}">
            <a href="${pageContext.request.contextPath}/book-taxi" class="nav-card">
                <div class="card-image"><img src="https://images.unsplash.com/photo-1494976388531-d1058494cdd8?auto=format&fit=crop&q=80&w=400" alt="Book a Ride"></div>
                <h3>Book a Ride</h3>
                <p>Request a new elite taxi immediately or schedule for later.</p>
            </a>
            
            <a href="${pageContext.request.contextPath}/myBookings" class="nav-card">
                <div class="card-image"><img src="https://images.unsplash.com/photo-1506784983877-45594efa4cbe?auto=format&fit=crop&q=80&w=400" alt="My Bookings"></div>
                <h3>My Bookings</h3>
                <p>View your ride history and active requests.</p>
            </a>
        </c:if>

        <c:if test="${loggedInUser.role == 'Driver'}">
            <a href="${pageContext.request.contextPath}/tasks" class="nav-card">
                <div class="card-image"><img src="https://images.unsplash.com/photo-1449965408869-eaa3f722e40d?auto=format&fit=crop&q=80&w=400" alt="View Tasks"></div>
                <h3>View Tasks</h3>
                <p>Browse available ride requests in your area and maximize earnings.</p>
            </a>
        </c:if>

        <c:if test="${loggedInUser.role == 'Company'}">
            <a href="${pageContext.request.contextPath}/tasks" class="nav-card">
                <div class="card-image"><img src="https://images.unsplash.com/photo-1554774853-719586f82d77?auto=format&fit=crop&q=80&w=400" alt="View Orders"></div>
                <h3>View Orders</h3>
                <p>See all pending premium ride requests from passengers.</p>
            </a>
            <a href="${pageContext.request.contextPath}/company/fleet" class="nav-card">
                <div class="card-image"><img src="https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?auto=format&fit=crop&q=80&w=400" alt="Manage Fleet"></div>
                <h3>Manage Fleet</h3>
                <p>Add, remove, and monitor vehicles in your company fleet.</p>
            </a>
        </c:if>
        
        <a href="${pageContext.request.contextPath}/profile" class="nav-card">
            <div class="card-image"><img src="https://images.unsplash.com/photo-1542282088-fe8426682b8f?auto=format&fit=crop&q=80&w=400" alt="Profile Settings"></div>
            <h3>Profile Settings</h3>
            <p>Update your personal information, cards, and password.</p>
        </a>

    </div>

    <div style="display: flex; gap: 20px; justify-content: center; align-items: center; width: 100%; max-width: 500px; margin-top: 60px; z-index: 10;">
        <c:if test="${loggedInUser.role == 'Passenger'}">
            <a href="${pageContext.request.contextPath}/contact" class="contact-btn" style="margin-top: 0;">Contact Us</a>
        </c:if>
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn" style="margin-top: 0;">Log Out</a>
    </div>

</body>
</html>
