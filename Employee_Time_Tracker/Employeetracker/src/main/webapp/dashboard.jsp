<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.timetracker.model.Employee"%>
<%@ page import="com.timetracker.model.Role"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <style>
        body {
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #1b1b1b; /* Dark background */
            font-family: 'Poppins', sans-serif;
        }

        .container {
            width: 80vw;
            max-width: 1000px;
            padding: 2%;
            box-sizing: border-box;
        }

        .heading {
            color: #ffffff;
            font-size: 36px;
            font-weight: 600;
            text-align: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 3px solid #ffb400; /* Accent color */
        }

        .boxes-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
        }

        .box {
            position: relative;
            width: 200px;
            height: 150px;
            overflow: hidden;
            border-radius: 8px;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }

        .box > img {
            position: absolute;
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .box > span {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            color: #ffffff;
            background-color: rgba(0, 0, 0, 0.5);
            transition: all 0.3s ease;
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.8);
        }

        .box:hover {
            transform: scale(1.1);
            z-index: 2;
        }

        .box:hover > img {
            transform: scale(1.1);
        }

        .box:hover > span {
            background-color: rgba(0, 0, 0, 0.7);
        }

        @media (max-width: 768px) {
            .container {
                width: 90vw;
            }
            .box {
                width: 150px;
                height: 120px;
            }
            .box > span {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <% Employee employee = (Employee) session.getAttribute("employee"); %>
        <h2 class="heading">Welcome, <%= employee.getName() %></h2>
        <div class="boxes-container">
            <a href="addTask.jsp" class="box">
                <img src="https://img.freepik.com/free-photo/modern-office-space-with-desktops-with-modern-computers-created-with-generative-ai-technology_185193-110089.jpg" alt="Add Task">
                <span>Add Task</span>
            </a>
            <a href="task" class="box">
                <img src="https://img.freepik.com/free-photo/modern-office-space-with-desktops-with-modern-computers-created-with-generative-ai-technology_185193-110089.jpg" alt="View Tasks">
                <span>View Tasks</span>
            </a>
            <a href="chart?type=daily&period=daily" class="box">
                <img src="https://img.freepik.com/free-photo/modern-office-space-with-desktops-with-modern-computers-created-with-generative-ai-technology_185193-110089.jpg" alt="Daily Tasks (Pie Chart)">
                <span>Daily Tasks (Pie Chart)</span>
            </a>
            <a href="chart?type=weekly&period=weekly" class="box">
                <img src="https://img.freepik.com/free-photo/modern-office-space-with-desktops-with-modern-computers-created-with-generative-ai-technology_185193-110089.jpg" alt="Weekly Tasks (Bar Chart)">
                <span>Weekly Tasks (Bar Chart)</span>
            </a>
            <a href="chart?type=monthly&period=monthly" class="box">
                <img src="https://img.freepik.com/free-photo/modern-office-space-with-desktops-with-modern-computers-created-with-generative-ai-technology_185193-110089.jpg" alt="Monthly Tasks (Bar Chart)">
                <span>Monthly Tasks (Bar Chart)</span>
            </a>
            <% if (employee.getRole() == Role.ADMIN) { %>
                <a href="adminDashboard.jsp" class="box">
                    <img src="https://img.freepik.com/free-photo/modern-office-space-with-desktops-with-modern-computers-created-with-generative-ai-technology_185193-110089.jpg" alt="Admin Dashboard">
                    <span>Admin Dashboard</span>
                </a>
            <% } %>
            <a href="logout" class="box">
                <img src="https://img.freepik.com/free-photo/modern-office-space-with-desktops-with-modern-computers-created-with-generative-ai-technology_185193-110089.jpg" alt="Logout">
                <span>Logout</span>
            </a>
        </div>
    </div>
</body>
</html>
