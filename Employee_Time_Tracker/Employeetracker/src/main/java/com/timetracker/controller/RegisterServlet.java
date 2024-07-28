package com.timetracker.controller;

import com.timetracker.dao.EmployeeDAO;
import com.timetracker.model.Employee;
import com.timetracker.model.Role;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private EmployeeDAO employeeDAO = new EmployeeDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String roleParam = request.getParameter("role");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        try {
            if (employeeDAO.usernameExists(username)) {
                request.setAttribute("error", "Username already exists");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            Employee employee = new Employee();
            employee.setName(name);
            employee.setUsername(username);
            employee.setPassword(password);
            employee.setRole(Role.valueOf(roleParam)); // Setting role based on user input

            employeeDAO.registerEmployee(employee);
            response.sendRedirect("login.jsp?registered=true");
        } catch (SQLException e) {
            throw new ServletException("Error registering user", e);
        }
    }
}
