<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Complaints - RaiseIT</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-container">
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
            <button class="sidebar-toggle" type="button" onclick="document.querySelector('.sidebar').classList.toggle('is-open')">☰</button>
            <h1>My Complaints</h1>
            <a href="${pageContext.request.contextPath}/student/submit" class="btn-primary">Submit New</a>
        </div>
        <c:if test="${param.error == 'already_submitted'}">
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
                .toast-warning button {
                    background: transparent;
                    border: none;
                    color: #ffffff;
                    font-size: 1rem;
                    cursor: pointer;
                    line-height: 1;
                }
                .toast-progress {
                    position: absolute;
                    left: 0;
                    bottom: 0;
                    height: 3px;
                    width: 100%;
                    background: rgba(255, 255, 255, 0.7);
                    animation: toastTimer 4s linear forwards;
                }
                @keyframes toastTimer {
                    from { width: 100%; }
                    to { width: 0%; }
                }
            </style>
            <div class="toast-warning" id="feedback-toast">
                <span>You have already submitted feedback for this complaint.</span>
                <button type="button" aria-label="Close" onclick="dismissToast()">&times;</button>
                <div class="toast-progress"></div>
            </div>
            <script>
                function dismissToast() {
                    var toast = document.getElementById('feedback-toast');
                    if (!toast) return;
                    toast.classList.add('fade-out');
                    setTimeout(function () { toast.remove(); }, 400);
                }
                setTimeout(function () {
                    dismissToast();
                }, 4000);
            </script>
        </c:if>
        <c:if test="${param.success == 'escalated'}">
            <style>
                @keyframes slideInRight {
                    from { transform: translateX(120%); opacity: 0; }
                    to { transform: translateX(0); opacity: 1; }
                }
                @keyframes fadeOut {
                    from { opacity: 1; }
                    to { opacity: 0; }
                }
                .toast-success {
                    position: fixed;
                    top: 80px;
                    right: 20px;
                    background: var(--success);
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
                .toast-success.fade-out {
                    animation: fadeOut 0.4s ease-in forwards;
                }
                .toast-success button {
                    background: transparent;
                    border: none;
                    color: #ffffff;
                    font-size: 1rem;
                    cursor: pointer;
                    line-height: 1;
                }
                .toast-success .toast-progress {
                    position: absolute;
                    left: 0;
                    bottom: 0;
                    height: 3px;
                    width: 100%;
                    background: rgba(255, 255, 255, 0.7);
                    animation: toastTimer 4s linear forwards;
                }
                @keyframes toastTimer {
                    from { width: 100%; }
                    to { width: 0%; }
                }
            </style>
            <div class="toast-success" id="escalate-toast">
                <span>Complaint escalated successfully.</span>
                <button type="button" aria-label="Close" onclick="dismissEscalateToast()">&times;</button>
                <div class="toast-progress"></div>
            </div>
            <script>
                function dismissEscalateToast() {
                    var toast = document.getElementById('escalate-toast');
                    if (!toast) return;
                    toast.classList.add('fade-out');
                    setTimeout(function () { toast.remove(); }, 400);
                }
                setTimeout(function () {
                    dismissEscalateToast();
                }, 4000);
            </script>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        <div class="table-container">
            <table class="data-table">
                <thead>
                <tr>
                    <th>Reference</th>
                    <th>Title</th>
                    <th>Category</th>
                    <th>Priority</th>
                    <th>Status</th>
                    <th>Date</th>
                    <th>Thread</th>
                    <th>Feedback</th>
                    <th>Escalate</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty complaints}">
                        <tr>
                            <td colspan="9" style="text-align:center;">No complaints submitted yet.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="complaint" items="${complaints}">
                            <tr>
                                <td>${complaint.referenceNumber}</td>
                                <td>${complaint.title}</td>
                                <td>${complaint.categoryName}</td>
                                <td>
                                    <span class="badge badge-${complaint.priority}">${complaint.priority}</span>
                                </td>
                                <td>
                                    <span class="badge badge-${complaint.status}">${complaint.status}</span>
                                </td>
                                <td>${complaint.createdAt}</td>
                                <td>
                                    <a class="btn-secondary" href="${pageContext.request.contextPath}/thread?complaintId=${complaint.id}">View Thread</a>
                                </td>
                                <td>
                                    <c:if test="${complaint.status == 'resolved'}">
                                        <a class="btn-secondary" href="${pageContext.request.contextPath}/feedback?complaintId=${complaint.id}">Leave Feedback</a>
                                    </c:if>
                                    <c:if test="${complaint.status != 'resolved'}">
                                        <span style="color:#6b7280;">Not Available</span>
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${complaint.status == 'assigned' || complaint.status == 'in_progress'}">
                                        <form method="post" action="${pageContext.request.contextPath}/student/escalate" style="display:inline">
                                            <input type="hidden" name="complaintId" value="${complaint.id}">
                                            <button type="submit" class="btn-suspend">Escalate</button>
                                        </form>
                                    </c:if>
                                    <c:if test="${complaint.status != 'assigned' && complaint.status != 'in_progress'}">
                                        <span style="color:#6b7280;">Not Available</span>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
