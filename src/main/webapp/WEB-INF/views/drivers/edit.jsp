<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Driver Profile | Zip SL</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #f97316;
            --primary-hover: #ea580c;
            --bg-dark: #0f0f11;
            --text-main: #f8fafc;
            --text-muted: #94a3b8;
            --glass-bg: rgba(255, 255, 255, 0.05);
            --glass-border: rgba(255, 255, 255, 0.1);
        }

        body {
            font-family: 'Outfit', sans-serif;
            background: linear-gradient(135deg, var(--bg-dark) 0%, #1a1a2e 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            color: var(--text-main);
            padding: 40px 20px;
            box-sizing: border-box;
        }

        .orb {
            position: fixed;
            border-radius: 50%;
            filter: blur(80px);
            opacity: 0.3;
            z-index: 0;
            animation: float 12s infinite ease-in-out alternate;
        }
        .orb-1 { width: 350px; height: 350px; background: var(--primary); top: 5%; left: 10%; }
        .orb-2 { width: 450px; height: 450px; background: #4338ca; bottom: 5%; right: 5%; animation-delay: -4s; }

        .form-container {
            width: 100%;
            max-width: 600px;
            background: rgba(20, 20, 25, 0.6);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: 24px;
            padding: 40px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
            z-index: 10;
            animation: formAppear 0.6s cubic-bezier(0.16, 1, 0.3, 1);
        }

        h2 {
            margin-top: 0;
            margin-bottom: 30px;
            font-weight: 700;
            text-align: center;
            font-size: 24px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: var(--text-muted);
            margin-bottom: 8px;
        }

        input, select {
            width: 100%;
            padding: 14px 16px;
            background: rgba(0, 0, 0, 0.2);
            border: 1px solid var(--glass-border);
            border-radius: 12px;
            color: var(--text-main);
            font-size: 14px;
            font-family: 'Outfit', sans-serif;
            box-sizing: border-box;
            transition: 0.3s;
        }

        input:focus, select:focus {
            outline: none;
            border-color: var(--primary);
            background: rgba(0, 0, 0, 0.4);
        }

        .row {
            display: flex;
            gap: 15px;
        }

        .btn-save {
            width: 100%;
            padding: 16px;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 12px;
            font-weight: 700;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
            transition: 0.3s;
            font-family: 'Outfit', sans-serif;
        }

        .btn-save:hover {
            background: var(--primary-hover);
            transform: translateY(-2px);
            box-shadow: 0 10px 25px -5px rgba(249, 115, 22, 0.4);
        }

        .btn-cancel {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: var(--text-muted);
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
        }
        .btn-cancel:hover { color: white; }

        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 10px;
            background: rgba(0,0,0,0.2);
            padding: 12px 16px;
            border-radius: 12px;
            border: 1px solid var(--glass-border);
        }

        .checkbox-group input { width: auto; margin: 0; }

        @keyframes formAppear {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes float {
            0% { transform: translate(0, 0); }
            100% { transform: translate(30px, 30px); }
        }
    </style>
</head>
<body>
    <div class="orb orb-1"></div>
    <div class="orb orb-2"></div>

    <div class="form-container">
        <h2>Edit Driver Partner</h2>
        
        <form action="${pageContext.request.contextPath}/drivers/edit/${driver.id}" method="post">
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="name" value="${driver.name}" required>
            </div>

            <div class="row">
                <div class="form-group" style="flex: 1.5;">
                    <label>Email Address</label>
                    <input type="email" name="email" value="${driver.email}" required>
                </div>
                <div class="form-group" style="flex: 1;">
                    <label>Phone Number</label>
                    <input type="text" name="phone" value="${driver.phone}" required>
                </div>
            </div>

            <div class="form-group">
                <label>Password (Leave as is if no change)</label>
                <input type="password" name="password" value="${driver.password}" required>
            </div>

            <div class="row">
                <div class="form-group">
                    <label>License Number</label>
                    <input type="text" name="licenseNumber" value="${driver.licenseNumber}" required>
                </div>
                <div class="form-group">
                    <label>Vehicle Type</label>
                    <select name="vehicleType">
                        <option value="Tuk" ${driver.vehicleType == 'Tuk' ? 'selected' : ''}>Tuk-tuk</option>
                        <option value="Moto" ${driver.vehicleType == 'Moto' ? 'selected' : ''}>Motorbike</option>
                        <option value="Mini" ${driver.vehicleType == 'Mini' ? 'selected' : ''}>Mini Car</option>
                        <option value="Sedan" ${driver.vehicleType == 'Sedan' ? 'selected' : ''}>Sedan</option>
                        <option value="Premium" ${driver.vehicleType == 'Premium' ? 'selected' : ''}>Premium</option>
                        <option value="Van" ${driver.vehicleType == 'Van' ? 'selected' : ''}>Van/SUV</option>
                        <option value="Luxury" ${driver.vehicleType == 'Luxury' ? 'selected' : ''}>Luxury</option>
                    </select>
                </div>
            </div>

            <div class="row">
                <div class="form-group">
                    <label>Plate Number</label>
                    <input type="text" name="plateNumber" value="${driver.plateNumber}" required>
                </div>
                <div class="form-group">
                    <label>Company Name</label>
                    <input type="text" name="companyName" value="${driver.companyName}" required>
                </div>
            </div>

            <div class="form-group">
                <div class="checkbox-group">
                    <input type="checkbox" name="isAvailable" id="isAvailable" ${driver.available ? 'checked' : ''}>
                    <label for="isAvailable" style="margin: 0; cursor: pointer;">Currently Available for Rides</label>
                </div>
            </div>

            <button type="submit" class="btn-save">Update Driver Profile</button>
            <a href="${pageContext.request.contextPath}/drivers" class="btn-cancel">Cancel and Go Back</a>
        </form>
    </div>
</body>
</html>
