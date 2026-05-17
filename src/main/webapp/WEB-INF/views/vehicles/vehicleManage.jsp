<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Vehicle Management - Zip SL</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f5f5f5; padding: 20px; }
        .flex-container { display: flex; gap: 20px; }
        .card { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .form-section { flex: 1; }
        .list-section { flex: 2; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { padding: 10px; border-bottom: 1px solid #ddd; text-align: left; }
        th { background: #4a6da7; color: white; }
        input, select, button { width: 100%; padding: 8px; margin: 8px 0; border-radius: 4px; border: 1px solid #ccc; }
        button { background: #4a6da7; color: white; border: none; cursor: pointer; font-weight: bold; }
    </style>
</head>
<body>

    <h2>🚕 Vehicle Fleet Management</h2>
    <div class="flex-container">

        <div class="card form-section">
            <h3>Add New Vehicle</h3>
            <form action="/addVehicle" method="post">
                <label>Plate Number</label>
                <input type="text" name="plateNumber" required placeholder="e.g. WP-ABC-1234">

                <label>Model</label>
                <input type="text" name="model" required placeholder="e.g. Toyota Prius">

                <label>Vehicle Type</label>
                <select name="type">
                    <option value="Car">Car</option>
                    <option value="Van">Van</option>
                    <option value="Tuk-Tuk">Tuk-Tuk</option>
                </select>

                <label>Assign to Driver</label>
                <select name="driverId">
                    <c:forEach items="${drivers}" var="driver">
                        <option value="${driver.userId}">${driver.name}</option>
                    </c:forEach>
                </select>

                <button type="submit">Register Vehicle</button>
            </form>
        </div>

        <div class="card list-section">
            <h3>Registered Vehicles</h3>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Plate No</th>
                        <th>Model</th>
                        <th>Type</th>
                        <th>Driver ID</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${vehicles}" var="v">
                        <tr>
                            <td>${v.vehicleId}</td>
                            <td>${v.plateNumber}</td>
                            <td>${v.model}</td>
                            <td>${v.type}</td>
                            <td>${v.driverId}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <br>
    <a href="/home" style="color: #4a6da7; text-decoration: none;">← Back to Dashboard</a>
</body>
</html>
