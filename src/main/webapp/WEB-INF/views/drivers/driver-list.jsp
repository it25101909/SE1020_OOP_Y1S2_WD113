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
            --bg: #08080a;
            --text: #f8fafc;
            --muted: #94a3b8;
            --glass: rgba(255,255,255,0.05);
            --border: rgba(255,255,255,0.1);
        }

        body {
            font-family: 'Outfit', sans-serif;
            background: var(--bg);
            margin: 0;
            padding: 20px;
            color: var(--text);
        }

        .container {
            max-width: 1100px;
            margin: auto;
        }

        .header {
            text-align: center;
            margin-bottom: 20px;
        }

        .header h1 {
            margin: 0;
        }

        .table-container {
            background: var(--glass);
            border: 1px solid var(--border);
            border-radius: 16px;
            overflow: hidden;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 15px;
            border-bottom: 1px solid var(--border);
            text-align: left;
        }

        th {
            color: var(--muted);
            font-size: 13px;
        }

        tr:hover {
            background: rgba(255,255,255,0.03);
        }

        .btn {
            padding: 6px 12px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 13px;
            margin-right: 5px;
        }

        .btn-edit {
            background: rgba(255,255,255,0.1);
            color: white;
            border: 1px solid var(--border);
        }

        .btn-edit:hover {
            background: rgba(255,255,255,0.2);
        }

        .btn-delete {
            background: rgba(239,68,68,0.15);
            color: #f87171;
            border: 1px solid rgba(239,68,68,0.3);
        }

        .btn-delete:hover {
            background: #ef4444;
            color: white;
        }

        .empty {
            text-align: center;
            padding: 40px;
            color: var(--muted);
        }
    </style>
</head>

<body>

<div class="container">

    <div class="header">
        <h1>Driver Directory</h1>
        <p style="color: var(--muted);">Manage all registered drivers</p>
    </div>

    <div class="table-container">
        <table>

            <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Actions</th>
            </tr>
            </thead>

            <tbody>

            <c:forEach var="driver" items="${drivers}">
                <tr>
                    <td>${driver.id}</td>
                    <td>${driver.name}</td>
                    <td>${driver.email}</td>
                    <td>${driver.phone}</td>
                    <td>

                        <a href="${pageContext.request.contextPath}/drivers/edit/${driver.id}"
                           class="btn btn-edit">
                            Edit
                        </a>

                        <a href="${pageContext.request.contextPath}/drivers/delete/${driver.id}"
                           class="btn btn-delete"
                           onclick="return confirm('Are you sure you want to delete this driver?');">
                            Delete
                        </a>

                    </td>
                </tr>
            </c:forEach>

            <c:if test="${empty drivers}">
                <tr>
                    <td colspan="5" class="empty">
                        No drivers found
                    </td>
                </tr>
            </c:if>

            </tbody>

        </table>
    </div>

</div>

</body>
</html>