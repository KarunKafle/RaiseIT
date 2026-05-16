package com.raiseit.controller;

import com.raiseit.dao.ComplaintDAO;
import com.raiseit.dao.FeedbackDAO;
import com.raiseit.model.Complaint;
import com.raiseit.model.Feedback;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

public class FeedbackServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String complaintIdParam = request.getParameter("complaintId");
        if (complaintIdParam == null || complaintIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/student/complaints");
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

            ComplaintDAO complaintDAO = new ComplaintDAO();
            FeedbackDAO feedbackDAO = new FeedbackDAO();

            Complaint complaint = complaintDAO.getComplaintById(complaintId);
            if (complaint == null || complaint.getUserId() != userId) {
                request.setAttribute("error", "You are not allowed to leave feedback for this complaint.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            if (!"resolved".equals(complaint.getStatus())) {
                request.setAttribute("error", "Feedback is only available after a complaint is resolved.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            Feedback existing = feedbackDAO.getFeedbackByComplaintId(complaintId);
            if (existing != null) {
                request.setAttribute("error", "Feedback has already been submitted for this complaint.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            request.setAttribute("complaint", complaint);
            request.getRequestDispatcher("/WEB-INF/views/student/feedback.jsp")
                    .forward(request, response);
        } catch (SQLException | NumberFormatException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String complaintIdParam = request.getParameter("complaintId");
        String ratingParam = request.getParameter("rating");
        String comment = request.getParameter("comment");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if (complaintIdParam == null || complaintIdParam.trim().isEmpty() || ratingParam == null || ratingParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/student/complaints");
            return;
        }

        try {
            int complaintId = Integer.parseInt(complaintIdParam);
            int rating = Integer.parseInt(ratingParam);
            int userId = (int) session.getAttribute("userId");

            ComplaintDAO complaintDAO = new ComplaintDAO();
            FeedbackDAO feedbackDAO = new FeedbackDAO();

            Complaint complaint = complaintDAO.getComplaintById(complaintId);
            if (complaint == null || complaint.getUserId() != userId) {
                request.setAttribute("error", "You are not allowed to leave feedback for this complaint.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            if (!"resolved".equals(complaint.getStatus())) {
                request.setAttribute("error", "Feedback is only available after a complaint is resolved.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            Feedback existing = feedbackDAO.getFeedbackByComplaintId(complaintId);
            if (existing != null) {
                request.setAttribute("error", "Feedback has already been submitted for this complaint.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            if (rating < 1 || rating > 5) {
                request.setAttribute("error", "Rating must be between 1 and 5.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            Feedback feedback = new Feedback();
            feedback.setComplaintId(complaintId);
            feedback.setStudentId(userId);
            feedback.setRating(rating);
            feedback.setComment(comment != null ? comment.trim() : null);
            feedbackDAO.addFeedback(feedback);

            response.sendRedirect(request.getContextPath() + "/thread?complaintId=" + complaintId);
        } catch (SQLException | NumberFormatException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
