-- =========================================
-- Project: E-commerce Revenue Performance Analysis
-- Author: Zakaria Belehri
-- Step 5: Validate the fact table
-- =========================================

-- Compared raw row count with modeled row count
SELECT COUNT(*)
FROM raw.raw_transactions rt;

SELECT COUNT(*) AS new_data
FROM analytics.fact_orders;

-- Checked data types for key modeled columns
SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'analytics'
  AND table_name = 'fact_orders'
  AND column_name IN ('cogs', 'payment_fees', 'shipping_cost', 'contribution_margin');

-- Compared raw revenue and modeled revenue
SELECT SUM(revenue) AS total_revenue
FROM raw.raw_transactions rt;

SELECT SUM(revenue_money) AS total_revenue_2
FROM analytics.fact_orders;

-- Validated the contribution margin identity
SELECT
    SUM(revenue) AS revenue,
    SUM(cogs) AS cogs,
    SUM(payment_fees) AS fees,
    SUM(shipping_cost) AS shipping,
    SUM(contribution_margin) AS cm
FROM analytics.fact_orders;

-- Reconstructed revenue from cost components and margin
SELECT
    SUM(revenue) AS total_revenue,
    SUM(cogs + payment_fees + shipping_cost + contribution_margin) AS reconstructed_revenue
FROM analytics.fact_orders fo;

-- Final reconciliation check
SELECT
    ROUND(SUM(fo.revenue_money), 2) AS total_revenue,
    ROUND(SUM(cogs + payment_fees + shipping_cost + contribution_margin), 2) AS reconstructed_revenue,
    ROUND(SUM(revenue_money) - SUM(cogs + payment_fees + shipping_cost + contribution_margin), 2) AS diff
FROM analytics.fact_orders fo;
