<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beans.user.UserDTO" %>
<%
    UserDTO user = (UserDTO) request.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit User</title>
</head>
<body>
    <h1>Edit User</h1>
    <form action="user.do?action=update" method="post">
        <input type="hidden" name="userId" value="<%= user.getUserId() %>" />
        <label>Name:</label>
        <input type="text" name="userName" value="<%= user.getUserName() %>" required /><br>
        <label>Email:</label>
        <input type="email" name="userEmail" value="<%= user.getUserEmail() %>" required /><br>
        <label>Password:</label>
        <input type="password" name="userPw" /><br>
        <button type="submit">Update</button>
    </form>
    <a href="user.do?action=list">Back to List</a>
</body>
</html>
