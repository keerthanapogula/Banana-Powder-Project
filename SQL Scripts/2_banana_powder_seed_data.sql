-- ============================================================
-- SEED DATA: Banana Powder Business Database
-- ============================================================

USE banana_powder_business;

-- ----------------------------
-- 1. Populate Commercialization Pricing Tiers First
-- ----------------------------
INSERT INTO pricing_tiers (tier_name, price_usd_low, price_usd_high, margin_pct_low, margin_pct_high, target_buyer) VALUES
('Standard Food-Grade',      4.00,  6.00, 25.00, 35.00, 'Bulk distributors and food manufacturers'), -- Assigned tier_id = 1
('Premium Spray-Dried',      6.00, 10.00, 30.00, 40.00, 'Nutraceuticals, beverage manufacturers'),   -- Assigned tier_id = 2
('Organic Certified',        8.00, 12.00, 35.00, 45.00, 'Health food brands, organic retailers');     -- Assigned tier_id = 3

-- ----------------------------
-- 2. Populate Master CRM Buyers Second (With Assigned tier_id)
-- ----------------------------
INSERT INTO buyers (company_name, buyer_type, location_state, location_country, relationship_status, specialty, priority_rank, tier_id) VALUES
('Pacific Wholesale Distributors', 'Mid-Size Distributor', 'California', 'USA', 'Active',   'Frequent importer of international banana powder shipments', 1, 1), 
('Eastern Trading Co.',            'Mid-Size Importer',    'California', 'USA', 'Prospect', 'Large-scale importer of Asian food products and base powders', 2, 1),  
('Midwest Natural Foods LLC',      'Small Distributor',    'Illinois',   'USA', 'Lead',     'Specializes in Latin-American style fruit ingredients', 4, 2),        
('Organic Ingredients USA Inc.',   'Mid-Size Supplier',    'New York',   'USA', 'Prospect', 'Organic fruit slices and powders; potential direct partner', 3, 3),   
('West Coast Lucky Imports',       'Mid-Size Importer',    'California', 'USA', 'Active',   'High-volume importer; known for thousands of unique SKUs', 2, 1);    

-- ----------------------------
-- 3. Populate Master Production Scale Baselines
-- ----------------------------
INSERT INTO production_capacity (capacity_level, input_kg_day, yield_pct_low, yield_pct_high, output_kg_day_low, output_kg_day_high, monthly_profit_low, monthly_profit_high, breakeven_months_low, breakeven_months_high) VALUES
('Low',   500.00,  15.00, 25.00,  75.00, 125.00,  4000.00,  7000.00, 12, 18),
('Mid',  1000.00,  15.00, 25.00, 150.00, 250.00,  8000.00, 15000.00,  8, 14),
('High', 2000.00,  15.00, 25.00, 300.00, 500.00, 18000.00, 30000.00,  5, 10);

-- ----------------------------
-- 4. Populate Dependent Quality Requirements
-- ----------------------------
INSERT INTO buyer_requirements (buyer_id, requirement, description, is_mandatory) VALUES
(1, 'Moisture Control',        'Moisture content must be below 7% to prevent clumping and spoilage',     TRUE),
(2, 'Uniform Particle Size',   'Consistent grind — typically 80–120 mesh for food-grade applications',   TRUE),
(4, 'Microbial Safety',        'Must meet FDA microbial limits — TPC, yeast, mold, E. coli, Salmonella', TRUE),
(5, 'Batch Consistency',       'Color, flavor, and texture must be consistent across batches',            TRUE),
(1, 'Reliable Supply Chain',   'Ability to fulfill repeat orders on time; minimum lead time guarantee',   TRUE),
(4, 'Organic Certification',   'USDA Organic preferred for premium buyers',                               FALSE),
(2, 'Certificate of Analysis', 'COA required per batch with full nutritional and safety panel',           TRUE);

-- ----------------------------
-- 5. Populate Dependent Machinery Production Flow
-- ----------------------------
INSERT INTO machinery (machine_name, process_stage, description, operating_range, output_spec, is_critical) VALUES
('Industrial Bubble Washer', 1, 'Removes dirt, pesticides, and contaminants using pressurized water', 'Ambient temperature',     'Clean, sanitized bananas',         TRUE),
('Peeling System',           2, 'Manual or semi-auto; optional steam blanching to reduce browning',   '60–80°C (steam blanch)',  'Peeled, browning-minimized fruit', TRUE),
('High-Speed Slicer',        3, 'Produces uniform slices for even drying',                            '1–5 mm slice thickness',  'Uniform banana slices',            TRUE),
('Heat Pump Dryer',          4, 'Moisture reduction while preserving color and nutrients',             '55°C – 65°C',             'Dehydrated banana chips',          TRUE),
('Water-Cooled Pulverizer',  5, 'Prevents heat damage during grinding; produces fine powder',         'Cooled — no heat spike',  'Fine banana powder',               TRUE),
('Vibro Sifter',             6, 'Ensures consistent particle size for food-grade output',              '80–120 mesh standard',    'Uniform particle-size powder',     TRUE),
('Vacuum Packaging Unit',    7, 'Nitrogen flushing — extends shelf life, prevents oxidation',         'Nitrogen atmosphere',     'Shelf-stable packaged product',    TRUE);

-- ----------------------------
-- 6. Populate Dependent Financial Investment Breakdowns
-- ----------------------------
INSERT INTO investment_breakdown (component, cost_usd_low, cost_usd_high, notes) VALUES
('Machinery',          45000.00,  75000.00, 'Full production line — washer to packaging'),
('Infrastructure',     20000.00,  40000.00, 'Facility setup, utilities, civil works'),
('Testing Lab Setup',  10000.00,  15000.00, 'In-house quality control and testing equipment'),
('Working Capital',    15000.00,  30000.00, 'Raw material stock, packaging, first shipment float'),
('Total Investment',   90000.00, 160000.00, 'Sum of all components — conservative to optimistic');

-- ----------------------------
-- 7. Populate Dependent Global Trade Compliance Checkpoints
-- ----------------------------
INSERT INTO compliance_requirements (authority, regulation_name, requirement_type, description, target_market) VALUES
('FDA',  'FSMA — Food Safety Modernization Act',         'Mandatory',    'Preventive controls, hazard analysis, and supplier verification required', 'USA'),
('FDA',  'Foreign Supplier Verification Program (FSVP)', 'Mandatory',    'US importers must verify that foreign suppliers meet FDA standards',        'USA'),
('FDA',  'Food Facility Registration',                   'Mandatory',    'All food facilities exporting to the US must register with FDA',            'USA'),
('USDA', 'USDA Organic Certification',                   'Recommended',  'Required only for organic-labeled products; enables premium pricing',       'USA'),
('SGS/Bureau Veritas', 'Certificate of Analysis (COA)', 'Mandatory',    'Third-party lab testing per batch for nutritional and safety profile',       'USA'),
('APEDA','Agricultural & Processed Food Export Cert',    'Mandatory',    'Indian regulatory requirement for processed food export',                   'India'),
('BIS',  'IS 14818 — Dehydrated Fruit Products',        'Recommended',  'Indian quality standard for dehydrated banana products',                    'India');
