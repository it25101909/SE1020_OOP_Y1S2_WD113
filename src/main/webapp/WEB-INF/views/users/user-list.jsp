<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Directory | Zip SL</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f4f7f6; padding: 40px; }
        .container { max-width: 1000px; margin: auto; background: white; padding: 30px; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); }
        .header-section { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }

        /* Search Bar Styling */
        .search-box { display: flex; gap: 10px; }
        .search-box input { padding: 10px; border: 1px solid #ddd; border-radius: 5px; width: 250px; }
        .btn-search { background: #4a6da7; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; }

        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        th { background: #f8f9fa; color: #1a2a4a; font-weight: 600; }
        .badge { padding: 5px 12px; border-radius: 20px; font-size: 12px; font-weight: bold; }
        .Passenger { background: #e3f2fd; color: #1976d2; }
        .Driver { background: #fff3e0; color: #f57c00; }
    </style>
</head>
<body>

    <div class="container">
        <div class="header-section">
            <h2>👥 User Directory</h2>
            <form action="${pageContext.request.contextPath}/search-users" method="get" class="search-box">
                <input type="text" name="query" placeholder="Search by name or email..." value="${searchQuery}">
                <button type="submit" class="btn-search">Search</button>
            </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Phone</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="user" items="${allUsers}">
                    <tr>
                        <td><strong>${user.id}</strong></td>
                        <td>${user.name}</td>
                        <td>${user.email}</td>
                        <td><span class="badge ${user.role}">${user.role}</span></td>
                        <td>${user.phone}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty allUsers}">
                    <tr>
                        <td colspan="5" style="text-align: center; padding: 30px; color: #999;">No users found matching your search.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <div style="margin-top: 25px;">
            <a href="${pageContext.request.contextPath}/home" style="color: #4a6da7; text-decoration: none; font-weight: 500;">← Back to Dashboard</a>
            <c:if test="${not empty searchQuery}">
                | <a href="${pageContext.request.contextPath}/view-users" style="color: #666; text-decoration: none;">Clear Search</a>
            </c:if>
        </div>
    </div>

</body>
</html>
