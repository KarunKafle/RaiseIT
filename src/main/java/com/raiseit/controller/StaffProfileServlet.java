package com.raiseit.controller;

import com.raiseit.dao.UserDAO;
import com.raiseit.model.User;
import com.raiseit.util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Allows staff users to view and update their profile.
 */
public class StaffProfileServlet extends HttpServlet {

    /**
     * Loads the staff profile data for the view.
     * @param request the HTTP request
     * @param response the HTTP response
     * @throws ServletException if forwarding fails
     * @throws IOException if an I/O error occurs
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            UserDAO userDAO = new UserDAO();
            User user = userDAO.getUserById(userId);
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/views/staff/profile.jsp")
                    .forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    /**
     * Updates staff profile details and password if provided.
     * @param request the HTTP request with form data
     * @param response the HTTP response
     * @throws ServletException if forwarding fails
     * @throws IOException if an I/O error occurs
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (fullName == null || fullName.trim().isEmpty() || email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Full name and email are required.");
            doGet(request, response);
            return;
        }

        try {
            UserDAO userDAO = new UserDAO();
            User user = userDAO.getUserById(userId);

            if (user == null) {
                request.setAttribute("error", "User not found.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            if (currentPassword == null || currentPassword.trim().isEmpty() ||
                    !PasswordUtil.verify(currentPassword, user.getPassword())) {
                request.setAttribute("error", "Current password is incorrect.");
                request.setAttribute("user", user);
                request.getRequestDispatcher("/WEB-INF/views/staff/profile.jsp")
                        .forward(request, response);
                return;
            }

            if (newPassword != null && !newPassword.trim().isEmpty()) {
                if (!newPassword.equals(confirmPassword)) {
                    request.setAttribute("error", "New passwords do not match.");
                    request.setAttribute("user", user);
                    request.getRequestDispatcher("/WEB-INF/views/staff/profile.jsp")
                            .forward(request, response);
                    return;
                }
                user.setPassword(PasswordUtil.hash(newPassword));
            }

            user.setFullName(fullName.trim());
            user.setEmail(email.trim());

            userDAO.updateUserWithEmail(user);
            session.setAttribute("user", user);

            request.setAttribute("success", "Profile updated successfully.");
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/views/staff/profile.jsp")
                    .forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/staff/profile.jsp")
                    .forward(request, response);
        }
    }
}
