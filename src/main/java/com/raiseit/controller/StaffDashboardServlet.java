package com.raiseit.controller;

import com.raiseit.dao.ComplaintDAO;
import com.raiseit.model.Complaint;
import com.raiseit.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * Builds summary stats for the staff dashboard.
 */
@WebServlet("/staff/dashboard")
public class StaffDashboardServlet extends HttpServlet {

    /**
     * Loads staff stats and forwards to the dashboard view.
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
            List<Complaint> assignedList = complaintDAO.getComplaintsByStatus("assigned");
            List<Complaint> escalatedList = complaintDAO.getComplaintsByStatus("escalated");
            List<Complaint> inProgressList = complaintDAO.getComplaintsByStatus("in_progress");
            List<Complaint> resolvedList = complaintDAO.getComplaintsByStatus("resolved");

            request.setAttribute("totalAssigned", assignedList.size() + escalatedList.size());
            request.setAttribute("inProgress", inProgressList.size());
            request.setAttribute("resolved", resolvedList.size());

            request.getRequestDispatcher("/WEB-INF/views/staff/dashboard.jsp")
                    .forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
