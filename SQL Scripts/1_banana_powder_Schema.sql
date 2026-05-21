DROP DATABASE IF EXISTS banana_powder_business;
CREATE DATABASE banana_powder_business;
USE banana_powder_business;
-- 1. MASTER COMMERCIALIZATION TABLES 
-- ============================================================

-- Reference table for pricing structures
CREATE TABLE pricing_tiers (
    tier_id         INT PRIMARY KEY AUTO_INCREMENT,
    tier_name       VARCHAR(50) NOT NULL,
    price_usd_low   DECIMAL(8,2) NOT NULL,
    price_usd_high  DECIMAL(8,2) NOT NULL,
    margin_pct_low  DECIMAL(5,2),
    margin_pct_high DECIMAL(5,2),
    target_buyer    VARCHAR(100)
);
-- ----------------------------
-- 2. MASTER CRM TABLE: Buyers
-- ----------------------------
CREATE TABLE buyers (
    buyer_id            INT PRIMARY KEY AUTO_INCREMENT,
    company_name        VARCHAR(150) NOT NULL,
    buyer_type          VARCHAR(50) NOT NULL,
    location_state      VARCHAR(50) NOT NULL,
    location_country    VARCHAR(50) NOT NULL DEFAULT 'USA',
    relationship_status VARCHAR(50) NOT NULL,
    specialty           VARCHAR(200),
    priority_rank       INT,
    tier_id             INT, -- Links each buyer to their pricing tier
    FOREIGN KEY (tier_id) REFERENCES pricing_tiers(tier_id) ON DELETE SET NULL
);


-- 2. Master Production Scale Table
CREATE TABLE production_capacity (
    capacity_id           INT PRIMARY KEY AUTO_INCREMENT,
    capacity_level        VARCHAR(50) NOT NULL,
    input_kg_day          DECIMAL(8,2) NOT NULL,
    yield_pct_low         DECIMAL(5,2) NOT NULL,
    yield_pct_high        DECIMAL(5,2) NOT NULL,
    output_kg_day_low     DECIMAL(8,2) NOT NULL,
    output_kg_day_high    DECIMAL(8,2) NOT NULL,
    monthly_profit_low    DECIMAL(10,2),
    monthly_profit_high   DECIMAL(10,2),
    breakeven_months_low  INT,
    breakeven_months_high INT
);

-- 3. Dependent Quality Requirements (Links to Buyers)
CREATE TABLE buyer_requirements (
    req_id        INT PRIMARY KEY AUTO_INCREMENT,
    buyer_id      INT,
    requirement   VARCHAR(100) NOT NULL,
    description   VARCHAR(200),
    is_mandatory  BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (buyer_id) REFERENCES buyers(buyer_id) ON DELETE CASCADE
);

-- 4. Dependent Machinery Production Flow
CREATE TABLE machinery (
    machine_id      INT PRIMARY KEY AUTO_INCREMENT,
    machine_name    VARCHAR(100) NOT NULL,
    process_stage   INT NOT NULL,
    description     VARCHAR(300),
    operating_range VARCHAR(100),
    output_spec     VARCHAR(100),
    is_critical     BOOLEAN NOT NULL DEFAULT TRUE
);

-- 5. Dependent Financial Investment Tracking
CREATE TABLE investment_breakdown (
    investment_id       INT PRIMARY KEY AUTO_INCREMENT,
    component           VARCHAR(100) NOT NULL,
    cost_usd_low        DECIMAL(10,2) NOT NULL,
    cost_usd_high       DECIMAL(10,2) NOT NULL,
    notes               VARCHAR(200)
);    


-- 7. Dependent Global Trade Compliance Checkpoints
CREATE TABLE compliance_requirements (
    compliance_id    INT PRIMARY KEY AUTO_INCREMENT,
    authority        VARCHAR(100) NOT NULL,
    regulation_name  VARCHAR(100) NOT NULL,
    requirement_type VARCHAR(50) NOT NULL,
    description      VARCHAR(300),
    target_market    VARCHAR(50) NOT NULL DEFAULT 'USA'
);



