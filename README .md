# Banana Powder Export Business — End-to-End Data Analytics Project

![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?logo=mysql&logoColor=white)
![Python](https://img.shields.io/badge/Python-3.9-green?logo=python&logoColor=white)
![Pandas](https://img.shields.io/badge/pandas-2.2-150458?logo=pandas&logoColor=white)
![Matplotlib](https://img.shields.io/badge/Matplotlib-3.9-orange)
![Tableau](https://img.shields.io/badge/Tableau-Dashboard-E97627?logo=tableau&logoColor=white)

A full-stack data analytics project modelling a real-world banana powder manufacturing and export business targeting the US market. Built to demonstrate end-to-end skills across relational database design, SQL analytics, Python data engineering, and Tableau business intelligence.

---

## Project Overview

This project covers the complete data lifecycle for a banana powder export operation — from raw database design to business insights and visual dashboards.

**Skills demonstrated:** MySQL · Python · pandas · matplotlib · Tableau · Git

---

## Repository Structure

```
Banana-Powder-Project/
├── Python Scripts/
│   ├── db_connect.py          # MySQL connection using .env credentials
│   ├── analysis.py            # Runs all 10 analytical queries via pandas
│   ├── visualize.py           # Generates 4 business charts using matplotlib
│   ├── chart1_investment.png  # Investment breakdown chart
│   ├── chart2_margins.png     # Pricing tier margin chart
│   ├── chart3_production.png  # Production scale profit chart
│   └── chart4_buyers.png      # Buyer relationship status chart
│
└── SQL Scripts/
    ├── 1.Banana_powder_Schema.sql       # DDL: all tables and constraints
    ├── 2.Banana_powder_seed_data.sql    # Seed data: realistic mock records
    ├── 3.Banana_powder_queries.sql      # 10 analytical business queries
    ├── 4_Banana_powder_Advanced_SQL.sql # Indexes, Views, Stored Procedure
    ├── Dashboard.png                    # Tableau dashboard screenshot
    ├── 5.Query_Output.png               # SQL query output verification
    └── 6.ER_Diagram.png                 # Entity-Relationship diagram
```

---

## Database Architecture

**7 tables · 6 indexes · 2 views · 1 stored procedure · FK constraints**

| Table | Purpose |
|---|---|
| `pricing_tiers` | Reference table — three pricing tiers with margin ranges |
| `buyers` | Master CRM — buyer companies, status, location, tier |
| `production_capacity` | Low / Mid / High scale with profit projections |
| `buyer_requirements` | Quality requirements per buyer |
| `machinery` | 7-stage production line from washing to packaging |
| `investment_breakdown` | Setup cost components with low/high estimates |
| `compliance_requirements` | FDA, USDA, APEDA regulatory checkpoints |

---

## Key Business Insights

1. **Organic Certified tier** offers the highest margin (35–45%) — strategic upgrade after initial market entry
2. **Mid-scale production** (1,000 kg/day) yields $8,000–$15,000 monthly profit with 8–14 month break-even
3. **2 of 5 buyers are already Active** — immediate revenue opportunity without new prospecting
4. **7 mandatory compliance checkpoints** must be cleared before first US export shipment

---

## Tableau Dashboard

Five interactive views: Buyer CRM · ROI Analysis · Pricing Tier Margin · Production Scale · Investment Breakdown

![Dashboard](SQL%20Scripts/Dashboard.png)

---

## How to Run

### Step 1 — Install dependencies
```bash
pip3 install mysql-connector-python pandas matplotlib seaborn python-dotenv
```

### Step 2 — Set up credentials
Create a `.env` file in the root folder:
```
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=banana_powder_business
```

### Step 3 — Set up database
Run SQL files in MySQL Workbench in this order:
1. `1.Banana_powder_Schema.sql`
2. `2.Banana_powder_seed_data.sql`
3. `3.Banana_powder_queries.sql`
4. `4_Banana_powder_Advanced_SQL.sql`

### Step 4 — Run Python analysis
```bash
cd "Python Scripts"
python3 analysis.py
```

### Step 5 — Generate charts
```bash
python3 visualize.py
```

---

## Author

**Keerthana Reddy Pogula**  
https://www.linkedin.com/in/keerthana-pogula/
