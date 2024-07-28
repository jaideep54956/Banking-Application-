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
import java.util.List;

@WebServlet("/task")
public class TaskServlet extends HttpServlet {
    private TaskDAO taskDAO = new TaskDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                addTask(request, response);
            } else if ("edit".equals(action)) {
                editTask(request, response);
            } else if ("delete".equals(action)) {
                deleteTask(request, response);
            }
        } catch (SQLException | ParseException e) {
            throw new ServletException("Error processing task", e);
        }
    }

    private void addTask(HttpServletRequest request, HttpServletResponse response) throws SQLException, ParseException, IOException, ServletException {
        HttpSession session = request.getSession();
        Employee employee = (Employee) session.getAttribute("employee");

        Task task = new Task();
        task.setEmployeeId(employee.getId());
        task.setProject(request.getParameter("project"));
        task.setDate(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("date")));
        task.setStartTime(request.getParameter("startTime"));
        task.setEndTime(request.getParameter("endTime"));
        task.setCategory(request.getParameter("category"));
        task.setDescription(request.getParameter("description"));

        taskDAO.addTask(task);

        // Retrieve updated list of tasks and forward to viewTasks.jsp
        List<Task> tasks = taskDAO.getTasksByEmployee(employee.getId());
        request.setAttribute("tasks", tasks);
        request.getRequestDispatcher("viewTasks.jsp").forward(request, response);
    }

    private void editTask(HttpServletRequest request, HttpServletResponse response) throws SQLException, ParseException, IOException, ServletException {
        int taskId = Integer.parseInt(request.getParameter("taskId"));
        Task task = new Task();
        task.setId(taskId);
        task.setProject(request.getParameter("project"));
        task.setDate(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("date")));
        task.setStartTime(request.getParameter("startTime"));
        task.setEndTime(request.getParameter("endTime"));
        task.setCategory(request.getParameter("category"));
        task.setDescription(request.getParameter("description"));

        taskDAO.updateTask(task);

        HttpSession session = request.getSession();
        Employee employee = (Employee) session.getAttribute("employee");

        // Retrieve updated list of tasks and forward to viewTasks.jsp
        List<Task> tasks = taskDAO.getTasksByEmployee(employee.getId());
        request.setAttribute("tasks", tasks);
        request.getRequestDispatcher("viewTasks.jsp").forward(request, response);
    }

    private void deleteTask(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        int taskId = Integer.parseInt(request.getParameter("taskId"));
        taskDAO.deleteTask(taskId);

        HttpSession session = request.getSession();
        Employee employee = (Employee) session.getAttribute("employee");

        // Retrieve updated list of tasks and forward to viewTasks.jsp
        List<Task> tasks = taskDAO.getTasksByEmployee(employee.getId());
        request.setAttribute("tasks", tasks);
        request.getRequestDispatcher("viewTasks.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Employee employee = (Employee) session.getAttribute("employee");

        try {
            request.setAttribute("tasks", taskDAO.getTasksByEmployee(employee.getId()));
            request.getRequestDispatcher("viewTasks.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error retrieving tasks", e);
        }
    }
}
