<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Zip SL | Premium Ride Service</title>
    <!-- Modern Font: Outfit -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #f97316; /* Vibrant Orange */
            --primary-hover: #ea580c;
            --bg-dark: #0f0f11;
            --bg-darker: #09090b;
            --bg-card: #18181b;
            --text-main: #f8fafc;
            --text-muted: #94a3b8;
            --glass-bg: rgba(255, 255, 255, 0.03);
            --glass-border: rgba(255, 255, 255, 0.08);
            --glass-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37);
        }
        
        body, html {
            margin: 0;
            padding: 0;
            font-family: 'Outfit', sans-serif;
            background-color: var(--bg-dark);
            color: var(--text-main);
            overflow-x: hidden;
            scroll-behavior: smooth;
        }

        /* Top Nav */
        .top-nav {
            position: absolute;
            top: 0;
            width: 100%;
            padding: 30px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-sizing: border-box;
            z-index: 100;
        }

        .logo {
            font-size: 28px;
            font-weight: 800;
            color: var(--text-main);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .logo span { color: var(--primary); }

        .nav-links { display: flex; gap: 30px; align-items: center; }
        .nav-links a { color: var(--text-main); text-decoration: none; font-weight: 500; transition: 0.3s; }
        .nav-links a:hover { color: var(--primary); }

        .login-btn {
            color: var(--text-main);
            text-decoration: none;
            font-weight: 600;
            font-size: 1rem;
            padding: 10px 25px;
            border: 1px solid var(--glass-border);
            border-radius: 50px;
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            transition: 0.3s ease;
        }

        .login-btn:hover {
            background: var(--glass-bg);
            border-color: white;
            color: white;
        }

        .signup-btn {
            color: white;
            text-decoration: none;
            font-weight: 600;
            font-size: 1rem;
            padding: 10px 25px;
            background: var(--primary);
            border-radius: 50px;
            transition: 0.3s ease;
        }

        .signup-btn:hover {
            background: var(--primary-hover);
            box-shadow: 0 0 20px rgba(249, 115, 22, 0.4);
        }

        /* Hero Section */
        .hero {
            min-height: 100vh;
            background: linear-gradient(135deg, rgba(15, 15, 17, 0.95) 0%, rgba(15, 15, 17, 0.7) 100%), 
                        url('https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?auto=format&fit=crop&q=80&w=2070') center/cover no-repeat;
            display: flex;
            align-items: center;
            position: relative;
            padding: 100px 50px 50px;
            box-sizing: border-box;
        }

        .hero::before {
            content: '';
            position: absolute;
            width: 800px;
            height: 800px;
            background: radial-gradient(circle, rgba(249, 115, 22, 0.15) 0%, rgba(0,0,0,0) 60%);
            top: 30%;
            left: 20%;
            transform: translate(-50%, -50%);
            z-index: 0;
            pointer-events: none;
        }

        .hero-content {
            max-width: 1300px;
            width: 100%;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 50px;
            position: relative;
            z-index: 10;
        }

        .hero-text { flex: 1; }
        .hero-text h1 {
            font-size: 4.5rem;
            font-weight: 800;
            margin-bottom: 20px;
            letter-spacing: -2px;
            line-height: 1.1;
            animation: fadeInDown 1s ease;
        }
        .hero-text h1 span {
            background: linear-gradient(90deg, var(--primary), #ffb703);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .hero-text p {
            font-size: 1.3rem;
            font-weight: 300;
            color: var(--text-muted);
            margin-bottom: 40px;
            max-width: 500px;
            animation: fadeInUp 1s ease 0.3s forwards;
            opacity: 0;
        }

        /* Glass booking form */
        .booking-widget {
            background: rgba(20, 20, 25, 0.7);
            backdrop-filter: blur(25px);
            -webkit-backdrop-filter: blur(25px);
            border: 1px solid var(--glass-border);
            border-radius: 24px;
            padding: 40px;
            width: 400px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
            animation: fadeInUp 1s ease 0.5s forwards;
            opacity: 0;
        }
        .booking-widget h2 { margin-top: 0; font-size: 1.8rem; margin-bottom: 25px; }
        .input-group { position: relative; margin-bottom: 20px; }
        .input-group input {
            width: 100%;
            padding: 16px 20px 16px 45px;
            background: rgba(0, 0, 0, 0.4);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            color: white;
            font-size: 1rem;
            font-family: 'Outfit', sans-serif;
            box-sizing: border-box;
            transition: 0.3s;
        }
        .input-group input:focus { outline: none; border-color: var(--primary); background: rgba(0, 0, 0, 0.6); }
        .input-icon { position: absolute; left: 15px; top: 50%; transform: translateY(-50%); font-size: 1.2rem; }
        
        .btn-primary {
            display: inline-block;
            width: 100%;
            text-align: center;
            background: var(--primary);
            color: white;
            padding: 16px;
            border-radius: 12px;
            font-weight: 700;
            font-size: 1.1rem;
            text-decoration: none;
            transition: 0.3s;
            box-shadow: 0 10px 25px -5px rgba(249, 115, 22, 0.4);
            box-sizing: border-box;
            border: none;
            cursor: pointer;
        }
        .btn-primary:hover { background: var(--primary-hover); transform: translateY(-2px); }

        /* Generic Section Styles */
        .section { padding: 120px 50px; text-align: center; }
        .section-header { margin-bottom: 60px; }
        .section-header h2 { font-size: 3rem; font-weight: 800; margin-bottom: 15px; }
        .section-header p { font-size: 1.2rem; color: var(--text-muted); max-width: 600px; margin: 0 auto; }

        /* Explore Section */
        .explore { background: var(--bg-dark); }
        .explore-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 40px;
            max-width: 1300px;
            margin: 0 auto;
        }
        .explore-card {
            background: var(--bg-card);
            border: 1px solid var(--glass-border);
            border-radius: 24px;
            overflow: hidden;
            text-align: left;
            transition: 0.4s;
            display: flex;
            flex-direction: column;
        }
        .explore-card:hover { 
            transform: translateY(-10px); 
            border-color: rgba(249, 115, 22, 0.5); 
            box-shadow: 0 20px 40px rgba(0,0,0,0.4); 
        }
        .explore-card img {
            width: 100%;
            height: 250px;
            object-fit: cover;
            border-bottom: 1px solid var(--glass-border);
        }
        .explore-info {
            padding: 30px;
            display: flex;
            flex-direction: column;
            flex: 1;
        }
        .explore-info h3 { font-size: 1.8rem; margin: 0 0 15px 0; font-weight: 700; }
        .explore-info p { color: var(--text-muted); font-size: 1.1rem; line-height: 1.6; margin: 0 0 25px 0; flex: 1; }
        .explore-info a {
            color: var(--text-main);
            text-decoration: none;
            font-weight: 600;
            font-size: 1.05rem;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: 0.3s;
            border-bottom: 2px solid transparent;
            width: fit-content;
        }
        .explore-info a:hover {
            color: var(--primary);
        }

        /* Fleet Section */
        .fleet { background: var(--bg-darker); }
        .fleet-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
            max-width: 1200px;
            margin: 0 auto;
        }
        .fleet-card {
            background: var(--bg-card);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            overflow: hidden;
            transition: 0.4s;
            cursor: pointer;
        }
        .fleet-card:hover { transform: translateY(-10px); border-color: var(--primary); box-shadow: 0 20px 40px rgba(249,115,22,0.2); }
        .fleet-img {
            width: 100%;
            height: 160px;
            object-fit: cover;
            display: block;
            transition: transform 0.5s ease;
        }
        .fleet-card:hover .fleet-img { transform: scale(1.08); }
        .fleet-card-body { padding: 22px 20px 24px; }
        .fleet-card-body h3 { font-size: 1.2rem; margin: 0 0 8px 0; font-weight: 700; }
        .fleet-card-body p { color: var(--text-muted); font-size: 0.9rem; margin: 0; line-height: 1.5; }
        .fleet-card-tag {
            display: inline-block;
            margin-bottom: 10px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: var(--primary);
            background: rgba(249,115,22,0.1);
            border: 1px solid rgba(249,115,22,0.25);
            padding: 3px 10px;
            border-radius: 20px;
        }

        /* Safety Section */
        .safety-content {
            display: flex;
            align-items: center;
            gap: 60px;
            max-width: 1200px;
            margin: 0 auto;
            text-align: left;
        }
        .safety-text { flex: 1; }
        .safety-text h2 { font-size: 3rem; font-weight: 800; margin-bottom: 20px; }
        .safety-text p { font-size: 1.2rem; color: var(--text-muted); line-height: 1.7; margin-bottom: 30px; }
        .safety-features { list-style: none; padding: 0; }
        .safety-features li { display: flex; align-items: center; gap: 15px; margin-bottom: 20px; font-size: 1.1rem; }
        .safety-features li .icon { background: rgba(249, 115, 22, 0.1); color: var(--primary); padding: 10px; border-radius: 50%; }
        
        .safety-visual { flex: 1; position: relative; }
        .safety-glass-box {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: 24px;
            padding: 40px;
            position: relative;
            z-index: 2;
        }
        .safety-visual::before {
            content: ''; position: absolute; width: 300px; height: 300px; background: #3b82f6; filter: blur(80px); opacity: 0.2; top: -20px; left: -20px; z-index: 0;
        }

        /* Join Section */
        .join-section {
            display: flex;
            flex-wrap: wrap;
            margin: 0;
            padding: 0;
        }
        .join-half {
            flex: 1;
            min-width: 300px;
            padding: 100px 60px;
            text-align: center;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            position: relative;
            overflow: hidden;
        }
        .passenger-half { background: var(--bg-dark); border-top: 1px solid var(--glass-border); border-right: 1px solid var(--glass-border); }
        .driver-half { background: linear-gradient(135deg, var(--primary), var(--primary-hover)); color: white; }
        .join-half h2 { font-size: 2.5rem; margin-bottom: 20px; font-weight: 800; z-index: 2; }
        .join-half p { font-size: 1.1rem; max-width: 400px; margin-bottom: 30px; opacity: 0.9; line-height: 1.6; z-index: 2; }
        
        .driver-half p { opacity: 1; }
        .passenger-half .btn-join { background: var(--primary); color: white; padding: 14px 30px; border-radius: 50px; text-decoration: none; font-weight: 600; z-index: 2; transition: 0.3s; }
        .passenger-half .btn-join:hover { background: var(--primary-hover); transform: translateY(-2px); }
        .driver-half .btn-join { background: white; color: var(--primary-hover); padding: 14px 30px; border-radius: 50px; text-decoration: none; font-weight: 600; z-index: 2; transition: 0.3s; }
        .driver-half .btn-join:hover { box-shadow: 0 10px 20px rgba(0,0,0,0.2); transform: translateY(-2px); }

        /* Footer */
        footer { padding: 40px 50px; border-top: 1px solid var(--glass-border); text-align: center; color: var(--text-muted); font-size: 0.9rem; }

        /* Animations */
        @keyframes fadeInDown { from { opacity: 0; transform: translateY(-40px); } to { opacity: 1; transform: translateY(0); } }
        @keyframes fadeInUp { from { opacity: 0; transform: translateY(40px); } to { opacity: 1; transform: translateY(0); } }

        /* Responsive */
        @media (max-width: 992px) {
            .hero-content { flex-direction: column; text-align: center; padding-top: 50px; }
            .hero-text h1 { font-size: 3.5rem; }
            .hero-text p { margin: 0 auto 40px; }
            .booking-widget { width: 100%; max-width: 400px; }
            .explore-grid { grid-template-columns: 1fr; }
            .safety-content { flex-direction: column; text-align: center; }
            .safety-features li { justify-content: center; }
            .join-section { flex-direction: column; }
            .passenger-half { border-right: none; }
        }
        @media (max-width: 768px) {
            .nav-links { display: none; }
            .top-nav { padding: 20px; }
        }
    </style>
