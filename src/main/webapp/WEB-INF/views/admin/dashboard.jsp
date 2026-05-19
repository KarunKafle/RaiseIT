<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.raiseit.model.Complaint" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
  <button class="hamburger-btn" type="button" onclick="document.body.classList.toggle('sidebar-open')">☰ Menu</button>
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
