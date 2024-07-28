package com.timetracker.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.timetracker.model.Employee;
import com.timetracker.model.Role;
import com.timetracker.dao.EmployeeDAO;

@WebServlet("/manageEmployees")
public class ManageEmployeesServlet extends HttpServlet {
    private EmployeeDAO employeeDAO = new EmployeeDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Employee> employees = employeeDAO.getAllEmployees();
            request.setAttribute("employees", employees);
            request.getRequestDispatcher("/manageEmployees.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error retrieving employees", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            if ("add".equals(action)) {
                addEmployee(request, response);
            } else if ("edit".equals(action)) {
                editEmployee(request, response);
            } else if ("delete".equals(action)) {
                deleteEmployee(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Error processing employee action", e);
        }
        
        response.sendRedirect("manageEmployees");
    }

    private void addEmployee(HttpServletRequest request, HttpServletResponse response) throws SQLException {
    	  
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        Role role = Role.valueOf(request.getParameter("role"));
        
        if (name != null && !name.isEmpty() && username != null && !username.isEmpty() && password != null && !password.isEmpty()) {
        	 Employee employee = new Employee();
             employee.setName(name);
             employee.setUsername(username);
             employee.setPassword(password);
             employee.setRole(role); // Setting role based on user input

            
            employeeDAO.addEmployee(employee);
        }
    }

    private void editEmployee(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String role = request.getParameter("role");
        
        if (name != null && !name.isEmpty() && username != null && !username.isEmpty() && role != null && !role.isEmpty()) {
            Employee employee = employeeDAO.getEmployeeById(id);
            if (employee != null) {
                employee.setName(name);
                employee.setUsername(username);
                employee.setRole(Role.valueOf(role));
                employeeDAO.updateEmployee(employee);
            }
        } else {
            throw new IllegalArgumentException("Name, username, and role are required");
        }
    }

    private void deleteEmployee(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        employeeDAO.deleteEmployee(id);
    }
}