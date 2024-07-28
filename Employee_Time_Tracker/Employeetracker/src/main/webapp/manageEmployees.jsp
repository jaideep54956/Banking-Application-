<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.timetracker.model.Employee" %>
<%@ page import="com.timetracker.model.Role" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Employees</title>
    <style>
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

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--bg-color);
            color: var(--text-color);
            line-height: 1.6;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            padding: 2rem;
            margin: 0;
            background-size: cover;
        }

        h1 {
            text-align: center;
            margin-bottom: 2rem;
            font-size: 4rem;
            font-family: 'Arial', sans-serif;
            text-transform: uppercase;
            letter-spacing: 2px;
            color: var(--text-color);
        }

        h2 {
            text-align: center;
            margin-bottom: 2rem;
            font-size: 2.5rem;
            text-transform: uppercase;
            letter-spacing: 2px;
            color: var(--text-color);
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
            margin-bottom: 2rem;
        }

        input, select {
            width: 100%;
            padding: 0.75rem;
            border: none;
            border-radius: 5px;
            background-color: var(--nav-bg-color);
            color: var(--text-color);
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        input:focus, select:focus {
            outline: none;
            box-shadow: 0 0 0 2px var(--link-hover-color);
        }

        input[type="submit"] {
            background-color: var(--link-hover-color);
            color: var(--bg-color);
            cursor: pointer;
            font-weight: bold;
            text-transform: uppercase;
            transition: all 0.3s ease;
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
        }

        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid var(--gradient-color);
        }

        th {
            background-color: var(--nav-bg-color);
            font-weight: bold;
        }

        tr {
            transition: all 0.3s ease;
        }

        tr:hover {
            background-color: var(--overlay-color);
            transform: translateY(-2px);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .actions {
            display: flex;
            gap: 0.5rem;
        }

        .actions form {
            margin: 0;
        }

        a {
            display: inline-block;
            margin-top: 1rem;
            color: var(--link-hover-color);
            text-decoration: none;
            transition: color 0.3s ease;
        }

        a:hover {
            color: var(--text-color);
            text-decoration: underline;
        }

        /* Responsive styles */
        @media (max-width: 768px) {
            body {
                padding: 1rem;
            }
        }

        @media (max-width: 320px) {
            body {
                padding: 0.5rem;
            }
        }
    </style>
    <script>
        function toggleEditForm(employeeId) {
            var viewRow = document.getElementById('view-' + employeeId);
            var editRow = document.getElementById('edit-' + employeeId);
            viewRow.style.display = viewRow.style.display === 'none' ? '' : 'none';
            editRow.style.display = editRow.style.display === 'none' ? '' : 'none';
        }
    </script>
</head>
<body>
    <h1>Manage Employees</h1>

    <h2>Add New Employee</h2>
    <form action="manageEmployees" method="post">
        <input type="hidden" name="action" value="add">
        <input type="text" name="name" required placeholder="Name">
        <input type="text" name="username" required placeholder="Username">
        <input type="password" name="password" required placeholder="Password">
        <select name="role" required>
            <option value="ASSOCIATE">Associate</option>
            <option value="ADMIN">Admin</option>
        </select>
        <input type="submit" value="Add Employee">
    </form>

    <h2>Employee List</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Username</th>
                <th>Role</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% for (Employee employee : (List<Employee>) request.getAttribute("employees")) { %>
            <tr id="view-<%= employee.getId() %>">
                <td><%= employee.getId() %></td>
                <td><%= employee.getName() %></td>
                <td><%= employee.getUsername() %></td>
                <td><%= employee.getRole() %></td>
                <td class="actions">
                    <button onclick="toggleEditForm(<%= employee.getId() %>)">Edit</button>
                    <form action="manageEmployees" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="<%= employee.getId() %>">
                        <input type="submit" value="Delete" onclick="return confirm('Are you sure you want to delete this employee?');">
                    </form>
                </td>
            </tr>
            <tr id="edit-<%= employee.getId() %>" style="display:none;">
                <td colspan="5">
                    <form action="manageEmployees" method="post">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="id" value="<%= employee.getId() %>">
                        Name: <input type="text" name="name" value="<%= employee.getName() %>" required>
                        Username: <input type="text" name="username" value="<%= employee.getUsername() %>" required>
                        Role:
                        <select name="role" required>
                            <option value="ASSOCIATE" <%= employee.getRole() == Role.ASSOCIATE ? "selected" : "" %>>Associate</option>
                            <option value="ADMIN" <%= employee.getRole() == Role.ADMIN ? "selected" : "" %>>Admin</option>
                        </select>
                        <input type="submit" value="Update">
                        <button type="button" onclick="toggleEditForm(<%= employee.getId() %>)">Cancel</button>
                    </form>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <a href="dashboard.jsp">Back to Dashboard</a>
</body>
</html>
