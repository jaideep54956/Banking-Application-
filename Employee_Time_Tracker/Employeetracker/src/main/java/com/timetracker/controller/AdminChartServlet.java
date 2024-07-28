package com.timetracker.controller;

import com.timetracker.dao.TaskDAO;
import com.timetracker.dao.EmployeeDAO;
import com.timetracker.model.Task;
import com.timetracker.model.Employee;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet("/adminChart")
public class AdminChartServlet extends HttpServlet {
    private TaskDAO taskDAO = new TaskDAO();
    private EmployeeDAO employeeDAO = new EmployeeDAO();
    private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    private SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String project = request.getParameter("project");
        String employeeId = request.getParameter("employeeId");
        String chartType = request.getParameter("type");
        String period = request.getParameter("period");

        try {
            if ((project != null && !project.isEmpty()) || (employeeId != null && !employeeId.isEmpty())) {
                List<Task> tasks;
                if (project != null && !project.isEmpty()) {
                    tasks = taskDAO.getTasksByProject(project);
                } else {
                    tasks = taskDAO.getTasksByEmployee(Integer.parseInt(employeeId));
                }

                Map<String, Double> chartData = generateChartData(tasks, chartType, period);

                request.setAttribute("chartData", chartData);
                request.setAttribute("chartType", chartType);
                request.setAttribute("period", period);
                request.setAttribute("totalHours", calculateTotalHours(chartData));
            } else {
                // Handle case where neither project nor employeeId is provided
                request.setAttribute("error", "Either project or employeeId must be provided");
            }

            List<Employee> employees = employeeDAO.getAllEmployees();
            request.setAttribute("employees", employees);

            List<String> projects = taskDAO.getAllProjects();
            request.setAttribute("projects", projects);

            request.getRequestDispatcher("adminCharts.jsp").forward(request, response);
        } catch (NumberFormatException | SQLException e) {
            throw new ServletException("Error retrieving tasks for chart", e);
        }
    }

    private double calculateTotalHours(Map<String, Double> chartData) {
        return chartData.values().stream().mapToDouble(Double::doubleValue).sum();
    }

    private Map<String, Double> generateChartData(List<Task> tasks, String chartType, String period) {
        Map<String, Double> chartData = new LinkedHashMap<>();

        switch (chartType) {
            case "daily":
                chartData = generateDailyChart(tasks, period);
                break;
            case "weekly":
                chartData = generateWeeklyChart(tasks, period);
                break;
            case "monthly":
                chartData = generateMonthlyChart(tasks, period);
                break;
            default:
                throw new IllegalArgumentException("Invalid chart type: " + chartType);
        }

        return chartData;
    }

    private Map<String, Double> generateDailyChart(List<Task> tasks, String period) {
        return tasks.stream()
                .filter(task -> isWithinPeriod(task.getDate(), period))
                .collect(Collectors.groupingBy(
                        task -> dateFormat.format(task.getDate()),
                        Collectors.summingDouble(this::calculateTaskDuration)
                ));
    }

    private Map<String, Double> generateWeeklyChart(List<Task> tasks, String period) {
        return tasks.stream()
                .filter(task -> isWithinPeriod(task.getDate(), period))
                .collect(Collectors.groupingBy(
                        task -> getWeekOfYear(task.getDate()),
                        Collectors.summingDouble(this::calculateTaskDuration)
                ));
    }

    private Map<String, Double> generateMonthlyChart(List<Task> tasks, String period) {
        return tasks.stream()
                .filter(task -> isWithinPeriod(task.getDate(), period))
                .collect(Collectors.groupingBy(
                        task -> getYearMonth(task.getDate()),
                        Collectors.summingDouble(this::calculateTaskDuration)
                ));
    }

    private boolean isWithinPeriod(Date date, String period) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());  // current date

        switch (period) {
            case "week":
                cal.add(Calendar.WEEK_OF_YEAR, -1);
                break;
            case "month":
                cal.add(Calendar.MONTH, -1);
                break;
            case "year":
                cal.add(Calendar.YEAR, -1);
                break;
            default:
                return true;  // if no period specified, include all
        }

        return date.after(cal.getTime());
    }

    private double calculateTaskDuration(Task task) {
        try {
            Date startTime = timeFormat.parse(task.getStartTime());
            Date endTime = timeFormat.parse(task.getEndTime());
            return (endTime.getTime() - startTime.getTime()) / (1000.0 * 60 * 60);  // convert to hours
        } catch (ParseException e) {
            e.printStackTrace();
            return 0;
        }
    }

    private String getWeekOfYear(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        int week = cal.get(Calendar.WEEK_OF_YEAR);
        int year = cal.get(Calendar.YEAR);
        return year + "-W" + String.format("%02d", week);
    }

    private String getYearMonth(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        int month = cal.get(Calendar.MONTH) + 1;  // Calendar months are 0-based
        int year = cal.get(Calendar.YEAR);
        return year + "-" + String.format("%02d", month);
    }
}
