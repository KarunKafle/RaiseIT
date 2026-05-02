package com.raiseit.controller;

import com.raiseit.dao.ComplaintDAO;
import com.raiseit.dao.UserDAO;
import com.raiseit.model.Complaint;
import com.raiseit.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            ComplaintDAO complaintDAO = new ComplaintDAO();
            UserDAO userDAO = new UserDAO();

            int totalComplaints = complaintDAO.getTotalComplaints();
            int pendingComplaints = complaintDAO.getComplaintsByStatus("submitted");
            int inProgressComplaints = complaintDAO.getComplaintsByStatus("in_progress");
            int resolvedComplaints = complaintDAO.getComplaintsByStatus("resolved");
            int totalUsers = userDAO.getTotalUsers();
            int pendingUsers = userDAO.getPendingUsers();

            List<Complaint> recentComplaints = complaintDAO.getAllComplaints();

            request.setAttribute("totalComplaints", totalComplaints);
            request.setAttribute("pendingComplaints", pendingComplaints);
            request.setAttribute("inProgressComplaints", inProgressComplaints);
            request.setAttribute("resolvedComplaints", resolvedComplaints);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("pendingUsers", pendingUsers);
            request.setAttribute("recentComplaints", recentComplaints);

            request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp")
                    .forward(request, response);

        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}