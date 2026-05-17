package com.raiseit.dao;

import com.raiseit.model.Response;
import com.raiseit.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Handles database actions for responses posted on complaints.
 * It loads responses and saves new ones.
 */
public class ResponseDAO {

    /**
     * Gets all responses for a complaint in time order.
     * @param complaintId the complaint id to filter by
     * @return a list of responses for that complaint
     * @throws SQLException if a database error occurs
     */
    public List<Response> getResponsesByComplaintId(int complaintId) throws SQLException {
        List<Response> responses = new ArrayList<>();
        String sql = "SELECT r.*, u.full_name, u.role FROM responses r " +
                "JOIN users u ON r.user_id = u.id " +
                "WHERE r.complaint_id = ? ORDER BY r.created_at ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, complaintId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                responses.add(mapRow(rs));
            }
        }
        return responses;
    }

    /**
     * Saves a new response for a complaint.
     * @param response the response data to save
     * @return true if the insert worked, false otherwise
     * @throws SQLException if a database error occurs
     */
    public boolean addResponse(Response response) throws SQLException {
        String sql = "INSERT INTO responses (complaint_id, user_id, message) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, response.getComplaintId());
            ps.setInt(2, response.getUserId());
            ps.setString(3, response.getMessage());
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Converts a result set row into a Response object.
     * @param rs the result set positioned on a row
     * @return a populated Response object
     * @throws SQLException if reading the row fails
     */
    private Response mapRow(ResultSet rs) throws SQLException {
        Response response = new Response();
        response.setId(rs.getInt("id"));
        response.setComplaintId(rs.getInt("complaint_id"));
        response.setUserId(rs.getInt("user_id"));
        response.setMessage(rs.getString("message"));
        response.setCreatedAt(rs.getTimestamp("created_at"));
        response.setUserFullName(rs.getString("full_name"));
        response.setUserRole(rs.getString("role"));
        return response;
    }
}
