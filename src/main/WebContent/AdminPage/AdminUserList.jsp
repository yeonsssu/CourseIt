<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beans.user.UserDTO" %>
<%@ page import="java.util.List" %>
<%
    List<UserDTO> userList = (List<UserDTO>) request.getAttribute("userList");
%>
<!DOCTYPE html>
<html>
<head>
    <title>User List</title>
</head>
<body>
    <h1>User Management</h1>
    <a href="user.do?action=add">Add User</a>
    <table border="1">
        <thead>
            <tr>
                <th>User ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% if (userList != null) {
                for (UserDTO user : userList) { %>
                    <tr>
                        <td><%= user.getUserId() %></td>
                        <td><%= user.getUserName() %></td>
                        <td><%= user.getUserEmail() %></td>
                        <td>
                            <a href="user.do?action=edit&userId=<%= user.getUserId() %>">Edit</a> |
                            <a href="user.do?action=delete&userId=<%= user.getUserId() %>">Delete</a>
                        </td>
                    </tr>
            <% } } else { %>
                <tr>
                    <td colspan="4">No Users Found</td>
                </tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>
