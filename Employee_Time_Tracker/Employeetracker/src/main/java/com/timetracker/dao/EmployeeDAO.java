package com.timetracker.dao;

import com.timetracker.model.Employee;
import com.timetracker.model.Role;
import com.timetracker.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EmployeeDAO {

    public Employee authenticate(String username, String password) throws SQLException {
        String sql = "SELECT * FROM employees WHERE username = ? AND password = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new Employee(
                            rs.getInt("id"),
                            rs.getString("name"),
                            Role.valueOf(rs.getString("role")),
                            rs.getString("username"),
                            rs.getString("password")
                    );
                }
            }
        }
        return null;
    }

    public void registerEmployee(Employee employee) throws SQLException {
        String sql = "INSERT INTO employees (name, role, username, password) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, employee.getName());
            pstmt.setString(2, employee.getRole().toString());
            pstmt.setString(3, employee.getUsername());
            pstmt.setString(4, employee.getPassword());
            pstmt.executeUpdate();
        }
    }

    public boolean usernameExists(String username) throws SQLException {
        String sql = "SELECT COUNT(*) FROM employees WHERE username = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    public List<Employee> getAllEmployees() throws SQLException {
        List<Employee> employees = new ArrayList<>();
        String sql = "SELECT * FROM employees";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                employees.add(new Employee(
                        rs.getInt("id"),
                        rs.getString("name"),
                        Role.valueOf(rs.getString("role")),
                        rs.getString("username"),
                        rs.getString("password")
                ));
            }
        }
        return employees;
    }

    public Employee getEmployeeById(int employeeId) throws SQLException {
        String sql = "SELECT * FROM employees WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, employeeId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new Employee(
                            rs.getInt("id"),
                            rs.getString("name"),
                            Role.valueOf(rs.getString("role")),
                            rs.getString("username"),
                            rs.getString("password")
                    );
                }
            }
        }
        return null;
    }

    public void addEmployee(Employee employee) throws SQLException {
        String sql = "INSERT INTO employees (name, role, username, password) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, employee.getName());
            pstmt.setString(2, employee.getRole().toString());
            pstmt.setString(3, employee.getUsername());
            pstmt.setString(4, employee.getPassword());
            pstmt.executeUpdate();
        }
    }

    public void updateEmployee(Employee employee) throws SQLException {
        String sql = "UPDATE employees SET name = ?, role = ?, username = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, employee.getName());
            pstmt.setString(2, employee.getRole().toString());
            pstmt.setString(3, employee.getUsername());
            pstmt.setInt(4, employee.getId());
            pstmt.executeUpdate();
        }
    }

    public void deleteEmployee(int id) throws SQLException {
        String sql = "DELETE FROM employees WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        }
    }

    public int getTotalEmployees() throws SQLException {
        String sql = "SELECT COUNT(*) FROM employees";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
}
