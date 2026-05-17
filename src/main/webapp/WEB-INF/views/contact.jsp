<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us | Zip SL</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #f97316;
            --primary-hover: #ea580c;
            --bg-dark: #08080a;
            --text-main: #f8fafc;
            --text-muted: #94a3b8;
            --glass-bg: rgba(20, 20, 25, 0.6);
            --glass-border: rgba(255, 255, 255, 0.1);
            --card-bg: rgba(20,20,25,0.6);
        }
        /* ===== LIGHT THEME ===== */
        [data-theme="light"] {
            --text-main: #1a1a2e;
            --text-muted: #4a5568;
            --glass-bg: rgba(255,255,255,0.85);
            --glass-border: rgba(0,0,0,0.12);
            --card-bg: rgba(255,255,255,0.9);
        }
        body { 
            font-family: 'Outfit', sans-serif; 
            margin: 0; 
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            overflow-x: hidden;
            transition: color 0.3s ease;
        }
        [data-theme="light"] body { background: #dde3f0; color: #1a1a2e; }

        .bg-light {
            position: fixed; inset: 0; z-index: 0; pointer-events: none; overflow: hidden;
            opacity: 0; transition: opacity 0.5s ease;
            filter: blur(10px) brightness(0.8);
            transform: scale(1.1);
        }
        .bg-night {
            position: fixed; inset: 0; z-index: 0; pointer-events: none; overflow: hidden;
            opacity: 1; transition: opacity 0.5s ease;
            filter: blur(10px) brightness(0.7);
            transform: scale(1.1);
        }
        [data-theme="light"] .bg-night { opacity: 0; pointer-events: none; }
        [data-theme="light"] .bg-light { opacity: 1 !important; }
        [data-theme="dark"] .bg-light { opacity: 0; pointer-events: none; }

        #theme-toggle {
            position: fixed; top: 18px; right: 22px; z-index: 9999;
            background: var(--card-bg); border: 1px solid var(--glass-border);
            backdrop-filter: blur(12px); border-radius: 50px;
            padding: 8px 16px; font-size: 0.9rem; cursor: pointer;
            color: var(--text-main); font-family: 'Outfit', sans-serif;
            font-weight: 600; display: flex; align-items: center; gap: 8px;
            transition: all 0.3s ease; box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        #theme-toggle:hover { transform: translateY(-2px) scale(1.05); border-color: var(--primary); }

        /* Ambient Orbs */
        .orb {
            position: fixed;
            border-radius: 50%;
            filter: blur(100px);
            opacity: 0.2;
            z-index: 1;
            pointer-events: none;
        }
        .orb-1 { width: 400px; height: 400px; background: var(--primary); top: 10%; left: -10%; }
        .orb-2 { width: 500px; height: 500px; background: #4338ca; bottom: 10%; right: -10%; }

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
        .top-nav a.logo { 
            color: var(--text-main); 
            font-size: 24px; 
            font-weight: 800; 
            text-decoration: none; 
            display: flex; 
            align-items: center; 
            gap: 10px; 
        }
        .top-nav a.logo span { color: var(--primary); }
        .back-link {
            color: var(--text-muted);
            text-decoration: none;
            font-weight: 600;
            transition: 0.3s;
        }
        .back-link:hover { color: white; }
        
        .contact-container { 
            max-width: 600px; 
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
        
        h2 { color: white; text-align: center; margin-bottom: 10px; margin-top: 0; font-weight: 700; font-size: 28px; }
        .subtitle { color: var(--text-muted); text-align: center; margin-bottom: 30px; font-size: 15px; font-weight: 300; }
        label { display: block; font-weight: 600; margin-bottom: 8px; color: var(--text-muted); font-size: 14px; }
        
        input, textarea, select { 
            width: 100%; 
            padding: 14px 16px; 
            margin-bottom: 20px; 
            background: rgba(0, 0, 0, 0.2); 
            border: 1px solid var(--glass-border); 
            border-radius: 12px; 
            box-sizing: border-box; 
            font-size: 15px; 
            color: var(--text-main);
            font-family: 'Outfit', sans-serif;
            transition: 0.3s;
        }
        input:focus, textarea:focus, select:focus {
            outline: none;
            border-color: var(--primary);
            background: rgba(0, 0, 0, 0.4);
            box-shadow: 0 0 0 4px rgba(249, 115, 22, 0.1);
        }

        .submit-btn { 
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
        .submit-btn:hover { 
            background: var(--primary-hover); 
            transform: translateY(-2px);
            box-shadow: 0 10px 25px -5px rgba(249, 115, 22, 0.4);
        }
        
        .contact-methods {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 30px;
        }
        .method-card {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid var(--glass-border);
            border-radius: 16px;
            padding: 20px;
            text-align: center;
            transition: 0.3s;
        }
        .method-card:hover {
            border-color: var(--primary);
            background: rgba(255, 255, 255, 0.06);
            transform: translateY(-3px);
        }
        .method-icon {
            font-size: 24px;
            margin-bottom: 10px;
        }
        .method-title {
            font-weight: 700;
            font-size: 15px;
            margin-bottom: 5px;
        }
        .method-desc {
            font-size: 13px;
            color: var(--text-muted);
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
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
        (function() {
            const savedTheme = localStorage.getItem('theme') || 'dark';
            document.documentElement.setAttribute('data-theme', savedTheme);
            window.addEventListener('DOMContentLoaded', () => updateToggleButton(savedTheme));
        })();

        function handleSubmit(e) {
            e.preventDefault();
            alert("Thank you for your message! Our elite support team will contact you shortly.");
            window.location.href = "${pageContext.request.contextPath}/home";
        }
    </script>
</head>
<body>
    <!-- Dynamic Backgrounds -->
    <div class="bg-light" style="background: url('${pageContext.request.contextPath}/images/bg-light.png') center/cover no-repeat;"></div>
    <div class="bg-night" style="background: url('${pageContext.request.contextPath}/images/bg-dark.png') center/cover no-repeat;"></div>

    <button id="theme-toggle" onclick="toggleTheme()">🌙 Dark</button>

    <div class="orb orb-1"></div>
    <div class="orb orb-2"></div>

    <div class="top-nav">
        <a href="${pageContext.request.contextPath}/home" class="logo">🚕 Zip<span>SL</span></a>
        <a href="${pageContext.request.contextPath}/home" class="back-link">← Back to Dashboard</a>
    </div>

    <div class="contact-container">
        <h2>Get in Touch</h2>
        <div class="subtitle">Have any questions or feedback? We'd love to hear from you.</div>

        <div class="contact-methods">
            <div class="method-card">
                <div class="method-icon">📞</div>
                <div class="method-title">Call Support</div>
                <div class="method-desc">+94 112 555 888</div>
            </div>
            <div class="method-card">
                <div class="method-icon">✉️</div>
                <div class="method-title">Email Us</div>
                <div class="method-desc">support@zipsl.com</div>
            </div>
        </div>

        <form onsubmit="handleSubmit(event)">
            <label>Inquiry Category</label>
            <select required>
                <option value="" disabled selected>Select a category</option>
                <option value="general">General Inquiry</option>
                <option value="billing">Billing & Refund Issue</option>
                <option value="driver">Driver Feedback / Complaint</option>
                <option value="technical">Technical Support</option>
            </select>

            <label>Subject</label>
            <input type="text" placeholder="Enter inquiry subject" required>

            <label>Description</label>
            <textarea rows="5" placeholder="Describe your issue or feedback in detail..." style="resize: none;" required></textarea>

            <button type="submit" class="submit-btn">Send Message</button>
        </form>
    </div>
</body>
</html>
