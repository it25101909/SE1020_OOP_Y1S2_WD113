<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome! Set Up Your Fleet | Zip SL</title>
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

        * { box-sizing: border-box; }
        body { 
            font-family: 'Outfit', sans-serif; 
            background: linear-gradient(135deg, var(--bg-dark) 0%, #1a1a2e 100%);
            color: var(--text-main);
            min-height: 100vh; 
            display: flex; 
            flex-direction: column;
            align-items: center; 
            justify-content: flex-start; 
            margin: 0; 
            padding: 0 20px 60px 20px; 
            overflow-x: hidden;
        }

        .top-nav { 
            width: 100%; 
            max-width: 1100px;
            padding: 20px 0; 
            box-sizing: border-box; 
            margin-bottom: 40px; 
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

        .logout-btn-nav {
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
        .logout-btn-nav:hover {
            background: #ef4444;
            color: white !important;
            box-shadow: 0 5px 15px rgba(239, 68, 68, 0.3);
            transform: translateY(-2px);
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
        .orb-1 { width: 500px; height: 500px; background: var(--primary); top: -10%; left: -10%; }
        .orb-2 { width: 600px; height: 600px; background: #4338ca; bottom: -10%; right: -10%; }

        .wizard { 
            background: var(--glass-bg); 
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-radius: 24px; 
            border: 1px solid var(--glass-border);
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5); 
            width: 100%; 
            max-width: 650px; 
            overflow: hidden; 
            z-index: 10;
            animation: fadeInUp 0.6s ease backwards;
        }

        .wizard-header { 
            background: rgba(0, 0, 0, 0.3); 
            padding: 40px 30px; 
            text-align: center; 
            border-bottom: 1px solid var(--glass-border);
        }
        .wizard-header h1 { 
            color: white; 
            font-size: 2rem; 
            margin: 0 0 10px 0; 
            font-weight: 700;
        }
        .wizard-header p { 
            color: var(--text-muted); 
            margin: 0; 
            font-size: 1.1rem; 
        }
        
        .steps { 
            display: flex; 
            background: rgba(0, 0, 0, 0.1);
        }
        .step { 
            flex: 1; 
            text-align: center; 
            padding: 15px 5px; 
            font-size: 14px; 
            font-weight: 700; 
            color: var(--text-muted); 
            border-bottom: 3px solid transparent; 
            transition: 0.3s; 
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .step.active { color: var(--primary); border-bottom-color: var(--primary); background: rgba(249, 115, 22, 0.05); }
        .step.done { color: #10b981; border-bottom-color: #10b981; }
        
        .wizard-body { padding: 40px 35px; }
        
        /* Step panels */
        .panel { display: none; }
        .panel.active { display: block; animation: fadeIn 0.4s; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(15px); } to { opacity: 1; transform: translateY(0); } }
        
        h2 { color: white; margin-top: 0; margin-bottom: 8px; font-size: 1.8rem; font-weight: 700; }
        .sub { color: var(--text-muted); margin-bottom: 30px; font-size: 15px; line-height: 1.5; }
        
        label { display: block; font-weight: 600; margin-bottom: 8px; color: var(--text-muted); font-size: 14px; }
        
        input, select { 
            width: 100%; 
            padding: 15px; 
            background: rgba(0, 0, 0, 0.2); 
            border: 1px solid var(--glass-border); 
            border-radius: 12px; 
            font-size: 15px; 
            margin-bottom: 25px; 
            color: white;
            font-family: 'Outfit', sans-serif;
            transition: 0.3s;
        }
        input:focus, select:focus { 
            outline: none; 
            border-color: var(--primary); 
            background: rgba(0, 0, 0, 0.4);
            box-shadow: 0 0 0 4px rgba(249, 115, 22, 0.1);
        }
        
        .btn-row { display: flex; gap: 15px; margin-top: 20px; }
        .btn { 
            flex: 1; 
            padding: 16px; 
            border: none; 
            border-radius: 12px; 
            font-size: 16px; 
            font-weight: 700; 
            cursor: pointer; 
            transition: 0.3s; 
            font-family: 'Outfit', sans-serif;
        }
        .btn-next { background: var(--primary); color: white; }
        .btn-next:hover { background: var(--primary-hover); transform: translateY(-2px); box-shadow: 0 10px 20px rgba(249, 115, 22, 0.3); }
        .btn-back { background: rgba(255, 255, 255, 0.1); color: white; border: 1px solid var(--glass-border); }
        .btn-back:hover { background: rgba(255, 255, 255, 0.15); transform: translateY(-2px); }
        .btn-finish { background: #10b981; color: white; }
        .btn-finish:hover { background: #059669; transform: translateY(-2px); box-shadow: 0 10px 20px rgba(16, 185, 129, 0.3); }
        
        /* Vehicle counters */
        .counter-row { 
            display: flex; 
            align-items: center; 
            margin-bottom: 15px; 
            background: rgba(0, 0, 0, 0.2); 
            border: 1px solid var(--glass-border);
            border-radius: 16px; 
            padding: 20px; 
            transition: 0.3s;
        }
        .counter-row:hover { background: rgba(255, 255, 255, 0.05); border-color: rgba(255, 255, 255, 0.2); }
        
        .counter-label { flex: 1; font-weight: 600; color: white; font-size: 1.1rem; }
        .counter-label span { display: block; font-size: 13px; color: var(--text-muted); font-weight: normal; margin-top: 4px; }
        
        .counter-controls { display: flex; align-items: center; gap: 15px; }
        .cnt-btn { 
            width: 40px; 
            height: 40px; 
            border-radius: 50%; 
            border: 1px solid var(--glass-border); 
            background: rgba(255, 255, 255, 0.05); 
            color: white;
            font-size: 20px; 
            cursor: pointer; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            transition: 0.2s; 
            line-height: 1; 
        }
        .cnt-btn:hover { border-color: var(--primary); color: var(--primary); background: rgba(249, 115, 22, 0.1); }
        .cnt-val { font-size: 1.4rem; font-weight: 700; color: var(--primary); min-width: 30px; text-align: center; }
        
        .total-box { 
            background: rgba(16, 185, 129, 0.1); 
            padding: 15px 20px; 
            border-radius: 12px; 
            text-align: center; 
            margin-top: 20px; 
            border: 1px solid rgba(16, 185, 129, 0.3);
            color: #34d399;
            font-size: 1.1rem;
        }
        .total-box strong { color: #10b981; font-size: 1.6rem; margin: 0 5px; }
        
        /* Summary */
        .summary-item { display: flex; justify-content: space-between; padding: 15px 0; border-bottom: 1px solid var(--glass-border); font-size: 1.1rem; }
        .summary-item:last-child { border-bottom: none; }
        .summary-item span:first-child { color: var(--text-muted); }
        .summary-item span:last-child { font-weight: 700; color: white; }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

    <div class="orb orb-1"></div>
    <div class="orb orb-2"></div>

    <div class="top-nav">
        <a href="${pageContext.request.contextPath}/home">🚕 Zip<span>SL</span></a>
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn-nav">Log Out</a>
    </div>

    <div class="wizard">
        <div class="wizard-header">
            <h1>🏢 Welcome, ${company.name}!</h1>
            <p>Let's get your fleet set up. It only takes 2 steps!</p>
        </div>
        
        <div class="steps">
            <div class="step active" id="tab1">1. Fleet Count</div>
            <div class="step" id="tab2">2. Confirm</div>
        </div>
        
        <div class="wizard-body">
            <form action="${pageContext.request.contextPath}/company/setup" method="post" id="setupForm">

                <!-- STEP 1: How many of each vehicle? -->
                <div class="panel active" id="panel1">
                    <h2>Set up your company profile</h2>
                    <p class="sub">Please enter your registration details and fleet counts to get started.</p>

                    <div class="form-group">
                        <label>Company Registration Number (ID)</label>
                        <input type="text" name="regId" placeholder="e.g. TAX-2024-XXX" required>
                    </div>

                    <h2 style="margin-top: 30px; font-size: 1.5rem;">How many vehicles do you have?</h2>
                    
                    <div class="counter-row">
                        <div class="counter-label">🛺 Tuk-Tuk <span>Three-wheeler</span></div>
                        <div class="counter-controls">
                            <button type="button" class="cnt-btn" onclick="change('tuk',-1)">−</button>
                            <span class="cnt-val" id="tuk-val">0</span>
                            <button type="button" class="cnt-btn" onclick="change('tuk',1)">+</button>
                        </div>
                    </div>
                    <div class="counter-row">
                        <div class="counter-label">🏍️ Motorbike <span>Fast, 1 passenger</span></div>
                        <div class="counter-controls">
                            <button type="button" class="cnt-btn" onclick="change('moto',-1)">−</button>
                            <span class="cnt-val" id="moto-val">0</span>
                            <button type="button" class="cnt-btn" onclick="change('moto',1)">+</button>
                        </div>
                    </div>
                    <div class="counter-row">
                        <div class="counter-label">🚗 Mini Car <span>Small car, up to 4 passengers</span></div>
                        <div class="counter-controls">
                            <button type="button" class="cnt-btn" onclick="change('mini',-1)">−</button>
                            <span class="cnt-val" id="mini-val">0</span>
                            <button type="button" class="cnt-btn" onclick="change('mini',1)">+</button>
                        </div>
                    </div>
                    <div class="counter-row">
                        <div class="counter-label">🚙 Sedan <span>Comfortable, up to 4 passengers</span></div>
                        <div class="counter-controls">
                            <button type="button" class="cnt-btn" onclick="change('sedan',-1)">−</button>
                            <span class="cnt-val" id="sedan-val">0</span>
                            <button type="button" class="cnt-btn" onclick="change('sedan',1)">+</button>
                        </div>
                    </div>
                    <div class="counter-row">
                        <div class="counter-label">✨ Premium <span>Superior comfort & legroom</span></div>
                        <div class="counter-controls">
                            <button type="button" class="cnt-btn" onclick="change('premium',-1)">−</button>
                            <span class="cnt-val" id="premium-val">0</span>
                            <button type="button" class="cnt-btn" onclick="change('premium',1)">+</button>
                        </div>
                    </div>
                    <div class="counter-row">
                        <div class="counter-label">🚐 Van/SUV <span>Large, up to 8 passengers</span></div>
                        <div class="counter-controls">
                            <button type="button" class="cnt-btn" onclick="change('van',-1)">−</button>
                            <span class="cnt-val" id="van-val">0</span>
                            <button type="button" class="cnt-btn" onclick="change('van',1)">+</button>
                        </div>
                    </div>
                    <div class="counter-row">
                        <div class="counter-label">🎩 Luxury <span>High-end premium experience</span></div>
                        <div class="counter-controls">
                            <button type="button" class="cnt-btn" onclick="change('luxury',-1)">−</button>
                            <span class="cnt-val" id="luxury-val">0</span>
                            <button type="button" class="cnt-btn" onclick="change('luxury',1)">+</button>
                        </div>
                    </div>
                    
                    <div class="total-box">Total Fleet: <strong id="total-val">0</strong> vehicles</div>
                    
                    <div class="btn-row" style="margin-top: 30px;">
                        <button type="button" class="btn btn-next" onclick="goToStep2()">Next Step →</button>
                    </div>
                </div>

                <!-- STEP 2: Confirm -->
                <div class="panel" id="panel2">
                    <h2>Confirm Your Fleet</h2>
                    <p class="sub">We will register these vehicles under your company account. You can change this anytime in Manage Fleet.</p>
                    
                    <div id="summary" style="background: rgba(0,0,0,0.2); padding: 20px; border-radius: 16px; border: 1px solid var(--glass-border); margin-bottom: 30px;"></div>
                    
                    <input type="hidden" name="tukCount" id="tukInput" value="0">
                    <input type="hidden" name="motoCount" id="motoInput" value="0">
                    <input type="hidden" name="miniCount" id="miniInput" value="0">
                    <input type="hidden" name="sedanCount" id="sedanInput" value="0">
                    <input type="hidden" name="premiumCount" id="premiumInput" value="0">
                    <input type="hidden" name="vanCount" id="vanInput" value="0">
                    <input type="hidden" name="luxuryCount" id="luxuryInput" value="0">
                    
                    <div class="btn-row">
                        <button type="button" class="btn btn-back" onclick="goToStep1()">← Go Back</button>
                        <button type="submit" class="btn btn-finish">✅ Finish Setup</button>
                    </div>
                </div>

            </form>
        </div>
    </div>

<script>
    const counts = { tuk: 0, moto: 0, mini: 0, sedan: 0, premium: 0, van: 0, luxury: 0 };
    const labels = { tuk: '🛺 Tuk-Tuk', moto: '🏍️ Motorbike', mini: '🚗 Mini Car', sedan: '🚙 Sedan', premium: '✨ Premium', van: '🚐 Van/SUV', luxury: '🎩 Luxury' };
    
    function change(type, delta) {
        counts[type] = Math.max(0, counts[type] + delta);
        document.getElementById(type + '-val').innerText = counts[type];
        document.getElementById('total-val').innerText = Object.values(counts).reduce((a,b) => a+b, 0);
    }
    
    function goToStep2() {
        let regId = document.querySelector('input[name="regId"]').value;
        if (!regId) { alert('Please enter your Company Registration Number.'); return; }

        let total = Object.values(counts).reduce((a,b) => a+b, 0);
        if (total === 0) { alert('Please add at least 1 vehicle to continue!'); return; }
        
        // Build summary HTML
        let html = '';
        for (let t in counts) {
            if (counts[t] > 0) {
                html += '<div class="summary-item"><span>' + labels[t] + '</span><span>' + counts[t] + ' vehicles</span></div>';
            }
        }
        html += '<div class="summary-item" style="border-top: 1px solid rgba(255,255,255,0.2); margin-top: 10px; padding-top: 20px;"><span><strong style="color:var(--primary);">Total Selection</strong></span><span><strong>' + total + ' vehicles</strong></span></div>';
        document.getElementById('summary').innerHTML = html;
        
        // Set hidden inputs
        document.getElementById('tukInput').value = counts.tuk;
        document.getElementById('motoInput').value = counts.moto;
        document.getElementById('miniInput').value = counts.mini;
        document.getElementById('sedanInput').value = counts.sedan;
        document.getElementById('premiumInput').value = counts.premium;
        document.getElementById('vanInput').value = counts.van;
        document.getElementById('luxuryInput').value = counts.luxury;
        
        document.getElementById('panel1').classList.remove('active');
        document.getElementById('panel2').classList.add('active');
        document.getElementById('tab1').classList.remove('active');
        document.getElementById('tab1').classList.add('done');
        document.getElementById('tab2').classList.add('active');
    }
    
    function goToStep1() {
        document.getElementById('panel2').classList.remove('active');
        document.getElementById('panel1').classList.add('active');
        document.getElementById('tab2').classList.remove('active');
        document.getElementById('tab1').classList.remove('done');
        document.getElementById('tab1').classList.add('active');
    }
</script>

</body>
</html>
