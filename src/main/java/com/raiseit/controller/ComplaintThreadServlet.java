package com.raiseit.controller;

import com.raiseit.dao.ComplaintDAO;
import com.raiseit.dao.FeedbackDAO;
import com.raiseit.dao.ResponseDAO;
import com.raiseit.model.Complaint;
import com.raiseit.model.Feedback;
import com.raiseit.model.Response;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class ComplaintThreadServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String complaintIdParam = request.getParameter("complaintId");
        if (complaintIdParam == null || complaintIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int complaintId = Integer.parseInt(complaintIdParam);
            int userId = (int) session.getAttribute("userId");
            String role = (String) session.getAttribute("userRole");

            ComplaintDAO complaintDAO = new ComplaintDAO();
            ResponseDAO responseDAO = new ResponseDAO();

            Complaint complaint = complaintDAO.getComplaintById(complaintId);
            if (complaint == null) {
                request.setAttribute("error", "Complaint not found.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            boolean canView = false;
            if ("admin".equals(role)) {
                canView = true;
            } else if ("staff".equals(role)) {
                canView = complaintDAO.isComplaintAssignedToStaff(complaintId, userId);
            } else if ("student".equals(role)) {
                canView = complaint.getUserId() == userId;
            }

            if (!canView) {
                request.setAttribute("error", "You are not allowed to view this complaint thread.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            List<Response> responses = responseDAO.getResponsesByComplaintId(complaintId);
            FeedbackDAO feedbackDAO = new FeedbackDAO();
            Feedback feedback = feedbackDAO.getFeedbackByComplaintId(complaintId);

            request.setAttribute("complaint", complaint);
            request.setAttribute("responses", responses);
            request.setAttribute("feedback", feedback);
            request.setAttribute("complaintStatus", complaint.getStatus());

            request.getRequestDispatcher("/WEB-INF/views/shared/complaint_thread.jsp")
                    .forward(request, response);
        } catch (SQLException | NumberFormatException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String complaintIdParam = request.getParameter("complaintId");
        String message = request.getParameter("message");

        if (complaintIdParam == null || complaintIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int complaintId = Integer.parseInt(complaintIdParam);
            int userId = (int) session.getAttribute("userId");
            String role = (String) session.getAttribute("userRole");

            if (message == null || message.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/thread?complaintId=" + complaintId);
                return;
            }

            ComplaintDAO complaintDAO = new ComplaintDAO();
            Complaint complaint = complaintDAO.getComplaintById(complaintId);
            if (complaint == null) {
                request.setAttribute("error", "Complaint not found.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            boolean canReply = false;
            if ("admin".equals(role)) {
                canReply = true;
            } else if ("staff".equals(role)) {
                canReply = complaintDAO.isComplaintAssignedToStaff(complaintId, userId);
            } else if ("student".equals(role)) {
                canReply = complaint.getUserId() == userId;
            }

            if (!canReply) {
                request.setAttribute("error", "You are not allowed to reply to this complaint.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            ResponseDAO responseDAO = new ResponseDAO();
            Response responseObj = new Response();
            responseObj.setComplaintId(complaintId);
            responseObj.setUserId(userId);
            responseObj.setMessage(message.trim());
            responseDAO.addResponse(responseObj);

            response.sendRedirect(request.getContextPath() + "/thread?complaintId=" + complaintId);
        } catch (SQLException | NumberFormatException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
