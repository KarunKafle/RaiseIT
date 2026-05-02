package com.raiseit.controller;

import com.raiseit.dao.UserDAO;
import com.raiseit.model.User;
import com.raiseit.util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/student/profile")
public class StudentProfileServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/views/student/profile.jsp")
                .forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        String fullName = request.getParameter("fullName");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (fullName == null || fullName.trim().isEmpty()) {
            request.setAttribute("error", "Full name cannot be empty.");
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/views/student/profile.jsp")
                    .forward(request, response);
            return;
        }

        if (newPassword != null && !newPassword.isEmpty()) {
            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "Passwords do not match.");
                request.setAttribute("user", user);
                request.getRequestDispatcher("/WEB-INF/views/student/profile.jsp")
                        .forward(request, response);
                return;
            }
            user.setPassword(PasswordUtil.hash(newPassword));
        }

        user.setFullName(fullName.trim());

        try {
            UserDAO userDAO = new UserDAO();
            userDAO.updateUser(user);
            session.setAttribute("user", user);
            request.setAttribute("success", "Profile updated successfully.");
        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
        }

        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/views/student/profile.jsp")
                .forward(request, response);
    }
}