package com.timetracker.controller;

import com.timetracker.dao.TaskDAO;
import com.timetracker.model.Task;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/generateReports")
public class GenerateReportsServlet extends HttpServlet {
    private TaskDAO taskDAO = new TaskDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String reportType = request.getParameter("type");
        try {
            if ("daily".equals(reportType)) {
                generateDailyReport(request);
            } else if ("weekly".equals(reportType)) {
                generateWeeklyReport(request);
            } else if ("monthly".equals(reportType)) {
                generateMonthlyReport(request);
            }
            request.getRequestDispatcher("viewReport.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error generating report", e);
        }
    }

    private void generateDailyReport(HttpServletRequest request) throws SQLException {
        List<Task> tasks = taskDAO.getTasksForToday();
        request.setAttribute("reportTasks", tasks);
        request.setAttribute("reportType", "Daily");
    }

    private void generateWeeklyReport(HttpServletRequest request) throws SQLException {
        List<Task> tasks = taskDAO.getTasksForLastWeek();
        request.setAttribute("reportTasks", tasks);
        request.setAttribute("reportType", "Weekly");
    }

    private void generateMonthlyReport(HttpServletRequest request) throws SQLException {
        List<Task> tasks = taskDAO.getTasksForLastMonth();
        request.setAttribute("reportTasks", tasks);
        request.setAttribute("reportType", "Monthly");
    }
}