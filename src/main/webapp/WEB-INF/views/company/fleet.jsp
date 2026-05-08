<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Fleet | Zip SL</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #f97316;
            --primary-hover: #ea580c;
            --bg-dark: #0f0f11;
            --text-main: #f8fafc;
            --text-muted: #94a3b8;
            --glass-bg: rgba(20, 20, 25, 0.6);
            --glass-border: rgba(255, 255, 255, 0.1);
        }

        body { 
            font-family: 'Outfit', sans-serif; 
            background: #0f0f11;
            color: var(--text-main);
            margin: 0; 
            display: flex; 
            flex-direction: column; 
            align-items: center; 
            min-height: 100vh;
            overflow-x: hidden;
        }
        body::before {
            content: '';
            position: fixed;
            inset: 0;
            background: url('https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?auto=format&fit=crop&q=60&w=1920') center/cover no-repeat;
            opacity: 0.06;
            z-index: 0;
            pointer-events: none;
        }
        body::after {
            content: '';
            position: fixed;
            inset: 0;
            background:
                linear-gradient(135deg, rgba(15,15,17,0.93) 0%, rgba(26,26,46,0.93) 100%),
                radial-gradient(circle, rgba(249,115,22,0.06) 1px, transparent 1px);
            background-size: 100% 100%, 45px 45px;
            z-index: 0;
            pointer-events: none;
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
            max-width: 1100px; 
            width: 100%; 
            padding: 0 20px 40px; 
            box-sizing: border-box; 
            display: flex; 
            gap: 30px; 
            align-items: flex-start;
            z-index: 10;
            animation: fadeInUp 0.6s ease backwards;
        }
        
        .header-section {
            width: 100%;
            max-width: 1100px;
            padding: 0 20px;
            box-sizing: border-box;
            z-index: 10;
            margin-bottom: 20px;
        }
        h2 { color: white; margin-bottom: 5px; margin-top: 0; font-size: 2.2rem; font-weight: 700; }
        .header-section p { color: var(--text-muted); font-size: 1.1rem; }
        .header-section strong { color: var(--primary); font-size: 1.2rem; }
        
        .form-card { 
            background: var(--glass-bg); 
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            padding: 35px; 
            border-radius: 20px; 
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3); 
            border: 1px solid var(--glass-border);
            flex: 1; 
            min-width: 300px;
        }
        .form-card h3 { margin-top: 0; color: white; font-size: 1.5rem; margin-bottom: 25px; }
        
        .form-group { margin-bottom: 20px; }
        label { display: block; font-weight: 600; margin-bottom: 8px; color: var(--text-muted); font-size: 14px; }
        
        input, select { 
            width: 100%; 
            padding: 14px 16px; 
            background: rgba(0, 0, 0, 0.2); 
            border: 1px solid var(--glass-border); 
            border-radius: 12px; 
            box-sizing: border-box; 
            font-size: 15px; 
            color: var(--text-main);
            font-family: 'Outfit', sans-serif;
            transition: 0.3s;
        }
        select option { background: #1a1a2e; color: var(--text-main); }
        input:focus, select:focus { outline: none; border-color: var(--primary); background: rgba(0, 0, 0, 0.4); }
        
        .btn-submit { 
            background: var(--primary); 
            color: white; 
            border: none; 
            padding: 16px; 
            border-radius: 12px; 
            cursor: pointer; 
            font-weight: 700; 
            width: 100%; 
            font-size: 16px;
            transition: 0.3s; 
            font-family: 'Outfit', sans-serif;
            margin-top: 10px;
        }
        .btn-submit:hover { 
            background: var(--primary-hover); 
            transform: translateY(-2px);
            box-shadow: 0 10px 25px -5px rgba(249, 115, 22, 0.4);
        }
        
        .fleet-list { 
            flex: 2; 
            display: flex; 
            flex-direction: column; 
            gap: 20px; 
        }
        
        .vehicle-card { 
            background: var(--glass-bg); 
            backdrop-filter: blur(10px);
            padding: 25px; 
            border-radius: 16px; 
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2); 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            border: 1px solid var(--glass-border);
            border-left: 5px solid #0ea5e9; 
            transition: all 0.3s ease;
        }
        .vehicle-card:hover { transform: translateX(5px); background: rgba(255, 255, 255, 0.08); }
        
        .vehicle-card .details h4 { margin: 0 0 8px 0; color: white; font-size: 1.3rem; letter-spacing: 1px; }
        .badge { 
            background: rgba(14, 165, 233, 0.2); 
            color: #7dd3fc; 
            padding: 4px 10px; 
            border-radius: 6px; 
            font-weight: 700; 
            font-size: 12px; 
            border: 1px solid rgba(14, 165, 233, 0.3);
        }
        
        .btn-remove { 
            background: rgba(239, 68, 68, 0.1); 
            color: #fca5a5; 
            border: 1px solid rgba(239, 68, 68, 0.3); 
            padding: 10px 20px; 
            border-radius: 8px; 
            cursor: pointer; 
            font-weight: 700; 
            font-size: 14px; 
            font-family: 'Outfit', sans-serif;
            transition: 0.3s; 
        }
        .btn-remove:hover { background: #ef4444; color: white; box-shadow: 0 5px 15px rgba(239, 68, 68, 0.4); transform: translateY(-2px); }
        
        .empty-msg { 
            text-align: center; 
            color: var(--text-muted); 
            background: var(--glass-bg); 
            backdrop-filter: blur(10px);
            padding: 50px; 
            border-radius: 20px; 
            border: 1px solid var(--glass-border);
        }
        .empty-msg h3 { color: white; margin-bottom: 10px; font-size: 1.5rem; }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            .container { flex-direction: column; }
            .form-card { width: 100%; box-sizing: border-box; }
            .fleet-list { width: 100%; }
        }
    </style>
