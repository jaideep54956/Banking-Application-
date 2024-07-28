<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="com.timetracker.model.Employee" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Task Charts</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root {
            --bg-color: #1b1b1b;
            --text-color: #ffffff;
            --nav-bg-color: #333333;
            --gradient-color: #444;
            --hover-color: #ffb400;
            --overlay-color: rgba(0, 0, 0, 0.5);
            --text-bg-color: rgba(0, 0, 0, 0.7);
            --paragraph-color: #e0e0e0;
            --gradient-start: rgba(255, 255, 255, 0.2);
            --gradient-end: rgba(0, 0, 0, 0.5);
            --footer-bg: #2d2d2d;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: var(--bg-color) url('https://img.pikbest.com/wp/202405/performance-charts-3d-rendering-of-a-corporate-chart_9837576.jpg!bw700') no-repeat center center fixed;
            background-size: cover;
            color: var(--text-color);
            line-height: 1.6;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            animation: bgPan 30s linear infinite;
        }

        @keyframes bgPan {
            0% {
                background-position: 0% 0%;
            }
            100% {
                background-position: 100% 100%;
            }
        }

        header {
            background-color: var(--nav-bg-color);
            padding: 1rem;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 1rem;
            font-size: 2rem;
            text-transform: uppercase;
            letter-spacing: 2px;
            background: linear-gradient(45deg, var(--text-color), var(--hover-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 2rem auto;
            padding: 2rem;
            background: linear-gradient(135deg, var(--gradient-start), var(--gradient-end));
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        form {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            margin-bottom: 2rem;
        }

        select, input[type="submit"] {
            flex: 1;
            padding: 0.5rem;
            border: none;
            border-radius: 5px;
            background-color: var(--nav-bg-color);
            color: var(--text-color);
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        select:focus, input[type="submit"]:focus {
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

        p {
            margin-bottom: 1rem;
            padding: 0.5rem;
            background-color: var(--text-bg-color);
            border-radius: 5px;
        }

        .chart-container {
            width: 100%;
            height: 600px; /* Increased height */
            margin: auto;
            background-color: var(--overlay-color);
            padding: 1rem;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        canvas {
            width: 100%;
            height: 100%;
        }

        footer {
            margin-top: auto;
            background-color: var(--footer-bg);
            color: var(--text-color);
            text-align: center;
            padding: 1rem;
        }

        @media (max-width: 768px) {
            form {
                flex-direction: column;
            }
            select, input[type="submit"] {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <header>
        <h2>Admin Task Charts</h2>
    </header>

    <div class="container">
        <form action="adminChart" method="get">
            <select name="employeeId">
                <option value="">Select Employee</option>
                <% List<Employee> employees = (List<Employee>) request.getAttribute("employees");
                for (Employee emp : employees) { %>
                    <option value="<%= emp.getId() %>"><%= emp.getName() %></option>
                <% } %>
            </select>
            <select name="project">
                <option value="">Select Project</option>
                <% List<String> projects = (List<String>) request.getAttribute("projects");
                for (String project : projects) { %>
                    <option value="<%= project %>"><%= project %></option>
                <% } %>
            </select>
            <select name="type">
                <option value="daily">Daily</option>
                <option value="weekly">Weekly</option>
                <option value="monthly">Monthly</option>
            </select>
            <select name="period">
                <option value="week">Last Week</option>
                <option value="month">Last Month</option>
                <option value="year">Last Year</option>
            </select>
            <input type="submit" value="Generate Chart">
        </form>

        <% if (request.getAttribute("error") != null) { %>
            <p>${error}</p>
        <% } else if (request.getAttribute("chartData") != null) { %>
            <p>Total Hours: ${totalHours}</p>

            <div class="chart-container">
                <canvas id="taskChart"></canvas>
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
                                for (Double value : chartData.values()) {
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
                                text: 'Hours',
                                color: '#ffffff'
                            },
                            ticks: {
                                color: '#ffffff'
                            },
                            grid: {
                                color: 'rgba(255, 255, 255, 0.1)'
                            }
                        },
                        x: {
                            ticks: {
                                color: '#ffffff'
                            },
                            grid: {
                                color: 'rgba(255, 255, 255, 0.1)'
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            position: 'top',
                            labels: {
                                color: '#ffffff'
                            }
                        },
                        title: {
                            display: true,
                            text: 'Task Hours Chart',
                            color: '#ffffff'
                        }
                    }
                };

                var myChart = new Chart(ctx, {
                    type: 'bar',
                    data: chartData,
                    options: chartOptions
                });
            </script>
        <% } %>
    </div>

    <footer>
        <p>Employee Time Tracker &copy; 2024</p>
    </footer>
</body>
</html>
