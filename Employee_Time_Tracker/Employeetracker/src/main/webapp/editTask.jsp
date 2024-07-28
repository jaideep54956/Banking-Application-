<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.timetracker.model.Task"%>
<%@ page import="com.timetracker.dao.TaskDAO"%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Task</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700&display=swap');

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #2d2d2d; /* Dark background color */
            color: #ffffff; /* Change text color to white */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            overflow: hidden;
            position: relative;
        }

        .image-background {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('https://cdn.dribbble.com/users/1319343/screenshots/14584578/media/0a63d314f0c5141774fc31e22b504a58.gif') no-repeat center center/cover;
            z-index: -1;
        }

        .form-content {
            width: 50%; /* Adjusted width of the form */
            padding: 30px;
            box-sizing: border-box;
            background-color: #333333; /* Darker background for form */
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #ffffff; /* Change heading color to white */
            margin-bottom: 20px;
            font-size: 24px;
            text-align: center;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        input[type="text"],
        input[type="date"],
        input[type="time"],
        textarea {
            padding: 14px;
            border: 1px solid rgba(255, 255, 255, 0.4); /* Change border color to white */
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.1);
            color: #ffffff; /* Change input text color to white */
            transition: border-color 0.3s ease, box-shadow 0.3s ease, background-color 0.3s ease;
            width: calc(100% - 28px);
        }

        input[type="text"]:focus,
        input[type="date"]:focus,
        input[type="time"]:focus,
        textarea:focus {
            border-color: #ffffff; /* Change focus border color to white */
            box-shadow: 0 0 8px rgba(255, 255, 255, 0.6); /* Change focus shadow color to white */
            background-color: rgba(255, 255, 255, 0.2);
        }

        input[type="submit"] {
            background-color: #555; /* Single color */
            color: #ffffff;
            padding: 14px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
            margin-top: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        input[type="submit"]:hover {
            background-color: #777; /* Darker shade for hover */
            transform: scale(1.05);
        }

        .back-link {
            display: block;
            margin-top: 20px;
            text-decoration: none;
            color: #ffffff; /* Change link color to white */
            text-align: center;
            transition: color 0.3s ease, transform 0.3s ease;
        }

        .back-link:hover {
            color: #aaaaaa; /* Lighter shade for hover */
            transform: translateY(-3px);
        }

        /* Floating Labels */
        .floating-label {
            position: relative;
            margin-bottom: 20px;
        }

        .floating-label input,
        .floating-label textarea {
            padding: 14px;
            margin: 0;
            width: 100%;
            border: 1px solid rgba(255, 255, 255, 0.4); /* Change border color to white */
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.1);
            color: #ffffff; /* Change input text color to white */
            transition: border-color 0.3s ease, box-shadow 0.3s ease, background-color 0.3s ease;
        }

        .floating-label label {
            position: absolute;
            top: 50%;
            left: 14px;
            transform: translateY(-50%);
            color: rgba(255, 255, 255, 0.7); /* Change label color to white */
            transition: top 0.3s ease, font-size 0.3s ease, color 0.3s ease;
        }

        .floating-label input:focus + label,
        .floating-label textarea:focus + label,
        .floating-label input:not(:placeholder-shown) + label,
        .floating-label textarea:not(:placeholder-shown) + label {
            top: -8px;
            font-size: 12px;
            color: #ffffff; /* Change focus label color to white */
        }

        .floating-label input:focus,
        .floating-label textarea:focus {
            border-color: #ffffff; /* Change focus border color to white */
            box-shadow: 0 0 8px rgba(255, 255, 255, 0.6); /* Change focus shadow color to white */
            background-color: rgba(255, 255, 255, 0.2);
        }
    </style>
</head>
<body>
    <div class="image-background"></div>
    <div class="form-content">
        <h2>Edit Task</h2>
        <%
            String taskIdParam = request.getParameter("id");
            if (taskIdParam != null) {
                try {
                    int taskId = Integer.parseInt(taskIdParam);
                    TaskDAO taskDAO = new TaskDAO();
                    Task task = taskDAO.getTaskById(taskId);
                    if (task != null) {
        %>
        <form action="task" method="post">
            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="taskId" value="<%= task.getId() %>">
            <div class="floating-label">
                <input type="text" name="project" value="<%= task.getProject() %>" required placeholder=" ">
                <label>Project</label>
            </div>
            <div class="floating-label">
                <input type="date" name="date" value="<%= task.getDate() %>" required placeholder=" ">
                <label>Date</label>
            </div>
            <div class="floating-label">
                <input type="time" name="startTime" value="<%= task.getStartTime() %>" required placeholder=" ">
                <label>Start Time</label>
            </div>
            <div class="floating-label">
                <input type="time" name="endTime" value="<%= task.getEndTime() %>" required placeholder=" ">
                <label>End Time</label>
            </div>
            <div class="floating-label">
                <input type="text" name="category" value="<%= task.getCategory() %>" required placeholder=" ">
                <label>Category</label>
            </div>
            <div class="floating-label">
                <textarea name="description" required placeholder=" "><%= task.getDescription() %></textarea>
                <label>Description</label>
            </div>
            <input type="submit" value="Update Task">
        </form>
        <a href="task" class="back-link">Back to Tasks</a>
        <%
                    } else {
                        out.println("<p>Task not found for ID " + taskId + "</p>");
                    }
                } catch (NumberFormatException e) {
                    out.println("<p>Invalid task ID format</p>");
                } catch (Exception e) {
                    out.println("<p>Error retrieving task: " + e.getMessage() + "</p>");
                }
            } else {
                out.println("<p>Task ID is missing</p>");
            }
        %>
    </div>
</body>
</html>
