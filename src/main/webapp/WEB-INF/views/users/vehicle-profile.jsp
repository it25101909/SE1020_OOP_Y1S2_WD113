<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Vehicle Profile | Zip SL</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f7f6; padding: 50px; }
        .form-container { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); max-width: 400px; margin: auto; }
        input, select { width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ccc; border-radius: 4px; }
        .btn { background: #4a6da7; color: white; border: none; padding: 12px; width: 100%; cursor: pointer; border-radius: 4px; }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>🚗 Vehicle Details</h2>
        <form action="${pageContext.request.contextPath}/update-vehicle" method="post">
            <label>Vehicle Model (e.g. Toyota Prius)</label>
            <input type="text" name="vehicleModel" placeholder="Enter car model" required>

            <label>Plate Number</label>
            <input type="text" name="plateNumber" placeholder="WP CAS-1234" required>

            <label>Vehicle Type</label>
            <select name="vehicleType">
                <option value="Tuk">Tuk Tuk</option>
                <option value="Mini">Mini (Budget)</option>
                <option value="Sedan">Sedan (Luxury)</option>
                <option value="Van">Van (Large Group)</option>
            </select>

            <button type="submit" class="btn">Update Vehicle Information</button>
        </form>
        <p style="text-align: center; margin-top: 15px;"><a href="${pageContext.request.contextPath}/home">Back to Dashboard</a></p>
    </div>
</body>
</html>
