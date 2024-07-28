<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Projects</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Red+Hat+Display:wght@900&display=swap');

        :root {
            --bg-color: #1b1b1b;
            --text-color: #ffffff;
            --nav-bg-color: #333333;
            --gradient-color: #444;
            --link-hover-color: #ffb400;
            --overlay-color: rgba(0, 0, 0, 0.5);
            --text-bg-color: rgba(0, 0, 0, 0.7);
            --para-text-color: #e0e0e0;
            --para-bg-gradient-start: rgba(255, 255, 255, 0.2);
            --para-bg-gradient-end: rgba(0, 0, 0, 0.5);
            --footer-bg-color: #2d2d2d;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html, body {
            width: 100%;
            height: 100%;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--bg-color);
            color: var(--text-color);
            line-height: 1.6;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 2rem;
            margin: 0;
        }

        h1, h2 {
            font-family: 'Red Hat Display', sans-serif;
            font-weight: 900;
            background: url("https://wallpapers.com/images/hd/light-color-background-0a6tnnu41xiz0i7q.jpg");
            background-size: 40%;
            background-position: 50% 50%;
            -webkit-background-clip: text;
            color: rgba(0,0,0,0.08);
            text-align: center;
            text-transform: uppercase;
            letter-spacing: 2px;
            animation: zoomout 10s ease 500ms forwards;
        }

        h1 {
            font-size: 6vw; /* Adjusted size */
            line-height: 6vw; /* Adjusted line-height */
            margin: 0 0 2rem 0;
        }

        h2 {
            font-size: 4vw;
            line-height: 4vw;
            margin-bottom: 2rem;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
            margin-bottom: 2rem;
        }

        input[type="text"], input[type="submit"] {
            width: 100%;
            padding: 0.75rem;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        input[type="text"] {
            background-color: var(--nav-bg-color);
            color: var(--text-color);
        }

        input[type="text"]:focus {
            outline: none;
            box-shadow: 0 0 0 2px var(--link-hover-color);
        }

        input[type="submit"] {
            background-color: var(--link-hover-color);
            color: var(--bg-color);
            cursor: pointer;
            font-weight: bold;
            text-transform: uppercase;
        }

        input[type="submit"]:hover {
            background-color: var(--text-color);
            color: var(--link-hover-color);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 2rem;
            background-color: var(--bg-color);
            animation: shimmer 2s infinite linear;
        }

        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid var(--gradient-color);
            transition: all 0.3s ease;
        }

        th {
            background-color: #444444; /* Updated background color */
            font-weight: bold;
        }

        tr:hover {
            background-color: var(--overlay-color);
            transform: translateY(-2px);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        a {
            display: inline-block;
            margin-top: 1rem;
            color: var(--link-hover-color);
            text-decoration: none;
            transition: color 0.3s ease;
            padding-bottom: 10px;
        }

        a:hover {
            color: var(--text-color);
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            body {
                padding: 1rem;
            }

            h1 {
                font-size: 8vw; /* Adjusted size for medium screens */
                line-height: 8vw; /* Adjusted line-height for medium screens */
            }

            h2 {
                font-size: 5vw; /* Adjusted size for medium screens */
                line-height: 5vw; /* Adjusted line-height for medium screens */
            }
        }

        @media (max-width: 320px) {
            h1 {
                font-size: 10vw; /* Adjusted size for small screens */
                line-height: 10vw; /* Adjusted line-height for small screens */
            }

            h2 {
                font-size: 7vw; /* Adjusted size for small screens */
                line-height: 7vw; /* Adjusted line-height for small screens */
            }
        }
    </style>
</head>
<body>
    
    <h2>Project List</h2>
    <table>
        <tr>
            <th>Project Name</th>
            <th>Actions</th>
        </tr>
        <% List<String> projects = (List<String>) request.getAttribute("projects"); %>
        <% if (projects != null && !projects.isEmpty()) { %>
            <% for (String projectName : projects) { %>
                <tr>
                    <td><%= projectName %></td>
                    <td>
                        <form action="manageProjects" method="post">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="projectName" value="<%= projectName %>">
                            <input type="submit" value="Delete" onclick="return confirm('Are you sure you want to delete this project?');">
                        </form>
                    </td>
                </tr>
            <% } %>
        <% } else { %>
            <tr>
                <td colspan="2">No projects found.</td>
            </tr>
        <% } %>
    </table>
    
    <a href="dashboard.jsp">Back to Dashboard</a>
</body>
</html>
