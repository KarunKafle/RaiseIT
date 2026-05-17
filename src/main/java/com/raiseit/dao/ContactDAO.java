package com.raiseit.dao;

import com.raiseit.model.ContactInquiry;
import com.raiseit.util.DBConnection;

import java.sql.*;

/**
 * Handles database actions for contact inquiries sent by users.
 * It saves new inquiries and lists all submitted ones.
 */
public class ContactDAO {

    /**
     * Saves a contact inquiry to the database.
     * @param inquiry the inquiry data to save
     * @return true if the insert worked, false otherwise
     * @throws SQLException if a database error occurs
     */
    public boolean saveInquiry(ContactInquiry inquiry) throws SQLException {
        String sql = "INSERT INTO contact_inquiries (name, email, phone, message) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, inquiry.getName());
            ps.setString(2, inquiry.getEmail());
            ps.setString(3, inquiry.getPhone());
            ps.setString(4, inquiry.getMessage());
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Gets all contact inquiries ordered by newest first.
     * @return a list of contact inquiries
     * @throws SQLException if a database error occurs
     */
    public java.util.List<ContactInquiry> getAllInquiries() throws SQLException {
        java.util.List<ContactInquiry> inquiries = new java.util.ArrayList<>();
        String sql = "SELECT * FROM contact_inquiries ORDER BY submitted_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ContactInquiry inquiry = new ContactInquiry();
                inquiry.setId(rs.getInt("id"));
                inquiry.setName(rs.getString("name"));
                inquiry.setEmail(rs.getString("email"));
                inquiry.setPhone(rs.getString("phone"));
                inquiry.setMessage(rs.getString("message"));
                inquiry.setSubmittedAt(rs.getTimestamp("submitted_at"));
                inquiries.add(inquiry);
            }
        }
        return inquiries;
    }
}
