-- ============================================================
-- ANALYTICAL QUERIES: Banana Powder Business
-- ============================================================
 
USE banana_powder_business;
 
-- ----------------------------
-- Q1: CRM — Buyers ranked by priority with relationship status
-- ----------------------------
SELECT
    priority_rank,
    company_name,
    buyer_type,
    CONCAT(location_state, ', ', location_country)  AS location,
    relationship_status,
    specialty
FROM buyers
ORDER BY priority_rank ASC;
 
-- ----------------------------
-- Q2: Which buyers are already Active vs still Leads/Prospects?
-- ----------------------------
SELECT
    relationship_status,
    COUNT(*)                                        AS buyer_count,
    GROUP_CONCAT(company_name ORDER BY priority_rank SEPARATOR ', ') AS companies
FROM buyers
GROUP BY relationship_status
ORDER BY buyer_count DESC;
 
-- ----------------------------
-- Q3: Production line — full process flow
-- ----------------------------
SELECT
    process_stage,
    machine_name,
    operating_range,
    output_spec,
    IF(is_critical, 'Critical', 'Optional')         AS importance
FROM machinery
ORDER BY process_stage ASC;
 
-- ----------------------------
-- Q4: Investment — low vs high estimate per component (FIXED MIDPOINT)
-- ----------------------------
SELECT
    component,
    CONCAT('$', FORMAT(cost_usd_low, 0))            AS low_estimate,
    CONCAT('$', FORMAT(cost_usd_high, 0))           AS high_estimate,
    CONCAT('$', FORMAT((cost_usd_low + cost_usd_high) / 2, 0)) AS midpoint,
    notes
FROM investment_breakdown
WHERE component != 'Total Investment'
ORDER BY (cost_usd_low + cost_usd_high) / 2 DESC;
 
-- ----------------------------
-- Q5: Which pricing tier gives the best margin?
-- ----------------------------
SELECT
    tier_name,
    CONCAT('$', price_usd_low, ' – $', price_usd_high, '/kg')  AS price_range,
    CONCAT(margin_pct_low, '% – ', margin_pct_high, '%')        AS margin_range,
    (margin_pct_low + margin_pct_high) / 2                       AS avg_margin_pct,
    target_buyer
FROM pricing_tiers
ORDER BY avg_margin_pct DESC;
 
-- ----------------------------
-- Q6: Compliance checklist — mandatory requirements only
-- ----------------------------
SELECT
    authority,
    regulation_name,
    requirement_type,
    target_market,
    description
FROM compliance_requirements
WHERE requirement_type = 'Mandatory'
ORDER BY target_market, authority;
 
-- ----------------------------
-- Q7: Production scale comparison — output and profitability
-- ----------------------------
SELECT
    capacity_level,
    input_kg_day,
    CONCAT(output_kg_day_low, ' – ', output_kg_day_high, ' kg') AS daily_output_range,
    CONCAT(yield_pct_low, '% – ', yield_pct_high, '%')          AS yield_range,
    CONCAT('$', FORMAT(monthly_profit_low, 0), ' – $', FORMAT(monthly_profit_high, 0)) AS monthly_profit_range,
    CONCAT(breakeven_months_low, ' – ', breakeven_months_high, ' months')  AS breakeven_range
FROM production_capacity
ORDER BY input_kg_day ASC;
 
-- ----------------------------
-- Q8: Total investment range (FIXED MIDPOINT)
-- ----------------------------
SELECT
    CONCAT('$', FORMAT(cost_usd_low, 0))            AS min_investment,
    CONCAT('$', FORMAT(cost_usd_high, 0))           AS max_investment,
    CONCAT('$', FORMAT((cost_usd_low + cost_usd_high) / 2, 0)) AS midpoint_investment
FROM investment_breakdown
WHERE component = 'Total Investment';
 
-- ----------------------------
-- Q9: Mandatory buyer requirements — what must we meet to sell to the US?
-- ----------------------------
SELECT
    requirement,
    description,
    IF(is_mandatory, 'MUST HAVE', 'NICE TO HAVE')   AS priority
FROM buyer_requirements
ORDER BY is_mandatory DESC, requirement;
 
-- ----------------------------
-- Q10: ROI potential — best pricing tier at mid-scale production (FIXED MIDPOINT)
-- ----------------------------
SELECT 
    pt.tier_name,
    pc.capacity_level,
    pc.output_kg_day_low * 22 AS monthly_output_kg_low,
    ROUND(pc.output_kg_day_low * 22 * pt.price_usd_low,
            2) AS monthly_revenue_conservative,
    ROUND(pc.output_kg_day_high * 22 * pt.price_usd_high,
            2) AS monthly_revenue_optimistic,
    CONCAT('$',
            FORMAT(pc.monthly_profit_low, 0),
            ' – $',
            FORMAT(pc.monthly_profit_high, 0)) AS expected_monthly_profit
FROM
    pricing_tiers pt
        CROSS JOIN
    production_capacity pc
WHERE
    pc.capacity_level = 'Mid'
ORDER BY (pt.price_usd_low + pt.price_usd_high) / 2 DESC
