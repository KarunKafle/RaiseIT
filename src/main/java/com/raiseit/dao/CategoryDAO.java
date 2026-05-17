package com.raiseit.dao;

import com.raiseit.model.Category;
import com.raiseit.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Handles database actions for complaint categories.
 * It lets the app create, read, update, and delete categories.
 */
public class CategoryDAO {

    /**
     * Gets all categories with their department names.
     * @return a list of categories
     * @throws SQLException if a database error occurs
     */
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

    /**
     * Finds a category by its id.
     * @param id the category id to look up
     * @return the category if found, or null
     * @throws SQLException if a database error occurs
     */
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

    /**
     * Adds a new category record.
     * @param category the category data to save
     * @return true if the insert worked, false otherwise
     * @throws SQLException if a database error occurs
     */
    public boolean addCategory(Category category) throws SQLException {
        String sql = "INSERT INTO categories (name, department_id) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category.getName());
            ps.setInt(2, category.getDepartmentId());
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Updates an existing category.
     * @param category the category data to update
     * @return true if the update worked, false otherwise
     * @throws SQLException if a database error occurs
     */
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

    /**
     * Deletes a category by id.
     * @param id the category id to delete
     * @return true if the delete worked, false otherwise
     * @throws SQLException if a database error occurs
     */
    public boolean deleteCategory(int id) throws SQLException {
        String sql = "DELETE FROM categories WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Converts a result set row into a Category object with department name.
     * @param rs the result set positioned on a row
     * @return a populated Category object
     * @throws SQLException if reading the row fails
     */
    private Category mapRowWithDepartment(ResultSet rs) throws SQLException {
        Category category = new Category();
        category.setId(rs.getInt("id"));
        category.setName(rs.getString("name"));
        category.setDepartmentId(rs.getInt("department_id"));
        category.setDepartmentName(rs.getString("department_name"));
        return category;
    }
}
