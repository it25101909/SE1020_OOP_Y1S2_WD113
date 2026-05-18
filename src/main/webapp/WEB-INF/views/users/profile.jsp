<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Edit Profile | Zip SL</title>
            <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap"
                rel="stylesheet">
            <style>
                :root {
                    --primary: #f97316;
                    --primary-hover: #ea580c;
                    --bg-dark: #08080a;
                    --text-main: #f8fafc;
                    --text-muted: #94a3b8;
                    --glass-bg: rgba(20, 20, 25, 0.6);
                    --glass-border: rgba(255, 255, 255, 0.1);
                    --card-bg: rgba(20, 20, 25, 0.6);
                    --input-bg: rgba(0, 0, 0, 0.2);
                    --input-focus-bg: rgba(0, 0, 0, 0.4);
                    --danger-text: #fca5a5;
                    --danger-border: rgba(239, 68, 68, 0.3);
                    --danger-bg: rgba(239, 68, 68, 0.05);
                }

                /* ===== LIGHT THEME ===== */
                [data-theme="light"] {
                    --text-main: #1a1a2e;
                    --text-muted: #4a5568;
                    --glass-bg: rgba(255, 255, 255, 0.8);
                    --glass-border: rgba(0, 0, 0, 0.12);
                    --card-bg: rgba(255, 255, 255, 0.85);
                    --input-bg: rgba(255, 255, 255, 0.6);
                    --input-focus-bg: rgba(255, 255, 255, 0.9);
                    --danger-text: #b91c1c;
                    --danger-border: rgba(185, 28, 28, 0.4);
                    --danger-bg: rgba(185, 28, 28, 0.05);
                }

                body {
                    font-family: 'Outfit', sans-serif;
                    background: var(--bg-dark);
                    margin: 0;
                    min-height: 100vh;
                    display: flex;
                    flex-direction: column;
                    overflow-x: hidden;
                    transition: color 0.3s ease, background-color 0.3s ease;
                }

                [data-theme="light"] body {
                    background: #dde3f0;
                    color: #1a1a2e;
                }

                .bg-light {
                    position: fixed;
                    inset: 0;
                    z-index: 0;
                    pointer-events: none;
                    overflow: hidden;
                    opacity: 0;
                    transition: opacity 0.5s ease;
                    filter: blur(10px) brightness(0.8);
                    transform: scale(1.1);
                }

                .bg-night {
                    position: fixed;
                    inset: 0;
                    z-index: 0;
                    pointer-events: none;
                    overflow: hidden;
                    opacity: 1;
                    transition: opacity 0.5s ease;
                    filter: blur(10px) brightness(0.7);
                    transform: scale(1.1);
                }

                [data-theme="light"] .bg-night {
                    opacity: 0;
                    pointer-events: none;
                }

                [data-theme="light"] .bg-light {
                    opacity: 1 !important;
                }

                [data-theme="dark"] .bg-light {
                    opacity: 0;
                    pointer-events: none;
                }

                #theme-toggle {
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
                    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
                }

                #theme-toggle:hover {
                    transform: translateY(-2px) scale(1.05);
                    border-color: var(--primary);
                }

                /* Ambient Orbs */
                .orb {
                    position: fixed;
                    border-radius: 50%;
                    filter: blur(100px);
                    opacity: 0.2;
                    z-index: 1;
                    pointer-events: none;
                }

                .orb-1 {
                    width: 400px;
                    height: 400px;
                    background: var(--primary);
                    top: 10%;
                    left: -10%;
                }

                .orb-2 {
                    width: 500px;
                    height: 500px;
                    background: #4338ca;
                    bottom: 10%;
                    right: -10%;
                }

                .top-nav {
                    width: 100%;
                    padding: 20px 40px;
                    box-sizing: border-box;
                    margin-bottom: 20px;
                    z-index: 10;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                }

                .top-nav a {
                    color: var(--text-main);
                    font-size: 24px;
                    font-weight: 800;
                    text-decoration: none;
                    display: flex;
                    align-items: center;
                    gap: 10px;
                }

                .top-nav a span {
                    color: var(--primary);
                }

                .top-nav a.back-link {
                    color: var(--text-muted);
                    text-decoration: none;
                    font-weight: 600;
                    transition: 0.3s;
                }

                .top-nav a.back-link:hover {
                    color: var(--primary);
                }

                .top-nav a.logout-btn-nav {
                    background: rgba(239, 68, 68, 0.1);
                    color: #fca5a5;
                    border: 1px solid rgba(239, 68, 68, 0.3);
                    text-decoration: none;
                    border-radius: 50px;
                    font-weight: 600;
                    padding: 8px 20px;
                    font-size: 14px;
                    transition: all 0.3s;
                    z-index: 10;
                }

                .top-nav a.logout-btn-nav:hover {
                    background: #ef4444;
                    color: white !important;
                    box-shadow: 0 5px 15px rgba(239, 68, 68, 0.3);
                    transform: translateY(-2px);
                }

                [data-theme="light"] .top-nav a.logout-btn-nav {
                    background: rgba(239, 68, 68, 0.1);
                    color: #c53030;
                    border-color: rgba(239, 68, 68, 0.3);
                }

                .profile-container {
                    max-width: 550px;
                    width: 90%;
                    margin: 0 auto 40px auto;
                    background: var(--glass-bg);
                    backdrop-filter: blur(20px);
                    -webkit-backdrop-filter: blur(20px);
                    padding: 40px;
                    border-radius: 24px;
                    border: 1px solid var(--glass-border);
                    box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
                    z-index: 10;
                    animation: fadeInUp 0.6s ease backwards;
                }

                h2 {
                    color: var(--text-main);
                    text-align: center;
                    margin-bottom: 30px;
                    margin-top: 0;
                    font-weight: 700;
                    font-size: 28px;
                }

                label {
                    display: block;
                    font-weight: 600;
                    margin-bottom: 8px;
                    color: var(--text-muted);
                    font-size: 14px;
                }

                input {
                    width: 100%;
                    padding: 14px 16px;
                    margin-bottom: 20px;
                    background: var(--input-bg);
                    border: 1px solid var(--glass-border);
                    border-radius: 12px;
                    box-sizing: border-box;
                    font-size: 15px;
                    color: var(--text-main);
                    font-family: 'Outfit', sans-serif;
                    transition: 0.3s;
                }

                input:focus {
                    outline: none;
                    border-color: var(--primary);
                    background: var(--input-focus-bg);
                    box-shadow: 0 0 0 4px rgba(249, 115, 22, 0.1);
                }

                .save-btn {
                    background: var(--primary);
                    color: white;
                    border: none;
                    padding: 16px;
                    cursor: pointer;
                    width: 100%;
                    border-radius: 12px;
                    font-weight: 700;
                    font-size: 16px;
                    transition: 0.3s;
                    font-family: 'Outfit', sans-serif;
                }

                .save-btn:hover {
                    background: var(--primary-hover);
                    transform: translateY(-2px);
                    box-shadow: 0 10px 25px -5px rgba(249, 115, 22, 0.4);
                }

                .danger-zone {
                    margin-top: 30px;
                    border: 1px dashed var(--danger-border);
                    padding: 30px;
                    border-radius: 20px;
                    background: var(--danger-bg);
                }

                .danger-zone h3 {
                    color: var(--danger-text);
                    margin-top: 0;
                    margin-bottom: 10px;
                    font-weight: 700;
                    text-align: center;
                }

                .danger-zone p {
                    font-size: 14px;
                    color: var(--danger-text);
                    margin-bottom: 20px;
                    text-align: center;
                }

                .del-btn {
                    background: rgba(239, 68, 68, 0.1);
                    color: var(--danger-text);
                    border: 1px solid var(--danger-border);
                    padding: 14px;
                    cursor: pointer;
                    width: 100%;
                    border-radius: 12px;
                    font-weight: 700;
                    transition: 0.3s;
                    font-family: 'Outfit', sans-serif;
                }

                .del-btn:hover {
                    background: #ef4444;
                    color: white;
                    transform: translateY(-2px);
                    box-shadow: 0 10px 20px var(--danger-border);
                }

                @keyframes fadeInUp {
                    from {
                        opacity: 0;
                        transform: translateY(30px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }
            </style>
            <script>
                function updateToggleButton(theme) {
                    const btn = document.getElementById('theme-toggle');
                    if (btn) {
                        btn.innerHTML = theme === 'light' ? '☀️ Light' : '🌙 Dark';
                    }
                }
                function toggleTheme() {
                    const html = document.documentElement;
                    const currentTheme = html.getAttribute('data-theme') || 'dark';
                    const next = currentTheme === 'dark' ? 'light' : 'dark';
                    html.setAttribute('data-theme', next);
                    localStorage.setItem('theme', next);
                    updateToggleButton(next);
                }
                (function () {
                    const savedTheme = localStorage.getItem('theme') || 'dark';
                    document.documentElement.setAttribute('data-theme', savedTheme);
                    window.addEventListener('DOMContentLoaded', () => updateToggleButton(savedTheme));
                })();
            </script>
        </head>

        <body>
            <!-- Dynamic Backgrounds -->
            <div class="bg-light"
                style="background: url('${pageContext.request.contextPath}/images/bg-light.png') center/cover no-repeat;">
            </div>
            <div class="bg-night"
                style="background: url('${pageContext.request.contextPath}/images/bg-dark.png') center/cover no-repeat;">
            </div>

            <div class="orb orb-1"></div>
            <div class="orb orb-2"></div>

            <div class="top-nav">
                <a href="${pageContext.request.contextPath}/home">🚕 Zip<span>SL</span></a>
                <div style="display: flex; gap: 20px; align-items: center; z-index: 9999;">
                    <button id="theme-toggle" onclick="toggleTheme()">🌙 Dark</button>
                    <a href="${pageContext.request.contextPath}/home" class="back-link">← Back to Dashboard</a>
                    <a href="${pageContext.request.contextPath}/logout" class="logout-btn-nav">Log Out</a>
                </div>
            </div>

            <div class="profile-container" style="padding-top: 0; overflow: hidden;">
                <div
                    style="height: 150px; background: url('https://images.unsplash.com/photo-1511367461989-f85a21fda167?auto=format&fit=crop&q=80&w=1000') center/cover; margin: 0 -40px 0 -40px; position: relative;">
                    <img src="https://ui-avatars.com/api/?name=${loggedInUser.name}&background=f97316&color=fff&size=100"
                        alt="Avatar"
                        style="position: absolute; bottom: -50px; left: 50%; transform: translateX(-50%); border-radius: 50%; border: 4px solid var(--bg-dark); box-shadow: 0 5px 15px rgba(0,0,0,0.3);">
                </div>
                <h2 style="margin-top: 60px;">Update Your Profile</h2>

                <c:if test="${param.status == 'updated'}">
                    <div class="success-msg"
                        style="background: rgba(16, 185, 129, 0.1); color: #34d399; border: 1px solid rgba(16, 185, 129, 0.3); padding: 12px; border-radius: 8px; text-align: center; margin-bottom: 20px; font-weight: 600;">
                        Profile updated successfully!
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/update-profile" method="post">
                    <label>${loggedInUser.role == 'Company' ? 'Company Name' : 'Full Name'}</label>
                    <input type="text" name="name" value="${loggedInUser.name}" required>

                    <label>Email Address</label>
                    <input type="email" name="email" value="${loggedInUser.email}" required>

                    <label>Phone Number</label>
                    <input type="text" name="phone" value="${loggedInUser.phone}" required>

                    <c:if test="${loggedInUser.role == 'Driver'}">
                        <label>License Number</label>
                        <input type="text" name="licenseNumber" value="${loggedInUser.licenseNumber}" required>

                        <label>Company ID (Optional)</label>
                        <input type="text" name="companyName" value="${loggedInUser.companyName}"
                            placeholder="e.g. C-XXXX">
                        <p style="font-size: 12px; color: var(--text-muted); margin-top: -15px; margin-bottom: 20px;">
                            Enter a Company ID to receive private orders from that company.</p>
                    </c:if>

                    <button type="submit" class="save-btn">Save Changes</button>
                </form>
            </div>

            <c:if test="${loggedInUser.role == 'Passenger'}">
                <div class="profile-container" style="border-top: 5px solid #0ea5e9; animation-delay: 0.1s;">
                    <h2 style="color: #38bdf8;">💳 Payment Settings</h2>

                    <c:if test="${param.status == 'payment_updated'}">
                        <div class="success-msg"
                            style="background: rgba(56, 189, 248, 0.1); color: #7dd3fc; border-color: rgba(56, 189, 248, 0.3); padding: 12px; border-radius: 8px; text-align: center; margin-bottom: 20px; font-weight: 600;">
                            Card details updated!
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/update-payment" method="post">
                        <label>Card Number (Mock)</label>
                        <input type="text" name="cardNumber" value="${loggedInUser.cardNumber}"
                            placeholder="XXXX XXXX XXXX XXXX" required>

                        <label>Expiry Date</label>
                        <input type="text" name="cardExpiry" value="${loggedInUser.cardExpiry}" placeholder="MM/YY"
                            required>

                        <p style="font-size: 12px; color: var(--text-muted); margin-top: -10px; margin-bottom: 20px;">
                            Note: For project demonstration purposes, card details are stored locally.
                        </p>

                        <button type="submit" class="save-btn" style="background: #0ea5e9;">Update Card Details</button>
                    </form>
                </div>
            </c:if>

            <div class="profile-container danger-zone" style="animation-delay: 0.2s;">
                <h3>Danger Zone</h3>
                <p>Once you delete your account, there is no going back. Please be certain.</p>

                <form action="${pageContext.request.contextPath}/delete-account" method="post"
                    onsubmit="return confirm('Are you absolutely sure you want to delete your account?');">
                    <button type="submit" class="del-btn">Delete My Account</button>
                </form>
            </div>
        </body>

        </html>