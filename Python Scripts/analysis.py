import pandas as pd
import sys
import os

sys.path.append(os.path.dirname(__file__))
from db_connect import get_connection

def run_query(conn, title, sql):
    print(f"\n{'='*60}")
    print(f"  {title}")
    print('='*60)
    df = pd.read_sql(sql, conn)
    print(df.to_string(index=False))

def main():
    conn = get_connection()

    run_query(conn, "Q1: Buyers Ranked by Priority", """
        SELECT priority_rank, company_name, buyer_type,
               CONCAT(location_state, ', ', location_country) AS location,
               relationship_status
        FROM buyers ORDER BY priority_rank ASC
    """)

    run_query(conn, "Q2: Buyer Count by Relationship Status", """
        SELECT relationship_status, COUNT(*) AS buyer_count,
               GROUP_CONCAT(company_name SEPARATOR ', ') AS companies
        FROM buyers GROUP BY relationship_status
    """)

    run_query(conn, "Q3: Production Line Process Flow", """
        SELECT process_stage, machine_name, operating_range, output_spec,
               IF(is_critical, 'Critical', 'Optional') AS importance
        FROM machinery ORDER BY process_stage ASC
    """)

    run_query(conn, "Q4: Investment Breakdown", """
        SELECT component,
               CONCAT('$', FORMAT(cost_usd_low, 0)) AS low_estimate,
               CONCAT('$', FORMAT((cost_usd_low + cost_usd_high)/2, 0)) AS midpoint,
               CONCAT('$', FORMAT(cost_usd_high, 0)) AS high_estimate
        FROM investment_breakdown WHERE component != 'Total Investment'
    """)

    run_query(conn, "Q5: Pricing Tiers Best Margin", """
        SELECT tier_name,
               CONCAT('$', price_usd_low, ' - $', price_usd_high, '/kg') AS price_range,
               (margin_pct_low + margin_pct_high) / 2 AS avg_margin_pct
        FROM pricing_tiers ORDER BY avg_margin_pct DESC
    """)

    run_query(conn, "Q6: Mandatory Compliance Requirements", """
        SELECT authority, regulation_name, target_market
        FROM compliance_requirements WHERE requirement_type = 'Mandatory'
    """)

    run_query(conn, "Q7: Production Scale Comparison", """
        SELECT capacity_level, input_kg_day,
               CONCAT(output_kg_day_low, ' - ', output_kg_day_high, ' kg') AS daily_output,
               CONCAT('$', FORMAT(monthly_profit_low, 0), ' - $', FORMAT(monthly_profit_high, 0)) AS monthly_profit
        FROM production_capacity ORDER BY input_kg_day ASC
    """)

    run_query(conn, "Q8: Total Investment Range", """
        SELECT CONCAT('$', FORMAT(cost_usd_low, 0)) AS min_investment,
               CONCAT('$', FORMAT((cost_usd_low + cost_usd_high)/2, 0)) AS midpoint,
               CONCAT('$', FORMAT(cost_usd_high, 0)) AS max_investment
        FROM investment_breakdown WHERE component = 'Total Investment'
    """)

    run_query(conn, "Q9: Buyer Requirements", """
        SELECT requirement, description,
               IF(is_mandatory, 'MUST HAVE', 'NICE TO HAVE') AS priority
        FROM buyer_requirements ORDER BY is_mandatory DESC
    """)

    run_query(conn, "Q10: ROI at Mid Scale Production", """
        SELECT pt.tier_name, pc.capacity_level,
               ROUND(pc.output_kg_day_low * 22 * pt.price_usd_low, 2) AS revenue_conservative,
               ROUND(pc.output_kg_day_high * 22 * pt.price_usd_high, 2) AS revenue_optimistic
        FROM pricing_tiers pt CROSS JOIN production_capacity pc
        WHERE pc.capacity_level = 'Mid'
        ORDER BY revenue_optimistic DESC
    """)

    conn.close()
    print("\n All 10 queries completed successfully!")

if __name__ == "__main__":
    main()