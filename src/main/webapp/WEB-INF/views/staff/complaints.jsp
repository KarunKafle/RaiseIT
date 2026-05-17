<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assigned Complaints - RaiseIT</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-container">
    <button class="hamburger-btn" type="button" onclick="document.body.classList.toggle('sidebar-open')">☰ Menu</button>
    <div class="sidebar">
        <div class="sidebar-brand">RaiseIT</div>
        <nav>
            <a href="${pageContext.request.contextPath}/staff/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/staff/complaints" class="active">My Assigned</a>
            <a href="${pageContext.request.contextPath}/staff/history">Response History</a>
            <a href="${pageContext.request.contextPath}/staff/profile">My Profile</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </nav>
    </div>
    <div class="main-content">
        <div class="page-header">
            <h1>Assigned Complaints</h1>
        </div>
        <div class="table-container">
            <table class="data-table">
                <thead>
                <tr>
                    <th>Reference</th>
                    <th>Title</th>
                    <th>Student</th>
                    <th>Category</th>
                    <th>Priority</th>
                    <th>Status</th>
                    <th>Deadline</th>
                    <th>Actions</th>
                    <th>Thread</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty complaints}">
                        <tr>
                            <td colspan="9" style="text-align:center;">No complaints assigned yet.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="complaint" items="${complaints}">
                            <tr>
                                <td>${complaint.referenceNumber}</td>
                                <td>${complaint.title}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${complaint.anonymous}">Anonymous</c:when>
                                        <c:otherwise>${complaint.studentName}</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${complaint.categoryName}</td>
                                <td><span class="badge badge-${complaint.priority}">${complaint.priority}</span></td>
                                <td><span class="badge badge-${complaint.status}">${complaint.status}</span></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${complaint.deadline != null}">
                                            <c:choose>
                                                <c:when test="${complaint.overdue}">
                                                    <span style="color:#b91c1c;">${complaint.deadline} ⚠ Overdue</span>
                                                </c:when>
                                                <c:when test="${complaint.dueToday}">
                                                    <span style="color:#c2410c;">${complaint.deadline} Due Today</span>
                                                </c:when>
                                                <c:otherwise>
                                                    ${complaint.deadline}
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            -
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${complaint.status == 'assigned'}">
                                            <form method="post" action="${pageContext.request.contextPath}/staff/update" style="display:inline">
                                                <input type="hidden" name="complaintId" value="${complaint.id}">
                                                <input type="hidden" name="newStatus" value="in_progress">
                                                <button type="submit" class="btn-approve">Mark In Progress</button>
                                            </form>
                                        </c:when>
                                        <c:when test="${complaint.status == 'in_progress' || complaint.status == 'escalated'}">
                                            <form method="post" action="${pageContext.request.contextPath}/staff/update" style="display:inline">
                                                <input type="hidden" name="complaintId" value="${complaint.id}">
                                                <input type="hidden" name="newStatus" value="resolved">
                                                <button type="submit" class="btn-approve">Mark Resolved</button>
                                            </form>
                                        </c:when>
                                        <c:when test="${complaint.status == 'resolved'}">
                                            <span style="color:#888;">Resolved ✓</span>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td>
                                    <a class="btn-secondary" href="${pageContext.request.contextPath}/thread?complaintId=${complaint.id}">View Thread</a>
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
