<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Profile - RaiseIT</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-container">
    <div class="sidebar">
        <div class="sidebar-brand">RaiseIT</div>
        <nav>
            <a href="${pageContext.request.contextPath}/student/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/student/complaints">My Complaints</a>
            <a href="${pageContext.request.contextPath}/student/submit">Submit Complaint</a>
            <a href="${pageContext.request.contextPath}/student/profile" class="active">My Profile</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </nav>
    </div>
    <div class="main-content">
        <div class="page-header">
            <h1>My Profile</h1>
        </div>
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        <div class="form-container">
            <form method="post" action="${pageContext.request.contextPath}/student/profile">
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="fullName" value="${user.fullName}" required>
                </div>
                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" value="${user.email}" disabled>
                </div>
                <div class="form-group">
                    <label>Role</label>
                    <input type="text" value="${user.role}" disabled>
                </div>
                <div class="form-group">
                    <label>New Password (leave blank to keep current)</label>
                    <input type="password" name="newPassword" placeholder="Enter new password">
                </div>
                <div class="form-group">
                    <label>Confirm New Password</label>
                    <input type="password" name="confirmPassword" placeholder="Confirm new password">
                </div>
                <button type="submit" class="btn-primary">Update Profile</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>