</head>
<body>

    <nav class="top-nav">
        <a href="${pageContext.request.contextPath}/" class="logo">🚕 Zip<span>SL</span></a>
        <div class="nav-links">
            <a href="#ride">Ride</a>
            <a href="#explore">Explore</a>
            <a href="#safety">Safety</a>
        </div>
        <div class="auth-buttons" style="display: flex; gap: 15px;">
            <a href="${pageContext.request.contextPath}/login" class="login-btn">Log In</a>
            <a href="${pageContext.request.contextPath}/register" class="signup-btn">Sign Up</a>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero" id="ride">
        <div class="hero-content">
            <div class="hero-text">
                <h1>Go anywhere with<br><span>Zip SL</span></h1>
                <p>Request a ride, hop in, and go. Discover the most reliable way to get around your city with transparent pricing and top-rated drivers.</p>
            </div>
            
            <div class="booking-widget">
                <h2>Request a ride</h2>
                <form action="${pageContext.request.contextPath}/login">
                    <div class="input-group">
                        <span class="input-icon">📍</span>
                        <input type="text" placeholder="Enter pickup location">
                    </div>
                    <div class="input-group">
                        <span class="input-icon">🏁</span>
                        <input type="text" placeholder="Enter destination">
                    </div>
                    <button type="submit" class="btn-primary">See prices & book</button>
                </form>
            </div>
        </div>
    </section>

    <!-- Explore Section -->
    <section class="section explore" id="explore">
        <div class="section-header">
            <h2>Explore what you can do</h2>
            <p>Unlock all the ways Zip SL can help you move, earn, and succeed in the city.</p>
        </div>
        <div class="explore-grid">
            <div class="explore-card">
                <img src="https://images.unsplash.com/photo-1449965408869-eaa3f722e40d?auto=format&fit=crop&q=80&w=600" alt="Ride">
                <div class="explore-info">
                    <h3>Ride with us</h3>
                    <p>Go wherever you need. From daily commutes to special events, request a premium ride on demand in just seconds.</p>
                    <a href="${pageContext.request.contextPath}/register">Get a ride &nbsp;&nbsp;<span>&#8594;</span></a>
                </div>
            </div>
            <div class="explore-card">
                <img src="https://images.unsplash.com/photo-1504215680853-026ed2a45def?auto=format&fit=crop&q=80&w=600" alt="Drive">
                <div class="explore-info">
                    <h3>Drive and earn</h3>
                    <p>Make money on your schedule. Drive with us and get paid for helping people move around the city.</p>
                    <a href="${pageContext.request.contextPath}/drivers/register">Sign up to drive &nbsp;&nbsp;<span>&#8594;</span></a>
                </div>
            </div>
            <div class="explore-card">
                <img src="https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?auto=format&fit=crop&q=80&w=600" alt="Business">
                <div class="explore-info">
                    <h3>For Business</h3>
                    <p>Register your entire fleet. Easily manage multiple vehicles, track your drivers, and unlock enterprise-level earning potential.</p>
                    <a href="${pageContext.request.contextPath}/drivers/register">Create a company account &nbsp;&nbsp;<span>&#8594;</span></a>
                </div>
            </div>
        </div>
    </section>

    <!-- Fleet Section -->
    <section class="section fleet">
        <div class="section-header">
            <h2>Ride your way</h2>
            <p>From quick grocery runs to luxury corporate travel, we have the perfect vehicle for every occasion.</p>
        </div>
        <div class="fleet-grid">
            <div class="fleet-card">
                <img class="fleet-img" src="https://images.unsplash.com/photo-1566041510394-cf7c8fe21800?auto=format&fit=crop&q=80&w=600&h=400&crop=center" alt="Tuk-tuk">
                <div class="fleet-card-body">
                    <span class="fleet-card-tag">Tuk &bull; Up to 3 pax</span>
                    <h3>Three-Wheelers (Tuk-tuk)</h3>
                    <p>Most common and cheapest option. Perfect for short city trips.</p>
                </div>
            </div>
            <div class="fleet-card">
                <img class="fleet-img" src="https://images.unsplash.com/photo-1558981403-c5f9899a28bc?auto=format&fit=crop&q=80&w=600" alt="Motorbike">
                <div class="fleet-card-body">
                    <span class="fleet-card-tag">Moto &bull; 1 pax</span>
                    <h3>Motorbikes (Moto)</h3>
                    <p>Fast and cheap for traffic-heavy areas. Best for solo riders.</p>
                </div>
            </div>
            <div class="fleet-card">
                <img class="fleet-img" src="https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?auto=format&fit=crop&q=80&w=600" alt="Budget Car">
                <div class="fleet-card-body">
                    <span class="fleet-card-tag">Mini &bull; Up to 4 pax</span>
                    <h3>Small Cars (Budget)</h3>
                    <p>Cheapest car option. Great for everyday quick errands.</p>
                </div>
            </div>
            <div class="fleet-card">
                <img class="fleet-img" src="https://images.unsplash.com/photo-1502877338535-766e1452684a?auto=format&fit=crop&q=80&w=600" alt="Sedan">
                <div class="fleet-card-body">
                    <span class="fleet-card-tag">Sedan &bull; Up to 4 pax</span>
                    <h3>Standard Cars (Sedan)</h3>
                    <p>Comfortable AC ride for up to 4 passengers. Reliable daily travel.</p>
                </div>
            </div>
            <div class="fleet-card">
                <img class="fleet-img" src="https://images.unsplash.com/photo-1555215695-3004980ad54e?auto=format&fit=crop&q=80&w=600" alt="Premium Car">
                <div class="fleet-card-body">
                    <span class="fleet-card-tag">Premium &bull; Up to 4 pax</span>
                    <h3>Premium Cars</h3>
                    <p>Better comfort, more legroom, and higher-rated drivers.</p>
                </div>
            </div>
            <div class="fleet-card">
                <img class="fleet-img" src="https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?auto=format&fit=crop&q=80&w=600" alt="Van SUV">
                <div class="fleet-card-body">
                    <span class="fleet-card-tag">Van/SUV &bull; 6&ndash;7+ pax</span>
                    <h3>Large Vehicles (Vans/SUVs)</h3>
                    <p>For groups or heavy luggage. Spacious for every journey.</p>
                </div>
            </div>
            <div class="fleet-card">
                <img class="fleet-img" src="https://images.unsplash.com/photo-1563720223185-11003d516935?auto=format&fit=crop&q=80&w=600" alt="Luxury Car">
                <div class="fleet-card-body">
                    <span class="fleet-card-tag">Luxury &bull; Up to 4 pax</span>
                    <h3>Luxury Cars</h3>
                    <p>High-end experience with leather seats in top-tier sedans or SUVs.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Safety Section -->
    <section class="section" id="safety">
        <div class="safety-content">
            <div class="safety-text">
                <h2>Your safety drives us</h2>
                <p>Whether you're in the back seat or behind the wheel, your safety is our first priority. We've built technology to keep you protected throughout your journey.</p>
                <ul class="safety-features">
                    <li><span class="icon">🛡️</span> Verified and background-checked drivers</li>
                    <li><span class="icon">📍</span> GPS tracking on every trip</li>
                    <li><span class="icon">📞</span> 24/7 dedicated customer support</li>
                    <li><span class="icon">🔒</span> Secure, cashless payment options</li>
                </ul>
            </div>
            <div class="safety-visual">
                <div class="safety-glass-box">
                    <h3 style="font-size: 1.5rem; margin-top: 0; margin-bottom: 15px;">Ride with confidence</h3>
                    <p style="color: var(--text-muted); line-height: 1.6; margin-bottom: 20px;">Share your trip details with loved ones. Our app lets them track your ride in real-time so they know when you arrive safely.</p>
                    <a href="${pageContext.request.contextPath}/register" style="color: var(--primary); text-decoration: none; font-weight: 700;">Learn about our safety features →</a>
                </div>
            </div>
        </div>
    </section>

    <!-- Join Section -->
    <section class="join-section">
        <div class="join-half passenger-half">
            <h2>Ready to ride?</h2>
            <p>Create an account today. Setup your payment methods once and enjoy seamless booking forever.</p>
            <a href="${pageContext.request.contextPath}/register" class="btn-join">Sign up to ride</a>
        </div>
        
        <div class="join-half driver-half">
            <h2>Drive and earn</h2>
            <p>Drive on the platform with the largest network of active riders. Register as an individual driver or add your entire company fleet.</p>
            <a href="${pageContext.request.contextPath}/drivers/register" class="btn-join">Sign up to drive</a>
        </div>
    </section>

    <footer>
        <p>&copy; 2024 Zip SL. All rights reserved. Premium transport solutions.</p>
    </footer>

</body>
</html>
