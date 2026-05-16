package com.raiseit.controller;

import com.raiseit.dao.ContactDAO;
import com.raiseit.model.ContactInquiry;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/contact.jsp")
                .forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String message = request.getParameter("message");

        if (name == null || name.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                phone == null || phone.trim().isEmpty() ||
                message == null || message.trim().isEmpty()) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/WEB-INF/views/contact.jsp")
                    .forward(request, response);
            return;
        }

        try {
            ContactInquiry inquiry = new ContactInquiry();
            inquiry.setName(name.trim());
            inquiry.setEmail(email.trim());
            inquiry.setPhone(phone.trim());
            inquiry.setMessage(message.trim());

            ContactDAO contactDAO = new ContactDAO();
            contactDAO.saveInquiry(inquiry);

            request.setAttribute("success", "Your message has been sent successfully!");
            request.getRequestDispatcher("/WEB-INF/views/contact.jsp")
                    .forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/contact.jsp")
                    .forward(request, response);
        }
    }
}
