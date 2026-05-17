<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Select Taxi Company | Zip SL</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Outfit', sans-serif; background: #f0f2f5; margin: 0; display: flex; flex-direction: column; align-items: center; min-height: 100vh; }
        .top-nav { width: 100%; background: #1a2a4a; padding: 20px 40px; box-shadow: 0 4px 20px rgba(0,0,0,0.1); margin-bottom: 40px; box-sizing: border-box; }
        .top-nav a { color: #f39c12; font-size: 28px; font-weight: 700; text-decoration: none; }
        
        .container { max-width: 900px; width: 100%; padding: 0 20px; box-sizing: border-box; text-align: center; }
        h1 { color: #1a2a4a; margin-bottom: 10px; font-size: 2.5rem; }
        p.subtitle { color: #64748b; margin-bottom: 40px; font-size: 1.1rem; }
        
        .company-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 25px; margin-bottom: 50px; }
        .company-card { background: white; border-radius: 20px; padding: 30px; box-shadow: 0 10px 25px rgba(0,0,0,0.05); transition: 0.3s; text-decoration: none; color: inherit; display: flex; flex-direction: column; align-items: center; border: 2px solid transparent; }
        .company-card:hover { transform: translateY(-10px); box-shadow: 0 15px 35px rgba(0,0,0,0.1); border-color: #3498db; }
        
        .company-icon { width: 80px; height: 80px; background: #e0f2fe; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 35px; margin-bottom: 20px; color: #0288d1; }
        .company-name { font-size: 1.4rem; font-weight: 700; color: #1e293b; margin-bottom: 10px; }
        .company-info { color: #64748b; font-size: 0.95rem; margin-bottom: 20px; }
        
        .btn-select { background: #3498db; color: white; padding: 12px 25px; border-radius: 12px; font-weight: 700; font-size: 1rem; transition: 0.3s; }
        .company-card:hover .btn-select { background: #1a2a4a; }
        
        .no-companies { background: white; padding: 60px; border-radius: 24px; box-shadow: 0 10px 25px rgba(0,0,0,0.05); }
    </style>
</head>
<body>

    <div class="top-nav">
        <a href="${pageContext.request.contextPath}/home">🚕 Zip SL</a>
    </div>

    <div class="container">
        <h1>Choose Your Service</h1>
        <p class="subtitle">Select a taxi company to see available vehicles and book your ride.</p>

        <c:if test="${empty companies}">
            <div class="no-companies">
                <div class="company-icon" style="margin: 0 auto 20px;">🏢</div>
                <h3>No taxi companies registered yet.</h3>
                <p>Please check back later or contact support.</p>
                <a href="${pageContext.request.contextPath}/home" style="color: #3498db; font-weight: bold; text-decoration: none;">Go Back</a>
            </div>
        </c:if>

        <div class="company-grid">
            <c:forEach var="comp" items="${companies}">
                <a href="${pageContext.request.contextPath}/book-taxi?companyId=${comp.id}" class="company-card">
                    <div class="company-icon">🏢</div>
                    <div class="company-name">${comp.name}</div>
                    <div class="company-info">📞 ${comp.phone}<br>✉️ ${comp.email}</div>
                    <div class="btn-select">View Availability →</div>
                </a>
            </c:forEach>
        </div>

        <a href="${pageContext.request.contextPath}/home" style="color: #64748b; text-decoration: none; font-weight: 600; display: inline-block; margin-bottom: 40px;">← Back to Home</a>
    </div>

</body>
</html>
