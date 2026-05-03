# 🚴 Divvy Bike Share — Rider Behaviour Analysis (2019)
### Google Data Analytics Professional Certificate — Capstone Project

![Dashboard Preview](divvy_dashboard.png)

🔗 **[View Live Tableau Dashboard](YOUR_TABLEAU_PUBLIC_URL_HERE)**

---

## 📌 Project Background

Divvy is Chicago's public bike-share program operated by Lyft. The business goal of this analysis is to understand how **annual members (Subscribers)** and **casual riders (Customers)** use Divvy bikes differently — and to use those insights to inform a marketing strategy that converts more casual riders into long-term members.

This project was completed as the capstone for the **Google Data Analytics Professional Certificate**.

---

## ❓ Business Question

> **How do annual Subscribers and casual Customers use Divvy bikes differently — and what data-driven recommendations can help grow annual memberships?**

---

## 🗂️ Data Sources

- **Source:** Divvy public trip data — [divvybikes.com/system-data](https://divvybikes.com/system-data)
- **Period:** Full year 2019 — Q1, Q2, Q3, Q4
- **Raw records:** 3,818,004 trips across four quarterly CSV files
- **Tool used for storage:** Microsoft SQL Server Management Studio (SSMS)
- **Licence:** Public data made available by Motivate International Inc.

---

## 🛠️ Tools Used

| Stage | Tool |
|---|---|
| Data storage and querying | Microsoft SQL Server (SSMS) |
| Data cleaning and transformation | SQL |
| Exploratory analysis | SQL |
| Visualisation and dashboard | Tableau Public |
| Documentation | GitHub |

---

## 🧹 Data Cleaning Process

All four quarterly tables were loaded into SQL Server and the following cleaning steps were performed:

1. **Standardised column names** — Q2 had different column naming conventions and was renamed to match Q1, Q3 and Q4 using `EXEC sp_rename`
2. **Checked for NULLs** — Only `gender` (559,206 nulls) and `birthyear` (538,751 nulls) contained missing values across all quarters — expected for optional profile fields. All core trip columns were 100% complete
3. **Checked for duplicates** — Zero duplicate `trip_id` values found across all 3.8 million records
4. **Removed outliers** — 14,146 rides over 3 hours were removed as likely lost or stolen bikes. Zero rides under 1 minute existed in the raw data
5. **Combined all quarters** — Used `UNION ALL` to merge Q1–Q4 into a single clean master table: `all_trips_clean` (3,803,858 rows)
6. **Engineered new columns:**
   - `ride_length_mins` — trip duration in minutes
   - `ride_length_hms` — trip duration in HH:MM:SS format
   - `age` — calculated from birth year
   - `day_of_week` — extracted from start time
   - `month_name` — extracted from start time
   - `hour_of_day` — extracted from start time
   - `quarter` — extracted from start time

---

## 📊 Key Findings

### Finding 1 — Subscribers dominate volume, Customers ride longer

| User Type | Total Rides | % of Total | Avg Ride Duration |
|---|---|---|---|
| Subscriber | 2,934,736 | 77.15% | 12.55 mins |
| Customer | 869,122 | 22.85% | 35.29 mins |

Subscribers make up three quarters of all rides but their average trip is only 12.5 minutes — short, purposeful commutes. Customers ride nearly **3x longer** on average, suggesting leisure and exploratory use.

---

### Finding 2 — Opposite weekly patterns reveal commuter vs leisure behaviour

- **Subscribers** peak on **Tuesday–Thursday** and drop sharply on weekends
- **Customers** are flat on weekdays and surge dramatically on **Saturday**

This is the clearest behavioural signal in the dataset — Subscribers are weekday commuters, Customers are weekend leisure riders.

---

### Finding 3 — Subscribers show classic commute spikes by hour

- **Subscribers** have two sharp peaks at **8am** and **5pm** — the classic morning and evening commute pattern
- **Customers** have one broad hump from **10am–6pm** — consistent with leisure and tourism riding

---

### Finding 4 — Strong summer seasonality, Customers nearly vanish in winter

- Both user types peak in **July–August**
- **Customer rides drop by 97%** from August to January (184,345 → 4,550)
- **Subscriber rides drop by 66%** over the same period — showing far greater year-round commitment

---

### Finding 5 — Customer top stations are tourist destinations

Every one of the top 10 Customer start stations is a Chicago tourist or leisure location:
Streeter Dr & Grand Ave, Millennium Park, Shedd Aquarium, Lake Shore Dr, Adler Planetarium, Field Museum, Theater on the Lake.

Subscriber top stations are concentrated in the **downtown business district** — commuter hubs near offices and transit.

---

### Finding 6 — Demographics show opportunity in female and younger riders

| User Type | Gender | Rides | Avg Age |
|---|---|---|---|
| Subscriber | Male | 2,185,235 | 35.8 |
| Subscriber | Female | 725,828 | 34.1 |
| Customer | Male | 210,611 | 31.5 |
| Customer | Female | 130,006 | 30.0 |

Both groups are approximately 75% male. Casual Customers are slightly younger (avg 31) than Subscribers (avg 35). A significant gender gap exists across both user types — a clear opportunity for targeted campaigns.

---

## 💡 Business Recommendations

**1. Target casual weekend riders with commuter conversion campaigns**
Customers already love Divvy — they just use it differently. A "Try commuting with Divvy" campaign targeting weekend riders with a discounted first-month membership trial could convert high-frequency casual users.

**2. Run summer acquisition campaigns at tourist stations**
The top Customer stations are all tourist spots. On-bike QR codes and station signage at Streeter Dr, Millennium Park and the Lakefront during summer could drive membership sign-ups when casual ridership is at its peak.

**3. Launch female-targeted membership campaigns**
With only ~25% female ridership across both groups, campaigns focused on safety, community rides or female cycling groups could significantly grow the member base.

**4. Introduce flexible membership tiers for seasonal riders**
Since Customers nearly disappear in winter, a summer-only or weekend-only membership tier priced between single rides and annual membership could capture riders who won't commit to a full year.

**5. Optimise bike availability at commuter stations during peak hours**
Subscriber commute spikes at 8am and 5pm at downtown stations suggest high demand concentrated in short windows. Ensuring bike and dock availability at peak times improves member experience and retention.

---

## 📁 Repository Structure

```
divvy-bike-share-analysis/
│
├── README.md                        ← This file
├── divvy_analysis.png               ← Dashboard screenshot
│
├── sql/
│   ├── 01_data_inspection.sql       ← Preview and column checks
│   ├── 02_null_duplicate_checks.sql ← Data quality checks
│   ├── 03_create_clean_table.sql    ← Master clean table creation
│   ├── 04_exploratory_analysis.sql  ← All analysis queries
│   └── 05_export_queries.sql        ← Queries used for CSV exports
│
└── data/
    ├── divvy_user_summary.csv
    ├── divvy_day_of_week.csv
    ├── divvy_monthly.csv
    ├── divvy_hourly.csv
    ├── divvy_top_stations.csv
    └── divvy_demographics.csv
```

---

## 👤 Author

**Emmanuel Baah Gyan**
Data Analyst | Google Data Analytics Certificate

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue)](YOUR_LINKEDIN_URL)
[![Tableau](https://img.shields.io/badge/Tableau-View_Dashboard-orange)](YOUR_TABLEAU_PUBLIC_URL_HERE)

---

*Data made available by Motivate International Inc. under their public data licence.*
