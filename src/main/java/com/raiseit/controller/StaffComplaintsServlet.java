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
import java.time.LocalDate;
import java.sql.SQLException;
import java.util.List;

/**
 * Shows complaints assigned to a staff member.
 */
@WebServlet("/staff/complaints")
public class StaffComplaintsServlet extends HttpServlet {

    /**
     * Loads assigned complaints and forwards to the list view.
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
            List<com.raiseit.model.Complaint> complaints = complaintDAO.getComplaintsAssignedToStaff(user.getId());
            LocalDate today = LocalDate.now();
            for (com.raiseit.model.Complaint complaint : complaints) {
                if (complaint.getDeadline() != null) {
                    LocalDate deadline = complaint.getDeadline().toLocalDate();
                    boolean isResolvedOrClosed = "resolved".equals(complaint.getStatus()) || "closed".equals(complaint.getStatus());
                    complaint.setOverdue(!isResolvedOrClosed && today.isAfter(deadline));
                    complaint.setDueToday(today.isEqual(deadline));
                }
            }
            request.setAttribute("complaints", complaints);
            request.getRequestDispatcher("/WEB-INF/views/staff/complaints.jsp")
                    .forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    /**
     * Updates a complaint status based on staff actions.
     * @param request the HTTP request with action data
     * @param response the HTTP response
     * @throws ServletException if forwarding fails
     * @throws IOException if an I/O error occurs
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String complaintIdStr = request.getParameter("complaintId");
        String action = request.getParameter("action");

        try {
            int complaintId = Integer.parseInt(complaintIdStr);
            ComplaintDAO complaintDAO = new ComplaintDAO();

            switch (action) {
                case "inprogress":
                    complaintDAO.updateComplaintStatus(complaintId, "in_progress");
                    break;
                case "resolve":
                    complaintDAO.updateComplaintStatus(complaintId, "resolved");
                    break;
            }
            response.sendRedirect(request.getContextPath() + "/staff/complaints");
        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
