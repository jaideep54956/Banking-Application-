package com.timetracker.controller;

import com.timetracker.dao.TaskDAO;
import com.timetracker.model.Employee;
import com.timetracker.model.Task;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet("/chart")
public class ChartServlet extends HttpServlet {
    private TaskDAO taskDAO = new TaskDAO();
    private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    private SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Employee employee = (Employee) session.getAttribute("employee");

        String chartType = request.getParameter("type");
        String period = request.getParameter("period");

        try {
            List<Task> tasks = taskDAO.getTasksByEmployee(employee.getId());
            Map<String, Double> chartData = generateChartData(tasks, chartType, period);

            request.setAttribute("chartData", chartData);
            request.setAttribute("chartType", chartType);
            request.setAttribute("period", period);
            request.setAttribute("totalHours", calculateTotalHours(chartData));

            request.getRequestDispatcher("charts.jsp").forward(request, response);
        } catch (SQLException | ParseException e) {
            throw new ServletException("Error retrieving tasks for chart", e);
        }
    }

    private Map<String, Double> generateChartData(List<Task> tasks, String chartType, String period) throws ParseException {
        Date today = new Date();
        Date startDate = getStartDate(today, period);

        return tasks.stream()
                .filter(task -> isTaskInPeriod(task, startDate, today))
                .collect(Collectors.groupingBy(
                        task -> getGroupKey(task, chartType),
                        Collectors.summingDouble(this::calculateTaskDuration)
                ));
    }

    private Date getStartDate(Date endDate, String period) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(endDate);
        switch (period) {
            case "daily":
                cal.set(Calendar.HOUR_OF_DAY, 0);
                cal.set(Calendar.MINUTE, 0);
                cal.set(Calendar.SECOND, 0);
                cal.set(Calendar.MILLISECOND, 0);
                return cal.getTime();
            case "weekly":
                cal.add(Calendar.DAY_OF_MONTH, -7);
                return cal.getTime();
            case "monthly":
                cal.add(Calendar.MONTH, -1);
                return cal.getTime();
            default:
                return endDate;
        }
    }

    private boolean isTaskInPeriod(Task task, Date startDate, Date endDate) {
        return !task.getDate().before(startDate) && !task.getDate().after(endDate);
    }

    private String getGroupKey(Task task, String chartType) {
        if ("daily".equals(chartType)) {
            return task.getCategory();
        } else {
            return dateFormat.format(task.getDate());
        }
    }

    private double calculateTaskDuration(Task task) {
        try {
            Date startTime = timeFormat.parse(task.getStartTime());
            Date endTime = timeFormat.parse(task.getEndTime());
            long durationMillis = endTime.getTime() - startTime.getTime();
            return durationMillis / (60.0 * 60 * 1000); // Convert to hours
        } catch (ParseException e) {
            e.printStackTrace();
            return 0.0;
        }
    }

    private double calculateTotalHours(Map<String, Double> chartData) {
        return chartData.values().stream().mapToDouble(Double::doubleValue).sum();
    }
}