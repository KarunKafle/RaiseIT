package com.raiseit.dao;

import com.raiseit.model.Department;
import com.raiseit.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Handles database operations for departments in RaiseIT.
 * It manages department records and their details.
 */
public class DepartmentDAO {

    /**
     * Gets all departments ordered by name.
     * @return a list of departments
     * @throws SQLException if a database error occurs
     */
    public List<Department> getAllDepartments() throws SQLException {
        List<Department> departments = new ArrayList<>();
        String sql = "SELECT * FROM departments ORDER BY name ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                departments.add(mapRow(rs));
            }
        }
        return departments;
    }

    /**
     * Finds a department by id.
     * @param id the department id to look up
     * @return the department if found, or null
     * @throws SQLException if a database error occurs
     */
    public Department getDepartmentById(int id) throws SQLException {
        String sql = "SELECT * FROM departments WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapRow(rs);
            }
        }
        return null;
    }

    /**
     * Adds a new department record.
     * @param department the department data to save
     * @return true if the insert worked, false otherwise
     * @throws SQLException if a database error occurs
     */
    public boolean addDepartment(Department department) throws SQLException {
        String sql = "INSERT INTO departments (name, description) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, department.getName());
            ps.setString(2, department.getDescription());
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Updates an existing department.
     * @param department the department data to update
     * @return true if the update worked, false otherwise
     * @throws SQLException if a database error occurs
     */
    public boolean updateDepartment(Department department) throws SQLException {
        String sql = "UPDATE departments SET name = ?, description = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, department.getName());
            ps.setString(2, department.getDescription());
            ps.setInt(3, department.getId());
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Deletes a department by id.
     * @param id the department id to delete
     * @return true if the delete worked, false otherwise
     * @throws SQLException if a database error occurs
     */
    public boolean deleteDepartment(int id) throws SQLException {
        String sql = "DELETE FROM departments WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Converts a result set row into a Department object.
     * @param rs the result set positioned on a row
     * @return a populated Department object
     * @throws SQLException if reading the row fails
     */
    private Department mapRow(ResultSet rs) throws SQLException {
        Department department = new Department();
        department.setId(rs.getInt("id"));
        department.setName(rs.getString("name"));
        department.setDescription(rs.getString("description"));
        department.setCreatedAt(rs.getTimestamp("created_at"));
        return department;
    }
}
