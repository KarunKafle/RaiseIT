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

    public int countComplaintsByStatus(String status) throws SQLException {
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
        String sql1 = "DELETE FROM assignments WHERE complaint_id = ?";
        String sql2 = "DELETE FROM complaints WHERE id = ?";
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try (PreparedStatement ps1 = conn.prepareStatement(sql1);
                 PreparedStatement ps2 = conn.prepareStatement(sql2)) {
                ps1.setInt(1, complaintId);
                ps1.executeUpdate();
                ps2.setInt(1, complaintId);
                ps2.executeUpdate();
                conn.commit();
                return true;
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            }
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

    public boolean isComplaintAssignedToStaff(int complaintId, int staffId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM assignments WHERE complaint_id = ? AND staff_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, complaintId);
            ps.setInt(2, staffId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1) > 0;
        }
        return false;
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

    public List<Complaint> searchComplaints(int userId, String keyword) throws SQLException {
        List<Complaint> complaints = new ArrayList<>();
        String sql = "SELECT c.*, cat.name as category_name, d.name as department_name, " +
                "u.full_name as student_name FROM complaints c " +
                "JOIN categories cat ON c.category_id = cat.id " +
                "JOIN departments d ON cat.department_id = d.id " +
                "LEFT JOIN users u ON c.user_id = u.id " +
                "WHERE c.user_id = ? AND (c.title LIKE ? OR c.reference_number LIKE ? OR c.description LIKE ?) " +
                "ORDER BY c.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, "%" + keyword + "%");
            ps.setString(3, "%" + keyword + "%");
            ps.setString(4, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                complaints.add(mapRow(rs));
            }
        }
        return complaints;
    }

    public List<Complaint> getComplaintsByStatus(String status) throws SQLException {
        List<Complaint> complaints = new ArrayList<>();
        String sql = "SELECT c.*, cat.name as category_name, d.name as department_name, " +
                "u.full_name as student_name FROM complaints c " +
                "JOIN categories cat ON c.category_id = cat.id " +
                "JOIN departments d ON cat.department_id = d.id " +
                "LEFT JOIN users u ON c.user_id = u.id " +
                "WHERE c.status = ? ORDER BY c.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                complaints.add(mapRow(rs));
            }
        }
        return complaints;
    }

    public boolean assignComplaintToStaff(int complaintId, int staffId) throws SQLException {
        String sql1 = "UPDATE complaints SET status = 'assigned' WHERE id = ?";
        String sql2 = "INSERT INTO assignments (complaint_id, staff_id, deadline) VALUES (?, ?, DATE_ADD(NOW(), INTERVAL 7 DAY))";
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try (PreparedStatement ps1 = conn.prepareStatement(sql1);
                 PreparedStatement ps2 = conn.prepareStatement(sql2)) {
                ps1.setInt(1, complaintId);
                ps1.executeUpdate();
                ps2.setInt(1, complaintId);
                ps2.setInt(2, staffId);
                ps2.executeUpdate();
                conn.commit();
                return true;
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            }
        }
    }

    public List<Complaint> getComplaintsAssignedToStaff(int staffId) throws SQLException {
        List<Complaint> complaints = new ArrayList<>();
        String sql = "SELECT c.*, cat.name as category_name, d.name as department_name, " +
                "u.full_name as student_name FROM complaints c " +
                "JOIN categories cat ON c.category_id = cat.id " +
                "JOIN departments d ON cat.department_id = d.id " +
                "LEFT JOIN users u ON c.user_id = u.id " +
                "JOIN assignments a ON c.id = a.complaint_id " +
                "WHERE a.staff_id = ? AND c.status IN ('assigned', 'in_progress', 'escalated') " +
                "ORDER BY c.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, staffId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                complaints.add(mapRow(rs));
            }
        }
        return complaints;
    }

    public List<Complaint> getResolvedComplaintsByStaffWithMessageCount(int staffId) throws SQLException {
        List<Complaint> complaints = new ArrayList<>();
        String sql = "SELECT c.*, cat.name as category_name, d.name as department_name, " +
                "u.full_name as student_name, COUNT(r.id) as message_count " +
                "FROM complaints c " +
                "JOIN assignments a ON c.id = a.complaint_id " +
                "JOIN categories cat ON c.category_id = cat.id " +
                "JOIN departments d ON cat.department_id = d.id " +
                "LEFT JOIN users u ON c.user_id = u.id " +
                "LEFT JOIN responses r ON r.complaint_id = c.id " +
                "WHERE a.staff_id = ? AND c.status IN ('resolved', 'closed') " +
                "GROUP BY c.id " +
                "ORDER BY c.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, staffId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Complaint complaint = mapRow(rs);
                complaint.setMessageCount(rs.getInt("message_count"));
                complaints.add(complaint);
            }
        }
        return complaints;
    }

    public List<com.raiseit.model.StatItem> getComplaintCountsByStatus() throws SQLException {
        List<com.raiseit.model.StatItem> items = new ArrayList<>();
        String sql = "SELECT status, COUNT(*) as total FROM complaints GROUP BY status ORDER BY total DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                items.add(new com.raiseit.model.StatItem(rs.getString("status"), rs.getInt("total")));
            }
        }
        return items;
    }

    public List<com.raiseit.model.StatItem> getComplaintCountsByPriority() throws SQLException {
        List<com.raiseit.model.StatItem> items = new ArrayList<>();
        String sql = "SELECT priority, COUNT(*) as total FROM complaints GROUP BY priority ORDER BY total DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                items.add(new com.raiseit.model.StatItem(rs.getString("priority"), rs.getInt("total")));
            }
        }
        return items;
    }
}
