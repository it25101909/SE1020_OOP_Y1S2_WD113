<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.taxibooking.taxibookingsystem.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit User</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background: #f5f5f5; }
        .form-box { background: white; padding: 30px; border-radius: 8px; max-width: 500px; margin: auto; }
        h2 { color: #333; }
        input, select { width: 100%; padding: 8px; margin: 8px 0 16px 0; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
        button { background: #4a6da7; color: white; padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; width: 100%; }
        button:hover { background: #3a5d97; }
        a { color: #4a6da7; }
    </style>
</head>
<body>
<div class="form-box">
    <h2>Edit User</h2>
    <%
        User user = (User) request.getAttribute("user");
    %>
    <form method="post" action="/users/edit/<%= user.getId() %>">
        <label>Full Name:</label>
        <input type="text" name="name" value="<%= user.getName() %>" required/>

        <label>Email:</label>
        <input type="email" name="email" value="<%= user.getEmail() %>" required/>

        <label>Phone:</label>
        <input type="text" name="phone" value="<%= user.getPhone() %>" required/>

        <label>Username:</label>
        <input type="text" name="username" value="<%= user.getUsername() %>" required/>

        <label>Password:</label>
        <input type="password" name="password" value="<%= user.getPassword() %>" required/>

        <label>User Type:</label>
        <select name="userType">
            <option value="regular" <%= user.getUserType().equals("regular") ? "selected" : "" %>>Regular</option>
            <option value="premium" <%= user.getUserType().equals("premium") ? "selected" : "" %>>Premium</option>
        </select>

        <button type="submit">Save Changes</button>
    </form>
    <br/>
    <a href="/users">← Back to User List</a>
</div>
</body>
</html>
