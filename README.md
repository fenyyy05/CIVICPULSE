# CivicPulse — Smart City Civic Intelligence Platform

> **"Every report tells a story. Every location reveals a pattern. Every action makes a city better."**

CivicPulse is a smart-city civic issue reporting, explainable prioritization, and hotspot analytics platform built with **ASP.NET Core MVC**, **Entity Framework Core**, **MySQL**, **ASP.NET Core Identity**, **Leaflet OpenStreetMap**, and **Chart.js**.

---

## 🌟 Key Features

### 1. Operations Command Center (`/Dashboard`)
- **Real-Time Telemetry Cards**: Total Reports, Open Active Queue, High-Priority Hazards, Resolved Incidents, and calculated Average Resolution Time.
- **Embedded City Density Map**: Live interactive Leaflet map previewing problem clusters with priority-colored pins.
- **14-Day Velocity Trend Chart**: Chart.js visualization comparing daily report volume against municipal resolution rates.
- **Category Breakdown & Priority Tiers**: Interactive donut chart and visual meters classifying issues into Critical (75–100), High (50–74), Medium (25–49), and Low (0–24) bands.
- **Needs Attention Queue & Recurring Hotspots**: Immediate visibility into aging or high-hazard reports requiring field dispatch.

### 2. Interactive City Map (`/Map`)
- Full-screen Leaflet & OpenStreetMap geospatial intelligence workspace.
- Multi-faceted filter drawer: Filter by infrastructure category, priority tier, lifecycle status, and city sector.
- Interactive circle markers with rich popups (tracking code, severity, thumbnail photo, priority score, and quick details link).
- Visual color-coded priority legend.

### 3. Citizen Report Intake (`/Issues/Create`)
- Multi-section guided submission workflow:
  1. **Issue Details**: Title, description, category selector, and 1–5 severity scale.
  2. **Location Pinpoint**: Area/Ward input, address, and interactive Leaflet map picker (click anywhere to pin GPS coordinates or use the browser geolocation API).
  3. **Visual Evidence**: Safe photo upload (JPG, PNG, WebP < 5MB) with live client-side preview.
- Server-side and client-side validation against malicious payloads and oversized files.

### 4. Explainable 0–100 Priority Engine
Unlike black-box algorithms, CivicPulse scores every issue transparently:
- **Public Safety Hazard**: 0–40 points (derived from category hazard weights).
- **Reported Severity**: 0–30 points (scaled by user-reported 1–5 severity).
- **Aging & Waiting Time**: 0–20 points (scaled by days elapsed since intake).
- **Community Endorsement**: 0–10 points (2 points per citizen upvote).
- **Total**: Capped at 100 points, determining the priority tier and dispatch urgency.

### 5. Geospatial Duplicate Detection
- Compares new submissions against active issues using the Haversine formula (proximity < 200m) and lexical title overlap.
- Flags potential duplicates with explanatory notes while preserving citizen reports for audit review.

### 6. Chronological Audit History & Lifecycle Workflow
- State machine: `Submitted` → `Verified` → `Assigned` → `InProgress` → `Resolved` (or `Rejected`).
- Every transition logs the responsible user, timestamp, and dispatch comments in an immutable audit timeline.
- Role-gated actions for municipal staff and operations directors.

### 7. Hotspot & Spatial Analytics (`/Analytics`)
- "Patterns Across the City" analytical workspace.
- **Area & Category Correlation Matrix**: Cross-tabulated frequency table revealing localized infrastructure patterns.
- Sector hotspot index rankings based on active report count and overdue durations (> 7 days).

### 8. Role-Based Administration (`/Admin`)
- Category configuration (icons, colors, hazard safety weights).
- User governance (promote between Citizen, Staff, and Admin roles).
- 1-Click live demonstration test data generator.

---

## 👥 Demonstration Accounts

The platform includes pre-configured persona accounts for testing (available via 1-click quick-fill buttons on the login screen):

| Persona | Email | Password | Role | Permissions |
| :--- | :--- | :--- | :--- | :--- |
| **Dr. Elena Vance** | `admin@civicpulse.org` | `Admin@123` | **Admin** | Full system governance, category editing, user role promotion, data seeding |
| **Marcus Thorne** | `staff@civicpulse.org` | `Staff@123` | **Staff** | Status workflows, staff assignment, duplicate review, operations notes |
| **David Miller** | `citizen@civicpulse.org` | `Citizen@123` | **Citizen** | Report issues, upload photos, track personal submissions, endorse issues |

---

## 🛠️ Technology Stack & Architecture

- **Backend Framework**: ASP.NET Core MVC (.NET 8 LTS / .NET 10 compatible)
- **Object-Relational Mapping (ORM)**: Entity Framework Core 8.0
- **Database**: MySQL Server (using Pomelo.EntityFrameworkCore.MySql with utf8 index optimization)
- **Authentication & Security**: ASP.NET Core Identity with role-based authorization and Anti-Forgery tokens
- **Frontend / Styling**: Vanilla CSS design tokens (`civicpulse.css`), Bootstrap 5, Bootstrap Icons
- **Mapping & Charts**: Leaflet 1.9.4 with OpenStreetMap tiles, Chart.js 4.4

---

## 🚀 Setup & Execution Instructions

### Prerequisites
1. .NET 8 or 10 SDK (`dotnet --version`)
2. MySQL Server running on `localhost:3306` (default user: `root`, password: empty, or configure in `appsettings.json`)

### Running the Application

1. **Clone or open the directory**:
   ```bash
   cd c:\Users\fenit\OneDrive\Desktop\CIVICPULSE
   ```

2. **Restore dependencies**:
   ```bash
   dotnet restore
   ```

3. **Database Migration & Seeding**:
   The application automatically applies EF Core migrations and seeds initial accounts, categories, and test issues upon startup.
   Alternatively, run manually:
   ```bash
   dotnet ef database update
   ```

4. **Launch the web application**:
   ```bash
   dotnet run --launch-profile http
   ```

5. **Open in Browser**:
   Navigate to [http://localhost:5000](http://localhost:5000)

---

## 📋 Test Verification Summary

| Test Case | Method | Result | Notes |
| :--- | :--- | :--- | :--- |
| **Compilation & Build** | `dotnet build` | **PASS** | 0 Warnings, 0 Errors |
| **Database Migrations** | EF Core + MySQL | **PASS** | Tables created cleanly with index length safeguards |
| **Database Seeding** | Startup Initializer | **PASS** | Roles, users, categories, and 8 seed issues initialized |
| **Landing Page** | Browser Subagent | **PASS** | Hero section, metrics preview, 3-step workflow rendered |
| **Operations Dashboard** | Browser Subagent | **PASS** | Metric cards, Leaflet map, Chart.js line/donut charts verified |
| **Interactive City Map** | Browser Subagent | **PASS** | Filters, popup cards, and circle markers verified |
| **Issue Submission** | Browser Subagent | **PASS** | Submitted Issue #CP-2026-5889, persisted to MySQL |
| **Priority Engine** | Unit calculation | **PASS** | 54/100 score calculated with safety, severity, aging, and vote points |
| **Audit Timeline** | MySQL Query | **PASS** | Transition and intake recorded with user identity and timestamp |
| **Authentication & Roles** | Browser Subagent | **PASS** | 1-click demo logins verified; Admin workspace role-gated |
| **Hotspot Analytics** | Browser Subagent | **PASS** | Area-Category correlation matrix and velocity charts verified |
