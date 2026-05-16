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

public class EscalateServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String complaintIdParam = request.getParameter("complaintId");
        if (complaintIdParam == null || complaintIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/student/complaints");
            return;
        }

        try {
            int complaintId = Integer.parseInt(complaintIdParam);
            int userId = (int) session.getAttribute("userId");

            ComplaintDAO complaintDAO = new ComplaintDAO();
            Complaint complaint = complaintDAO.getComplaintById(complaintId);

            if (complaint == null || complaint.getUserId() != userId) {
                response.sendRedirect(request.getContextPath() + "/student/complaints");
                return;
            }

            String status = complaint.getStatus();
            if (!"assigned".equals(status) && !"in_progress".equals(status)) {
                response.sendRedirect(request.getContextPath() + "/student/complaints");
                return;
            }

            complaintDAO.updateComplaintStatus(complaintId, "escalated");
            response.sendRedirect(request.getContextPath() + "/student/complaints?success=escalated");
        } catch (SQLException | NumberFormatException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
