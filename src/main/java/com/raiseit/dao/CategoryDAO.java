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
                categories.add(mapRowWithDepartment(rs));
            }
        }
        return categories;
    }

    public Category getCategoryById(int id) throws SQLException {
        String sql = "SELECT * FROM categories WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                category.setDepartmentId(rs.getInt("department_id"));
                return category;
            }
        }
        return null;
    }

    public boolean addCategory(Category category) throws SQLException {
        String sql = "INSERT INTO categories (name, department_id) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category.getName());
            ps.setInt(2, category.getDepartmentId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateCategory(Category category) throws SQLException {
        String sql = "UPDATE categories SET name = ?, department_id = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category.getName());
            ps.setInt(2, category.getDepartmentId());
            ps.setInt(3, category.getId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean deleteCategory(int id) throws SQLException {
        String sql = "DELETE FROM categories WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    private Category mapRowWithDepartment(ResultSet rs) throws SQLException {
        Category category = new Category();
        category.setId(rs.getInt("id"));
        category.setName(rs.getString("name"));
        category.setDepartmentId(rs.getInt("department_id"));
        category.setDepartmentName(rs.getString("department_name"));
        return category;
    }
}
