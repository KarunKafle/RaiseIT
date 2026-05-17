package com.raiseit.dao;

import com.raiseit.model.StatItem;
import com.raiseit.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Builds summary counts for reports and dashboard charts.
 * It groups complaint data into simple totals.
 */
public class ReportDAO {

    /**
     * Counts complaints grouped by department.
     * @return a list of department totals
     * @throws SQLException if a database error occurs
     */
    public List<StatItem> getComplaintCountsByDepartment() throws SQLException {
        List<StatItem> items = new ArrayList<>();
        String sql = "SELECT d.name as label, COUNT(c.id) as total " +
                "FROM departments d " +
                "LEFT JOIN categories cat ON cat.department_id = d.id " +
                "LEFT JOIN complaints c ON c.category_id = cat.id " +
                "GROUP BY d.id, d.name " +
                "ORDER BY total DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                items.add(new StatItem(rs.getString("label"), rs.getInt("total")));
            }
        }
        return items;
    }

    /**
     * Counts resolved or closed complaints per staff member.
     * @return a list of staff totals, limited to the top five
     * @throws SQLException if a database error occurs
     */
    public List<StatItem> getResolvedCountsByStaff() throws SQLException {
        List<StatItem> items = new ArrayList<>();
        String sql = "SELECT u.full_name as label, COUNT(c.id) as count " +
                "FROM users u " +
                "LEFT JOIN assignments a ON a.staff_id = u.id " +
                "LEFT JOIN complaints c ON c.id = a.complaint_id AND c.status IN ('resolved', 'closed') " +
                "WHERE u.role = 'staff' " +
                "GROUP BY u.id, u.full_name " +
                "ORDER BY count DESC " +
                "LIMIT 5";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                items.add(new StatItem(rs.getString("label"), rs.getInt("count")));
            }
        }
        return items;
    }
}
