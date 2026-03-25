-- =========================================
-- Project: E-commerce Revenue Performance Analysis
-- Author: Zakaria Belehri
-- Step 7: Build revenue bridge and analyze revenue drivers
-- =========================================

DROP TABLE IF EXISTS analytics.revenue_bridge;

CREATE TABLE analytics.revenue_bridge AS 

WITH base AS (
    SELECT
        *,
        (orders::numeric / NULLIF(active_customers, 0)) AS orders_per_customer,
        ROUND((total_revenue / NULLIF(orders::numeric, 0)), 2) AS aov_cal
    FROM analytics.monthly_kpis
),

business_metrics AS (
    SELECT
        *,
        LAG(total_revenue) OVER (ORDER BY month) AS prev_total_revenue,
        LAG(active_customers) OVER (ORDER BY month) AS prev_active_customers,
        LAG(orders) OVER (ORDER BY month) AS prev_orders,
        LAG(aov_cal) OVER (ORDER BY month) AS prev_aov,
        LAG(orders_per_customer) OVER (ORDER BY month) AS prev_orders_per_customer
    FROM base
),

bridge_columns AS (
    SELECT
        *,
        (total_revenue - prev_total_revenue) AS revenue_change,
        ROUND(((active_customers - prev_active_customers) * prev_orders_per_customer * prev_aov), 2) AS customer_impact,
        ROUND(((orders_per_customer - prev_orders_per_customer) * active_customers * prev_aov), 2) AS frequency_impact,
        ((aov_cal - prev_aov) * active_customers * orders_per_customer) AS aov_impact
    FROM business_metrics
)

SELECT
    *,
    (revenue_change - (customer_impact + frequency_impact + aov_impact)) AS bridge_delta
FROM bridge_columns;

-- Checked revenue_bridge schema
SELECT
    column_name AS revenue_bridge
FROM information_schema.columns
WHERE table_schema = 'analytics'
  AND table_name = 'revenue_bridge'
ORDER BY ordinal_position;

-- Standardize month format in monthly_kpis
ALTER TABLE analytics.monthly_kpis 
ALTER COLUMN month TYPE date
USING month::date;

-- Quick validation: latest month revenue decomposition
SELECT
    month::date,
    revenue_change,
    customer_impact,
    frequency_impact,
    aov_impact
FROM analytics.revenue_bridge rb
ORDER BY month DESC
LIMIT 1;

-- Review full year by month
SELECT
    month::date,
    customer_impact,
    frequency_impact,
    aov_impact,
    total_revenue
FROM analytics.revenue_bridge
WHERE month >= '2024-01-01'
  AND month < '2024-12-31'
ORDER BY month DESC;

-- Checked months where AOV had a positive contribution
SELECT
    month::date,
    customer_impact,
    frequency_impact,
    aov_impact,
    total_revenue
FROM analytics.revenue_bridge
WHERE aov_impact > 0
ORDER BY month DESC;

-- Which months had the largest revenue growth?
SELECT
    month::date,
    revenue_change
FROM analytics.revenue_bridge
WHERE revenue_change IS NOT NULL
ORDER BY revenue_change DESC;

-- Which driver contributed most to revenue growth?
SELECT
    month::date,
    revenue_change,
    customer_impact,
    frequency_impact,
    aov_impact
FROM analytics.revenue_bridge rb
WHERE revenue_change IS NOT NULL
ORDER BY revenue_change DESC;

-- Which KPI correlates most with revenue changes?
SELECT 
    CORR(revenue_change, active_customers) AS correlation_customers, 
    CORR(revenue_change, orders) AS correlation_orders,
    CORR(revenue_change, aov) AS correlation_aov,
    CORR(revenue_change, revenue_per_customer) AS correlation_rev_per_customer,
    CORR(revenue_change, profit_margin_pct) AS correlation_margin_
FROM analytics.revenue_bridge mk;
