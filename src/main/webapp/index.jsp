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
  <title>RaiseIT — Student Complaint Portal</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
  <style>
    *{margin:0;padding:0;box-sizing:border-box;}
    :root{
      --indigo:#5b52e8;
      --indigo-dark:#4338ca;
      --indigo-deeper:#2d2780;
      --indigo-light:#eeeeff;
      --indigo-mid:#c7c4f8;
      --purple:#8b5cf6;
      --white:#ffffff;
      --text:#1a1a2e;
      --text-light:#64648a;
      --bg:#f6f5ff;
      --card:#ffffff;
      --success:#10b981;
      --warning:#f59e0b;
      --danger:#ef4444;
    }
    html{scroll-behavior:smooth;}
    body{font-family:'DM Sans',sans-serif;color:var(--text);background:var(--bg);overflow-x:hidden;}

    /* NAV */
    nav{position:fixed;top:0;left:0;right:0;z-index:100;padding:0 5%;height:68px;display:flex;align-items:center;justify-content:space-between;background:rgba(255,255,255,0.97);backdrop-filter:blur(16px);border-bottom:1px solid rgba(79,70,229,0.12);box-shadow:0 1px 24px rgba(79,70,229,0.07);}
    .nav-logo{font-family:'Syne',sans-serif;font-size:22px;font-weight:800;color:var(--indigo-deeper);display:flex;align-items:center;gap:8px;}
    .nav-logo-dot{width:8px;height:8px;border-radius:50%;background:var(--indigo);display:inline-block;box-shadow:0 0 0 3px rgba(79,70,229,0.15);}
    .nav-logo span{color:var(--indigo);}
    .nav-links{display:flex;gap:4px;list-style:none;}
    .nav-links a{text-decoration:none;color:var(--text-light);font-size:14px;font-weight:500;padding:6px 14px;border-radius:8px;transition:all 0.2s;}
    .nav-links a:hover{color:var(--indigo);background:rgba(79,70,229,0.06);}
    .nav-actions{display:flex;gap:10px;align-items:center;}
    .nav-divider{width:1px;height:20px;background:rgba(79,70,229,0.15);margin:0 4px;}
    .btn-ghost{padding:8px 20px;border:1.5px solid rgba(79,70,229,0.25);border-radius:8px;background:transparent;color:var(--indigo);font-size:14px;font-weight:500;cursor:pointer;text-decoration:none;transition:all 0.2s;}
    .btn-ghost:hover{background:var(--indigo-light);border-color:var(--indigo);}
    .btn-primary{padding:8px 20px;border:none;border-radius:8px;background:var(--indigo);color:white;font-size:14px;font-weight:500;cursor:pointer;text-decoration:none;transition:all 0.2s;box-shadow:0 4px 14px rgba(79,70,229,0.3);}
    .btn-primary:hover{background:var(--indigo-dark);transform:translateY(-1px);box-shadow:0 6px 20px rgba(79,70,229,0.4);}

    /* HERO */
    .hero{min-height:100vh;display:flex;align-items:center;padding:68px 6% 0;position:relative;overflow:hidden;background:linear-gradient(145deg,#1e1960 0%,#2d2780 40%,#3d35a0 70%,#4c3db8 100%);}
    .hero-bg{position:absolute;inset:0;background:url('${pageContext.request.contextPath}/images/hero-section.png') center right/contain no-repeat;opacity:1;}
    .hero-overlay{position:absolute;inset:0;background:linear-gradient(90deg,rgba(30,27,75,0.6) 0%,rgba(30,27,75,0.1) 100%);}
    .hero-content{position:relative;z-index:2;max-width:520px;flex-shrink:0;}
    .hero-badge{display:inline-flex;align-items:center;gap:8px;padding:6px 14px;background:rgba(255,255,255,0.1);border:1px solid rgba(255,255,255,0.2);border-radius:100px;color:rgba(255,255,255,0.85);font-size:13px;font-weight:500;margin-bottom:28px;backdrop-filter:blur(8px);}
    .hero-badge-dot{width:7px;height:7px;border-radius:50%;background:#22c55e;animation:pulse 2s infinite;}
    @keyframes pulse{0%,100%{opacity:1;}50%{opacity:0.4;}}
    .hero h1{font-family:'Syne',sans-serif;font-size:clamp(40px,5vw,64px);font-weight:800;color:white;line-height:1.1;margin-bottom:20px;letter-spacing:-1px;}
    .hero h1 em{font-style:normal;color:#c4bfff;}
    .hero p{font-size:17px;color:rgba(255,255,255,0.7);line-height:1.7;margin-bottom:36px;font-weight:300;max-width:460px;}
    .hero-actions{display:flex;gap:14px;flex-wrap:wrap;}
    .btn-hero-primary{padding:14px 28px;background:linear-gradient(135deg,#6c63f5,#8b5cf6);color:white;border:none;border-radius:10px;font-size:15px;font-weight:500;cursor:pointer;text-decoration:none;display:inline-flex;align-items:center;gap:8px;transition:all 0.25s;font-family:'DM Sans',sans-serif;box-shadow:0 8px 24px rgba(108,99,245,0.4);}
    .btn-hero-primary:hover{background:linear-gradient(135deg,#5b52e8,#7c3aed);transform:translateY(-2px);box-shadow:0 14px 36px rgba(108,99,245,0.5);}
    .btn-hero-secondary{padding:14px 28px;background:rgba(255,255,255,0.1);color:white;border:1.5px solid rgba(255,255,255,0.25);border-radius:10px;font-size:15px;font-weight:500;cursor:pointer;text-decoration:none;backdrop-filter:blur(8px);transition:all 0.25s;font-family:'DM Sans',sans-serif;}
    .btn-hero-secondary:hover{background:rgba(255,255,255,0.18);border-color:rgba(255,255,255,0.4);}
    .hero-stats{display:flex;gap:36px;margin-top:52px;padding-top:36px;border-top:1px solid rgba(255,255,255,0.1);}
    .hero-stat-num{font-family:'Syne',sans-serif;font-size:26px;font-weight:700;color:white;}
    .hero-stat-label{font-size:13px;color:rgba(255,255,255,0.5);margin-top:2px;}

    /* FEATURES SECTION */
    .section{padding:96px 5%;background:#f8f7ff;}
    .section-label{font-size:13px;font-weight:600;color:var(--indigo);text-transform:uppercase;letter-spacing:2px;margin-bottom:12px;}
    .section-title{font-family:'Syne',sans-serif;font-size:clamp(28px,4vw,42px);font-weight:700;color:var(--text);line-height:1.2;margin-bottom:16px;}
    .section-sub{font-size:16px;color:var(--text-light);line-height:1.7;max-width:520px;}
    .features-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(280px,1fr));gap:20px;margin-top:56px;}
    .feature-card{background:white;border:1px solid rgba(91,82,232,0.09);border-radius:16px;padding:28px;transition:all 0.3s;position:relative;overflow:hidden;}
    .feature-card::before{content:'';position:absolute;top:0;left:0;right:0;height:3px;background:linear-gradient(90deg,#5b52e8,#8b5cf6);transform:scaleX(0);transition:transform 0.3s;transform-origin:left;}
    .feature-card:hover{transform:translateY(-4px);box-shadow:0 16px 48px rgba(91,82,232,0.1);border-color:rgba(91,82,232,0.18);}
    .feature-card:hover::before{transform:scaleX(1);}
    .feature-icon{width:48px;height:48px;border-radius:12px;background:linear-gradient(135deg,#eeeeff,#dddcff);display:flex;align-items:center;justify-content:center;margin-bottom:18px;}
    .feature-icon svg{width:22px;height:22px;stroke:#5b52e8;fill:none;stroke-width:2;stroke-linecap:round;stroke-linejoin:round;}
    .feature-title{font-family:'Syne',sans-serif;font-size:17px;font-weight:700;color:var(--text);margin-bottom:10px;}
    .feature-desc{font-size:14px;color:var(--text-light);line-height:1.65;}

    /* HOW IT WORKS */
    .how-section{padding:96px 5%;background:white;}
    .steps-container{display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:0;margin-top:56px;position:relative;}
    .steps-container::before{content:'';position:absolute;top:36px;left:10%;right:10%;height:1px;background:linear-gradient(90deg,transparent,#c7c4f8,transparent);z-index:0;}
    .step{text-align:center;padding:0 24px;position:relative;z-index:1;}
    .step-num{width:72px;height:72px;border-radius:50%;background:linear-gradient(135deg,#5b52e8,#8b5cf6);color:white;font-family:'Syne',sans-serif;font-size:24px;font-weight:800;display:flex;align-items:center;justify-content:center;margin:0 auto 20px;position:relative;box-shadow:0 8px 28px rgba(91,82,232,0.35);}
    .step-num::after{content:'';position:absolute;inset:-4px;border-radius:50%;border:1.5px dashed rgba(91,82,232,0.3);}
    .step-title{font-family:'Syne',sans-serif;font-size:16px;font-weight:700;color:var(--text);margin-bottom:10px;}
    .step-desc{font-size:14px;color:var(--text-light);line-height:1.6;}

    /* TESTIMONIAL / SOCIAL PROOF */
    .proof-section{padding:80px 5%;background:linear-gradient(145deg,#2d2780 0%,#3d35a0 50%,#4c3db8 100%);}
    .proof-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(260px,1fr));gap:20px;margin-top:48px;}
    .proof-card{background:rgba(255,255,255,0.09);border:1px solid rgba(255,255,255,0.15);border-radius:14px;padding:24px;backdrop-filter:blur(8px);}
    .proof-quote{font-size:15px;color:rgba(255,255,255,0.85);line-height:1.7;margin-bottom:18px;font-style:italic;}
    .proof-author{display:flex;align-items:center;gap:10px;}
    .proof-avatar{width:36px;height:36px;border-radius:50%;background:linear-gradient(135deg,#6c63f5,#8b5cf6);display:flex;align-items:center;justify-content:center;font-size:13px;font-weight:700;color:white;}
    .proof-name{font-size:13px;font-weight:600;color:white;}
    .proof-role{font-size:12px;color:rgba(196,191,255,0.7);}
    .stars{color:#fbbf24;font-size:13px;margin-bottom:12px;}

    /* CTA */
    .cta-section{padding:96px 5%;text-align:center;background:#f8f7ff;}
    .cta-box{background:linear-gradient(135deg,#eeeeff 0%,#e4e2ff 50%,#dddcff 100%);border:1px solid rgba(91,82,232,0.2);border-radius:24px;padding:72px 48px;position:relative;overflow:hidden;}
    .cta-box::before{content:'';position:absolute;top:-80px;right:-80px;width:280px;height:280px;border-radius:50%;background:rgba(139,92,246,0.12);}
    .cta-box::after{content:'';position:absolute;bottom:-60px;left:-60px;width:200px;height:200px;border-radius:50%;background:rgba(91,82,232,0.1);}
    .cta-title{font-family:'Syne',sans-serif;font-size:clamp(28px,4vw,44px);font-weight:800;color:#2d2780;margin-bottom:16px;position:relative;z-index:1;}
    .cta-sub{font-size:16px;color:#5b52e8;margin-bottom:36px;position:relative;z-index:1;opacity:0.85;}
    .cta-actions{display:flex;gap:14px;justify-content:center;flex-wrap:wrap;position:relative;z-index:1;}

    /* FOOTER */
    footer{padding:48px 5% 32px;border-top:1px solid rgba(91,82,232,0.08);background:white;}
    .footer-inner{display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:20px;}
    .footer-logo{font-family:'Syne',sans-serif;font-size:18px;font-weight:800;color:var(--text);}
    .footer-logo span{color:var(--indigo);}
    .footer-links{display:flex;gap:24px;list-style:none;}
    .footer-links a{font-size:14px;color:var(--text-light);text-decoration:none;transition:color 0.2s;}
    .footer-links a:hover{color:var(--indigo);}
    .footer-copy{font-size:13px;color:var(--text-light);}
  </style>
</head>
<body>

<!-- NAV -->
<nav>
  <div class="nav-logo"><span class="nav-logo-dot"></span>Raise<span>IT</span></div>
  <ul class="nav-links">
    <li><a href="#features">Features</a></li>
    <li><a href="#how">How It Works</a></li>
    <li><a href="${pageContext.request.contextPath}/faq">FAQ</a></li>
    <li><a href="${pageContext.request.contextPath}/about">About</a></li>
    <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
  </ul>
  <div class="nav-actions">
    <div class="nav-divider"></div>
    <a href="${pageContext.request.contextPath}/login" class="btn-ghost">Login</a>
    <a href="${pageContext.request.contextPath}/register" class="btn-primary">Register</a>
  </div>
</nav>

<!-- HERO -->
<section class="hero">
  <div class="hero-bg"></div>
  <div class="hero-overlay"></div>
  <div class="hero-content">
    <div class="hero-badge">
      <span class="hero-badge-dot"></span>
      Student Complaint Portal
    </div>
    <h1>Your Voice <em>Deserves</em> to Be Heard</h1>
    <p>RaiseIT is a secure, transparent platform for students to raise complaints and track resolutions — all in one place.</p>
    <div class="hero-actions">
      <a href="${pageContext.request.contextPath}/register" class="btn-hero-primary">
        Get Started
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
      </a>
      <a href="${pageContext.request.contextPath}/login" class="btn-hero-secondary">Login to Portal</a>
    </div>
    <div class="hero-stats">
      <div>
        <div class="hero-stat-num">3 Roles</div>
        <div class="hero-stat-label">Student · Staff · Admin</div>
      </div>
      <div>
        <div class="hero-stat-num">100%</div>
        <div class="hero-stat-label">Transparent Process</div>
      </div>
      <div>
        <div class="hero-stat-num">Real-time</div>
        <div class="hero-stat-label">Status Tracking</div>
      </div>
    </div>
  </div>
</section>

<!-- FEATURES -->
<section class="section" id="features">
  <div class="section-label">What We Offer</div>
  <div class="section-title">Everything You Need</div>
  <div class="section-sub">Built for students, managed by staff, overseen by admins — a complete grievance management system.</div>
  <div class="features-grid">
    <div class="feature-card">
      <div class="feature-icon">
        <svg viewBox="0 0 24 24"><path d="M14 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/></svg>
      </div>
      <div class="feature-title">Submit Complaints</div>
      <div class="feature-desc">Raise academic, administrative, or facility complaints with full details, category, and priority level.</div>
    </div>
    <div class="feature-card">
      <div class="feature-icon">
        <svg viewBox="0 0 24 24"><circle cx="11" cy="11" r="8"/><path d="M21 21l-4.35-4.35"/></svg>
      </div>
      <div class="feature-title">Track in Real Time</div>
      <div class="feature-desc">Follow your complaint status from submitted → assigned → in progress → resolved with full transparency.</div>
    </div>
    <div class="feature-card">
      <div class="feature-icon">
        <svg viewBox="0 0 24 24"><path d="M21 15a2 2 0 01-2 2H7l-4 4V5a2 2 0 012-2h14a2 2 0 012 2z"/></svg>
      </div>
      <div class="feature-title">Two-Way Messaging</div>
      <div class="feature-desc">Communicate directly with assigned staff through the complaint thread. Get updates instantly.</div>
    </div>
    <div class="feature-card">
      <div class="feature-icon">
        <svg viewBox="0 0 24 24"><rect x="3" y="3" width="18" height="18" rx="2"/><path d="M3 9h18M9 21V9"/></svg>
      </div>
      <div class="feature-title">Admin Analytics</div>
      <div class="feature-desc">Admins get full visibility — complaint volumes, resolution times, staff performance, and department breakdowns.</div>
    </div>
    <div class="feature-card">
      <div class="feature-icon">
        <svg viewBox="0 0 24 24"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>
      </div>
      <div class="feature-title">Anonymous Option</div>
      <div class="feature-desc">Submit sensitive complaints anonymously. Your identity stays fully protected from staff.</div>
    </div>
    <div class="feature-card">
      <div class="feature-icon">
        <svg viewBox="0 0 24 24"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/></svg>
      </div>
      <div class="feature-title">Rate Resolutions</div>
      <div class="feature-desc">Once resolved, leave feedback and ratings so the institution can continuously improve its services.</div>
    </div>
  </div>
</section>

<!-- HOW IT WORKS -->
<section class="how-section" id="how">
  <div style="text-align:center;">
    <div class="section-label">Simple Process</div>
    <div class="section-title">How It Works</div>
    <div class="section-sub" style="margin:0 auto;">Three simple steps to get your complaint resolved fairly and transparently.</div>
  </div>
  <div class="steps-container">
    <div class="step">
      <div class="step-num">1</div>
      <div class="step-title">Register & Login</div>
      <div class="step-desc">Create your student account and log in securely. Your data is always protected.</div>
    </div>
    <div class="step">
      <div class="step-num">2</div>
      <div class="step-title">Submit a Complaint</div>
      <div class="step-desc">Fill in the details, set priority, and submit. You'll receive a reference number instantly.</div>
    </div>
    <div class="step">
      <div class="step-num">3</div>
      <div class="step-title">Track & Resolve</div>
      <div class="step-desc">Staff reviews and responds. Track progress in real time and rate the outcome.</div>
    </div>
  </div>
</section>

<!-- SOCIAL PROOF -->
<section class="proof-section">
  <div style="text-align:center;">
    <div class="section-label" style="color:#c4bfff;">Student Voices</div>
    <div class="section-title" style="color:white;">Trusted by Students</div>
  </div>
  <div class="proof-grid">
    <div class="proof-card">
      <div class="stars">★★★★★</div>
      <div class="proof-quote">"My lab equipment complaint was resolved within 3 days. The thread messaging made it so easy to follow up."</div>
      <div class="proof-author">
        <div class="proof-avatar">KK</div>
        <div>
          <div class="proof-name">Karun Kafle</div>
          <div class="proof-role">BIT, 2nd Year</div>
        </div>
      </div>
    </div>
    <div class="proof-card">
      <div class="stars">★★★★★</div>
      <div class="proof-quote">"I used the anonymous option for a sensitive issue. The process was completely transparent and fair."</div>
      <div class="proof-author">
        <div class="proof-avatar">AS</div>
        <div>
          <div class="proof-name">Anish Shah</div>
          <div class="proof-role">BIT, 2nd Year</div>
        </div>
      </div>
    </div>
    <div class="proof-card">
      <div class="stars">★★★★☆</div>
      <div class="proof-quote">"The escalation feature was a game-changer. My complaint got priority attention when it was taking too long."</div>
      <div class="proof-author">
        <div class="proof-avatar">BK</div>
        <div>
          <div class="proof-name">Bhabishya Koirala</div>
          <div class="proof-role">BIT, 2nd Year</div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- CTA -->
<section class="cta-section">
  <div class="cta-box">
    <div class="cta-title">Ready to Raise Your Voice?</div>
    <div class="cta-sub">Join students already using RaiseIT to resolve their grievances fairly and transparently.</div>
    <div class="cta-actions">
      <a href="${pageContext.request.contextPath}/register" class="btn-hero-primary" style="background:linear-gradient(135deg,#5b52e8,#8b5cf6);box-shadow:0 8px 24px rgba(91,82,232,0.35);">Create Your Account</a>
      <a href="${pageContext.request.contextPath}/contact" class="btn-hero-secondary" style="background:white;color:#5b52e8;border-color:rgba(91,82,232,0.3);">Contact Us</a>
    </div>
  </div>
</section>

<!-- FOOTER -->
<footer>
  <div class="footer-inner">
    <div class="footer-logo">Raise<span>IT</span></div>
    <ul class="footer-links">
      <li><a href="${pageContext.request.contextPath}/about">About</a></li>
      <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
      <li><a href="${pageContext.request.contextPath}/faq">FAQ</a></li>
      <li><a href="${pageContext.request.contextPath}/login">Login</a></li>
      <li><a href="${pageContext.request.contextPath}/register">Register</a></li>
    </ul>
    <div class="footer-copy">© 2026 RaiseIT. Student Complaint & Grievance Management System.</div>
  </div>
</footer>

</body>
</html>
