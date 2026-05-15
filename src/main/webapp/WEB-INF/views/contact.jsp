<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Contact - RaiseIT</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-container">
    <div class="sidebar">
        <div class="sidebar-brand">RaiseIT</div>
        <nav>
            <a href="${pageContext.request.contextPath}/about">About</a>
            <a href="${pageContext.request.contextPath}/contact" class="active">Contact</a>
            <a href="${pageContext.request.contextPath}/faq">FAQ</a>
            <a href="${pageContext.request.contextPath}/login">Login</a>
        </nav>
    </div>
    <div class="main-content">
        <div class="page-header">
            <h1>Contact Us</h1>
        </div>
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        <div class="form-container">
            <p>Have a question or need support? Fill in the form below and we'll get back to you.</p>
            <form method="post" action="${pageContext.request.contextPath}/contact">
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="name" placeholder="Enter your full name" required>
                </div>
                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" name="email" placeholder="Enter your email" required>
                </div>
                <div class="form-group">
                    <label>Phone Number</label>
                    <input type="tel" name="phone" placeholder="Enter your phone number" required>
                </div>
                <div class="form-group">
                    <label>Message</label>
                    <textarea name="message" rows="6" placeholder="Write your message here" required></textarea>
                </div>
                <button type="submit" class="btn-primary">Send Message</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>
