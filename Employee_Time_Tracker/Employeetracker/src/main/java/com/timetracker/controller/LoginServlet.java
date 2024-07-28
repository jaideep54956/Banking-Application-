package com.timetracker.controller;

import com.timetracker.dao.EmployeeDAO;
import com.timetracker.model.Employee;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private EmployeeDAO employeeDAO = new EmployeeDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Employee employee = employeeDAO.authenticate(username, password);
            if (employee != null) {
                HttpSession session = request.getSession();
                session.setAttribute("employee", employee);
                response.sendRedirect("dashboard.jsp");
            } else {
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }
}