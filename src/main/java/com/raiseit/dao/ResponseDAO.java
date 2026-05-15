package com.raiseit.dao;

import com.raiseit.model.Response;
import com.raiseit.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ResponseDAO {

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
