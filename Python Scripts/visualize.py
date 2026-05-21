import pandas as pd
import matplotlib.pyplot as plt
import sys
import os

sys.path.append(os.path.dirname(__file__))
from db_connect import get_connection

conn = get_connection()

# Chart 1: Investment Breakdown
df1 = pd.read_sql("""
    SELECT component, (cost_usd_low + cost_usd_high) / 2 AS midpoint
    FROM investment_breakdown WHERE component != 'Total Investment'
""", conn)

plt.figure(figsize=(8, 5))
bars = plt.bar(df1["component"], df1["midpoint"],
               color=["#2196F3", "#FF9800", "#4CAF50", "#E91E63"])
for bar, val in zip(bars, df1["midpoint"]):
    plt.text(bar.get_x() + bar.get_width()/2, bar.get_height() + 500,
             f"${val:,.0f}", ha="center", fontsize=9)
plt.title("Investment Breakdown (Midpoint Estimate)", fontsize=13, fontweight="bold")
plt.ylabel("Cost (USD)")
plt.xticks(rotation=15, ha="right")
plt.tight_layout()
plt.savefig("chart1_investment.png", dpi=150)
plt.show()
print("Chart 1 saved!")

# Chart 2: Pricing Tier Margins
df2 = pd.read_sql("""
    SELECT tier_name, (margin_pct_low + margin_pct_high) / 2 AS avg_margin
    FROM pricing_tiers ORDER BY avg_margin ASC
""", conn)

plt.figure(figsize=(7, 4))
bars = plt.barh(df2["tier_name"], df2["avg_margin"],
                color=["#4CAF50", "#FF9800", "#2196F3"])
for bar, val in zip(bars, df2["avg_margin"]):
    plt.text(val + 0.3, bar.get_y() + bar.get_height()/2,
             f"{val:.1f}%", va="center", fontsize=10)
plt.title("Average Margin by Pricing Tier", fontsize=13, fontweight="bold")
plt.xlabel("Average Margin (%)")
plt.tight_layout()
plt.savefig("chart2_margins.png", dpi=150)
plt.show()
print("Chart 2 saved!")

# Chart 3: Monthly Profit by Production Scale
df3 = pd.read_sql("""
    SELECT capacity_level, monthly_profit_low, monthly_profit_high
    FROM production_capacity ORDER BY monthly_profit_low ASC
""", conn)

x = range(len(df3))
width = 0.35
plt.figure(figsize=(7, 5))
b1 = plt.bar([i - width/2 for i in x], df3["monthly_profit_low"],
             width, label="Low Estimate", color="#2196F3")
b2 = plt.bar([i + width/2 for i in x], df3["monthly_profit_high"],
             width, label="High Estimate", color="#4CAF50")
for bar, val in zip(b1, df3["monthly_profit_low"]):
    plt.text(bar.get_x() + bar.get_width()/2, bar.get_height() + 200,
             f"${val:,.0f}", ha="center", fontsize=8)
for bar, val in zip(b2, df3["monthly_profit_high"]):
    plt.text(bar.get_x() + bar.get_width()/2, bar.get_height() + 200,
             f"${val:,.0f}", ha="center", fontsize=8)
plt.xticks(list(x), df3["capacity_level"])
plt.title("Monthly Profit by Production Scale", fontsize=13, fontweight="bold")
plt.ylabel("Monthly Profit (USD)")
plt.legend()
plt.tight_layout()
plt.savefig("chart3_production.png", dpi=150)
plt.show()
print("Chart 3 saved!")

# Chart 4: Buyers by Relationship Status
df4 = pd.read_sql("""
    SELECT relationship_status, COUNT(*) AS count
    FROM buyers GROUP BY relationship_status
""", conn)

plt.figure(figsize=(6, 5))
plt.pie(df4["count"], labels=df4["relationship_status"],
        autopct="%1.0f%%", colors=["#2196F3", "#FF9800", "#4CAF50"],
        startangle=140)
plt.title("Buyers by Relationship Status", fontsize=13, fontweight="bold")
plt.tight_layout()
plt.savefig("chart4_buyers.png", dpi=150)
plt.show()
print("Chart 4 saved!")

conn.close()
print("\nAll 4 charts saved successfully!")