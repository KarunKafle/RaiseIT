package com.raiseit.controller;

import com.raiseit.dao.ComplaintDAO;
import com.raiseit.model.Complaint;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

public class StaffUpdateServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String complaintIdParam = request.getParameter("complaintId");
        String newStatus = request.getParameter("newStatus");
        if (complaintIdParam == null || newStatus == null) {
            response.sendRedirect(request.getContextPath() + "/staff/complaints");
            return;
        }

        try {
            int complaintId = Integer.parseInt(complaintIdParam);
            int staffId = (int) session.getAttribute("userId");
            ComplaintDAO complaintDAO = new ComplaintDAO();

            Complaint complaint = complaintDAO.getComplaintById(complaintId);
            if (complaint == null || !complaintDAO.isComplaintAssignedToStaff(complaintId, staffId)) {
                response.sendRedirect(request.getContextPath() + "/staff/complaints");
                return;
            }

            if (!"in_progress".equals(newStatus) && !"resolved".equals(newStatus) && !"escalated".equals(newStatus)) {
                response.sendRedirect(request.getContextPath() + "/staff/complaints");
                return;
            }

            complaintDAO.updateComplaintStatus(complaintId, newStatus);
            response.sendRedirect(request.getContextPath() + "/staff/complaints");
        } catch (SQLException | NumberFormatException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
