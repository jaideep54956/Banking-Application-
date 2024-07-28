<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Task</title>
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

        .container {
            width: 100%;
            max-width: 1200px; /* Adjusted width for more space */
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .form-wrapper {
            width: 100%;
            max-width: 1200px;
            transform-style: preserve-3d; /* Preserve 3D transforms if needed for other effects */
            transition: transform 0.5s ease-in-out;
        }

        .form-content {
            background: rgba(255, 255, 255, 0.1); /* Glassmorphism effect */
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            padding: 30px;
            box-sizing: border-box;
            display: flex;
            align-items: center;
            gap: 30px; /* Space between image and form */
            opacity: 0;
            transform: translateY(50px);
            animation: fadeInUp 1s ease forwards;
        }

        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .image-container {
            flex: 1;
            max-width: 600px; /* Increased max-width for the image container */
            transition: transform 0.5s ease-in-out;
        }

        .image-container img {
            width: 100%;
            height: auto; /* Maintain aspect ratio */
            max-height: 700px; /* Increased height to make the image larger */
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .form-container {
            flex: 2;
            display: flex;
            flex-direction: column;
            margin-left: 20px; /* Space between image and form */
        }

        h2 {
            color: #ffffff; /* Change heading color to white */
            margin-bottom: 20px;
            position: relative;
            font-size: 24px;
            text-align: center;
        }

        h2:before {
            content: '';
            position: absolute;
            width: 50px;
            height: 3px;
            background-color: #ffffff; /* Change underline color to white */
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
        }

        form {
            display: flex;
            flex-direction: column;
            animation: formSlideIn 1s ease forwards;
        }

        @keyframes formSlideIn {
            from {
                opacity: 0;
                transform: translateX(-50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        input[type="text"],
        input[type="date"],
        input[type="time"],
        textarea {
            padding: 14px;
            margin: 10px 0;
            border: 1px solid rgba(255, 255, 255, 0.4); /* Change border color to white */
            border-radius: 8px;
            width: calc(100% - 28px);
            background: rgba(255, 255, 255, 0.2);
            color: #ffffff; /* Change input text color to white */
            transition: border-color 0.3s ease, box-shadow 0.3s ease, background-color 0.3s ease;
        }

        input[type="text"]:focus,
        input[type="date"]:focus,
        input[type="time"]:focus,
        textarea:focus {
            border-color: #ffffff; /* Change focus border color to white */
            box-shadow: 0 0 8px rgba(255, 255, 255, 0.6); /* Change focus shadow color to white */
            background-color: rgba(255, 255, 255, 0.3);
        }

        input[type="submit"] {
            background-color: #fdfd09; /* Single color */
            color: rgb(14, 14, 14);
            padding: 14px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
            margin-top: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        input[type="submit"]:hover {
            background-color: #555;
            color: #ffffff; /* Darker shade for hover */
            transform: scale(1.05);
        }

        .back-link {
            display: block;
            margin-top: 20px;
            text-decoration: none;
            color: #ffffff; /* Change link color to white */
            transition: color 0.3s ease, transform 0.3s ease;
            text-align: center;
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
            background: rgba(255, 255, 255, 0.2);
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
            background-color: rgba(255, 255, 255, 0.3);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-wrapper">
            <div class="form-content">
                <div class="image-container">
                    <img src="https://cdn.pixabay.com/photo/2019/05/16/20/15/online-4208112_640.jpg" alt="Task Image">
                </div>
                <div class="form-container">
                    <h2>Add New Task</h2>
                    <form action="task" method="post">
                        <input type="hidden" name="action" value="add">
                        <div class="floating-label">
                            <input type="text" name="project" required placeholder=" ">
                            <label>Project</label>
                        </div>
                        <div class="floating-label">
                            <input type="date" name="date" required placeholder=" ">
                            <label>Date</label>
                        </div>
                        <div class="floating-label">
                            <input type="time" name="startTime" required placeholder=" ">
                            <label>Start Time</label>
                        </div>
                        <div class="floating-label">
                            <input type="time" name="endTime" required placeholder=" ">
                            <label>End Time</label>
                        </div>
                        <div class="floating-label">
                            <input type="text" name="category" required placeholder=" ">
                            <label>Category</label>
                        </div>
                        <div class="floating-label">
                            <textarea name="description" required placeholder=" " rows="5"></textarea>
                            <label>Description</label>
                        </div>
                        <input type="submit" value="Add Task">
                    </form>
                    <a href="viewTasks.jsp" class="back-link">Back to Tasks</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
