-- =========================================
-- Project: E-commerce Revenue Performance Analysis
-- Author: Zakaria Belehri
-- Step 6: Build monthly KPI table
-- =========================================

DROP TABLE IF EXISTS analytics.monthly_kpis; 

CREATE TABLE analytics.monthly_kpis AS

WITH business_metrics AS ( 
    SELECT 
        date_trunc('month', transaction_date::date) AS month,
        SUM(revenue_money) AS total_revenue,
        SUM(contribution_margin) AS total_contribution_margin,
        SUM(ad_spend_money) AS total_ad_spend,
        SUM(profit_after_ads) AS total_profit_after_ads,
        COUNT(*) AS orders,
        COUNT(DISTINCT(customer_id)) AS active_customers
    FROM analytics.fact_orders 
    GROUP BY month
),

base AS ( 
    SELECT
        *,
        (total_contribution_margin / total_revenue) AS contribution_margin_pct,
        (total_profit_after_ads / total_revenue) AS profit_margin_pct
    FROM business_metrics
)

SELECT
    month,
    total_revenue,
    total_contribution_margin,
    contribution_margin_pct,
    total_ad_spend,
    total_profit_after_ads,
    profit_margin_pct,
    orders,
    active_customers
FROM base;

-- Add two business KPIs used later in the dashboard
ALTER TABLE analytics.monthly_kpis
ADD COLUMN aov NUMERIC(12,2);

ALTER TABLE analytics.monthly_kpis
ADD COLUMN revenue_per_customer NUMERIC(12,2);

UPDATE analytics.monthly_kpis
SET
    aov = ROUND(total_revenue / NULLIF(orders,0), 2),
    revenue_per_customer = ROUND(total_revenue / NULLIF(active_customers,0), 2);

-- Quick check
SELECT *
FROM analytics.monthly_kpis mk
LIMIT 10;

-- Correlation check on monthly KPI level
SELECT 
    CORR(total_revenue, active_customers) AS correlation_customers, 
    CORR(total_revenue, orders) AS correlation_orders,
    CORR(total_revenue, aov) AS correlation_aov,
    CORR(total_revenue, revenue_per_customer) AS correlation_rev_per_customer,
    CORR(total_revenue, profit_margin_pct) AS correlation_margin_
FROM analytics.monthly_kpis mk;
