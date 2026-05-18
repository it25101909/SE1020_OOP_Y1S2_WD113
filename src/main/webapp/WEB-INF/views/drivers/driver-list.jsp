<%@ page language="java" contentType="text/html; charset=UTF-8" pageContext="session" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Driver List</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 10px; border: 1px solid #ddd; text-align: left; }
        th { background-color: #f4f4f4; }
        .delete-btn { color: red; text-decoration: none; cursor: pointer; }
    </style>
</head>
<body>
    <h2>Driver List</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Action</th>
        </tr>
        <c:forEach var="driver" items="${drivers}">
            <tr>
                <td>${driver.id}</td>
                <td>${driver.name}</td>
                <td>${driver.email}</td>
                <td>${driver.phone}</td>
                <td>
                    <a href="/drivers/delete/${driver.id}" class="delete-btn" onclick="return confirm('Are you sure you want to delete this driver?');">Delete</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
