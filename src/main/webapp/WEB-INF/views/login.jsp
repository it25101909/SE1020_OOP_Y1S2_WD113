<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Zip SL</title>
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
            background: #0f0f11;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            color: var(--text-main);
            overflow: hidden;
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
            position: absolute;
            border-radius: 50%;
            filter: blur(80px);
            opacity: 0.4;
            z-index: 0;
            animation: float 10s infinite ease-in-out alternate;
        }
        .orb-1 {
            width: 300px; height: 300px;
            background: var(--primary);
            top: 10%; left: 15%;
        }
        .orb-2 {
            width: 400px; height: 400px;
            background: #4338ca;
            bottom: 10%; right: 10%;
            animation-delay: -5s;
        }

        .login-card {
            background: rgba(20, 20, 25, 0.6);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            padding: 50px 40px;
            border-radius: 24px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
            width: 100%;
            max-width: 420px;
            z-index: 10;
            animation: formAppear 0.6s cubic-bezier(0.16, 1, 0.3, 1);
        }

        .logo-area {
            text-align: center;
            margin-bottom: 35px;
        }

        .logo-area a {
            font-size: 28px;
            font-weight: 800;
            color: var(--text-main);
            text-decoration: none;
        }
        .logo-area span { color: var(--primary); }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            color: var(--text-muted);
            margin-bottom: 8px;
            transition: 0.3s;
        }

        input {
            width: 100%;
            padding: 15px 16px;
            background: rgba(0, 0, 0, 0.2);
            border: 1px solid var(--glass-border);
            border-radius: 12px;
            color: var(--text-main);
            font-size: 15px;
            font-family: 'Outfit', sans-serif;
            box-sizing: border-box;
            transition: all 0.3s;
        }

        input:focus {
            outline: none;
            border-color: var(--primary);
            background: rgba(0, 0, 0, 0.4);
            box-shadow: 0 0 0 4px rgba(249, 115, 22, 0.1);
        }

        input:focus + label, input:not(:placeholder-shown) + label {
            color: var(--primary);
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
            letter-spacing: 0.5px;
        }

        button:hover {
            background: var(--primary-hover);
            transform: translateY(-2px);
            box-shadow: 0 10px 25px -5px rgba(249, 115, 22, 0.4);
        }

        button:active {
            transform: translateY(0);
        }

        .error {
            background: rgba(239, 68, 68, 0.1);
            border: 1px solid rgba(239, 68, 68, 0.3);
            color: #fca5a5;
            padding: 12px;
            border-radius: 8px;
            font-size: 14px;
            margin-bottom: 25px;
            text-align: center;
        }

        .success {
            background: rgba(34, 197, 94, 0.1);
            border: 1px solid rgba(34, 197, 94, 0.3);
            color: #86efac;
            padding: 12px;
            border-radius: 8px;
            font-size: 14px;
            margin-bottom: 25px;
            text-align: center;
        }

        .footer {
            text-align: center;
            margin-top: 30px;
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
    </style>
</head>
<body>
    <div class="orb orb-1"></div>
    <div class="orb orb-2"></div>

    <div class="login-card">
        <div class="logo-area">
            <a href="${pageContext.request.contextPath}/">🚕 Zip<span>SL</span></a>
        </div>
        
        <h2 style="margin-top: 0; margin-bottom: 25px; font-weight: 700; text-align: center; font-size: 22px;">Welcome Back</h2>

        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>

        <c:if test="${not empty message}">
            <div class="success">${message}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label>Email Address</label>
                <input type="email" name="email" placeholder="Enter your email" required>
            </div>

            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="Enter your password" required>
            </div>

            <button type="submit">Sign In</button>
        </form>

        <div class="footer">
            Don't have an account? <br><br>
            <a href="${pageContext.request.contextPath}/register">Passenger</a> &nbsp;|&nbsp; 
            <a href="${pageContext.request.contextPath}/drivers/register">Driver / Company</a>
        </div>
    </div>
</body>
</html>
