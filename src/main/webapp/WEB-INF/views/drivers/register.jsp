<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Partner Registration | Zip SL</title>
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
            overflow-x: hidden;
            padding: 20px;
            box-sizing: border-box;
        }

        /* Ambient Orbs */
        .orb {
            position: fixed;
            border-radius: 50%;
            filter: blur(80px);
            opacity: 0.3;
            z-index: 0;
            animation: float 12s infinite ease-in-out alternate;
        }
        .orb-1 {
            width: 350px; height: 350px;
            background: var(--primary);
            top: 5%; left: 10%;
        }
        .orb-2 {
            width: 450px; height: 450px;
            background: #4338ca;
            bottom: 5%; right: 5%;
            animation-delay: -4s;
        }

        .split-container {
            display: flex;
            width: 100%;
            max-width: 1000px;
            background: rgba(20, 20, 25, 0.6);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: 24px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
            z-index: 10;
            overflow: hidden;
            animation: formAppear 0.6s cubic-bezier(0.16, 1, 0.3, 1);
        }

        .image-side {
            flex: 1;
            background: linear-gradient(135deg, rgba(249, 115, 22, 0.8), rgba(67, 56, 202, 0.8)), url('https://images.unsplash.com/photo-1519003722824-194d4455a60c?auto=format&fit=crop&q=80&w=1000') center/cover;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 40px;
            text-align: center;
            color: white;
        }

        .image-side h2 {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 15px;
            line-height: 1.2;
        }

        .image-side p {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        .form-side {
            flex: 1.2;
            padding: 40px;
            max-height: 90vh;
            overflow-y: auto;
        }
        
        .form-side::-webkit-scrollbar {
            width: 6px;
        }
        .form-side::-webkit-scrollbar-thumb {
            background-color: var(--glass-border);
            border-radius: 10px;
        }

        .logo-area {
            text-align: center;
            margin-bottom: 20px;
        }

        .logo-area a {
            font-size: 24px;
            font-weight: 800;
            color: var(--text-main);
            text-decoration: none;
        }
        .logo-area span { color: var(--primary); }

        .form-side h2 {
            margin-top: 0;
            margin-bottom: 20px;
            font-weight: 700;
            text-align: center;
            font-size: 22px;
        }

        /* Toggle Group */
        .toggle-group {
            display: flex;
            gap: 10px;
            margin-bottom: 25px;
            background: rgba(0, 0, 0, 0.3);
            padding: 6px;
            border-radius: 14px;
            border: 1px solid var(--glass-border);
        }
        .toggle-btn {
            flex: 1;
            text-align: center;
            padding: 12px;
            cursor: pointer;
            border-radius: 10px;
            font-weight: 600;
            color: var(--text-muted);
            transition: all 0.3s ease;
            font-size: 14px;
        }
        .toggle-btn.active {
            background: var(--primary);
            color: white;
            box-shadow: 0 4px 10px rgba(249, 115, 22, 0.3);
        }

        .row {
            display: flex;
            gap: 15px;
        }

        .form-group {
            margin-bottom: 20px;
            flex: 1;
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
            transition: all 0.3s;
        }

        select option {
            background: #1a1a2e;
            color: var(--text-main);
        }

        input:focus, select:focus {
            outline: none;
            border-color: var(--primary);
            background: rgba(0, 0, 0, 0.4);
            box-shadow: 0 0 0 4px rgba(249, 115, 22, 0.1);
        }

        button {
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
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            font-family: 'Outfit', sans-serif;
        }

        button:hover {
            background: var(--primary-hover);
            transform: translateY(-2px);
            box-shadow: 0 10px 25px -5px rgba(249, 115, 22, 0.4);
        }

        .hidden { display: none; }

        .footer {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
            color: var(--text-muted);
        }

        .footer a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
            transition: 0.3s;
        }

        .footer a:hover {
            color: white;
        }

        @keyframes formAppear {
            from { opacity: 0; transform: translateY(20px) scale(0.98); }
            to { opacity: 1; transform: translateY(0) scale(1); }
        }

        @keyframes float {
            0% { transform: translate(0, 0); }
            100% { transform: translate(30px, 30px); }
        }

        @media (max-width: 768px) {
            .split-container { flex-direction: column; }
            .image-side { padding: 30px; display: none; }
            .form-side { padding: 30px 20px; max-height: none; overflow-y: visible; }
            .row { flex-direction: column; gap: 0; }
        }
    </style>
