<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.raiseit.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard - RaiseIT</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-container">
    <div class="sidebar">
        <div class="sidebar-brand">RaiseIT</div>
        <nav>
            <a href="${pageContext.request.contextPath}/student/search">Search</a>
            <a href="${pageContext.request.contextPath}/student/dashboard" class="active">Dashboard</a>
            <a href="${pageContext.request.contextPath}/student/complaints">My Complaints</a>
            <a href="${pageContext.request.contextPath}/student/submit">Submit Complaint</a>
            <a href="${pageContext.request.contextPath}/student/profile">My Profile</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </nav>
    </div>
    <div class="main-content">
        <div class="page-header">
            <h1>Welcome, ${sessionScope.user.fullName}</h1>
        </div>
        <div class="stats-grid">
            <div class="stat-card">
                <h3>Total Complaints</h3>
                <p class="stat-number">${totalComplaints}</p>
            </div>
            <div class="stat-card">
                <h3>Pending</h3>
                <p class="stat-number">${pendingComplaints}</p>
            </div>
            <div class="stat-card">
                <h3>Resolved</h3>
                <p class="stat-number">${resolvedComplaints}</p>
            </div>
        </div>
        <div class="quick-actions">
            <h2>Quick Actions</h2>
            <a href="${pageContext.request.contextPath}/student/submit" class="btn-primary">Submit New Complaint</a>
            <a href="${pageContext.request.contextPath}/student/complaints" class="btn-secondary">View My Complaints</a>
        </div>
    </div>
</div>
</body>
</html>