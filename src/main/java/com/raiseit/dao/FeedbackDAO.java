package com.raiseit.dao;

import com.raiseit.model.Feedback;
import com.raiseit.util.DBConnection;

import java.sql.*;

/**
 * Handles database operations for feedback linked to complaints.
 * It reads and writes feedback records.
 */
public class FeedbackDAO {

    /**
     * Finds feedback for a complaint by its id.
     * @param complaintId the complaint id to search for
     * @return the feedback if found, or null
     * @throws SQLException if a database error occurs
     */
    public Feedback getFeedbackByComplaintId(int complaintId) throws SQLException {
        String sql = "SELECT f.*, u.full_name FROM feedback f JOIN users u ON f.student_id = u.id WHERE f.complaint_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, complaintId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setId(rs.getInt("id"));
                feedback.setComplaintId(rs.getInt("complaint_id"));
                feedback.setStudentId(rs.getInt("student_id"));
                feedback.setRating(rs.getInt("rating"));
                feedback.setComment(rs.getString("comment"));
                feedback.setCreatedAt(rs.getTimestamp("created_at"));
                feedback.setStudentName(rs.getString("full_name"));
                return feedback;
            }
        }
        return null;
    }

    /**
     * Saves a new feedback record for a complaint.
     * @param feedback the feedback data to save
     * @return true if the insert worked, false otherwise
     * @throws SQLException if a database error occurs
     */
    public boolean addFeedback(Feedback feedback) throws SQLException {
        String sql = "INSERT INTO feedback (complaint_id, student_id, rating, comment) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, feedback.getComplaintId());
            ps.setInt(2, feedback.getStudentId());
            ps.setInt(3, feedback.getRating());
            ps.setString(4, feedback.getComment());
            return ps.executeUpdate() > 0;
        }
    }
}
