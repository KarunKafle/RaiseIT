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

@WebServlet("/staff/dashboard")
public class StaffDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        try {
            ComplaintDAO complaintDAO = new ComplaintDAO();
            int totalAssigned = complaintDAO.getComplaintsByStatus("assigned").size();
            int inProgress = complaintDAO.getComplaintsByStatus("in_progress").size();
            int resolved = complaintDAO.getComplaintsByStatus("resolved").size();

            request.setAttribute("totalAssigned", totalAssigned);
            request.setAttribute("inProgress", inProgress);
            request.setAttribute("resolved", resolved);

            request.getRequestDispatcher("/WEB-INF/views/staff/dashboard.jsp")
                    .forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}