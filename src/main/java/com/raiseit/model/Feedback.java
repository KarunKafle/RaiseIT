package com.raiseit.model;

import java.sql.Timestamp;

/**
 * Represents feedback left by a student on a resolved complaint.
 */
public class Feedback {
    /** The unique ID of the feedback entry. */
    private int id;
    /** The complaint ID this feedback belongs to. */
    private int complaintId;
    /** The student ID who submitted the feedback. */
    private int studentId;
    /** The rating value from 1 to 5. */
    private int rating;
    /** The optional comment from the student. */
    private String comment;
    /** The time when the feedback was submitted. */
    private Timestamp createdAt;
    /** The student name for display in views. */
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
