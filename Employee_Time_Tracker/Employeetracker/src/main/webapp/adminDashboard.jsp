<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.timetracker.model.Employee"%>
<%@ page import="com.timetracker.model.Role"%>
<%@ page import="com.timetracker.controller.AdminDashboardServlet"%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            background: url('https://i.pinimg.com/originals/dd/ca/be/ddcabeb0bbdd9cdb4e5e911c18a4987c.jpg') no-repeat center center fixed;
            background-size: cover;
            color: #ffffff;
            position: relative;
        }
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(14, 14, 14, 0.7);
            z-index: 1;
        }
        .container {
            width: 80%;
            margin: auto;
            overflow: hidden;
            position: relative;
            z-index: 2;
        }
        h1, h2 {
            color: #eef3f3;
            text-align: center;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }
        h1 {
            font-size: 3em;
            margin-bottom: 0.5em;
        }
        h2 {
            font-size: 2em;
            margin-top: 1em;
        }
        .admin-menu {
            background: rgba(255, 255, 255, 0.1);
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .admin-menu ul {
            list-style-type: none;
            padding: 0;
            text-align: center;
        }
        .admin-menu ul li {
            display: inline-block;
            margin: 0 10px;
        }
        .admin-menu ul li a {
            text-decoration: none;
            color: #00e5ff;
            padding: 10px 20px;
            border: 1px solid #00e5ff;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s;
        }
        .admin-menu ul li a:hover {
            background: #00e5ff;
            color: #333;
        }
        .summary, .recent-activity {
            background: rgba(255, 255, 255, 0.1);
            padding: 20px;
            border-radius: 10px;
            margin-top: 20px;
            text-align: center;
        }
        .summary p, .recent-activity ul {
            margin: 5px 0;
        }
        .recent-activity ul {
            list-style-type: none;
            padding: 0;
        }
        .recent-activity ul li {
            margin: 5px 0;
        }
        .links {
            text-align: center;
            margin-top: 20px;
        }
        .links a {
            color: #00e5ff;
            text-decoration: none;
            margin: 0 10px;
            border: 1px solid #00e5ff;
            padding: 10px 20px;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s;
        }
        .links a:hover {
            background: #00e5ff;
            color: #333;
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        h1, h2, .admin-menu, .summary, .recent-activity, .links {
            animation: fadeIn 1s ease-in-out;
        }
    </style>
</head>
<body>
    <% 
    Employee admin = (Employee) session.getAttribute("employee");
    if(admin == null || admin.getRole() != Role.ADMIN) {
        response.sendRedirect("login.jsp");
        return;
    }
    %>
    <div class="container">
        <h1>Welcome to the Admin Dashboard, <%= admin.getName() %></h1>
        
        <div class="admin-menu">
            <h2>Administrative Functions</h2>
            <ul>
                <li><a href="adminChart">View Employee/Project Charts</a></li>
                <li><a href="manageEmployees">Manage Employees</a></li>
                <li><a href="manageProjects">Manage Projects</a></li>
                <li><a href="generateReports">Generate Reports</a></li>
            </ul>
        </div>

        <div class="summary">
            <h2>System Summary</h2>
            <p>Total Employees: ${totalEmployees}</p>
            <p>Total Projects: ${totalProjects}</p>
            <p>Tasks Logged Today: ${tasksLoggedToday}</p>
        </div>

        <div class="recent-activity">
            <h2>Recent Activity</h2>
            <ul>
                <li>John Doe logged 8 hours on Project A</li>
                <li>Jane Smith created a new task for Project B</li>
            </ul>
        </div>

        <div class="links">
            <a href="dashboard.jsp">Back to Main Dashboard</a>
            <a href="logout">Logout</a>
        </div>
    </div>
</body>
</html>
