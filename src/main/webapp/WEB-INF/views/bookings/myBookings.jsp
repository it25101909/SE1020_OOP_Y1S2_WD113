<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings | Zip SL</title>
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
            --glass-bg: rgba(255,255,255,0.8);
            --glass-border: rgba(0,0,0,0.12);
            --card-bg: rgba(255,255,255,0.85);
        }
        [data-theme="light"] body { background: #dde3f0; color: #1a1a2e; }
        [data-theme="light"] .bg-night { opacity: 0; pointer-events: none; }
        [data-theme="light"] .bg-light { opacity: 1 !important; }
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
        [data-theme="dark"] .bg-light { opacity: 0; pointer-events: none; }
        [data-theme="light"] .booking-card { background: var(--card-bg); border-color: rgba(0,0,0,0.1); color: #1a1a2e; }
        [data-theme="light"] .booking-card h3 { color: #1a1a2e; }
        [data-theme="light"] .booking-detail span { color: #4a5568; }

        #theme-toggle {
            background: var(--card-bg); border: 1px solid var(--glass-border);
            backdrop-filter: blur(12px); border-radius: 50px;
            padding: 8px 16px; font-size: 0.9rem; cursor: pointer;
            color: var(--text-main); font-family: 'Outfit', sans-serif;
            font-weight: 600; display: flex; align-items: center; gap: 8px;
            transition: all 0.3s ease; box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            z-index: 10;
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
        (function() {
            const savedTheme = localStorage.getItem('theme') || 'dark';
            document.documentElement.setAttribute('data-theme', savedTheme);
            window.addEventListener('DOMContentLoaded', () => updateToggleButton(savedTheme));
        })();
    </script>
</head>
<body>
    <style>
        body { 
            font-family: 'Outfit', sans-serif; 
            background: #08080a;
            color: var(--text-main);
            margin: 0; 
            display: flex; 
            flex-direction: column; 
            align-items: center; 
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* Ambient Orbs */
        .orb {
            position: fixed;
            border-radius: 50%;
            filter: blur(100px);
            opacity: 0.2;
            z-index: 0;
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
        .top-nav a { 
            color: var(--text-main); 
            font-size: 24px; 
            font-weight: 800; 
            text-decoration: none; 
            display: flex; 
            align-items: center; 
            gap: 10px; 
        }
        .top-nav a span { color: var(--primary); }
        .back-link {
            color: var(--text-muted);
            text-decoration: none;
            font-weight: 600;
            transition: 0.3s;
        }
        .back-link:hover { color: white; }
        
        .container { 
            max-width: 850px; 
            width: 100%; 
            padding: 0 20px 40px; 
            box-sizing: border-box; 
            z-index: 10;
        }
        
        h2 { color: var(--text-main); text-align: center; margin-bottom: 40px; margin-top: 0; font-size: 2.5rem; font-weight: 700; }
        
        .booking-card { 
            background: var(--glass-bg); 
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            padding: 30px; 
            border-radius: 20px; 
            margin-bottom: 25px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3); 
            border: 1px solid var(--glass-border);
            border-left: 6px solid #0ea5e9; 
            transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275); 
            animation: fadeInUp 0.5s ease backwards;
        }
        .booking-card:hover { 
            transform: translateY(-5px); 
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.4); 
            background: rgba(255, 255, 255, 0.08);
        }
        
        .locations { font-size: 1.2rem; color: var(--text-main); margin-bottom: 12px; font-weight: 700; }
        .details { color: var(--text-muted); font-size: 0.95rem; margin-bottom: 18px; line-height: 1.6; }
        .details strong { color: #cbd5e1; }
        
        .fare { font-size: 1.4rem; font-weight: 800; color: #10b981; margin-bottom: 15px; }
        
        .status-badge { 
            display: inline-block; 
            padding: 8px 16px; 
            border-radius: 30px; 
            font-size: 0.85rem; 
            font-weight: 700; 
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }
        .status-pending { background-color: rgba(245, 158, 11, 0.15); color: #fbbf24; border: 1px solid rgba(245, 158, 11, 0.3); }
        
        @keyframes pulse-green {
            0% { box-shadow: 0 0 0 0 rgba(16, 185, 129, 0.4); }
            70% { box-shadow: 0 0 0 10px rgba(16, 185, 129, 0); }
            100% { box-shadow: 0 0 0 0 rgba(16, 185, 129, 0); }
        }
        .status-accepted { 
            background-color: rgba(16, 185, 129, 0.15); 
            color: #34d399; 
            border: 1px solid rgba(16, 185, 129, 0.3); 
            animation: pulse-green 2s infinite;
        }
        .status-cancelled { background-color: rgba(239, 68, 68, 0.15); color: #fca5a5; border: 1px solid rgba(239, 68, 68, 0.3); }
        
        .driver-info { 
            background: rgba(14, 165, 233, 0.1); 
            padding: 20px; 
            border-radius: 12px; 
            margin-top: 20px; 
            font-size: 0.95rem; 
            border: 1px dashed rgba(14, 165, 233, 0.4); 
            color: #bae6fd;
        }
        
        .verification-box {
            margin-top: 15px; 
            background: rgba(0, 0, 0, 0.3); 
            padding: 15px; 
            border-radius: 12px; 
            border: 1px solid var(--primary); 
            text-align: center;
        }
        .verification-box span.title { display: block; font-size: 0.8rem; color: var(--text-muted); text-transform: uppercase; letter-spacing: 1px; }
        .verification-box span.code { font-size: 2rem; font-weight: 800; color: var(--primary); letter-spacing: 8px; text-shadow: 0 0 10px rgba(249, 115, 22, 0.4); }
        
        .no-bookings { 
            text-align: center; 
            background: var(--glass-bg); 
            backdrop-filter: blur(10px);
            padding: 60px 40px; 
            border-radius: 20px; 
            border: 1px solid var(--glass-border);
        }
        .no-bookings h3 { color: var(--text-main); margin-bottom: 10px; font-size: 1.5rem; }
        .no-bookings p { color: var(--text-muted); margin-bottom: 25px; }
        .btn-primary { 
            background: var(--primary); 
            color: white; 
            text-decoration: none; 
            font-weight: 700; 
            padding: 12px 30px; 
            border-radius: 50px; 
            display: inline-block;
            transition: 0.3s;
        }
        .btn-primary:hover { background: var(--primary-hover); transform: translateY(-2px); box-shadow: 0 10px 20px rgba(249, 115, 22, 0.4); }

        .btn-cancel {
            background: rgba(239, 68, 68, 0.1); 
            color: #fca5a5; 
            border: 1px solid rgba(239, 68, 68, 0.4); 
            padding: 10px 20px; 
            border-radius: 8px; 
            cursor: pointer;
            font-weight: 600;
            font-family: 'Outfit', sans-serif;
            transition: 0.3s;
        }
        .btn-cancel:hover { background: #ef4444; color: white; }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
    <script>
        (function(){
            var t = localStorage.getItem('kc-theme') || 'dark';
            document.documentElement.setAttribute('data-theme', t);
        })();
        function toggleTheme(){
            var html = document.documentElement;
            var next = html.getAttribute('data-theme') === 'dark' ? 'light' : 'dark';
            html.setAttribute('data-theme', next);
            localStorage.setItem('kc-theme', next);
            var btn = document.getElementById('theme-toggle');
            btn.innerHTML = next === 'dark' ? '&#9790; Dark' : '&#9788; Light';
        }
        window.onload = function() {
            var t = localStorage.getItem('kc-theme') || 'dark';
            var btn = document.getElementById('theme-toggle');
            if(btn) btn.innerHTML = t === 'dark' ? '&#9790; Dark' : '&#9788; Light';
        }
    </script>
</head>
<body>


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
    <div class="orb orb-1"></div>
    <div class="orb orb-2"></div>

    <div class="top-nav">
        <a href="${pageContext.request.contextPath}/home">🚕 Zip<span>SL</span></a>
    </div>

    <div class="container">
        <div style="height: 150px; border-radius: 20px; margin-bottom: 30px; background: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.7)), url('https://images.unsplash.com/photo-1449965408869-eaa3f722e40d?auto=format&fit=crop&q=80&w=1200') center/cover; display: flex; align-items: center; justify-content: center;">
            <h2 style="margin: 0; font-size: 3rem;">Your Ride History</h2>
        </div>

        <c:forEach var="ride" items="${bookings}">
            <div class="booking-card">
                <div class="locations">${ride.pickupLocation} ➔ ${ride.dropLocation}</div>
                <div class="details">
                    <strong style="color: var(--text-main);">Vehicle:</strong> ${ride.requestedVehicleType} &nbsp;&bull;&nbsp; 
                    <strong style="color: var(--text-main);">Time:</strong> ${ride.scheduledTime} &nbsp;&bull;&nbsp; 
                    <strong style="color: var(--text-main);">Company:</strong> ${ride.requestedCooperation}
                </div>
                <div class="fare">
                    <c:choose>
                        <c:when test="${ride.status == 'Cancelled'}"><span style="text-decoration: line-through; color: var(--text-muted);">LKR ${ride.fare}</span> <span style="color: #10b981; font-size: 1rem;">(FREE)</span></c:when>
                        <c:otherwise>LKR ${ride.fare}</c:otherwise>
                    </c:choose>
                </div>

                <div>
                    <span class="status-badge ${ride.status == 'Pending' ? 'status-pending' : (ride.status == 'Accepted' || ride.status == 'Started' || ride.status == 'Completed' ? 'status-accepted' : 'status-cancelled')}">
                        <c:choose>
                            <c:when test="${ride.status == 'Pending'}">Searching for Drivers...</c:when>
                            <c:when test="${ride.status == 'Accepted'}">Driver Arriving...</c:when>
                            <c:when test="${ride.status == 'Started'}">In Transit (Ride Started)</c:when>
                            <c:when test="${ride.status == 'Cancelled-Paid'}">Cancelled (Full Payment Required)</c:when>
                            <c:otherwise>${ride.status}</c:otherwise>
                        </c:choose>
                    </span>
                </div>

                <c:if test="${ride.status == 'Accepted' || ride.status == 'Started' || ride.status == 'Completed'}">
                    <div class="driver-info">
                        <strong>Driver ID:</strong> ${ride.driverId} 
                        <c:if test="${ride.status == 'Started'}"> is currently driving you.</c:if>
                        <c:if test="${ride.status == 'Accepted'}"> is on the way to your location.</c:if>
                        
                        <div class="verification-box">
                            <span class="title">PASSENGER VERIFICATION CODE</span>
                            <span class="code">${ride.verificationCode}</span>
                            <p style="font-size: 0.8rem; color: #cbd5e1; margin: 5px 0 0 0;">Share this with your driver to start the trip!</p>
                        </div>
                    </div>
                </c:if>
                
                <c:if test="${ride.status == 'Pending' || ride.status == 'Accepted' || ride.status == 'Started'}">
                    <form action="${pageContext.request.contextPath}/cancel-booking/${ride.bookingId}" method="post" style="margin-top: 20px; display: inline-block;">
                        <button type="submit" class="btn-cancel" onclick="return confirm('${ride.status == 'Started' ? 'Your ride has already started! If you cancel now, you will still be charged the FULL price. Continue?' : 'Are you sure you want to cancel?'}')">
                            ${ride.status == 'Started' ? 'Cancel Mid-Ride (Full Charge)' : 'Cancel Ride (Free)'}
                        </button>
                    </form>
                </c:if>
            </div>
        </c:forEach>

        <c:if test="${empty bookings}">
            <div class="no-bookings">
                <h3>No rides found!</h3>
                <p>You haven't booked any elite rides yet.</p>
                <a href="${pageContext.request.contextPath}/book-taxi" class="btn-primary">Book a Ride Now</a>
            </div>
        </c:if>

        <div style="text-align: center; margin-top: 40px;">
            <a href="${pageContext.request.contextPath}/home" class="back-link">← Back to Dashboard</a>
        </div>
    </div>
</body>
</html>
