<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.raiseit.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - RaiseIT</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-container">
    <button class="hamburger-btn" type="button" onclick="document.body.classList.toggle('sidebar-open')">☰ Menu</button>
    <div class="sidebar">
        <div class="sidebar-brand">RaiseIT</div>
        <nav>
            <a href="${pageContext.request.contextPath}/student/search">Search</a>
            <a href="${pageContext.request.contextPath}/student/dashboard" class="active">Dashboard</a>
            <a href="${pageContext.request.contextPath}/student/complaints">My Complaints</a>
            <a href="${pageContext.request.contextPath}/student/submit">Submit Complaint</a>
            <a href="${pageContext.request.contextPath}/faq">FAQ</a>
            <a href="${pageContext.request.contextPath}/student/profile">My Profile</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </nav>
    </div>
    <div class="main-content">
        <c:if test="${param.warning == 'logout_required'}">
            <style>
                @keyframes slideInRight {
                    from { transform: translateX(120%); opacity: 0; }
                    to { transform: translateX(0); opacity: 1; }
                }
                @keyframes fadeOut {
                    from { opacity: 1; }
                    to { opacity: 0; }
                }
                .toast-warning {
                    position: fixed;
                    top: 80px;
                    right: 20px;
                    background: var(--warning);
                    color: #ffffff;
                    padding: 12px 16px;
                    border-radius: 10px;
                    box-shadow: 0 12px 24px rgba(0, 0, 0, 0.18);
                    display: flex;
                    align-items: center;
                    gap: 12px;
                    z-index: 9999;
                    animation: slideInRight 0.4s ease-out;
                    overflow: hidden;
                }
                .toast-warning.fade-out {
                    animation: fadeOut 0.4s ease-in forwards;
                }
                .toast-progress {
                    position: absolute;
                    left: 0;
                    bottom: 0;
                    height: 3px;
                    width: 100%;
                    background: rgba(255, 255, 255, 0.7);
                    animation: toastTimer 5s linear forwards;
                }
                @keyframes toastTimer {
                    from { width: 100%; }
                    to { width: 0%; }
                }
            </style>
            <div class="toast-warning" id="logout-required-toast">
                <span>You are already logged in. Please logout first to access the home page.</span>
                <div class="toast-progress"></div>
            </div>
            <script>
                (function () {
                    var toast = document.getElementById('logout-required-toast');
                    if (!toast) return;
                    setTimeout(function () {
                        toast.classList.add('fade-out');
                        setTimeout(function () { toast.remove(); }, 400);
                    }, 5000);
                })();
            </script>
        </c:if>
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
