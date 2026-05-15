<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Complaints - RaiseIT</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-container">
    <div class="sidebar">
        <div class="sidebar-brand">RaiseIT</div>
        <nav>
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/users">Users</a>
            <a href="${pageContext.request.contextPath}/admin/complaints" class="active">Complaints</a>
            <a href="${pageContext.request.contextPath}/admin/departments">Departments</a>
            <a href="${pageContext.request.contextPath}/admin/categories">Categories</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </nav>
    </div>
    <div class="main-content">
        <div class="page-header">
            <h1>Manage Complaints</h1>
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
                    <th>Date</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
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
                        <td>${complaint.createdAt}</td>
                        <td>
                            <div class="action-stack">
                                <c:if test="${complaint.status == 'submitted'}">
                                    <form method="post" action="${pageContext.request.contextPath}/admin/complaints">
                                        <input type="hidden" name="complaintId" value="${complaint.id}">
                                        <input type="hidden" name="action" value="assign">
                                        <select name="staffId" class="staff-select" required>
                                            <option value="">Select Staff</option>
                                            <c:forEach var="staff" items="${staffList}">
                                                <option value="${staff.id}">${staff.fullName}</option>
                                            </c:forEach>
                                        </select>
                                        <button type="submit" class="btn-approve">Assign</button>
                                    </form>
                                </c:if>
                                <c:if test="${complaint.status == 'assigned' or complaint.status == 'in_progress'}">
                                    <form method="post" action="${pageContext.request.contextPath}/admin/complaints">
                                        <input type="hidden" name="complaintId" value="${complaint.id}">
                                        <input type="hidden" name="action" value="resolve">
                                        <button type="submit" class="btn-approve">Resolve</button>
                                    </form>
                                </c:if>
                                <c:if test="${complaint.status == 'resolved'}">
                                    <form method="post" action="${pageContext.request.contextPath}/admin/complaints">
                                        <input type="hidden" name="complaintId" value="${complaint.id}">
                                        <input type="hidden" name="action" value="close">
                                        <button type="submit" class="btn-suspend">Close</button>
                                    </form>
                                </c:if>
                                <form method="post" action="${pageContext.request.contextPath}/admin/complaints">
                                    <input type="hidden" name="complaintId" value="${complaint.id}">
                                    <input type="hidden" name="action" value="delete">
                                    <button type="submit" class="btn-delete" onclick="return confirm('Delete this complaint?')">Delete</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
