<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Orders | Zip SL</title>
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
            --text-assignments: #38bdf8;
            --text-transit: var(--primary);
        }
        /* ===== LIGHT THEME ===== */
        [data-theme="light"] {
            --text-main: #1a1a2e;
            --text-muted: #4a5568;
            --glass-bg: rgba(255,255,255,0.8);
            --glass-border: rgba(0,0,0,0.12);
            --card-bg: rgba(255,255,255,0.85);
            --text-assignments: #0284c7;
            --text-transit: #ea580c;
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
        [data-theme="light"] .order-card { background: var(--card-bg); border-color: rgba(0,0,0,0.1); color: #1a1a2e; }
        [data-theme="light"] .order-card h3 { color: #1a1a2e; }
        [data-theme="light"] .order-detail span { color: #4a5568; }

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
        .orb-1 { width: 350px; height: 350px; background: var(--primary); top: 10%; left: -5%; }
        .orb-2 { width: 450px; height: 450px; background: #4338ca; bottom: 10%; right: -5%; }

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
            max-width: 900px; 
            width: 100%; 
            padding: 0 20px 40px; 
            box-sizing: border-box; 
            z-index: 10;
        }
        
        h2 { color: var(--text-main); margin-bottom: 5px; margin-top: 0; font-weight: 700; font-size: 26px; }
        .subtitle { color: var(--text-muted); margin-bottom: 25px; font-size: 1rem; }
        
        .task-card { 
            background: var(--glass-bg); 
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            padding: 25px 30px; 
            border-radius: 20px; 
            margin-bottom: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2); 
            display: flex; 
            justify-content: space-between; 
            align-items: center;
            border: 1px solid var(--glass-border);
            border-left: 6px solid #10b981; 
            transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275); 
            animation: fadeInUp 0.5s ease backwards;
        }
        .task-card:hover { 
            transform: translateY(-5px); 
            background: rgba(255, 255, 255, 0.08);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
        }

        .details h4 { color: var(--text-main); margin: 0 0 10px 0; font-size: 1.2rem; }
        .details p { margin: 6px 0; color: #cbd5e1; font-size: 0.95rem; }
        
        .badge { background: rgba(16, 185, 129, 0.2); color: #34d399; padding: 6px 12px; border-radius: 6px; font-weight: 700; font-size: 12px; border: 1px solid rgba(16, 185, 129, 0.3); }
        .fare-badge { background: rgba(56, 189, 248, 0.2); color: #7dd3fc; padding: 6px 12px; border-radius: 6px; font-weight: 700; font-size: 12px; border: 1px solid rgba(56, 189, 248, 0.3); }
        
        .btn-accept { 
            background: #10b981; 
            color: white; 
            border: none; 
            padding: 14px 28px; 
            border-radius: 12px; 
            cursor: pointer; 
            font-weight: 700; 
            font-size: 15px;
            transition: 0.3s; 
            white-space: nowrap; 
            font-family: 'Outfit', sans-serif;
        }
        .btn-accept:hover { 
            background: #059669; 
            transform: translateY(-2px); 
            box-shadow: 0 10px 20px rgba(16, 185, 129, 0.4);
        }

        .empty-msg { 
            text-align: center; 
            color: var(--text-muted); 
            background: var(--glass-bg); 
            backdrop-filter: blur(10px);
            padding: 60px 40px; 
            border-radius: 20px; 
            border: 1px solid var(--glass-border);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2); 
        }
        .empty-msg h3 { color: var(--text-main); margin-bottom: 10px; }
        
        .info-bar { 
            background: rgba(56, 189, 248, 0.1); 
            border: 1px solid rgba(56, 189, 248, 0.3); 
            border-radius: 12px; 
            padding: 15px 20px; 
            margin-bottom: 25px; 
            font-size: 15px; 
            color: #7dd3fc; 
            backdrop-filter: blur(5px);
        }

        input[type="text"] {
            width: 140px; 
            padding: 12px; 
            background: rgba(0, 0, 0, 0.3);
            border: 1px solid var(--glass-border); 
            border-radius: 8px; 
            margin-bottom: 10px; 
            text-align: center; 
            font-weight: 700; 
            letter-spacing: 2px;
            color: white;
            font-family: 'Outfit', sans-serif;
            transition: 0.3s;
        }
        input[type="text"]:focus {
            outline: none;
            border-color: #38bdf8;
            background: rgba(0, 0, 0, 0.5);
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            .task-card { flex-direction: column; align-items: flex-start; gap: 20px; }
            .task-card > div { width: 100%; text-align: left !important; }
            .btn-accept { width: 100%; }
            input[type="text"] { width: 100%; box-sizing: border-box; }
        }
    </style>
    
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
        <div style="display: flex; align-items: center; gap: 20px;">
            <button id="theme-toggle" onclick="toggleTheme()">🌙 Dark</button>
            <a href="${pageContext.request.contextPath}/home" class="back-link">← Back to Dashboard</a>
        </div>
    </div>

    <div class="container">
        <div style="height: 120px; border-radius: 16px; margin-bottom: 20px; background: linear-gradient(rgba(0,0,0,0.2), rgba(0,0,0,0.6)), url('https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?auto=format&fit=crop&q=80&w=1000') center/cover;"></div>
        <h2>Available Ride Requests</h2>
        <p class="subtitle">Orders matching your fleet will appear here.</p>

        <c:if test="${not empty availabilityNote}">
            <div class="info-bar" style="background: rgba(245, 158, 11, 0.1); border-color: rgba(245, 158, 11, 0.3); color: #fbbf24;">🚨 ${availabilityNote}</div>
        </c:if>

        <c:if test="${not empty reminder}">
            <div class="info-bar" style="background: rgba(16, 185, 129, 0.1); border-color: rgba(16, 185, 129, 0.3); color: #34d399;">⏰ ${reminder}</div>
        </c:if>

        <c:if test="${not empty driverVehicleType}">
            <div class="info-bar">🚗 Showing orders for vehicle type: <strong style="color: white;">${driverVehicleType}</strong></div>
        </c:if>

        <c:if test="${empty availableBookings}">
            <div class="empty-msg">
                <h3>📝 No pending rides at the moment.</h3>
                <p>New requests will show up here when passengers book a ride.</p>
                <br>
                <a href="${pageContext.request.contextPath}/tasks" style="color: var(--primary); font-weight: bold; text-decoration: none; padding: 10px 20px; border: 1px solid var(--primary); border-radius: 50px;">🔄 Refresh Page</a>
            </div>
        </c:if>

        <c:forEach var="task" items="${availableBookings}">
            <div class="task-card">
                <div class="details">
                    <h4>📍 ${task.pickupLocation} ➔ 🏠 ${task.dropLocation}</h4>
                    <p>
                        <span class="badge">${task.requestedVehicleType}</span>
                        <span class="fare-badge">LKR ${task.fare}</span>
                        &nbsp;⏱ ${task.scheduledTime}
                        <c:if test="${task.bookingType == 'Scheduled'}"><span style="color: var(--primary); font-weight: bold; margin-left: 5px;">(SCHEDULED)</span></c:if>
                    </p>
                    <p style="color: var(--text-muted); font-size: 12px; margin-top: 10px;">Booking ID: ${task.bookingId}</p>
                </div>

                <form action="${pageContext.request.contextPath}/accept-booking/${task.bookingId}" method="post">
                    <button type="submit" class="btn-accept">✅ Accept Ride</button>
                </form>
            </div>
        </c:forEach>

        <c:if test="${param.error == 'invalid_code'}">
            <div class="info-bar" style="background: rgba(239, 68, 68, 0.1); border-color: rgba(239, 68, 68, 0.3); color: #fca5a5;">❌ Invalid Verification Code! Please ask the passenger for the correct code.</div>
        </c:if>
        <c:if test="${param.error == 'time_conflict'}">
            <div class="info-bar" style="background: rgba(239, 68, 68, 0.1); border-color: rgba(239, 68, 68, 0.3); color: #fca5a5;">❌ Time Conflict! You must have at least 6 hours between scheduled rides.</div>
        </c:if>

        <br><br>
        <div style="height: 120px; border-radius: 16px; margin-bottom: 20px; background: linear-gradient(rgba(0,0,0,0.2), rgba(0,0,0,0.6)), url('https://images.unsplash.com/photo-1449965408869-eaa3f722e40d?auto=format&fit=crop&q=80&w=1000') center/cover;"></div>
        <h2 style="color: var(--text-assignments);">My Active Assignments</h2>
        <p class="subtitle">Rides where you are on the way to pick up the passenger.</p>

        <c:set var="hasAccepted" value="false" />
        <c:forEach var="task" items="${myBookings}">
            <c:if test="${task.status == 'Accepted'}">
                <c:set var="hasAccepted" value="true" />
                <div class="task-card" style="border-left-color: #38bdf8;">
                    <div class="details">
                        <h4>📍 ${task.pickupLocation} ➔ 🏠 ${task.dropLocation}</h4>
                        <p>
                            <span class="badge" style="background: rgba(56, 189, 248, 0.2); color: #7dd3fc; border-color: rgba(56, 189, 248, 0.3);">${task.requestedVehicleType}</span>
                            <span class="fare-badge">LKR ${task.fare}</span>
                            &nbsp;⏱ ${task.scheduledTime}
                        </p>
                        <p style="font-size: 13px; color: var(--text-muted); margin-top: 10px;">Passenger: ${task.passengerId}</p>
                    </div>
                    <div style="text-align: right;">
                        <span class="badge" style="background: rgba(56, 189, 248, 0.1); color: #38bdf8; border-color: transparent; margin-bottom: 12px; display: inline-block;">ON THE WAY</span>
                        
                        <form action="${pageContext.request.contextPath}/start-booking/${task.bookingId}" method="post">
                            <input type="text" name="code" placeholder="4-digit code" required>
                            <br>
                            <button type="submit" class="btn-accept" style="background: #0ea5e9; box-shadow: none;">🚀 Start Trip</button>
                        </form>
                    </div>
                </div>
            </c:if>
        </c:forEach>
        <c:if test="${!hasAccepted}">
            <p style="text-align: center; color: var(--text-muted);">No rides currently being assigned.</p>
        </c:if>

        <br><br>
        <div style="height: 120px; border-radius: 16px; margin-bottom: 20px; background: linear-gradient(rgba(0,0,0,0.2), rgba(0,0,0,0.6)), url('https://images.unsplash.com/photo-1506784951209-243e05a8baf1?auto=format&fit=crop&q=80&w=1000') center/cover;"></div>
        <h2 style="color: var(--text-transit);">Passengers in Vehicle</h2>
        <p class="subtitle">Rides currently in transit.</p>

        <c:set var="hasStarted" value="false" />
        <c:forEach var="task" items="${myBookings}">
            <c:if test="${task.status == 'Started'}">
                <c:set var="hasStarted" value="true" />
                <div class="task-card" style="border-left-color: var(--primary);">
                    <div class="details">
                        <h4>📍 ${task.pickupLocation} ➔ 🏠 ${task.dropLocation}</h4>
                        <p>
                            <span class="badge" style="background: rgba(249, 115, 22, 0.2); color: #fdba74; border-color: rgba(249, 115, 22, 0.3);">${task.requestedVehicleType}</span>
                            <span class="fare-badge">LKR ${task.fare}</span>
                            &nbsp;⏱ ${task.scheduledTime}
                        </p>
                        <p style="font-size: 13px; color: var(--text-muted); margin-top: 10px;">Passenger: ${task.passengerId}</p>
                    </div>
                    <div style="text-align: right;">
                        <span class="badge" style="background: rgba(249, 115, 22, 0.1); color: var(--primary); border-color: transparent; margin-bottom: 12px; display: inline-block;">IN TRANSIT</span>
                        
                        <form action="${pageContext.request.contextPath}/complete-booking/${task.bookingId}" method="post">
                            <button type="submit" class="btn-accept" style="background: #10b981;">🏁 Finish Ride</button>
                        </form>
                    </div>
                </div>
            </c:if>
        </c:forEach>
        <c:if test="${!hasStarted}">
            <p style="text-align: center; color: var(--text-muted);">No passengers currently in vehicle.</p>
        </c:if>
    </div>
</body>
</html>
