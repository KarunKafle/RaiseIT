<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Complaint Thread - RaiseIT</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-container">
    <div class="sidebar">
        <div class="sidebar-brand">RaiseIT</div>
        <nav>
            <c:choose>
                <c:when test="${sessionScope.userRole == 'admin'}">
                    <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
                    <a href="${pageContext.request.contextPath}/admin/complaints">Complaints</a>
                    <a href="${pageContext.request.contextPath}/admin/departments">Departments</a>
                    <a href="${pageContext.request.contextPath}/admin/categories">Categories</a>
                </c:when>
                <c:when test="${sessionScope.userRole == 'staff'}">
                    <a href="${pageContext.request.contextPath}/staff/dashboard">Dashboard</a>
                    <a href="${pageContext.request.contextPath}/staff/complaints">My Assigned</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/student/dashboard">Dashboard</a>
                    <a href="${pageContext.request.contextPath}/student/complaints">My Complaints</a>
                    <a href="${pageContext.request.contextPath}/student/submit">Submit Complaint</a>
                </c:otherwise>
            </c:choose>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </nav>
    </div>
    <div class="main-content">
        <div class="page-header">
            <h1>Complaint Thread</h1>
        </div>

        <div class="form-container" style="max-width: 900px;">
            <h2>${complaint.title}</h2>
            <p><strong>Reference:</strong> ${complaint.referenceNumber}</p>
            <p><strong>Status:</strong> <span class="badge badge-${complaint.status}">${complaint.status}</span></p>
            <p><strong>Category:</strong> ${complaint.categoryName}</p>
            <p><strong>Priority:</strong> <span class="badge badge-${complaint.priority}">${complaint.priority}</span></p>
            <p style="margin-top: 12px;"><strong>Description:</strong></p>
            <p>${complaint.description}</p>
        </div>

        <div class="form-container" style="max-width: 900px; margin-top: 24px;">
            <h2>Conversation</h2>
            <c:choose>
                <c:when test="${empty responses}">
                    <p>No responses yet. Start the conversation below.</p>
                </c:when>
                <c:otherwise>
                    <div style="display:flex; flex-direction:column; gap:12px; margin-top: 12px;">
                        <c:forEach var="reply" items="${responses}">
                            <div style="background:#f8fafc; border:1px solid #e5e7eb; border-radius:10px; padding:12px 14px;">
                                <div style="display:flex; justify-content:space-between; font-size:0.85rem; color:#6b7280;">
                                    <span>${reply.userFullName} (${reply.userRole})</span>
                                    <span>${reply.createdAt}</span>
                                </div>
                                <div style="margin-top:6px; color:#1f2937;">${reply.message}</div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <c:if test="${not empty feedback}">
            <div class="form-container" style="max-width: 900px; margin-top: 24px;">
                <h2>Feedback</h2>
                <p><strong>Rating:</strong> ${feedback.rating} / 5</p>
                <c:if test="${not empty feedback.comment}">
                    <p><strong>Comment:</strong> ${feedback.comment}</p>
                </c:if>
                <p style="color:#6b7280; font-size:0.85rem; margin-top: 6px;">Submitted by ${feedback.studentName} on ${feedback.createdAt}</p>
            </div>
        </c:if>

        <c:if test="${complaint.status == 'resolved' and sessionScope.userRole == 'student' and empty feedback}">
            <div class="form-container" style="max-width: 900px; margin-top: 24px;">
                <h2>Leave Feedback</h2>
                <a class="btn-primary" href="${pageContext.request.contextPath}/feedback?complaintId=${complaint.id}">Leave Feedback</a>
            </div>
        </c:if>

        <div class="form-container" style="max-width: 900px; margin-top: 24px;">
            <h2>Write a Reply</h2>
            <form method="post" action="${pageContext.request.contextPath}/thread">
                <input type="hidden" name="complaintId" value="${complaint.id}">
                <div class="form-group">
                    <label for="message">Message</label>
                    <textarea id="message" name="message" rows="4" required></textarea>
                </div>
                <button type="submit" class="btn-primary">Send Reply</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>
