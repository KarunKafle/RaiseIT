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
<title>RaiseIT — Student Grievance Portal</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
<style>
*{margin:0;padding:0;box-sizing:border-box;}
:root{
  --indigo:#4f46e5;
  --indigo-dark:#3730a3;
  --indigo-deeper:#1e1b4b;
  --indigo-light:#e0e7ff;
  --purple:#7c3aed;
  --white:#ffffff;
  --text:#1f2937;
  --text-light:#6b7280;
  --bg:#f8fafc;
  --card:#ffffff;
  --success:#22c55e;
  --warning:#f59e0b;
  --danger:#ef4444;
}
html{scroll-behavior:smooth;}
body{font-family:'DM Sans',sans-serif;color:var(--text);background:var(--bg);overflow-x:hidden;}

/* NAV */
nav{position:fixed;top:0;left:0;right:0;z-index:100;padding:0 5%;height:68px;display:flex;align-items:center;justify-content:space-between;background:rgba(255,255,255,0.92);backdrop-filter:blur(12px);border-bottom:1px solid rgba(79,70,229,0.1);}
.nav-logo{font-family:'Syne',sans-serif;font-size:22px;font-weight:800;color:var(--indigo-deeper);}
.nav-logo span{color:var(--indigo);}
.nav-links{display:flex;gap:32px;list-style:none;}
.nav-links a{text-decoration:none;color:var(--text-light);font-size:14px;font-weight:500;transition:color 0.2s;}
.nav-links a:hover{color:var(--indigo);}
.nav-actions{display:flex;gap:12px;align-items:center;}
.btn-ghost{padding:8px 20px;border:1.5px solid rgba(79,70,229,0.3);border-radius:8px;background:transparent;color:var(--indigo);font-size:14px;font-weight:500;cursor:pointer;text-decoration:none;transition:all 0.2s;}
.btn-ghost:hover{background:var(--indigo-light);}
.btn-primary{padding:8px 20px;border:none;border-radius:8px;background:var(--indigo);color:white;font-size:14px;font-weight:500;cursor:pointer;text-decoration:none;transition:all 0.2s;}
.btn-primary:hover{background:var(--indigo-dark);transform:translateY(-1px);}

