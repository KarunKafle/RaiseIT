<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Leave Feedback - RaiseIT</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-container">
    <button class="hamburger-btn" type="button" onclick="document.body.classList.toggle('sidebar-open')">☰ Menu</button>
    <div class="sidebar">
        <div class="sidebar-brand">RaiseIT</div>
        <nav>
            <a href="${pageContext.request.contextPath}/student/search">Search</a>
            <a href="${pageContext.request.contextPath}/student/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/student/complaints" class="active">My Complaints</a>
            <a href="${pageContext.request.contextPath}/student/submit">Submit Complaint</a>
            <a href="${pageContext.request.contextPath}/faq">FAQ</a>
            <a href="${pageContext.request.contextPath}/student/profile">My Profile</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </nav>
    </div>
    <div class="main-content">
        <div class="page-header">
            <h1>Leave Feedback</h1>
        </div>

        <div class="form-container" style="max-width: 700px;">
            <h2>${complaint.title}</h2>
            <p><strong>Reference:</strong> ${complaint.referenceNumber}</p>
            <p><strong>Status:</strong> <span class="badge badge-${complaint.status}">${complaint.status}</span></p>
            <form method="post" action="${pageContext.request.contextPath}/feedback" style="margin-top: 16px;">
                <input type="hidden" name="complaintId" value="${complaint.id}">
                <div class="form-group">
                    <label for="rating">Rating (1 to 5)</label>
                    <select id="rating" name="rating" required>
                        <option value="">Select rating</option>
                        <option value="1">1 - Very Poor</option>
                        <option value="2">2 - Poor</option>
                        <option value="3">3 - Neutral</option>
                        <option value="4">4 - Good</option>
                        <option value="5">5 - Excellent</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="comment">Comment (optional)</label>
                    <textarea id="comment" name="comment" rows="4"></textarea>
                </div>
                <button type="submit" class="btn-primary">Submit Feedback</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>
