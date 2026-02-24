# E-Commerce-Sales-Customer-Insights-Dashboard-ETL
End-to-end E-commerce analytics project using SQL, Python ETL automation, and Power BI dashboarding.

🛒 E-Commerce Sales & Customer Insights Dashboard with ETL Automation

An end-to-end analytics project combining SQL-driven analysis, automated Python ETL pipelines, and interactive Power BI storytelling to diagnose revenue trends, marketing efficiency, funnel bottlenecks, and customer retention performance in an e-commerce environment.

1️⃣ Project Overview

This project simulates a real-world e-commerce analytics workflow:

• Raw transactional data ingestion

• Relational database schema design

• Advanced SQL-based analytical querying

• Automated ETL processing using Python

• Business storytelling through an executive Power BI dashboard

The objective is to identify revenue drivers, uncover conversion bottlenecks, and deliver data-backed strategic recommendations.

2️⃣ Tech Stack

• 🗄 MySQL – Database design, indexing, and advanced analytical queries.

• 🐍 Python (Pandas) – ETL automation and data transformation.

• 🔄 SQL (Joins, Aggregations, Window Functions) – Funnel, cohort, and performance analysis.

• 📊 Power BI Desktop – Interactive dashboard and executive storytelling.

• 🧠 DAX – KPI calculations, retention metrics, and performance measures.

• 📁 CSV Files – Structured transactional datasets.

3️⃣ Data Architecture

Raw CSV Files
→ SQL Database (Schema + Constraints)
→ Python ETL Cleaning Layer
→ Analytical Tables
→ Power BI Data Model
→ Executive Dashboard

This layered architecture ensures scalability, reproducibility, and analytical clarity.

4️⃣ SQL Analytics Layer

The SQL layer was designed to replicate a real-world business analytics workflow.

Key components include:

• Monthly revenue and conversion trend analysis

• Funnel drop-off analysis (Sessions → Product → Cart → Billing → Orders)

• Channel-level revenue and conversion performance

• Cohort-style retention analysis

• Refund impact assessment

• Revenue concentration (Pareto logic)

• Performance ranking using window functions

All SQL scripts are available in the /sql directory.

5️⃣ ETL Automation (Python)

The ETL pipeline performs:

• Duplicate removal

• Date standardization

• Null handling and attribution cleanup

• Profit calculation

• Referential integrity validation

• Clean dataset generation for BI layer

Automation ensures the entire transformation layer can be reproduced efficiently.

ETL scripts are available in the /etl directory.

6️⃣ Dashboard Overview
Project Title

E-Commerce Sales & Customer Insights Dashboard

An executive-focused, story-driven Power BI report designed to evaluate revenue performance, marketing efficiency, funnel health, and retention quality.

Purpose:

The dashboard enables stakeholders to:

• Understand revenue fluctuations

• Identify scalable acquisition channels

• Diagnose funnel leakage points

• Compare mobile vs desktop performance

• Evaluate retention strength

• Support data-driven budget allocation decisions

Dashboard Structure
Page 1 — Executive Overview

• Total Revenue

• Total Orders

• Conversion Rate

• Average Order Value

• Revenue Trend

• Traffic Trend

• Revenue per Session Trend

Page 2 — Marketing Intelligence

• Channel Revenue Contribution

• Channel Conversion Performance

• Channel Ranking

Performance Matrix (Scale vs Efficiency)

Page 3 — Funnel Analysis

• Step-wise Drop-off

• Product → Cart Leakage

• Device-Level Funnel Comparison

• Monthly Funnel Trend

Page 4 — Customer Retention

• Cohort Retention Matrix

• Repeat Purchase Rate

• Retention Strength Index

• High-Value Customer Segmentation

Page 5 — Strategic Growth Assessment

• Revenue Concentration (Pareto Analysis)

• Channel Performance Matrix

• Retention Quality Comparison

• Growth Bottleneck Identification

7️⃣ Key Business Insights

• Revenue softness observed was primarily traffic-driven.

• Paid search (gsearch) emerged as the dominant scalable revenue engine.

• Largest funnel drop-off occurred between Product and Cart stages.

• Mobile conversion significantly trailed desktop performance.

• Retention strength varied meaningfully by acquisition channel.

8️⃣ Strategic Recommendations

• Scale high-performing paid search channels with controlled ROI monitoring

• Optimize product page UX to reduce cart drop-off

• Improve mobile checkout experience

• Audit traffic attribution to correct channel measurement

• Strengthen lifecycle marketing to improve repeat revenue contribution

9️⃣ Data & Dashboard Access

Due to file size constraints, full datasets and the Power BI dashboard file are hosted externally.

🔗 Raw Dataset:
https://drive.google.com/drive/folders/1lUH4B0RT3cBkZvL4fEUgq7lYeqNzILr5?usp=sharing

🔗 Cleaned Analytical Dataset:
https://drive.google.com/drive/folders/1EovqNjzN2jTwcuVYn4npgqIo4LhDHLDn?usp=sharing

🔗 Power BI Dashboard (.pbix file):
https://drive.google.com/file/d/1yPxO8G4sJKYlIhuND4gYA6V4UNFBRYE8/view?usp=sharing

All transformation logic and analytical queries required to reproduce the results are available within this repository.

🔟 Repository Structure

sql/        → Database schema & analytical queries  
etl/        → Python ETL automation scripts  
powerbi/    → Dashboard screenshots  
images/     → Supporting visuals  
README.md   → Project documentation  
.gitignore  → File exclusion configuration  

1️⃣1️⃣ Project Value

This project demonstrates:

• SQL proficiency for analytical reporting

• ETL pipeline design using Python

• Data modeling and DAX implementation

• Business-oriented dashboard storytelling

• Strategic thinking beyond visualization
