-- ============================================================
-- BANANA POWDER BUSINESS — Advanced SQL
-- File 4: Indexes + Views + Stored Procedure
-- Author: Keerthana Reddy Pogula
-- Run this AFTER files 1, 2, and 3
-- ============================================================

USE banana_powder_business;

-- ============================================================
-- SECTION 1: INDEXES
-- What is an index? It helps MySQL find data faster.
-- Think of it like the index at the back of a textbook —
-- instead of reading every page, you jump straight to the answer.
-- ============================================================

-- Speeds up JOIN between buyers and pricing_tiers
CREATE INDEX idx_buyers_tier_id
    ON buyers(tier_id);

-- Speeds up filtering buyers by Active / Prospect / Lead
CREATE INDEX idx_buyers_status
    ON buyers(relationship_status);

-- Speeds up JOIN between buyer_requirements and buyers
CREATE INDEX idx_buyer_req_buyer_id
    ON buyer_requirements(buyer_id);

-- Speeds up compliance queries filtered by Mandatory / Recommended
CREATE INDEX idx_compliance_type
    ON compliance_requirements(requirement_type);

-- Speeds up filtering compliance by country (USA / India)
CREATE INDEX idx_compliance_market
    ON compliance_requirements(target_market);

-- Speeds up sorting machinery by process stage
CREATE INDEX idx_machinery_stage
    ON machinery(process_stage);


-- ============================================================
-- SECTION 2: VIEWS
-- What is a view? It is a saved query with a name.
-- Instead of writing a long JOIN every time, you just say:
-- SELECT * FROM buyer_pricing_summary;
-- and MySQL runs the JOIN for you automatically.
-- ============================================================

-- VIEW 1: buyer_pricing_summary
-- Shows each buyer alongside their pricing tier and margin.
-- Useful for sales team to quickly see buyer + price info together.
CREATE VIEW buyer_pricing_summary AS
SELECT
    b.buyer_id,
    b.company_name,
    b.buyer_type,
    CONCAT(b.location_state, ', ', b.location_country) AS location,
    b.relationship_status,
    b.priority_rank,
    pt.tier_name,
    CONCAT('$', pt.price_usd_low, ' – $', pt.price_usd_high, '/kg') AS price_range,
    CONCAT(pt.margin_pct_low, '% – ', pt.margin_pct_high, '%')       AS margin_range
FROM buyers b
LEFT JOIN pricing_tiers pt ON b.tier_id = pt.tier_id
ORDER BY b.priority_rank ASC;


-- VIEW 2: compliance_checklist
-- Shows only the MANDATORY compliance items.
-- A seller must clear all of these before the first export.
CREATE VIEW compliance_checklist AS
SELECT
    authority,
    regulation_name,
    description,
    target_market
FROM compliance_requirements
WHERE requirement_type = 'Mandatory'
ORDER BY target_market, authority;


-- ============================================================
-- SECTION 3: STORED PROCEDURE
-- What is a stored procedure? It is like a function in Python.
-- You give it an input, it runs a query and gives back results.
-- Example: CALL GetBuyersByTier(1); --> shows tier 1 buyers
--          CALL GetBuyersByTier(3); --> shows tier 3 buyers
-- ============================================================

DELIMITER $$

CREATE PROCEDURE GetBuyersByTier(IN p_tier_id INT)
BEGIN
    SELECT
        b.company_name,
        b.buyer_type,
        b.relationship_status,
        b.priority_rank,
        pt.tier_name,
        CONCAT('$', pt.price_usd_low, ' – $', pt.price_usd_high, '/kg') AS price_range
    FROM buyers b
    JOIN pricing_tiers pt ON b.tier_id = pt.tier_id
    WHERE b.tier_id = p_tier_id
    ORDER BY b.priority_rank ASC;
END$$

DELIMITER ;


-- ============================================================
-- SECTION 4: TEST — Run these to verify everything works
-- ============================================================

-- Test View 1: should show all buyers with their tier info
SELECT * FROM buyer_pricing_summary;

-- Test View 2: should show only Mandatory compliance items
SELECT * FROM compliance_checklist;

-- Test Stored Procedure: should show buyers in tier 1
CALL GetBuyersByTier(1);

-- Test Stored Procedure: should show buyers in tier 3
CALL GetBuyersByTier(3);
