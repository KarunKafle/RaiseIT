package com.raiseit.model;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * Represents a student complaint record and its status.
 */
public class Complaint {
    /** The unique ID of the complaint. */
    private int id;
    /** The public reference number shown to users. */
    private String referenceNumber;
    /** The ID of the student who submitted the complaint. */
    private int userId;
    /** The complaint title entered by the student. */
    private String title;
    /** The detailed complaint description. */
    private String description;
    /** The category ID selected for this complaint. */
    private int categoryId;
    /** The priority level for this complaint. */
    private String priority;
    /** The current status of the complaint. */
    private String status;
    /** Whether the complaint was submitted anonymously. */
    private boolean isAnonymous;
    /** The timestamp when the complaint was created. */
    private Timestamp createdAt;
    /** The full name of the student for display. */
    private String userName;
    /** The category name for display. */
    private String categoryName;
    /** The department name for display. */
    private String departmentName;
    /** The student name for display in staff views. */
    private String studentName;
    /** The number of messages in the complaint thread. */
    private int messageCount;
    /** The deadline date for resolving the complaint. */
    private Date deadline;
    /** Whether the complaint is overdue. */
    private boolean overdue;
    /** Whether the complaint is due today. */
    private boolean dueToday;

    public Complaint() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getReferenceNumber() { return referenceNumber; }
    public void setReferenceNumber(String referenceNumber) { this.referenceNumber = referenceNumber; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    public String getPriority() { return priority; }
    public void setPriority(String priority) { this.priority = priority; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public boolean isAnonymous() { return isAnonymous; }
    public void setAnonymous(boolean anonymous) { isAnonymous = anonymous; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }

    public String getDepartmentName() { return departmentName; }
    public void setDepartmentName(String departmentName) { this.departmentName = departmentName; }

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }

    public int getMessageCount() { return messageCount; }
    public void setMessageCount(int messageCount) { this.messageCount = messageCount; }

    public Date getDeadline() { return deadline; }
    public void setDeadline(Date deadline) { this.deadline = deadline; }

    public boolean isOverdue() { return overdue; }
    public void setOverdue(boolean overdue) { this.overdue = overdue; }

    public boolean isDueToday() { return dueToday; }
    public void setDueToday(boolean dueToday) { this.dueToday = dueToday; }
}
