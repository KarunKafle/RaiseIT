<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Staff Dashboard - RaiseIT</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-container">
    <div class="sidebar">
        <div class="sidebar-brand">RaiseIT</div>
        <nav>
            <a href="${pageContext.request.contextPath}/staff/dashboard" class="active">Dashboard</a>
            <a href="${pageContext.request.contextPath}/staff/complaints">My Assigned</a>
            <a href="${pageContext.request.contextPath}/staff/profile">My Profile</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </nav>
    </div>
    <div class="main-content">
        <div class="page-header">
            <h1>Welcome, ${sessionScope.user.fullName}</h1>
        </div>
        <div class="stats-grid">
            <div class="stat-card">
                <h3>Assigned to Me</h3>
                <p class="stat-number">${totalAssigned}</p>
            </div>
            <div class="stat-card">
                <h3>In Progress</h3>
                <p class="stat-number">${inProgress}</p>
            </div>
            <div class="stat-card">
                <h3>Resolved</h3>
                <p class="stat-number">${resolved}</p>
            </div>
        </div>
        <div class="quick-actions">
            <h2>Quick Actions</h2>
            <a href="${pageContext.request.contextPath}/staff/complaints" class="btn-primary">View Assigned Complaints</a>
        </div>
    </div>
</div>
</body>
</html>