/* HERO */
.hero{min-height:100vh;display:flex;align-items:center;padding:68px 5% 0;position:relative;overflow:hidden;background:var(--indigo-deeper);}
.hero-bg{position:absolute;inset:0;background:url('${pageContext.request.contextPath}/images/herosection.png') center/cover no-repeat;opacity:0.6;}
.hero-overlay{position:absolute;inset:0;background:linear-gradient(135deg,rgba(30,27,75,0.85) 45%,rgba(30,27,75,0.3) 100%);}
.hero-content{position:relative;z-index:2;max-width:580px;}
.hero-badge{display:inline-flex;align-items:center;gap:8px;padding:6px 14px;background:rgba(255,255,255,0.1);border:1px solid rgba(255,255,255,0.2);border-radius:100px;color:rgba(255,255,255,0.85);font-size:13px;font-weight:500;margin-bottom:28px;backdrop-filter:blur(8px);}
.hero-badge-dot{width:7px;height:7px;border-radius:50%;background:#22c55e;animation:pulse 2s infinite;}
@keyframes pulse{0%,100%{opacity:1;}50%{opacity:0.4;}}
.hero h1{font-family:'Syne',sans-serif;font-size:clamp(40px,5vw,64px);font-weight:800;color:white;line-height:1.1;margin-bottom:20px;letter-spacing:-1px;}
.hero h1 em{font-style:normal;color:#a5b4fc;}
.hero p{font-size:17px;color:rgba(255,255,255,0.7);line-height:1.7;margin-bottom:36px;font-weight:300;max-width:460px;}
.hero-actions{display:flex;gap:14px;flex-wrap:wrap;}
.btn-hero-primary{padding:14px 28px;background:var(--indigo);color:white;border:none;border-radius:10px;font-size:15px;font-weight:500;cursor:pointer;text-decoration:none;display:inline-flex;align-items:center;gap:8px;transition:all 0.25s;font-family:'DM Sans',sans-serif;}
.btn-hero-primary:hover{background:#4338ca;transform:translateY(-2px);box-shadow:0 12px 32px rgba(79,70,229,0.4);}
.btn-hero-secondary{padding:14px 28px;background:rgba(255,255,255,0.08);color:white;border:1.5px solid rgba(255,255,255,0.2);border-radius:10px;font-size:15px;font-weight:500;cursor:pointer;text-decoration:none;backdrop-filter:blur(8px);transition:all 0.25s;font-family:'DM Sans',sans-serif;}
.btn-hero-secondary:hover{background:rgba(255,255,255,0.15);}
.hero-stats{display:flex;gap:36px;margin-top:52px;padding-top:36px;border-top:1px solid rgba(255,255,255,0.1);}
.hero-stat-num{font-family:'Syne',sans-serif;font-size:26px;font-weight:700;color:white;}
.hero-stat-label{font-size:13px;color:rgba(255,255,255,0.5);margin-top:2px;}

/* FLOATING CARD */
.hero-visual{position:absolute;right:6%;top:50%;transform:translateY(-50%);z-index:2;width:320px;}
.glass-card{background:rgba(255,255,255,0.07);backdrop-filter:blur(20px);border:1px solid rgba(255,255,255,0.13);border-radius:16px;padding:20px;margin-bottom:14px;animation:floatY 4s ease-in-out infinite;}
@keyframes floatY{0%,100%{transform:translateY(0);}50%{transform:translateY(-8px);}}
.glass-card-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:14px;}
.glass-card-title{font-size:13px;color:rgba(255,255,255,0.5);font-weight:500;}
.status-badge{padding:3px 10px;border-radius:100px;font-size:11px;font-weight:600;}
.status-submitted{background:rgba(99,102,241,0.25);color:#a5b4fc;}
.status-resolved{background:rgba(34,197,94,0.2);color:#86efac;}
.status-progress{background:rgba(245,158,11,0.2);color:#fcd34d;}
.complaint-title{font-size:15px;font-weight:600;color:white;margin-bottom:8px;}
.complaint-meta{display:flex;gap:10px;font-size:12px;color:rgba(255,255,255,0.5);margin-bottom:14px;}
.progress-bar{height:4px;background:rgba(255,255,255,0.1);border-radius:100px;overflow:hidden;}
.progress-fill{height:100%;background:linear-gradient(90deg,var(--indigo),#a5b4fc);border-radius:100px;}
.mini-card{background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.1);border-radius:12px;padding:14px 16px;display:flex;align-items:center;gap:12px;animation:floatY 4s ease-in-out infinite;animation-delay:2s;}
.mini-avatar{width:36px;height:36px;border-radius:50%;background:linear-gradient(135deg,var(--indigo),var(--purple));display:flex;align-items:center;justify-content:center;font-size:13px;font-weight:600;color:white;flex-shrink:0;}
.mini-text{font-size:13px;color:rgba(255,255,255,0.7);}
.mini-time{font-size:11px;color:rgba(255,255,255,0.35);margin-top:2px;}

/* FEATURES SECTION */
.section{padding:96px 5%;}
.section-label{font-size:13px;font-weight:600;color:var(--indigo);text-transform:uppercase;letter-spacing:2px;margin-bottom:12px;}
.section-title{font-family:'Syne',sans-serif;font-size:clamp(28px,4vw,42px);font-weight:700;color:var(--indigo-deeper);line-height:1.2;margin-bottom:16px;}
.section-sub{font-size:16px;color:var(--text-light);line-height:1.7;max-width:520px;}
.features-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(280px,1fr));gap:24px;margin-top:56px;}
.feature-card{background:white;border:1px solid rgba(79,70,229,0.08);border-radius:16px;padding:28px;transition:all 0.3s;position:relative;overflow:hidden;}
.feature-card::before{content:'';position:absolute;top:0;left:0;right:0;height:3px;background:linear-gradient(90deg,var(--indigo),var(--purple));transform:scaleX(0);transition:transform 0.3s;transform-origin:left;}
.feature-card:hover{transform:translateY(-4px);box-shadow:0 20px 48px rgba(79,70,229,0.1);border-color:rgba(79,70,229,0.2);}
.feature-card:hover::before{transform:scaleX(1);}
.feature-icon{width:48px;height:48px;border-radius:12px;background:var(--indigo-light);display:flex;align-items:center;justify-content:center;margin-bottom:18px;}
.feature-icon svg{width:22px;height:22px;stroke:var(--indigo);fill:none;stroke-width:2;stroke-linecap:round;stroke-linejoin:round;}
.feature-title{font-family:'Syne',sans-serif;font-size:17px;font-weight:700;color:var(--indigo-deeper);margin-bottom:10px;}
.feature-desc{font-size:14px;color:var(--text-light);line-height:1.65;}

/* HOW IT WORKS */
.how-section{padding:96px 5%;background:white;}
.steps-container{display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:0;margin-top:56px;position:relative;}
.steps-container::before{content:'';position:absolute;top:36px;left:10%;right:10%;height:1px;background:linear-gradient(90deg,transparent,var(--indigo-light),transparent);z-index:0;}
.step{text-align:center;padding:0 24px;position:relative;z-index:1;}
.step-num{width:72px;height:72px;border-radius:50%;background:var(--indigo-deeper);color:white;font-family:'Syne',sans-serif;font-size:24px;font-weight:800;display:flex;align-items:center;justify-content:center;margin:0 auto 20px;position:relative;box-shadow:0 8px 24px rgba(79,70,229,0.3);}
.step-num::after{content:'';position:absolute;inset:-4px;border-radius:50%;border:1.5px dashed rgba(79,70,229,0.25);}
.step-title{font-family:'Syne',sans-serif;font-size:16px;font-weight:700;color:var(--indigo-deeper);margin-bottom:10px;}
.step-desc{font-size:14px;color:var(--text-light);line-height:1.6;}

/* TESTIMONIAL / SOCIAL PROOF */
.proof-section{padding:80px 5%;background:linear-gradient(135deg,var(--indigo-deeper),#312e81);}
.proof-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(260px,1fr));gap:20px;margin-top:48px;}
.proof-card{background:rgba(255,255,255,0.06);border:1px solid rgba(255,255,255,0.1);border-radius:14px;padding:24px;}
.proof-quote{font-size:15px;color:rgba(255,255,255,0.8);line-height:1.7;margin-bottom:18px;font-style:italic;}
.proof-author{display:flex;align-items:center;gap:10px;}
.proof-avatar{width:36px;height:36px;border-radius:50%;background:linear-gradient(135deg,var(--indigo),var(--purple));display:flex;align-items:center;justify-content:center;font-size:13px;font-weight:700;color:white;}
.proof-name{font-size:13px;font-weight:600;color:white;}
.proof-role{font-size:12px;color:rgba(255,255,255,0.4);}
.stars{color:#fbbf24;font-size:13px;margin-bottom:12px;}

/* CTA */
.cta-section{padding:96px 5%;text-align:center;}
.cta-box{background:var(--indigo-deeper);border-radius:24px;padding:72px 48px;position:relative;overflow:hidden;}
.cta-box::before{content:'';position:absolute;top:-80px;right:-80px;width:280px;height:280px;border-radius:50%;background:rgba(124,58,237,0.15);}
.cta-box::after{content:'';position:absolute;bottom:-60px;left:-60px;width:200px;height:200px;border-radius:50%;background:rgba(79,70,229,0.15);}
.cta-title{font-family:'Syne',sans-serif;font-size:clamp(28px,4vw,44px);font-weight:800;color:white;margin-bottom:16px;position:relative;z-index:1;}
.cta-sub{font-size:16px;color:rgba(255,255,255,0.6);margin-bottom:36px;position:relative;z-index:1;}
.cta-actions{display:flex;gap:14px;justify-content:center;flex-wrap:wrap;position:relative;z-index:1;}

/* FOOTER */
footer{padding:48px 5% 32px;border-top:1px solid rgba(79,70,229,0.08);}
.footer-inner{display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:20px;}
.footer-logo{font-family:'Syne',sans-serif;font-size:18px;font-weight:800;color:var(--indigo-deeper);}
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
  <div class="nav-logo">Raise<span>IT</span></div>
  <ul class="nav-links">
    <li><a href="#features">Features</a></li>
    <li><a href="#how">How It Works</a></li>
    <li><a href="${pageContext.request.contextPath}/faq">FAQ</a></li>
    <li><a href="${pageContext.request.contextPath}/about">About</a></li>
    <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
  </ul>
  <div class="nav-actions">
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
      Student Grievance Portal
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

  <!-- FLOATING COMPLAINT CARD -->
  <div class="hero-visual">
    <div class="glass-card">
      <div class="glass-card-header">
        <span class="glass-card-title">Latest Complaint</span>
        <span class="status-badge status-progress">In Progress</span>
      </div>
      <div class="complaint-title">Unfair Grading on Assignment 3</div>
      <div class="complaint-meta">
        <span>📁 Academic Affairs</span>
        <span>🔴 High Priority</span>
      </div>
      <div class="progress-bar"><div class="progress-fill" style="width:60%"></div></div>
      <div style="font-size:12px;color:rgba(255,255,255,0.4);margin-top:8px;">Under review by staff · RIT2026-00142</div>
    </div>
    <div class="mini-card">
      <div class="mini-avatar">AS</div>
      <div>
        <div class="mini-text">Staff replied to your complaint</div>
        <div class="mini-time">2 minutes ago</div>
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
    <div class="section-label" style="color:#a5b4fc;">Student Voices</div>
    <div class="section-title" style="color:white;">Trusted by Students</div>
  </div>
  <div class="proof-grid">
    <div class="proof-card">
      <div class="stars">★★★★★</div>
      <div class="proof-quote">"My lab equipment complaint was resolved within 3 days. The thread messaging made it so easy to follow up."</div>
      <div class="proof-author">
        <div class="proof-avatar">RK</div>
        <div>
          <div class="proof-name">Rohan K.</div>
          <div class="proof-role">BSc Computer Science, Year 2</div>
        </div>
      </div>
    </div>
    <div class="proof-card">
      <div class="stars">★★★★★</div>
      <div class="proof-quote">"I used the anonymous option for a sensitive issue. The process was completely transparent and fair."</div>
      <div class="proof-author">
        <div class="proof-avatar">PS</div>
        <div>
          <div class="proof-name">Priya S.</div>
          <div class="proof-role">BBA Finance, Year 3</div>
        </div>
      </div>
    </div>
    <div class="proof-card">
      <div class="stars">★★★★☆</div>
      <div class="proof-quote">"The escalation feature was a game-changer. My complaint got priority attention when it was taking too long."</div>
      <div class="proof-author">
        <div class="proof-avatar">AT</div>
        <div>
          <div class="proof-name">Anish T.</div>
          <div class="proof-role">BE Civil Engineering, Year 1</div>
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
      <a href="${pageContext.request.contextPath}/register" class="btn-hero-primary">Create Your Account</a>
      <a href="${pageContext.request.contextPath}/contact" class="btn-hero-secondary">Contact Us</a>
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
