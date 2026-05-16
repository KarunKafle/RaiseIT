package com.raiseit.controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class FaqServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            Object wishlist = session.getAttribute("faqWishlist");
            request.setAttribute("wishlist", wishlist);
        }
        request.getRequestDispatcher("/WEB-INF/views/faq.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userRole") == null ||
                !"student".equals(session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/faq");
            return;
        }

        String action = request.getParameter("action");
        String question = request.getParameter("question");
        if (question == null || question.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/faq");
            return;
        }

        List<String> wishlist = (List<String>) session.getAttribute("faqWishlist");
        if (wishlist == null) {
            wishlist = new ArrayList<>();
        }

        if ("add".equals(action)) {
            if (!wishlist.contains(question)) {
                wishlist.add(question);
            }
        } else if ("remove".equals(action)) {
            wishlist.remove(question);
        }

        session.setAttribute("faqWishlist", wishlist);
        response.sendRedirect(request.getContextPath() + "/faq");
    }
}
