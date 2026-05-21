package com.raiseit.model;

import java.sql.Timestamp;

/**
 * Represents a registered user account in the system.
 */
public class User {
    /** The unique ID of the user. */
    private int id;
    /** The full name of the user. */
    private String fullName;
    /** The email address used for login. */
    private String email;
    /** The hashed password for the account. */
    private String password;
    /** The role assigned to the user. */
    private String role;
    /** The department ID for staff users, if any. */
    private Integer departmentId;
    /** The account status such as pending or active. */
    private String status;
    /** The time when the account was created. */
    private Timestamp createdAt;

    public User() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public Integer getDepartmentId() { return departmentId; }
    public void setDepartmentId(Integer departmentId) { this.departmentId = departmentId; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
