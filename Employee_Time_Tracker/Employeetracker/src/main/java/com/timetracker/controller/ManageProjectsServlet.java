package com.timetracker.controller;

import com.timetracker.dao.TaskDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/manageProjects")
public class ManageProjectsServlet extends HttpServlet {
    private TaskDAO taskDAO = new TaskDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<String> projects = taskDAO.getAllProjects();
            request.setAttribute("projects", projects);
            request.getRequestDispatcher("manageProjects.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error retrieving projects", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("add".equals(action)) {
                addProject(request);
            } else if ("delete".equals(action)) {
                deleteProject(request);
            }
            response.sendRedirect("manageProjects");
        } catch (SQLException e) {
            throw new ServletException("Error managing projects", e);
        }
    }

    private void addProject(HttpServletRequest request) throws SQLException {
        String projectName = request.getParameter("projectName");
        taskDAO.addProject(projectName);
    }

    private void deleteProject(HttpServletRequest request) throws SQLException {
        String projectName = request.getParameter("projectName");
        taskDAO.deleteProject(projectName);
    }
}
