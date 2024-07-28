<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.timetracker.model.Task"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Tasks</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap');

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #2d2d2d; /* Dark background color */
            color: #fff; /* Light text color */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            overflow: hidden;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            background: rgba(255, 255, 255, 0.1); /* Glassmorphism effect */
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            padding: 20px;
            box-sizing: border-box;
            position: relative;
            overflow: hidden;
            animation: fadeIn 1s ease-out;
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

        .container img {
            position: absolute;
            top: 20px;
            right: 20px;
            width: 150px;
            height: auto;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            animation: pulseRotate 5s infinite ease-in-out;
        }

        @keyframes pulseRotate {
            0% {
                transform: scale(1) rotate(0deg);
                opacity: 0.8;
            }
            50% {
                transform: scale(1.1) rotate(10deg);
                opacity: 1;
            }
            100% {
                transform: scale(1) rotate(0deg);
                opacity: 0.8;
            }
        }

        h2 {
            margin: 20px 0;
            font-size: 28px;
            color: #fff;
            text-align: center;
            position: relative;
            padding-bottom: 10px;
            animation: slideIn 1s ease-out;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        h2:after {
            content: '';
            position: absolute;
            left: 50%;
            bottom: 0;
            width: 60px;
            height: 4px;
            background: #fff;
            transform: translateX(-50%);
            border-radius: 2px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            animation: underline 1s ease-out;
        }

        @keyframes underline {
            from {
                width: 0;
            }
            to {
                width: 60px;
            }
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            animation: tableFadeIn 1.5s ease-in-out;
            color: #fff;
            border-radius: 12px;
            overflow: hidden;
        }

        @keyframes tableFadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        th {
            background-color: #ffd700; /* Yellow header background */
            color: #333; /* Dark text color for contrast */
            font-weight: 600;
            text-transform: uppercase;
            font-size: 14px; /* Increase font size for headings */
            letter-spacing: 0.5px; /* Add spacing between letters */
            text-align: center; /* Center align text */
            border-bottom: 2px solid rgba(255, 255, 255, 0.3); /* Add bottom border */
        }

        tr:nth-child(even) {
            background-color: rgba(255, 255, 255, 0.1); /* Slightly lighter for even rows */
        }

        tr:hover {
            background-color: rgba(255, 255, 255, 0.2); /* Highlight on hover */
            transform: scale(1.02);
        }

        td {
            font-size: 13px; /* Adjust font size for table data */
            text-align: center; /* Center align text */
        }

        a {
            color: #000; /* Black text color */
            text-decoration: none;
            transition: color 0.3s ease, text-shadow 0.3s ease;
            display: inline-block;
            position: relative;
        }

        a::before {
            content: '';
            position: absolute;
            width: 100%;
            height: 2px;
            bottom: 0;
            left: 0;
            background-color: #ffd700; /* Yellow underline color */
            transform: scaleX(0);
            transform-origin: bottom right;
            transition: transform 0.3s ease;
        }

        a:hover::before {
            transform: scaleX(1);
            transform-origin: bottom left;
        }

        a:hover {
            color: #fff; /* Change to white on hover */
            text-shadow: 0 1px 5px rgba(0, 0, 0, 0.2);
        }

        input[type="submit"] {
            background-color: #444;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        input[type="submit"]:hover {
            background-color: #666;
            transform: scale(1.05);
        }

        .navigation-links {
            margin-top: 20px;
            text-align: center;
        }

        .navigation-links a {
            margin: 0 15px;
            font-size: 16px;
            font-weight: 500;
            text-decoration: none;
            color: #000; /* Black text color */
            transition: color 0.3s ease;
            position: relative;
        }

        .navigation-links a::before {
            content: '';
            position: absolute;
            width: 100%;
            height: 2px;
            bottom: 0;
            left: 0;
            background-color: #ffd700; /* Yellow underline color */
            transform: scaleX(0);
            transform-origin: bottom right;
            transition: transform 0.3s ease;
        }

        .navigation-links a:hover::before {
            transform: scaleX(1);
            transform-origin: bottom left;
        }

        .navigation-links a:hover {
            color: #fff; /* Change to white on hover */
            text-shadow: 0 1px 5px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>
    <div class="container">
        <img src="https://cdn.pixabay.com/photo/2020/05/30/09/53/todo-lists-5238324_640.jpg" alt="Decorative Image">
        <h2>Your Tasks</h2>
        <table border="0">
            <tr>
                <th>Project</th>
                <th>Date</th>
                <th>Start Time</th>
                <th>End Time</th>
                <th>Category</th>
                <th>Description</th>
                <th>Actions</th>
            </tr>
            <% 
            List<Task> tasks = (List<Task>) request.getAttribute("tasks");
            if (tasks != null) {
                for(Task task : tasks) { 
            %>
                <tr>
                    <td><%= task.getProject() %></td>
                    <td><%= task.getDate() %></td>
                    <td><%= task.getStartTime() %></td>
                    <td><%= task.getEndTime() %></td>
                    <td><%= task.getCategory() %></td>
                    <td><%= task.getDescription() %></td>
                    <td>
                        <a href="editTask.jsp?id=<%= task.getId() %>">Edit</a> | 
                        <a href="deleteTask?id=<%= task.getId() %>" onclick="return confirm('Are you sure you want to delete this task?')">Delete</a>
                    </td>
                </tr>
            <% 
                } 
            }
            %>
        </table>
        <div class="navigation-links">
            <a href="index.jsp">Home</a>
            <a href="addTask.jsp">Add Task</a>
        </div>
    </div>
</body>
</html>
