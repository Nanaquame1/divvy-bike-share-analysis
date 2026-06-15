# Divvy Bike Share — Rider Behaviour Analysis 2019

**How do Subscribers and Casual Customers use Divvy bikes differently?**

This project analyses 3.8 million bike-share rides from Chicago's Divvy network across all four quarters of 2019. The full pipeline runs from raw CSV ingestion into Google Cloud Storage, through BigQuery for cleaning and analysis, to interactive dashboards in both Looker Studio and Tableau.

---

## Dashboards

| Tool | Link |
|------|------|
| Looker Studio (BigQuery-connected) | [View dashboard](https://datastudio.google.com/s/nyrPGswkgTI) |
| Tableau Public | [View dashboard](https://public.tableau.com/views/DivvyBikeShareRiderBehaviourAnalysis2019/Dashboard1) |

---

## Project Pipeline

```
Raw CSV files (Q1–Q4 2019)
        ↓
Google Cloud Storage
        ↓
BigQuery — data inspection, cleaning, feature engineering
        ↓
Looker Studio — interactive dashboard
        ↓
Tableau — visual analysis
```

**Tools used:** Google Cloud Storage · BigQuery · Looker Studio · Tableau · SQL

---

## SQL Scripts

| File | Description |
|------|-------------|
| `01_data_inspection.sql` | Initial schema review, row counts, column types across all four quarterly tables |
| `02_null_duplicate_checks.sql` | Identifies NULL values, duplicate trip IDs, and data quality issues by quarter |
| `03_create_clean_table.sql` | Combines all four quarters, removes outlier rides, engineers new columns (`day_of_week`, `month_name`, `hour_of_day`, `ride_length_mins`, `age`) |
| `04_exploratory_analysis.sql` | Aggregations by usertype, time of day, day of week, month, and top stations |
| `05_export_queries.sql` | Final export queries used to feed the Looker Studio data source |

### Cleaning logic (`03_create_clean_table.sql`)

```sql
WHERE tripduration >= 60       -- removes sub-1-minute trips (false starts / test rides)
AND tripduration <= 10800      -- removes trips over 3 hours (lost / stolen bikes)
```

- Raw records: 3,818,004
- Cleaned records: **3,803,858** (removed 14,146 outlier rides)

---

## Key Findings

### Ride volume
- **77.1%** of all rides are by Subscribers; **22.9%** by Customers

### Ride duration
- Customers ride nearly **3× longer** on average: 35.29 mins vs 12.55 mins for Subscribers
- Subscribers take short, purposeful trips; Customers take longer leisure rides

### Time patterns
- **Subscribers** show a clear commuter pattern — two peaks at 8AM and 6PM on weekdays
- **Customers** ride throughout the day, peaking in the afternoon (~4–5PM) with no morning spike
- Subscriber rides are highest **Tuesday–Thursday**; Customer rides peak on **weekends**

### Seasonality
- Both groups peak in **summer (July–August)** and drop sharply in winter
- Customer usage nearly disappears in January–February; Subscribers remain more active year-round

### Top start station
- **Streeter Dr & Grand Ave** is the busiest station — heavily Customer-driven (52,663 Customer rides vs far fewer Subscriber rides), suggesting it is a tourist/leisure destination rather than a commuter hub

---

## Dataset

Source: [Divvy Trip Data](https://divvy-tripdata.s3.amazonaws.com/index.html) — Motivate International Inc. (public dataset, available under the [Divvy Data License Agreement](https://www.divvybikes.com/data-license-agreement))

Year: 2019 (Q1–Q4)
