-- =========================================
-- Project: E-commerce Revenue Performance Analysis
-- Author: Zakaria Belehri
-- Step 4: Build the analytics fact table
-- =========================================

-- Recreated the fact table to ensure a clean version of the model
DROP TABLE IF EXISTS analytics.fact_orders;

CREATE TABLE analytics.fact_orders AS

-- Step 1: Standardized monetary fields
WITH base_money AS (
    SELECT
        *,
        ROUND(revenue::numeric, 2) AS revenue_money,
        ROUND(ad_spend::numeric, 2) AS ad_spend_money
    FROM raw.raw_transactions
),

-- Step 2: Here I estimated core cost components
base_costs AS (
    SELECT
        *,
        ROUND((revenue_money * 0.5)::numeric, 2) AS cogs,
        ROUND((revenue_money * 0.025)::numeric, 2) AS payment_fees,
        ROUND(5::numeric, 2) AS shipping_cost
    FROM base_money
),

-- Step 3: Calculated contribution margin and profit after ads
business_metrics AS (
    SELECT
        *,
        ROUND((revenue_money - cogs - payment_fees - shipping_cost)::numeric, 2) AS contribution_margin,
        ROUND(((revenue_money - cogs - payment_fees - shipping_cost) - ad_spend_money)::numeric, 2) AS profit_after_ads
    FROM base_costs
)

-- Final fact table used for downstream KPI analysis
SELECT
    transaction_id,
    transaction_date,
    customer_id,
    revenue_money,
    contribution_margin,
    profit_after_ads,
    cogs,
    payment_fees,
    shipping_cost,
    ad_spend_money
FROM business_metrics;
