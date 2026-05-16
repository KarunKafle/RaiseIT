<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Smart redirect — logged in users go to their dashboard
    String role = (String) session.getAttribute("role");
    if (role != null) {
        if (role.equals("admin")) response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        else if (role.equals("staff")) response.sendRedirect(request.getContextPath() + "/staff/dashboard");
        else response.sendRedirect(request.getContextPath() + "/student/dashboard");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RaiseIT — Student Complaint & Grievance System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <style>
        .hero {
            background: none;
            background-image: url('${pageContext.request.contextPath}/images/herosection.png');
            background-size: cover;
            background-position: center right;
        }

        .hero-content,
        .hero-content h1,
        .hero-content h1 span,
        .hero-content p {
            color: #ffffff;
        }

        .hero-badge {
            background: rgba(255, 255, 255, 0.2);
            color: #ffffff;
        }
    </style>
</head>
<body class="home-body">

<!-- NAVBAR -->
<nav class="home-nav">
    <div class="nav-brand">Raise<span>IT</span></div>
    <div class="nav-links">
        <a href="#features">Features</a>
        <a href="#how-it-works">How It Works</a>
        <a href="${pageContext.request.contextPath}/faq">FAQ</a>
        <a href="${pageContext.request.contextPath}/about">About</a>
        <a href="${pageContext.request.contextPath}/contact">Contact</a>
    </div>
    <div class="nav-actions">
        <a href="${pageContext.request.contextPath}/login" class="btn-secondary">Login</a>
        <a href="${pageContext.request.contextPath}/register" class="btn-primary">Register</a>
    </div>
</nav>

<!-- HERO -->
<section class="hero">
    <div class="hero-content">
        <span class="hero-badge">🎓 Student Grievance Portal</span>
        <h1>Your Voice <span>Deserves</span> to Be Heard</h1>
        <p>RaiseIT is a secure, transparent platform for students to raise complaints and track resolutions — all in one place.</p>
        <div class="hero-actions">
            <a href="${pageContext.request.contextPath}/register" class="btn-primary btn-lg">Get Started</a>
            <a href="${pageContext.request.contextPath}/login" class="btn-outline btn-lg">Login</a>
        </div>
    </div>
    <div class="hero-visual">
        <div class="hero-card">
            <div class="hero-card-header">
                <span class="badge badge-submitted">Submitted</span>
                <span class="hero-ref">RIT2026-00142</span>
            </div>
            <p class="hero-card-title">Unfair grading on Assignment 3</p>
            <p class="hero-card-meta">📁 Academic Affairs &nbsp;·&nbsp; 🔴 High Priority</p>
            <div class="hero-progress">
                <div class="hero-progress-bar"></div>
            </div>
            <p class="hero-card-status">⏳ Under review by staff</p>
        </div>
    </div>
</section>

<!-- FEATURES -->
<section class="features" id="features">
    <h2>Everything You Need</h2>
    <p class="section-sub">Built for students, managed by staff, overseen by admins.</p>
    <div class="features-grid">
        <div class="feature-card">
            <div class="feature-icon">📝</div>
            <h3>Submit Complaints</h3>
            <p>Raise academic, administrative, or facility complaints with full details and priority levels.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">🔍</div>
            <h3>Track in Real Time</h3>
            <p>Follow your complaint status from submitted → assigned → in progress → resolved.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">🔒</div>
            <h3>Anonymous Option</h3>
            <p>Submit sensitive complaints anonymously. Your identity stays protected.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">💬</div>
            <h3>Two-Way Messaging</h3>
            <p>Communicate directly with assigned staff through the complaint thread.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">📊</div>
            <h3>Admin Analytics</h3>
            <p>Admins get full visibility — complaint volumes, resolution times, staff performance.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">⭐</div>
            <h3>Rate Resolutions</h3>
            <p>Once resolved, give feedback so the institution can keep improving.</p>
        </div>
    </div>
</section>

<!-- HOW IT WORKS -->
<section class="how-it-works" id="how-it-works">
    <h2>How It Works</h2>
    <p class="section-sub">Three simple steps to get your complaint resolved.</p>
    <div class="steps">
        <div class="step">
            <div class="step-number">1</div>
            <h3>Register & Login</h3>
            <p>Create your student account and log in securely.</p>
        </div>
        <div class="step-arrow">→</div>
        <div class="step">
            <div class="step-number">2</div>
            <h3>Submit a Complaint</h3>
            <p>Fill in the details, set priority, and submit. You'll get a reference number instantly.</p>
        </div>
        <div class="step-arrow">→</div>
        <div class="step">
            <div class="step-number">3</div>
            <h3>Get It Resolved</h3>
            <p>Staff review and respond. Track progress and rate the outcome.</p>
        </div>
    </div>
</section>

<!-- CTA -->
<section class="cta">
    <h2>Ready to Raise Your Voice?</h2>
    <p>Join students already using RaiseIT to resolve their grievances fairly and transparently.</p>
    <a href="${pageContext.request.contextPath}/register" class="btn-primary btn-lg">Create Your Account</a>
</section>

<!-- FOOTER -->
<footer class="home-footer">
    <div class="footer-brand">Raise<span>IT</span></div>
    <p>© 2026 RaiseIT. Student Complaint & Grievance Management System.</p>
    <div class="footer-links">
        <a href="${pageContext.request.contextPath}/about">About</a>
        <a href="${pageContext.request.contextPath}/contact">Contact</a>
        <a href="${pageContext.request.contextPath}/login">Login</a>
        <a href="${pageContext.request.contextPath}/register">Register</a>
    </div>
</footer>

</body>
</html>
