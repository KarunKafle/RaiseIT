package com.raiseit.controller;

import com.raiseit.dao.UserDAO;
import com.raiseit.model.User;
import com.raiseit.util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Handles student and staff account registration.
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    /**
     * Forwards the user to the registration page.
     * @param request the HTTP request
     * @param response the HTTP response
     * @throws ServletException if forwarding fails
     * @throws IOException if an I/O error occurs
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    /**
     * Validates input and creates a new user record.
     * @param request the HTTP request with form data
     * @param response the HTTP response
     * @throws ServletException if forwarding fails
     * @throws IOException if an I/O error occurs
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String role = request.getParameter("role");

        if (fullName == null || fullName.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (!fullName.matches("[a-zA-Z ]+")) {
            request.setAttribute("error", "Full name must contain letters only.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (password.length() < 6) {
            request.setAttribute("error", "Password must be at least 6 characters.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (role == null || (!role.equals("student") && !role.equals("staff"))) {
            request.setAttribute("error", "Please select a valid role.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        try {
            UserDAO userDAO = new UserDAO();

            if (userDAO.emailExists(email)) {
                request.setAttribute("error", "An account with this email already exists.");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
                return;
            }

            User user = new User();
            user.setFullName(fullName.trim());
            user.setEmail(email.trim());
            user.setPassword(PasswordUtil.hash(password));
            user.setRole(role);

            boolean success = userDAO.registerUser(user);

            if (success) {
                request.setAttribute("success", "Registration successful! Please wait for admin approval before logging in.");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Registration failed. Please try again.");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}
