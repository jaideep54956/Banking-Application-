<%@ page import="com.timetracker.model.Employee, com.timetracker.model.Role" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Employee</title>
    <style>
        :root {
            --bg-color: #1b1b1b;
            --text-color: #ffffff;
            --hover-color: #ffb400;
            --input-bg: #2a2a2a;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: var(--bg-color) url('https://t3.ftcdn.net/jpg/03/62/24/10/360_F_362241054_WAwFfvPpJlF30BjitjkW4nFRyF7OSn8o.jpg') no-repeat center center fixed;
            background-size: cover;
            color: var(--text-color);
            line-height: 1.6;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            animation: bgPan 30s linear infinite;
        }

        @keyframes bgPan {
            0% { background-position: 0% 0%; }
            100% { background-position: 100% 100%; }
        }

        .container {
            width: 90%;
            max-width: 600px;
            padding: 2rem;
            background-color: rgba(0, 0, 0, 0.8);
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            margin-top: 2rem;
        }

        h2 {
            text-align: center;
            margin-bottom: 2rem;
            font-size: 2rem;
            text-transform: uppercase;
            letter-spacing: 2px;
            color: var(--text-color);
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        input, select {
            width: 100%;
            padding: 0.5rem;
            border: none;
            border-radius: 5px;
            background-color: var(--input-bg);
            color: var(--text-color);
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        input:focus, select:focus {
            outline: none;
            box-shadow: 0 0 0 2px var(--hover-color);
        }

        input[type="submit"] {
            background-color: var(--hover-color);
            color: var(--bg-color);
            cursor: pointer;
            font-weight: bold;
            text-transform: uppercase;
        }

        input[type="submit"]:hover {
            background-color: var(--text-color);
            color: var(--hover-color);
        }

        a {
            display: inline-block;
            margin-top: 1rem;
            color: var(--hover-color);
            text-decoration: none;
            transition: color 0.3s ease;
            text-align: center;
        }

        a:hover {
            color: var(--text-color);
        }

        @media (max-width: 768px) {
            .container {
                width: 95%;
                padding: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Edit Employee</h2>
        <%
            // Fetch employee object from request attribute
            Employee employee = (Employee) request.getAttribute("employee");
            if (employee == null) {
                throw new ServletException("Employee object is missing from request.");
            }
        %>
        <form action="manageEmployees" method="post">
            <input type="hidden" name="action" value="edit" />
            <input type="hidden" name="id" value="<%= employee.getId() %>" />
            <input type="text" name="name" value="<%= employee.getName() %>" placeholder="Name" />
            <input type="text" name="username" value="<%= employee.getUsername() %>" placeholder="Username" />
            <select name="role">
                <option value="ASSOCIATE" <%= "ASSOCIATE".equals(employee.getRole().name()) ? "selected" : "" %>>Associate</option>
                <option value="ADMIN" <%= "ADMIN".equals(employee.getRole().name()) ? "selected" : "" %>>Admin</option>
            </select>
            <input type="password" name="password" value="" placeholder="Password" />
            <input type="submit" value="Save Changes" />
        </form>
        <a href="manageEmployees">Back to Employee List</a>
    </div>
</body>
</html>
