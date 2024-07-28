package com.timetracker.controller;
import com.timetracker.dao.EmployeeDAO;
import com.timetracker.dao.TaskDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {
    private EmployeeDAO employeeDAO;
    private TaskDAO taskDAO;

    @Override
    public void init() {
        employeeDAO = new EmployeeDAO();
        taskDAO = new TaskDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int totalEmployees = employeeDAO.getTotalEmployees();
            int totalProjects = taskDAO.getTotalProjects();
            int tasksLoggedToday = taskDAO.getTasksLoggedToday();

            request.setAttribute("totalEmployees", totalEmployees);
            request.setAttribute("totalProjects", totalProjects);
            request.setAttribute("tasksLoggedToday", tasksLoggedToday);

            request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
