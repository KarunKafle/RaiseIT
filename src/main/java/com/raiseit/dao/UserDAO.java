package com.raiseit.dao;

import com.raiseit.model.User;
import com.raiseit.util.DBConnection;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;

/**
 * Handles database operations related to users in RaiseIT.
 * It reads, writes, and updates user records.
 */
public class UserDAO {

    /**
     * Adds a new user record with a pending status.
     * @param user the user data to save
     * @return true if the insert worked, false otherwise
     * @throws SQLException if a database error occurs
     */
    public boolean registerUser(User user) throws SQLException {
        String sql = "INSERT INTO users (full_name, email, password, role, status) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getRole());
            ps.setString(5, "pending");
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Finds a user by email address.
     * @param email the email to search for
     * @return the matching user, or null if not found
     * @throws SQLException if a database error occurs
     */
    public User getUserByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));
                return user;
            }
        }
        return null;
    }

    /**
     * Checks if an email address is already in the users table.
     * @param email the email to check
     * @return true if the email exists, false otherwise
     * @throws SQLException if a database error occurs
     */
    public boolean emailExists(String email) throws SQLException {
        String sql = "SELECT id FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        }
    }
    /**
     * Counts all non-admin users.
     * @return the number of users who are not admins
     * @throws SQLException if a database error occurs
     */
    public int getTotalUsers() throws SQLException {
        String sql = "SELECT COUNT(*) FROM users WHERE role != 'admin'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    /**
     * Counts users whose status is pending.
     * @return the number of pending users
     * @throws SQLException if a database error occurs
     */
    public int getPendingUsers() throws SQLException {
        String sql = "SELECT COUNT(*) FROM users WHERE status = 'pending'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    /**
     * Loads all users ordered by newest first.
     * @return a list of all users
     * @throws SQLException if a database error occurs
     */
    public List<User> getAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                users.add(user);
            }
        }
        return users;
    }

    /**
     * Updates the status field for a user.
     * @param userId the user id to update
     * @param status the new status value
     * @return true if the update worked, false otherwise
     * @throws SQLException if a database error occurs
     */
    public boolean updateUserStatus(int userId, String status) throws SQLException {
        String sql = "UPDATE users SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Deletes a user and clears related records in other tables.
     * @param userId the user id to delete
     * @return true if the user was deleted, false otherwise
     * @throws SQLException if a database error occurs
     */
    public boolean deleteUser(int userId) throws SQLException {
        String deleteAssignments = "DELETE FROM assignments WHERE staff_id = ?";
        String deleteResponses = "DELETE FROM responses WHERE user_id = ?";
        String deleteFeedback = "DELETE FROM feedback WHERE student_id = ?";
        String nullComplaints = "UPDATE complaints SET user_id = NULL WHERE user_id = ?";
        String deleteUser = "DELETE FROM users WHERE id = ?";

        try (Connection conn = DBConnection.getConnection()) {
            boolean oldAutoCommit = conn.getAutoCommit();
            conn.setAutoCommit(false);

            try (PreparedStatement psAssignments = conn.prepareStatement(deleteAssignments);
                 PreparedStatement psResponses = conn.prepareStatement(deleteResponses);
                 PreparedStatement psFeedback = conn.prepareStatement(deleteFeedback);
                 PreparedStatement psComplaints = conn.prepareStatement(nullComplaints);
                 PreparedStatement psUser = conn.prepareStatement(deleteUser)) {

                psAssignments.setInt(1, userId);
                psAssignments.executeUpdate();

                psResponses.setInt(1, userId);
                psResponses.executeUpdate();

                psFeedback.setInt(1, userId);
                psFeedback.executeUpdate();

                psComplaints.setInt(1, userId);
                psComplaints.executeUpdate();

                psUser.setInt(1, userId);
                boolean deleted = psUser.executeUpdate() > 0;

                conn.commit();
                return deleted;
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(oldAutoCommit);
            }
        }
    }

    /**
     * Updates a user's full name and password.
     * @param user the user with updated fields
     * @return true if the update worked, false otherwise
     * @throws SQLException if a database error occurs
     */
    public boolean updateUser(User user) throws SQLException {
        String sql = "UPDATE users SET full_name = ?, password = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getPassword());
            ps.setInt(3, user.getId());
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Updates a user's full name, email, and password.
     * @param user the user with updated fields
     * @return true if the update worked, false otherwise
     * @throws SQLException if a database error occurs
     */
    public boolean updateUserWithEmail(User user) throws SQLException {
        String sql = "UPDATE users SET full_name = ?, email = ?, password = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setInt(4, user.getId());
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Finds a user by id.
     * @param id the user id to look up
     * @return the matching user, or null if not found
     * @throws SQLException if a database error occurs
     */
    public User getUserById(int id) throws SQLException {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));
                return user;
            }
        }
        return null;
    }
    /**
     * Loads active users who have the staff role.
     * @return a list of active staff users
     * @throws SQLException if a database error occurs
     */
    public List<User> getStaffUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role = 'staff' AND status = 'active'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));
                users.add(user);
            }
        }
        return users;
    }
}
