package com.raiseit.dao;

import com.raiseit.model.Category;
import com.raiseit.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    public List<Category> getAllCategories() throws SQLException {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT c.*, d.name as department_name FROM categories c " +
                "JOIN departments d ON c.department_id = d.id";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Category cat = new Category();
                cat.setId(rs.getInt("id"));
                cat.setName(rs.getString("name"));
                cat.setDepartmentId(rs.getInt("department_id"));
                cat.setDepartmentName(rs.getString("department_name"));
                categories.add(cat);
            }
        }
        return categories;
    }
}