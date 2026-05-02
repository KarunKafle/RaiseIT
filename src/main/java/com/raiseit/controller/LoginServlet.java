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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Email and password are required.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        try {
            UserDAO userDAO = new UserDAO();
            User user = userDAO.getUserByEmail(email.trim());

            if (user == null) {
                request.setAttribute("error", "No account found with this email.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                return;
            }

            if (!PasswordUtil.verify(password, user.getPassword())) {
                request.setAttribute("error", "Incorrect password.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                return;
            }

            if (user.getStatus().equals("pending")) {
                request.setAttribute("error", "Your account is pending admin approval.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                return;
            }

            if (user.getStatus().equals("suspended")) {
                request.setAttribute("error", "Your account has been suspended.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                return;
            }

            HttpSession session = request.getSession();
            session.setAttribute("userId", user.getId());
            session.setAttribute("userFullName", user.getFullName());
            session.setAttribute("userRole", user.getRole());
            session.setAttribute("userEmail", user.getEmail());

            if (user.getRole().equals("admin")) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else if (user.getRole().equals("staff")) {
                response.sendRedirect(request.getContextPath() + "/staff/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/student/dashboard");
            }

        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}