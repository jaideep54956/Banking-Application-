<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            overflow: hidden;
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            position: relative;
            background: #000000;
        }
        .background {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('https://cdn.dribbble.com/users/359348/screenshots/14919342/media/403e917b092965ed5674813466b300ae.gif') no-repeat center center fixed;
            background-size: cover;
            z-index: -1;
        }
        .form-section {
            width: 400px;
            background: rgba(0, 0, 0, 0.8);
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);
            padding: 30px;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            opacity: 0;
            transform: translateY(-50px);
            animation: formFadeIn 1s forwards, formSlideIn 0.5s ease-out 1s forwards;
        }
        @keyframes formFadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
        @keyframes formSlideIn {
            from {
                transform: translateY(-50px);
            }
            to {
                transform: translateY(0);
            }
        }
        .login-icon {
            font-size: 3em;
            color: #ffb400;
            margin-bottom: 20px;
            animation: iconPulse 1.5s infinite;
        }
        @keyframes iconPulse {
            0% {
                transform: scale(1);
                color: #ffb400;
            }
            50% {
                transform: scale(1.1);
                color: #e0a900;
            }
            100% {
                transform: scale(1);
                color: #ffb400;
            }
        }
        h2 {
            font-size: 2em;
            color: #ffffff;
            margin-bottom: 20px;
            font-weight: 400;
            animation: headingFadeIn 1s ease-in-out;
        }
        @keyframes headingFadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .floating-label {
            position: relative;
            margin-bottom: 20px;
            width: 100%;
        }
        .floating-label input {
            width: 100%;
            padding: 15px;
            border: 1px solid #444;
            border-radius: 5px;
            background: rgba(0, 0, 0, 0.7);
            color: #ffffff;
            font-size: 1em;
            outline: none;
            transition: border-color 0.3s, transform 0.3s;
        }
        .floating-label input:focus {
            border-color: #ffb400;
            transform: scale(1.02);
        }
        .floating-label label {
            position: absolute;
            top: 10px;
            left: 15px;
            color: #ffffff;
            font-size: 1em;
            transition: 0.3s;
        }
        .floating-label input:focus ~ label,
        .floating-label input:not(:placeholder-shown) ~ label {
            top: -10px;
            left: 10px;
            font-size: 0.8em;
            color: #ffb400;
        }
        input[type="submit"] {
            background-color: #ffb400;
            color: #000000;
            border: none;
            padding: 15px 30px;
            font-size: 1.2em;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
            width: 100%;
            margin-top: 20px;
        }
        input[type="submit"]:hover {
            background-color: #e0a900;
            transform: scale(1.05);
        }
        .error {
            color: #ff4d4d;
            margin-top: 10px;
        }
        .success {
            color: #4dff4d;
            margin-top: 10px;
        }
        a {
            color: #ffb400;
            text-decoration: none;
            transition: color 0.3s;
        }
        a:hover {
            color: #e0a900;
        }
    </style>
</head>
<body>
    <div class="background"></div>
    <div class="form-section">
        <i class="fas fa-sign-in-alt login-icon"></i>
        <h2>Login</h2>
        <form action="login" method="post">
            <div class="floating-label">
                <input type="text" id="username" name="username" required placeholder=" ">
                <label for="username">Username</label>
            </div>
            <div class="floating-label">
                <input type="password" id="password" name="password" required placeholder=" ">
                <label for="password">Password</label>
            </div>
            <input type="submit" value="Login">
            <% if (request.getAttribute("error") != null) { %>
                <p class="error"><%= request.getAttribute("error") %></p>
            <% } %>
            <% if (request.getParameter("registered") != null) { %>
                <p class="success">Registration successful. Please login.</p>
            <% } %>
            <p>Don't have an account? <a href="register.jsp">Register here</a></p>
        </form>
    </div>
</body>
</html>
