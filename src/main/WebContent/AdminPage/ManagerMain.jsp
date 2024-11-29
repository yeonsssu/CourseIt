<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/Manager.css">
</head>
<body>
    <div class="container-fluid">
        <!-- Sidebar -->
        <div class="row">
            <nav class="col-md-2 bg-dark text-white sidebar">
                <h3 class="p-3">CourseIt 관리자 페이지</h3>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link text-white" href="Dashboard.jsp">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="User_management.jsp">User Management</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="Post_management.jsp">Post Management</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="Settings.jsp">Settings</a>
                    </li>
                </ul>
            </nav>

            <!-- Main Content -->
            <main class="col-md-10 ms-sm-auto px-4">
                <h1 class="mt-4">Welcome to the Admin Panel</h1>
                <p>Select a section from the sidebar to get started.</p>
            </main>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
