package com.raiseit.controller;

import com.raiseit.dao.ComplaintDAO;
import com.raiseit.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Builds summary data for the student dashboard.
 */
@WebServlet("/student/dashboard")
public class StudentDashboardServlet extends HttpServlet {

    /**
     * Loads student complaint stats and forwards to the dashboard.
     * @param request the HTTP request
     * @param response the HTTP response
     * @throws ServletException if forwarding fails
     * @throws IOException if an I/O error occurs
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        try {
            ComplaintDAO complaintDAO = new ComplaintDAO();
            int totalComplaints = complaintDAO.getComplaintsByUserId(user.getId()).size();
            int pendingComplaints = complaintDAO.getComplaintsByUserIdAndStatus(user.getId(), "submitted").size();
            int resolvedComplaints = complaintDAO.getComplaintsByUserIdAndStatus(user.getId(), "resolved").size();

            request.setAttribute("totalComplaints", totalComplaints);
            request.setAttribute("pendingComplaints", pendingComplaints);
            request.setAttribute("resolvedComplaints", resolvedComplaints);
            request.getRequestDispatcher("/WEB-INF/views/student/dashboard.jsp")
                    .forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
