package com.raiseit.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Provides a simple way to open database connections for RaiseIT.
 * It uses the configured URL, user name, and password.
 */
public class DBConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/raiseit_db";
    private static final String USER = "root";
    private static final String PASSWORD = "1234";

    /**
     * Opens a new connection to the RaiseIT database.
     * @return a live database connection
     * @throws SQLException if the driver is missing or the connection fails
     */
    public static connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL Driver not found", e);
        }
    }
}
