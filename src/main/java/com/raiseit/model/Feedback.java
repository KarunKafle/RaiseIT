package com.raiseit.model;

import java.sql.Timestamp;

public class Feedback {
    private int id;
    private int complaintId;
    private int studentId;
    private int rating;
    private String comment;
    private Timestamp createdAt;
    private String studentName;

    public Feedback() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getComplaintId() { return complaintId; }
    public void setComplaintId(int complaintId) { this.complaintId = complaintId; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
}
