<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Directory | Zip SL</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #f97316;
            --primary-hover: #ea580c;
            --bg-dark: #08080a;
            --text-main: #f8fafc;
            --text-muted: #94a3b8;
            --glass-bg: rgba(255,255,255,0.05);
            --glass-border: rgba(255,255,255,0.1);
            --card-bg: rgba(20,20,25,0.6);
        }

        body {
            font-family: 'Outfit', sans-serif;
            background: #08080a;
            min-height: 100vh;
            margin: 0;
            padding: 0 20px 40px;
            color: var(--text-main);
            display: flex;
            flex-direction: column;
            align-items: center;
            overflow-x: hidden;
            position: relative;
        }

        /* Ambient Orbs */
        .orb {
            position: fixed;
            border-radius: 50%;
            filter: blur(100px);
            opacity: 0.3;
            z-index: 0;
            pointer-events: none;
            animation: float 15s infinite ease-in-out alternate;
        }
        .orb-1 { width: 400px; height: 400px; background: var(--primary); top: -10%; left: -10%; }
        .orb-2 { width: 500px; height: 500px; background: #4338ca; bottom: -10%; right: -10%; animation-delay: -5s; }

        .top-nav {
            width: 100%;
            max-width: 1200px;
            padding: 25px 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            z-index: 10;
        }

        .logo {
            font-size: 24px;
            font-weight: 800;
            color: var(--text-main);
            text-decoration: none;
        }
        .logo span { color: var(--primary); }

        .back-link {
            color: var(--text-muted);
            text-decoration: none;
            font-weight: 600;
            transition: 0.3s;
        }
        .back-link:hover { color: white; }

        .header {
            text-align: center;
            margin-bottom: 40px;
            z-index: 10;
            animation: fadeInDown 0.6s ease;
        }

        .header h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            font-weight: 700;
        }

        .container {
            width: 100%;
            max-width: 1100px;
            z-index: 10;
            animation: fadeInUp 0.6s ease backwards;
        }

        .table-container {
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 20px 50px rgba(0,0,0,0.3);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        th {
            padding: 20px;
            background: rgba(255,255,255,0.03);
            color: var(--text-muted);
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 1px;
            border-bottom: 1px solid var(--glass-border);
        }

        td {
            padding: 18px 20px;
            border-bottom: 1px solid var(--glass-border);
            font-size: 15px;
        }

        tr:last-child td { border-bottom: none; }

        tr:hover td { background: rgba(255,255,255,0.02); }

        .driver-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .driver-avatar {
            width: 40px;
            height: 40px;
            background: var(--primary);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            color: white;
        }

        .badge {
            padding: 5px 12px;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 700;
            display: inline-block;
        }

        .badge-available { background: rgba(34, 197, 94, 0.15); color: #4ade80; border: 1px solid rgba(34, 197, 94, 0.3); }
        .badge-busy { background: rgba(239, 68, 68, 0.15); color: #f87171; border: 1px solid rgba(239, 68, 68, 0.3); }

        .action-btns {
            display: flex;
            gap: 10px;
        }

        .btn {
            padding: 8px 16px;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 600;
            text-decoration: none;
            transition: 0.3s;
            cursor: pointer;
            border: 1px solid transparent;
            font-family: 'Outfit', sans-serif;
        }

        .btn-edit {
            background: rgba(255,255,255,0.05);
            color: white;
            border-color: var(--glass-border);
        }
        .btn-edit:hover { background: rgba(255,255,255,0.1); border-color: white; }

        .btn-delete {
            background: rgba(239, 68, 68, 0.1);
            color: #f87171;
            border-color: rgba(239, 68, 68, 0.2);
        }
        .btn-delete:hover { background: #ef4444; color: white; }

        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
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

    <div class="top-nav">
        <a href="${pageContext.request.contextPath}/home" class="logo">🚕 Zip<span>SL</span></a>
        <a href="${pageContext.request.contextPath}/home" class="back-link">← Back to Dashboard</a>
    </div>

    <div class="header">
        <h1>Driver Directory</h1>
        <p style="color: var(--text-muted);">Manage our elite team of professional partners</p>
    </div>

    <div class="container">
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Driver</th>
                        <th>Contact</th>
                        <th>Vehicle Type</th>
                        <th>Plate No</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="driver" items="${drivers}">
                        <tr>
                            <td>
                                <div class="driver-info">
                                     <div class="driver-avatar">${driver.name.substring(0,1)}</div>
                                    <div>
                                        <div style="font-weight: 700;">${driver.name}</div>
                                        <div style="font-size: 12px; color: var(--text-muted);">${driver.id}</div>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div>${driver.email}</div>
                                <div style="font-size: 13px; color: var(--text-muted);">${driver.phone}</div>
                            </td>
                            <td>
                                <span style="font-weight: 600;">${driver.vehicleType}</span>
                            </td>
                            <td>
                                <code style="background: rgba(0,0,0,0.3); padding: 4px 8px; border-radius: 6px; border: 1px solid var(--glass-border); font-family: monospace;">${driver.plateNumber}</code>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${driver.available}">
                                        <span class="badge badge-available">Available</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-busy">On Trip</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="action-btns">
                                    <a href="${pageContext.request.contextPath}/drivers/edit/${driver.id}" class="btn btn-edit">Edit</a>
                                    <a href="${pageContext.request.contextPath}/drivers/delete/${driver.id}" class="btn btn-delete" onclick="return confirm('Remove this driver partner?')">Remove</a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty drivers}">
                        <tr>
                            <td colspan="6" style="text-align: center; padding: 50px; color: var(--text-muted);">
                                <div style="font-size: 40px; margin-bottom: 10px;">🚕</div>
                                <h3>No drivers registered yet</h3>
                                <p>Partners will appear here once they join the platform.</p>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>

