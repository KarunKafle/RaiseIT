package com.raiseit.model;

import java.sql.Timestamp;

/**
 * Represents a single reply in a complaint thread.
 */
public class Response {
    /** The unique ID of the response. */
    private int id;
    /** The complaint ID that this reply belongs to. */
    private int complaintId;
    /** The ID of the user who wrote the reply. */
    private int userId;
    /** The reply message content. */
    private String message;
    /** The time when the reply was created. */
    private Timestamp createdAt;
    /** The full name of the user for display. */
    private String userFullName;
    /** The role of the user who posted the reply. */
    private String userRole;

    public Response() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getComplaintId() { return complaintId; }
    public void setComplaintId(int complaintId) { this.complaintId = complaintId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getUserFullName() { return userFullName; }
    public void setUserFullName(String userFullName) { this.userFullName = userFullName; }

    public String getUserRole() { return userRole; }
    public void setUserRole(String userRole) { this.userRole = userRole; }
}
