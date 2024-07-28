<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.timetracker.model.Task" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= request.getAttribute("reportType") %> Report</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            background-color: #0e0e0e;
            color: #fbf7f7;
            font-family: Arial, sans-serif;
            background-image: url('https://w0.peakpx.com/wallpaper/574/203/HD-wallpaper-chart-pattern.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            height: 100vh;
            margin: 0;
        }
        h1, h2 {
            text-align: center;
            margin-top: 20px;
            color: white;
        }
        h2 {
            font-size: 2em;
        }
        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            transition: transform 0.3s;
        }
        table:hover {
            transform: scale(1.02);
        }
        table, th, td {
            border: 1px solid #ffffff;
        }
        th, td {
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #ffb400;
            color: #1b1b1b;
        }
        tr:nth-child(even) {
            background-color: #444444;
        }
        tr:hover {
            background-color: #555555;
        }
        form {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 20px;
        }
        select, input[type="submit"] {
            padding: 10px;
            margin: 5px;
            border: none;
            border-radius: 5px;
            transition: background-color 0.3s, transform 0.3s;
        }
        input[type="submit"] {
            background-color: #ffb400;
            color: #1b1b1b;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #ffaa00;
            transform: scale(1.1);
        }
        input[type="submit"]:active {
            transform: scale(1);
        }
        a {
            display: block;
            text-align: center;
            margin: 20px;
            color: #ffb400;
            text-decoration: none;
            transition: color 0.3s;
        }
        a:hover {
            text-decoration: underline;
            color: #ffaa00;
        }
        .graph-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            margin-top: 20px;
        }
        .graph {
            margin: 10px;
            padding: 20px;
            background-color: #1b1b1b;
            border-radius: 10px;
            width: calc(100% / 3 - 40px);
            min-width: 250px;
            color: #fff;
        }
    </style>
</head>
<body>
    <h1><%= request.getAttribute("reportType") %> Report</h1>
    
    <table>
        <tr>
            <th>Employee ID</th>
            <th>Project</th>
            <th>Date</th>
            <th>Start Time</th>
            <th>End Time</th>
            <th>Category</th>
            <th>Description</th>
        </tr>
        
        <% List<Task> tasks = (List<Task>) request.getAttribute("reportTasks");
           if (tasks != null && !tasks.isEmpty()) {
               for (Task task : tasks) { %>
                   <tr>
                       <td><%= task.getEmployeeId() %></td>
                       <td><%= task.getProject() %></td>
                       <td><%= new SimpleDateFormat("yyyy-MM-dd").format(task.getDate()) %></td>
                       <td><%= task.getStartTime() %></td>
                       <td><%= task.getEndTime() %></td>
                       <td><%= task.getCategory() %></td>
                       <td><%= task.getDescription() %></td>
                   </tr>
               <% }
           } else { %>
               <tr>
                   <td colspan="7">No tasks found for this report type.</td>
               </tr>
        <% } %>
    </table>

    <h2>Generate New Report</h2>
    <form action="generateReports" method="get">
        <select name="type">
            <option value="daily">Daily Report</option>
            <option value="weekly">Weekly Report</option>
            <option value="monthly">Monthly Report</option>
        </select>
        <input type="submit" value="Generate Report">
    </form>

    <div class="graph-container" id="graph-container">
        <!-- Graphs will be dynamically added here -->
    </div>

    <a href="dashboard.jsp">Back to Dashboard</a>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const graphContainer = document.getElementById('graph-container');

            function addGraph(graphTitle, graphContent) {
                const graphDiv = document.createElement('div');
                graphDiv.classList.add('graph');
                
                const graphTitleElem = document.createElement('h3');
                graphTitleElem.innerText = graphTitle;
                graphDiv.appendChild(graphTitleElem);

                const graphContentElem = document.createElement('div');
                graphContentElem.innerHTML = graphContent;
                graphDiv.appendChild(graphContentElem);

                graphContainer.appendChild(graphDiv);
            }

            addGraph('Graph 1', '<canvas id="chart1"></canvas>');
            addGraph('Graph 2', '<canvas id="chart2"></canvas>');
            addGraph('Graph 3', '<canvas id="chart3"></canvas>');

            new Chart(document.getElementById('chart1').getContext('2d'), {
                type: 'bar',
                data: {
                    labels: ['January', 'February', 'March', 'April', 'May'],
                    datasets: [{
                        label: 'Dataset 1',
                        data: [10, 20, 30, 40, 50],
                        backgroundColor: 'rgba(255, 99, 132, 0.2)',
                        borderColor: 'rgba(255, 99, 132, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false
                }
            });

            new Chart(document.getElementById('chart2').getContext('2d'), {
                type: 'line',
                data: {
                    labels: ['January', 'February', 'March', 'April', 'May'],
                    datasets: [{
                        label: 'Dataset 2',
                        data: [50, 40, 30, 20, 10],
                        backgroundColor: 'rgba(54, 162, 235, 0.2)',
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false
                }
            });

            new Chart(document.getElementById('chart3').getContext('2d'), {
                type: 'pie',
                data: {
                    labels: ['Red', 'Blue', 'Yellow'],
                    datasets: [{
                        label: 'Dataset 3',
                        data: [300, 50, 100],
                        backgroundColor: ['rgba(255, 99, 132, 0.2)', 'rgba(54, 162, 235, 0.2)', 'rgba(255, 206, 86, 0.2)'],
                        borderColor: ['rgba(255, 99, 132, 1)', 'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)'],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false
                }
            });
        });
    </script>

</body>
</html>
