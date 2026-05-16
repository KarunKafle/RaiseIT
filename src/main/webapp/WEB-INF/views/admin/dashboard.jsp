<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.raiseit.model.Complaint" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Dashboard - RaiseIT</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-container">
  <div class="sidebar">
    <div class="sidebar-brand">RaiseIT</div>
    <nav>
      <a href="${pageContext.request.contextPath}/admin/dashboard" class="active">Dashboard</a>
      <a href="${pageContext.request.contextPath}/admin/users">Manage Users</a>
      <a href="${pageContext.request.contextPath}/admin/complaints">Manage Complaints</a>
      <a href="${pageContext.request.contextPath}/admin/departments">Manage Departments</a>
      <a href="${pageContext.request.contextPath}/admin/categories">Manage Categories</a>
      <a href="${pageContext.request.contextPath}/admin/reports">Reports</a>
      <a href="${pageContext.request.contextPath}/admin/contacts">Contact Inquiries</a>
      <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </nav>
  </div>
  <div class="main-content">
    <div class="page-header">
      <h1>Welcome, <%= session.getAttribute("userFullName") %></h1>
    </div>
    <div class="stats-grid">
      <div class="stat-card">
        <h3>Total Complaints</h3>
        <p class="stat-number">${totalComplaints}</p>
      </div>
      <div class="stat-card">
        <h3>Pending Review</h3>
        <p class="stat-number">${pendingComplaints}</p>
      </div>
      <div class="stat-card">
        <h3>In Progress</h3>
        <p class="stat-number">${inProgressComplaints}</p>
      </div>
      <div class="stat-card">
        <h3>Resolved</h3>
        <p class="stat-number">${resolvedComplaints}</p>
      </div>
      <div class="stat-card">
        <h3>Total Users</h3>
        <p class="stat-number">${totalUsers}</p>
      </div>
      <div class="stat-card">
        <h3>Pending Users</h3>
        <p class="stat-number">${pendingUsers}</p>
      </div>
    </div>
    <div class="table-container">
      <div class="page-header" style="padding: 20px 20px 0 20px;">
        <h2 style="font-size:1.1rem;">Recent Complaints</h2>
      </div>
      <table class="data-table">
        <thead>
        <tr>
          <th>Reference</th>
          <th>Title</th>
          <th>Priority</th>
          <th>Status</th>
          <th>Date</th>
        </tr>
        </thead>
        <tbody>
        <%
          List<Complaint> recentComplaints = (List<Complaint>) request.getAttribute("recentComplaints");
          if (recentComplaints != null) {
            for (Complaint c : recentComplaints) {
        %>
        <tr>
          <td><%= c.getReferenceNumber() %></td>
          <td><%= c.getTitle() %></td>
          <td><span class="badge badge-<%= c.getPriority() %>"><%= c.getPriority() %></span></td>
          <td><span class="badge badge-<%= c.getStatus() %>"><%= c.getStatus() %></span></td>
          <td><%= c.getCreatedAt() %></td>
        </tr>
        <%
            }
          }
        %>
        </tbody>
      </table>
    </div>
  </div>
</div>
</body>
</html>
