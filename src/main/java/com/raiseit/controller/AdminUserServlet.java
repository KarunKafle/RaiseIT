package com.raiseit.controller;

import com.raiseit.dao.UserDAO;
import com.raiseit.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * Manages user accounts for admin users.
 */
@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {

    /**
     * Loads all users for the admin view.
     * @param request the HTTP request
     * @param response the HTTP response
     * @throws ServletException if forwarding fails
     * @throws IOException if an I/O error occurs
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            UserDAO userDAO = new UserDAO();
            List<User> users = userDAO.getAllUsers();
            request.setAttribute("users", users);
            request.getRequestDispatcher("/WEB-INF/views/admin/users.jsp")
                    .forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    /**
     * Updates a user status or deletes a user.
     * @param request the HTTP request with action data
     * @param response the HTTP response
     * @throws ServletException if forwarding fails
     * @throws IOException if an I/O error occurs
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String userIdStr = request.getParameter("userId");

        try {
            int userId = Integer.parseInt(userIdStr);
            UserDAO userDAO = new UserDAO();

            switch (action) {
                case "approve":
                    userDAO.updateUserStatus(userId, "active");
                    break;
                case "suspend":
                    userDAO.updateUserStatus(userId, "suspended");
                    break;
                case "delete":
                    userDAO.deleteUser(userId);
                    break;
            }
            response.sendRedirect(request.getContextPath() + "/admin/users");
        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
