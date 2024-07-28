<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <style>
        @keyframes zoomIn {
            0% { transform: scale(1); }
            100% { transform: scale(1.1); }
        }

        @keyframes parallax {
            0% { background-position: center center; }
            50% { background-position: center top; }
            100% { background-position: center center; }
        }

        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background: url('https://st3.depositphotos.com/8911320/33966/i/450/depositphotos_339665118-stock-photo-render-modern-office-interior.jpg') center center / cover no-repeat;
            color: #ffffff;
            overflow-x: hidden;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            animation: zoomIn 10s infinite alternate, parallax 20s infinite ease-in-out;
        }

        .container {
            width: 100%;
            max-width: 600px;
            margin: 50px auto;
            padding: 30px;
            background: rgba(0, 0, 0, 0.7);
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);
            color: #ffffff;
        }

        h2 {
            font-size: 2em;
            margin-bottom: 20px;
            color: #ffffff;
            text-align: center;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .floating-label {
            position: relative;
            margin-bottom: 20px;
        }

        .floating-label input,
        .floating-label select {
            width: 100%;
            padding: 15px;
            border: 1px solid #444;
            border-radius: 5px;
            font-size: 1em;
            background-color: rgba(255, 255, 255, 0.1);
            color: #ffffff;
            transition: border-color 0.3s;
        }

        .floating-label label {
            position: absolute;
            top: 10px;
            left: 15px;
            color: #888;
            pointer-events: none;
            transition: 0.3s;
            font-size: 1em;
        }

        .floating-label input:focus,
        .floating-label select:focus {
            border-color: #ffb400;
        }

        .floating-label input:focus + label,
        .floating-label select:focus + label {
            top: -10px;
            left: 10px;
            font-size: 0.75em;
            color: #ffb400;
        }

        input[type="submit"] {
            background-color: #ffb400;
            color: #000000;
            border: none;
            padding: 15px;
            font-size: 1.1em;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #e0a800;
        }

        .error {
            color: #e63946;
            text-align: center;
            margin-top: 20px;
        }

        p {
            text-align: center;
        }

        a {
            color: #ffb400;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Register</h2>
        <form action="register" method="post">
            <div class="floating-label">
                <input type="text" id="name" name="name" required placeholder=" ">
                <label for="name">Name</label>
            </div>
            <div class="floating-label">
                <input type="text" id="username" name="username" required placeholder=" ">
                <label for="username">Username</label>
            </div>
            <div class="floating-label">
                <input type="password" id="password" name="password" required placeholder=" ">
                <label for="password">Password</label>
            </div>
            <div class="floating-label">
                <input type="password" id="confirmPassword" name="confirmPassword" required placeholder=" ">
                <label for="confirmPassword">Confirm Password</label>
            </div>
            <div class="floating-label">
                <select id="role" name="role" required>
                    <option value="ASSOCIATE">Associate</option>
                    <option value="ADMIN">Admin</option>
                </select>
                <label for="role">Role</label>
            </div>
            <input type="submit" value="Register">
        </form>
        
        <p class="error"><%= request.getAttribute("error") %></p>
        
        <p>Already have an account? <a href="login.jsp">Login here</a></p>
    </div>
</body>
</html>