</head>
<body>
    <div class="orb orb-1"></div>
    <div class="orb orb-2"></div>

    <div class="split-container">
        <div class="image-side">
            <h2>Drive With The Best</h2>
            <p>Join the most respected and high-earning fleet in the city. Drive on your own terms.</p>
        </div>

        <div class="form-side">
            <div class="logo-area">
                <a href="${pageContext.request.contextPath}/">Ã°Å¸Å¡â€¢ Zip<span>SL</span></a>
            </div>
            
            <h2>Partner Registration</h2>

            <div class="toggle-group">
                <div class="toggle-btn active" id="btn-individual" onclick="setMode('Individual')">Individual Driver</div>
                <div class="toggle-btn" id="btn-company" onclick="setMode('Company')">Taxi Company</div>
            </div>

            <form action="${pageContext.request.contextPath}/drivers/register" method="post">
                <input type="hidden" name="accountType" id="accountType" value="Individual">

                <div class="form-group">
                    <label id="lblName">Full Name</label>
                    <input type="text" name="name" required>
                </div>

                <div class="row">
                    <div class="form-group">
                        <label>Email Address</label>
                        <input type="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label>Phone Number</label>
                        <input type="text" name="phone" required>
                    </div>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" required>
                </div>

                <!-- Individual Driver Only Fields -->
                <div id="individual-fields">
                    <div class="row">
                        <div class="form-group">
                            <label>License Number</label>
                            <input type="text" name="licenseNumber" id="licenseInput" required>
                        </div>
                        <div class="form-group">
                            <label>Vehicle Type</label>
                            <select name="vehicleType" id="vehicleTypeInput">
                                <option value="Tuk">Three-Wheelers (Tuk-tuk)</option>
                                <option value="Moto">Motorbikes (Moto)</option>
                                <option value="Mini">Small Cars (Budget)</option>
                                <option value="Sedan">Standard Cars (Sedan)</option>
                                <option value="Premium">Premium Cars</option>
                                <option value="Van">Large Vehicles (Vans/SUVs)</option>
                                <option value="Luxury">Luxury Cars</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Vehicle Plate Number</label>
                        <input type="text" name="plateNumber" id="plateInput" placeholder="e.g. WP ABC-1234" required>
                    </div>
                </div>

                <button type="submit" id="submitBtn">Register as Driver</button>
            </form>

            <div class="footer">
                Looking for a ride? <a href="${pageContext.request.contextPath}/register">Passenger Registration</a><br><br>
                Already a partner? <a href="${pageContext.request.contextPath}/login">Sign In</a>
            </div>
        </div>
    </div>

    <script>
        function setMode(mode) {
            document.getElementById('accountType').value = mode;
            
            if (mode === 'Company') {
                document.getElementById('btn-company').classList.add('active');
                document.getElementById('btn-individual').classList.remove('active');
                
                document.getElementById('individual-fields').classList.add('hidden');
                document.getElementById('lblName').innerText = "Company Name";
                document.getElementById('submitBtn').innerText = "Register Company";
                
                // Remove required constraints
                document.getElementById('licenseInput').removeAttribute('required');
                document.getElementById('plateInput').removeAttribute('required');
            } else {
                document.getElementById('btn-individual').classList.add('active');
                document.getElementById('btn-company').classList.remove('active');
                
                document.getElementById('individual-fields').classList.remove('hidden');
                document.getElementById('lblName').innerText = "Full Name";
                document.getElementById('submitBtn').innerText = "Register as Driver";
                
                // Add required constraints
                document.getElementById('licenseInput').setAttribute('required', 'true');
                document.getElementById('plateInput').setAttribute('required', 'true');
            }
        }
    </script>
</body>
</html>
