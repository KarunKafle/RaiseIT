package com.raiseit.dao;

import com.raiseit.model.Complaint;
import com.raiseit.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ComplaintDAO {

    public List<Complaint> getAllComplaints() throws SQLException {
        List<Complaint> complaints = new ArrayList<>();
        String sql = "SELECT c.*, cat.name as category_name, d.name as department_name, " +
                "u.full_name as student_name FROM complaints c " +
                "JOIN categories cat ON c.category_id = cat.id " +
                "JOIN departments d ON cat.department_id = d.id " +
                "LEFT JOIN users u ON c.user_id = u.id " +
                "ORDER BY c.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                complaints.add(mapRow(rs));
            }
        }
        return complaints;
    }

    public int getTotalComplaints() throws SQLException {
        String sql = "SELECT COUNT(*) FROM complaints";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    public int getComplaintsByStatus(String status) throws SQLException {
        String sql = "SELECT COUNT(*) FROM complaints WHERE status = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    public boolean updateComplaintStatus(int complaintId, String status) throws SQLException {
        String sql = "UPDATE complaints SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, complaintId);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean deleteComplaint(int complaintId) throws SQLException {
        String sql = "DELETE FROM complaints WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, complaintId);
            return ps.executeUpdate() > 0;
        }
    }

    public Complaint getComplaintById(int id) throws SQLException {
        String sql = "SELECT c.*, cat.name as category_name, d.name as department_name, " +
                "u.full_name as student_name FROM complaints c " +
                "JOIN categories cat ON c.category_id = cat.id " +
                "JOIN departments d ON cat.department_id = d.id " +
                "LEFT JOIN users u ON c.user_id = u.id " +
                "WHERE c.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        }
        return null;
    }

    private Complaint mapRow(ResultSet rs) throws SQLException {
        Complaint c = new Complaint();
        c.setId(rs.getInt("id"));
        c.setReferenceNumber(rs.getString("reference_number"));
        c.setUserId(rs.getInt("user_id"));
        c.setTitle(rs.getString("title"));
        c.setDescription(rs.getString("description"));
        c.setCategoryId(rs.getInt("category_id"));
        c.setPriority(rs.getString("priority"));
        c.setStatus(rs.getString("status"));
        c.setAnonymous(rs.getBoolean("is_anonymous"));
        c.setCreatedAt(rs.getTimestamp("created_at"));
        c.setCategoryName(rs.getString("category_name"));
        c.setDepartmentName(rs.getString("department_name"));
        c.setStudentName(rs.getString("student_name"));
        return c;
    }

    public List<Complaint> getComplaintsByUserId(int userId) throws SQLException {
        List<Complaint> complaints = new ArrayList<>();
        String sql = "SELECT c.*, cat.name as category_name, d.name as department_name, " +
                "u.full_name as student_name FROM complaints c " +
                "JOIN categories cat ON c.category_id = cat.id " +
                "JOIN departments d ON cat.department_id = d.id " +
                "LEFT JOIN users u ON c.user_id = u.id " +
                "WHERE c.user_id = ? ORDER BY c.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                complaints.add(mapRow(rs));
            }
        }
        return complaints;
    }

    public List<Complaint> getComplaintsByUserIdAndStatus(int userId, String status) throws SQLException {
        List<Complaint> complaints = new ArrayList<>();
        String sql = "SELECT c.*, cat.name as category_name, d.name as department_name, " +
                "u.full_name as student_name FROM complaints c " +
                "JOIN categories cat ON c.category_id = cat.id " +
                "JOIN departments d ON cat.department_id = d.id " +
                "LEFT JOIN users u ON c.user_id = u.id " +
                "WHERE c.user_id = ? AND c.status = ? ORDER BY c.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                complaints.add(mapRow(rs));
            }
        }
        return complaints;
    }

    public String submitComplaint(Complaint complaint) throws SQLException {
        String refNumber = "RIT2026-" + String.format("%05d", (int)(Math.random() * 99999));
        String sql = "INSERT INTO complaints (reference_number, user_id, title, description, category_id, priority, status, is_anonymous) " +
                "VALUES (?, ?, ?, ?, ?, ?, 'submitted', ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, refNumber);
            ps.setInt(2, complaint.getUserId());
            ps.setString(3, complaint.getTitle());
            ps.setString(4, complaint.getDescription());
            ps.setInt(5, complaint.getCategoryId());
            ps.setString(6, complaint.getPriority());
            ps.setBoolean(7, complaint.isAnonymous());
            ps.executeUpdate();
        }
        return refNumber;
    }
}