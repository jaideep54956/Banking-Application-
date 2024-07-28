<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.TreeMap" %>
<!DOCTYPE html>
<html>
<head>
    <title>Task Charts</title>
    <link rel="stylesheet" href="styles.css"> <!-- Link to your CSS file -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700&display=swap');

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #2d2d2d; /* Dark background color */
            color: #ffffff; /* Change text color to white */
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .image-background {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('https://www.aimtechnologies.co/wp-content/uploads/2024/06/Social-Media-Performance-Analysis.jpg') no-repeat center center/cover;
            z-index: -1;
        }

        .container {
            width: 60%; /* Adjust as needed */
            padding: 30px;
            box-sizing: border-box;
            animation: fadeInUp 1s ease forwards;
            background-color: rgba(45, 45, 45, 0.8); /* Blend with body background */
            margin: auto;
            height: auto; /* Adjust height */
            max-height: 90vh; /* Prevent container from exceeding viewport height */
            overflow-y: auto;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        h2 {
            color: #ffffff; /* Change heading color to white */
            margin-bottom: 20px;
            font-size: 24px;
            padding-bottom: 10px; /* Space below the heading */
            border-bottom: 2px solid #ffffff; /* Clean line below heading */
            display: inline-block;
            text-align: center;
            animation: slideInLeft 1s ease forwards;
        }

        @keyframes slideInLeft {
            from {
                opacity: 0;
                transform: translateX(-50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .chart-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px; /* Space between charts */
            justify-content: center;
        }

        .chart-box {
            flex: 1 1 calc(100% - 40px); /* Full width on small screens, adjust for spacing */
            max-width: 800px; /* Max width for each chart */
            min-width: 300px; /* Minimum width for responsiveness */
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background: rgba(255, 255, 255, 0.1); /* Slight background for each chart box */
            padding: 15px;
            box-sizing: border-box;
            border: none; /* Remove any unwanted borders */
        }

        canvas {
            width: 100% !important; /* Ensure chart canvas fits the box */
            height: auto !important; /* Maintain aspect ratio */
        }

        a {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            color: #ffffff; /* Change link color to white */
            transition: color 0.3s ease, transform 0.3s ease;
            text-align: center;
            font-weight: 500;
            animation: slideInRight 1s ease forwards;
        }

        @keyframes slideInRight {
            from {
                opacity: 0;
                transform: translateX(50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        a:hover {
            color: #aaaaaa; /* Lighter shade for hover */
            transform: translateY(-3px);
        }
    </style>
</head>
<body>
    <div class="image-background"></div>
    <div class="container">
        <h2>Task Charts</h2>
        <p>Total Hours: ${totalHours}</p>
        <div class="chart-container">
            <div class="chart-box">
                <canvas id="taskChart"></canvas>
            </div>
        </div>
        <a href="dashboard.jsp">Back to Dashboard</a>
    </div>

    <script>
        var ctx = document.getElementById('taskChart').getContext('2d');
        var chartData = {
            labels: [
                <% 
                    Map<String, Double> chartData = (Map<String, Double>) request.getAttribute("chartData");
                    for (String key : chartData.keySet()) {
                        out.print("'" + key + "',");
                    }
                %>
            ],
            datasets: [{
                label: 'Hours',
                data: [
                    <% 
                        Map<String, Double> chartData2 = (Map<String, Double>) request.getAttribute("chartData");
                        for (Double value : chartData2.values()) {
                            out.print(value + ",");
                        }
                    %>
                ],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(153, 102, 255, 0.2)',
                    'rgba(255, 159, 64, 0.2)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(255, 159, 64, 1)'
                ],
                borderWidth: 1
            }]
        };
        
        var chartOptions = {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Hours'
                    }
                }
            },
            plugins: {
                title: {
                    display: true,
                    text: 'Task Distribution - <%= request.getAttribute("period") %>'
                },
                legend: {
                    display: <%= "daily".equals(request.getAttribute("chartType")) %>
                }
            }
        };

        var myChart = new Chart(ctx, {
            type: '<%= "daily".equals(request.getAttribute("chartType")) ? "pie" : "bar" %>',
            data: chartData,
            options: chartOptions
        });
    </script>
</body>
</html>
