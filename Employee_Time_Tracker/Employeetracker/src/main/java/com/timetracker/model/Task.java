package com.timetracker.model;

import java.util.Date;

public class Task {
    private int id;
    private int employeeId;
    private String project;
    private Date date;
    private String startTime;
    private String endTime;
    private String category;
    private String description;

    // Constructors, getters, and setters
    public Task() {}

    public Task(int id, int employeeId, String project, Date date, String startTime, String endTime, String category, String description) {
        this.id = id;
        this.employeeId = employeeId;
        this.project = project;
        this.date = date;
        this.startTime = startTime;
        this.endTime = endTime;
        this.category = category;
        this.description = description;
    }

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getEmployeeId() { return employeeId; }
    public void setEmployeeId(int employeeId) { this.employeeId = employeeId; }
    public String getProject() { return project; }
    public void setProject(String project) { this.project = project; }
    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }
    public String getStartTime() { return startTime; }
    public void setStartTime(String startTime) { this.startTime = startTime; }
    public String getEndTime() { return endTime; }
    public void setEndTime(String endTime) { this.endTime = endTime; }
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}