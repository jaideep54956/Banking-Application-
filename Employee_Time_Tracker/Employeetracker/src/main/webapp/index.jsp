<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Time Tracker</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #1b1b1b;
            color: #ffffff;
            overflow-x: hidden; /* Prevent horizontal scrollbar */
            display: flex;
            flex-direction: column;
            min-height: 100vh; /* Ensure body takes up full viewport height */
        }
        nav {
            display: flex;
            justify-content: center;
            background-color: #333333;
            padding: 20px 0; /* Increase the top and bottom padding */
            position: sticky;
            top: 0; /* Stick to the top of the viewport */
            width: 100%; /* Full width */
            z-index: 1000; /* Ensure it's above other content */
            overflow: hidden; /* Prevent overflow */
            border-bottom: 2px solid #444; /* Add a subtle bottom border */
            background: linear-gradient(90deg, #333, #444); /* Gradient background */
        }
        nav a {
            color: #ffffff;
            text-decoration: none;
            margin: 0 20px; /* Increase horizontal margin between links */
            font-size: 1.4em; /* Increase font size for better readability */
            position: relative; /* For positioning the pseudo-element */
            padding: 10px 0; /* Padding for better click area */
            transition: color 0.3s, transform 0.3s; /* Smooth transitions */
        }
        nav a::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: -5px; /* Position the line below text */
            width: 100%;
            height: 2px; /* Thickness of the underline */
            background: #ffb400; /* Color of the underline */
            transform: scaleX(0); /* Initially hidden */
            transform-origin: bottom right; /* Animates from right to left */
            transition: transform 0.3s; /* Smooth underline animation */
        }
        nav a:hover::after {
            transform: scaleX(1); /* Show underline on hover */
            transform-origin: bottom left; /* Animate from left to right */
        }
        nav a:hover {
            color: #ffb400; /* Change text color on hover */
            transform: translateY(-3px); /* Slightly raise text on hover */
        }
        .welcome-section {
            height: 100vh; /* Full viewport height */
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative; /* For positioning the animation */
            overflow: hidden; /* Hide the overflow of the animation */
            background: url('https://e1.pxfuel.com/desktop-wallpaper/1003/321/desktop-wallpaper-office-workers-2018-in-business-workers.jpg') center center / cover no-repeat;
            animation: zoomPan 30s infinite linear;
        }
        .welcome-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5); /* Dark overlay with opacity */
            z-index: 1;
            animation: overlayShift 15s infinite alternate;
        }
        .welcome-section h1 {
            font-size: 3em;
            margin: 0;
            background-color: rgba(0, 0, 0, 0.7); /* Semi-transparent background for text */
            padding: 30px; /* Increased padding */
            border-radius: 10px;
            position: relative; /* Ensure text is above the overlay */
            z-index: 2;
            color: #ffffff; /* Ensure text color contrasts well with background */
            text-align: center; /* Center-align the text */
        }
        @keyframes zoomPan {
            0% {
                background-size: 110%;
                background-position: center center;
            }
            100% {
                background-size: 120%;
                background-position: top right;
            }
        }
        @keyframes overlayShift {
            0% {
                background-color: rgba(0, 0, 0, 0.3);
            }
            100% {
                background-color: rgba(0, 0, 0, 0.6);
            }
        }
        .container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px; /* Increased padding for container */
            flex: 1; /* Allows container to grow and fill space */
            display: flex;
            flex-direction: column;
        }
        main {
            padding: 40px; /* Increased padding for main */
            flex: 1; /* Allows main to grow and fill space */
            display: flex;
            flex-direction: column;
            align-items: center; /* Center-align content */
            text-align: center; /* Center-align text */
        }
        main section {
            margin-bottom: 50px; /* Increased margin-bottom for sections */
            position: relative; /* For positioning the animation */
            overflow: hidden; /* Hide overflow for animations */
        }
        main h2 {
            font-size: 3em; /* Increased font size for the heading */
            margin-bottom: 20px;
            color: #ffffff; /* Standard text color */
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.8); /* Add text shadow */
        }
        main p {
            font-size: 1.3em; /* Slightly larger font size for better readability */
            line-height: 1.8; /* Increased line height for better spacing */
            position: relative; /* Ensure paragraph is above animation */
            color: #e0e0e0; /* Slightly lighter text color */
            background: linear-gradient(45deg, rgba(255, 255, 255, 0.2), rgba(0, 0, 0, 0.5)); /* Gradient background */
            padding: 20px; /* Padding for paragraph */
            border-radius: 10px; /* Rounded corners */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5); /* Shadow for depth */
            animation: fadeInUp 1.5s ease-out; /* Animation for paragraph */
        }
        @keyframes fadeInUp {
            0% {
                opacity: 0;
                transform: translateY(20px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .key-features {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }
        .key-feature {
            flex: 1 1 18%; /* Adjust to fit 5 features */
            margin: 20px;
            text-align: center;
            background-color: rgba(0, 0, 0, 0.5);
            padding: 30px; /* Increased padding for key features */
            border-radius: 10px;
            animation: slideIn 1s ease-out; /* Animation for key features */
        }
        .key-feature img {
            max-width: 100%;
            height: auto;
            border-radius: 10px;
        }
        .key-feature h3 {
            font-size: 1.8em; /* Increased font size for key feature titles */
            margin-top: 15px;
            color: #ffb400; /* Highlight color for feature titles */
        }
        section button {
            background-color: #ffb400;
            color: #000000;
            border: none;
            padding: 20px 40px; /* Increased padding for buttons */
            font-size: 1.5em; /* Larger font size for buttons */
            margin: 10px;
            border-radius: 5px;
            cursor: pointer;
        }
        footer {
            background-color: #2d2d2d;
            text-align: center;
            padding: 30px 0; /* Increased padding for footer */
        }
    </style>
</head>
<body>
    <nav>
        <a href="login.jsp">Login</a>
        <a href="register.jsp">Register</a>
       
    </nav>
    
    <div class="welcome-section">
        <h1>Welcome to Employee Time Tracker</h1>
    </div>

    <div class="container">
        <main>
            <section>
                <h2>Track Your Time Efficiently</h2>
                <p>Our Employee Time Tracker helps you manage your tasks and working hours effectively. 
                   Whether you're an individual contributor or a team lead, our tool provides insights 
                   into your productivity and helps you stay organized.</p>
            </section>
            <section class="key-features">
                <div class="key-feature">
                    <img src="feature1.jpg" alt="Feature 1">
                    <h3>Feature 1</h3>
                </div>
                <div class="key-feature">
                    <img src="feature2.jpg" alt="Feature 2">
                    <h3>Feature 2</h3>
                </div>
                <div class="key-feature">
                    <img src="feature3.jpg" alt="Feature 3">
                    <h3>Feature 3</h3>
                </div>
                <div class="key-feature">
                    <img src="feature4.jpg" alt="Feature 4">
                    <h3>Feature 4</h3>
                </div>
                <div class="key-feature">
                    <img src="feature5.jpg" alt="Feature 5">
                    <h3>Feature 5</h3>
                </div>
            </section>
        </main>
    </div>

    <footer>
        <p>&copy; 2024 Employee Time Tracker. All rights reserved.</p>
    </footer>
</body>
</html>