</head>
<body>
    <div class="orb orb-1"></div>
    <div class="orb orb-2"></div>

    <div class="top-nav">
        <a href="${pageContext.request.contextPath}/home">🚀 Zip<span>SL</span></a>
        <a href="${pageContext.request.contextPath}/home" class="back-link">← Back to Dashboard</a>
    </div>
    
    <div class="header-section">
        <h2>🏢 Manage Your Fleet</h2>
        <p>Total Vehicles: <strong>${fleet.size()}</strong></p>
    </div>

    <div class="container">
        <!-- Add Vehicle Form -->
        <div class="form-card">
            <h3>Add New Vehicle</h3>
            <form action="${pageContext.request.contextPath}/company/add-vehicle" method="post">
                <div class="form-group">
                    <label>Vehicle Type</label>
                    <select name="type" required>
                        <option value="Tuk">Three-Wheelers (Tuk-tuk)</option>
                        <option value="Moto">Motorbikes (Moto)</option>
                        <option value="Mini">Small Cars (Budget)</option>
                        <option value="Sedan">Standard Cars (Sedan)</option>
                        <option value="Premium">Premium Cars</option>
                        <option value="Van">Large Vehicles (Vans/SUVs)</option>
                        <option value="Luxury">Luxury Cars</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Model / Brand</label>
                    <input type="text" name="modelName" placeholder="e.g. Toyota Prius" required>
                </div>
                <div class="form-group">
                    <label>License Plate</label>
                    <input type="text" name="plateNumber" placeholder="e.g. WP ABC-1234" required>
                </div>
                <button type="submit" class="btn-submit">Add to Fleet</button>
            </form>
        </div>

        <!-- Fleet List -->
        <div class="fleet-list">
            <c:if test="${empty fleet}">
                <div class="empty-msg">
                    <h3>No vehicles in your fleet!</h3>
                    <p>Use the form on the left to add your first elite vehicle.</p>
                </div>
            </c:if>

            <c:forEach var="v" items="${fleet}">
                <div class="vehicle-card">
                    <div class="details">
                        <h4>${v.plateNumber}</h4>
                        <span class="badge">${v.type}</span> &bull; <span style="color: var(--text-muted); font-size: 14px;">${v.model}</span>
                    </div>
                    <form action="${pageContext.request.contextPath}/company/remove-vehicle/${v.vehicleId}" method="post">
                        <button type="submit" class="btn-remove" onclick="return confirm('Remove this vehicle from your fleet?');">Remove</button>
                    </form>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>
