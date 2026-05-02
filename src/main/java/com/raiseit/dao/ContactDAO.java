package com.raiseit.dao;

import com.raiseit.model.ContactInquiry;
import com.raiseit.util.DBConnection;

import java.sql.*;

public class ContactDAO {

    public boolean saveInquiry(ContactInquiry inquiry) throws SQLException {
        String sql = "INSERT INTO contact_inquiries (name, email, message) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, inquiry.getName());
            ps.setString(2, inquiry.getEmail());
            ps.setString(3, inquiry.getMessage());
            return ps.executeUpdate() > 0;
        }
    }
}