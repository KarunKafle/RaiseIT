<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports - RaiseIT</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .stat-row {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 16px;
            margin-bottom: 24px;
        }
        .stat-box {
            background: var(--white);
            border-radius: 12px;
            box-shadow: var(--shadow);
            padding: 18px 20px;
            border-left: 6px solid var(--primary);
        }
        .stat-box.orange { border-left-color: var(--warning); }
        .stat-box.green { border-left-color: var(--success); }
        .stat-box.gray { border-left-color: var(--text-light); }
        .stat-value {
            font-size: 1.8rem;
            font-weight: 800;
            color: var(--text);
        }
        .stat-label {
            color: var(--text-light);
            font-size: 0.9rem;
            margin-top: 4px;
        }
        .report-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 20px;
        }
        .report-card {
            background: var(--white);
            border-radius: 12px;
            box-shadow: var(--shadow);
            padding: 20px;
        }
        .report-card h2 {
            font-size: 1.05rem;
            font-weight: 700;
            margin-bottom: 12px;
            color: var(--text);
        }
        .report-item {
            display: grid;
            grid-template-columns: 1fr auto;
            align-items: center;
            gap: 12px;
            padding: 8px 0;
            border-bottom: 1px solid var(--border);
        }
        .report-item:last-child {
            border-bottom: none;
        }
        .report-label {
            color: var(--text);
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .report-count {
            background: #eef2ff;
            color: #3730a3;
            border-radius: 999px;
            padding: 4px 10px;
            font-size: 0.8rem;
            font-weight: 600;
            min-width: 28px;
            text-align: center;
        }
        .bar-row {
            display: grid;
            grid-template-columns: auto 1fr auto;
            align-items: center;
            gap: 10px;
            padding: 8px 0;
            border-bottom: 1px solid var(--border);
        }
        .bar-row:last-child { border-bottom: none; }
        .bar-track {
            height: 8px;
            border-radius: 999px;
            background: #f1f5f9;
            overflow: hidden;
        }
        .bar-fill {
            height: 100%;
            width: 0;
            border-radius: 999px;
            transition: width 0.8s ease;
        }
        .bar-fill.high { background: var(--danger); }
        .bar-fill.medium { background: var(--warning); }
        .bar-fill.low { background: var(--success); }
        .bar-fill.status { background: var(--primary); }
        .dept-chart {
            display: flex;
            align-items: flex-end;
            gap: 12px;
            height: 200px;
            margin-top: 8px;
        }
        .dept-bar {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 6px;
            flex: 1 1 0;
        }
        .dept-bar .bar {
            width: 40px;
            background: var(--primary);
            border-radius: 8px 8px 4px 4px;
            height: 0;
            min-height: 4px;
            transition: height 0.8s ease;
        }
        .dept-count {
            font-size: 0.8rem;
            color: var(--text);
            font-weight: 600;
        }
        .dept-label {
            font-size: 0.75rem;
            color: var(--text-light);
            text-align: center;
            word-break: break-word;
        }
        @media (max-width: 1100px) {
            .stat-row { grid-template-columns: repeat(2, minmax(0, 1fr)); }
            .report-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <button class="hamburger-btn" type="button" onclick="document.body.classList.toggle('sidebar-open')">☰ Menu</button>
    <div class="sidebar">
        <div class="sidebar-brand">RaiseIT</div>
        <nav>
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/users">Users</a>
            <a href="${pageContext.request.contextPath}/admin/complaints">Complaints</a>
            <a href="${pageContext.request.contextPath}/admin/departments">Departments</a>
            <a href="${pageContext.request.contextPath}/admin/categories">Categories</a>
            <a href="${pageContext.request.contextPath}/admin/reports" class="active">Reports</a>
            <a href="${pageContext.request.contextPath}/admin/contacts">Contact Inquiries</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </nav>
    </div>
    <div class="main-content">
        <div class="page-header">
            <h1>Reports & Analytics</h1>
        </div>

        <c:set var="totalComplaints" value="0" />
        <c:set var="openCount" value="0" />
        <c:set var="resolvedCount" value="0" />
        <c:set var="closedCount" value="0" />
        <c:forEach var="item" items="${statusStats}">
            <c:set var="totalComplaints" value="${totalComplaints + item.count}" />
            <c:if test="${item.label == 'submitted' || item.label == 'assigned' || item.label == 'in_progress'}">
                <c:set var="openCount" value="${openCount + item.count}" />
            </c:if>
            <c:if test="${item.label == 'resolved'}">
                <c:set var="resolvedCount" value="${item.count}" />
            </c:if>
            <c:if test="${item.label == 'closed'}">
                <c:set var="closedCount" value="${item.count}" />
            </c:if>
        </c:forEach>

        <div class="stat-row">
            <div class="stat-box">
                <div class="stat-value">${totalComplaints}</div>
                <div class="stat-label">Total Complaints</div>
            </div>
            <div class="stat-box orange">
                <div class="stat-value">${openCount}</div>
                <div class="stat-label">Open / In Progress</div>
            </div>
            <div class="stat-box green">
                <div class="stat-value">${resolvedCount}</div>
                <div class="stat-label">Resolved</div>
            </div>
            <div class="stat-box gray">
                <div class="stat-value">${closedCount}</div>
                <div class="stat-label">Closed</div>
            </div>
        </div>

        <c:set var="statusTotal" value="0" />
        <c:forEach var="item" items="${statusStats}">
            <c:set var="statusTotal" value="${statusTotal + item.count}" />
        </c:forEach>
        <c:set var="statusTotal" value="${statusTotal == 0 ? 1 : statusTotal}" />

        <c:set var="priorityTotal" value="0" />
        <c:forEach var="item" items="${priorityStats}">
            <c:set var="priorityTotal" value="${priorityTotal + item.count}" />
        </c:forEach>
        <c:set var="priorityTotal" value="${priorityTotal == 0 ? 1 : priorityTotal}" />

        <c:set var="maxDept" value="0" />
        <c:forEach var="item" items="${departmentStats}">
            <c:if test="${item.count > maxDept}">
                <c:set var="maxDept" value="${item.count}" />
            </c:if>
        </c:forEach>
        <c:set var="maxDept" value="${maxDept == 0 ? 1 : maxDept}" />

        <div class="report-grid">
            <div class="report-card">
                <h2>Complaints by Status</h2>
                <c:forEach var="item" items="${statusStats}">
                    <div class="bar-row">
                        <span class="report-label">
                            <span class="badge badge-${item.label}">${item.label}</span>
                        </span>
                        <div class="bar-track">
                            <div class="bar-fill status" style="width: ${item.count * 100 / statusTotal}%;"></div>
                        </div>
                        <span class="report-count">${item.count}</span>
                    </div>
                </c:forEach>
            </div>
            <div class="report-card">
                <h2>Complaints by Priority</h2>
                <c:forEach var="item" items="${priorityStats}">
                    <div class="bar-row">
                        <span class="report-label">
                            <span class="badge badge-${item.label}">${item.label}</span>
                        </span>
                        <div class="bar-track">
                            <div class="bar-fill ${item.label}" style="width: ${item.count * 100 / priorityTotal}%;"></div>
                        </div>
                        <span class="report-count">${item.count}</span>
                    </div>
                </c:forEach>
            </div>
            <div class="report-card">
                <h2>Complaints by Department</h2>
                <div class="dept-chart">
                    <c:forEach var="item" items="${departmentStats}">
                        <div class="dept-bar">
                            <div class="dept-count">${item.count}</div>
                            <div class="bar" style="height: calc(${item.count} / ${maxDept} * 180px);"></div>
                            <div class="dept-label">${item.label}</div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="report-card">
                <h2>Resolved by Staff</h2>
                <c:forEach var="item" items="${staffResolvedStats}">
                    <div class="report-item">
                        <span class="report-label">${item.label}</span>
                        <span class="report-count">
                            <c:choose>
                                <c:when test="${item.count == 0}">-</c:when>
                                <c:otherwise>${item.count}</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </c:forEach>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                document.querySelectorAll('.bar-fill').forEach(function (bar) {
                    var target = bar.style.width;
                    bar.style.width = '0%';
                    setTimeout(function () { bar.style.width = target; }, 50);
                });
                document.querySelectorAll('.dept-bar .bar').forEach(function (bar) {
                    var target = bar.style.height;
                    bar.style.height = '0%';
                    setTimeout(function () { bar.style.height = target; }, 50);
                });
            });
        </script>
    </div>
</div>
</body>
</html>
