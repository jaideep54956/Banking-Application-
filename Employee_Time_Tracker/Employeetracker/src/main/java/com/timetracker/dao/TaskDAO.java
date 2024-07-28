package com.timetracker.dao;

import com.timetracker.model.Task;
import com.timetracker.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TaskDAO {

    public void addTask(Task task) throws SQLException {
        String sql = "INSERT INTO tasks (employee_id, project, date, start_time, end_time, category, description) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, task.getEmployeeId());
            pstmt.setString(2, task.getProject());
            pstmt.setDate(3, new java.sql.Date(task.getDate().getTime()));
            pstmt.setString(4, task.getStartTime());
            pstmt.setString(5, task.getEndTime());
            pstmt.setString(6, task.getCategory());
            pstmt.setString(7, task.getDescription());
            pstmt.executeUpdate();
        }
    }
    

   

    public List<Task> getTasksByProject(String project) throws SQLException {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM tasks WHERE project = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, project);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    tasks.add(new Task(
                        rs.getInt("id"),
                        rs.getInt("employee_id"),
                        rs.getString("project"),
                        rs.getDate("date"),
                        rs.getString("start_time"),
                        rs.getString("end_time"),
                        rs.getString("category"),
                        rs.getString("description")
                    ));
                }
            }
        }
        return tasks;
    }

        public List<Task> getAllTasks() throws SQLException {
            List<Task> tasks = new ArrayList<>();
            String sql = "SELECT * FROM tasks";
            try (Connection conn = DBUtil.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql);
                 ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    tasks.add(new Task(
                        rs.getInt("id"),
                        rs.getInt("employee_id"),
                        rs.getString("project"),
                        rs.getDate("date"),
                        rs.getString("start_time"),
                        rs.getString("end_time"),
                        rs.getString("category"),
                        rs.getString("description")
                    ));
                }
            }
            return tasks;
        }
    

    
    public void updateTask(Task task) throws SQLException {
        String sql = "UPDATE tasks SET project = ?, date = ?, start_time = ?, end_time = ?, category = ?, description = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, task.getProject());
            pstmt.setDate(2, new java.sql.Date(task.getDate().getTime()));
            pstmt.setString(3, task.getStartTime());
            pstmt.setString(4, task.getEndTime());
            pstmt.setString(5, task.getCategory());
            pstmt.setString(6, task.getDescription());
            pstmt.setInt(7, task.getId());
            pstmt.executeUpdate();
        }
    }

    public void deleteTask(int taskId) throws SQLException {
        String sql = "DELETE FROM tasks WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, taskId);
            pstmt.executeUpdate();
        }
    }

    public List<Task> getTasksByEmployee(int employeeId) throws SQLException {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM tasks WHERE employee_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, employeeId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    tasks.add(new Task(
                        rs.getInt("id"),
                        rs.getInt("employee_id"),
                        rs.getString("project"),
                        rs.getDate("date"),
                        rs.getString("start_time"),
                        rs.getString("end_time"),
                        rs.getString("category"),
                        rs.getString("description")
                    ));
                }
            }
        }
        return tasks;
    }

    public Task getTaskById(int taskId) throws SQLException {
        String sql = "SELECT * FROM tasks WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, taskId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new Task(
                        rs.getInt("id"),
                        rs.getInt("employee_id"),
                        rs.getString("project"),
                        rs.getDate("date"),
                        rs.getString("start_time"),
                        rs.getString("end_time"),
                        rs.getString("category"),
                        rs.getString("description")
                    );
                }
            }
        }
        return null;
    }
    public List<String> getAllProjects() throws SQLException {
        List<String> projects = new ArrayList<>();
        String sql = "SELECT DISTINCT project FROM tasks";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                projects.add(rs.getString("project"));
            }
        }
        return projects;
    }
    public void deleteProject(String projectName) throws SQLException {
        String sql = "DELETE FROM tasks WHERE project = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, projectName);
            pstmt.executeUpdate();
        }
    }
    public void addProject(String projectName) throws SQLException {
        // Since we're not using a separate projects table, we'll add a dummy task
        // to ensure the project exists in the tasks table
        String sql = "INSERT INTO tasks (employee_id, project, date, start_time, end_time, category, description) " +
                     "VALUES (?, ?, CURDATE(), '00:00', '00:00', 'Project Creation', 'Project initialization')";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, 0);  // Use 0 as a dummy employee_id
            pstmt.setString(2, projectName);
            pstmt.executeUpdate();
        }
    }
    public int getTotalProjects() throws SQLException {
        String sql = "SELECT COUNT(DISTINCT project) FROM tasks";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
    public int getTasksLoggedToday() throws SQLException {
        String sql = "SELECT COUNT(*) FROM tasks WHERE date = CURDATE()";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    } public List<Task> getTasksForToday() throws SQLException {
        return getTasksForDateRange("WHERE date = CURDATE()");
    }

    public List<Task> getTasksForLastWeek() throws SQLException {
        return getTasksForDateRange("WHERE date >= DATE_SUB(CURDATE(), INTERVAL 1 WEEK)");
    }

    public List<Task> getTasksForLastMonth() throws SQLException {
        return getTasksForDateRange("WHERE date >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)");
    }

    private List<Task> getTasksForDateRange(String whereClause) throws SQLException {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM tasks " + whereClause;
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                tasks.add(new Task(
                    rs.getInt("id"),
                    rs.getInt("employee_id"),
                    rs.getString("project"),
                    rs.getDate("date"),
                    rs.getString("start_time"),
                    rs.getString("end_time"),
                    rs.getString("category"),
                    rs.getString("description")
                ));
            }
        }
        return tasks;
    }
}
    // Additional methods for retrieving tasks by date range, project, etc.

