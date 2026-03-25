-- =========================================
-- Project: E-commerce Revenue Performance Analysis
-- Author: Zakaria Belehri
-- Step 8: Build profit bridge and analyze profit drivers
-- =========================================

DROP TABLE IF EXISTS analytics.profit_bridge;

CREATE TABLE analytics.profit_bridge AS

WITH bm AS (
    SELECT
        month,
        total_revenue,
        total_profit_after_ads,
        contribution_margin_pct,
        total_ad_spend,
        LAG(total_revenue) OVER (ORDER BY month) AS prev_revenue,
        LAG(total_profit_after_ads) OVER (ORDER BY month) AS prev_profit,
        LAG(contribution_margin_pct) OVER (ORDER BY month) AS prev_cm_pct,
        LAG(total_ad_spend) OVER (ORDER BY month) AS prev_ad_spend
    FROM analytics.monthly_kpis
),

effects AS (
    SELECT
        *,
        (total_profit_after_ads - prev_profit) AS profit_change,
        (total_revenue - prev_revenue) AS revenue_change,
        (prev_profit / NULLIF(prev_revenue, 0)) AS prev_profit_margin,
        ROUND((total_revenue - prev_revenue) * (prev_profit / NULLIF(prev_revenue, 0)), 2) AS revenue_effect,
        ROUND((contribution_margin_pct - prev_cm_pct) * total_revenue, 2) AS margin_effect,
        -(total_ad_spend - prev_ad_spend) AS marketing_effect
    FROM bm
)

SELECT
    *,
    profit_change - (revenue_effect + margin_effect + marketing_effect) AS bridge_delta
FROM effects
ORDER BY month;

-- Checked profit_bridge schema
SELECT
    column_name AS profit_bridge
FROM information_schema.columns
WHERE table_schema = 'analytics'
  AND table_name = 'profit_bridge'
ORDER BY ordinal_position;

-- Which driver explains profit volatility?
SELECT
    month::date,
    profit_change,
    revenue_effect,
    margin_effect,
    marketing_effect
FROM analytics.profit_bridge
WHERE month >= '2024-01-01'
  AND month < '2024-12-31'
ORDER BY ABS(profit_change) DESC;

-- Inspected contribution margin percentage directly
SELECT contribution_margin_pct
FROM analytics.profit_bridge
LIMIT 10;

-- Reviewed monthly contribution margin percentage
SELECT 
    month,
    contribution_margin_pct
FROM analytics.profit_bridge
WHERE month >= '2024-01-01'
  AND month < '2025-01-01'
ORDER BY month;

-- Reconstructed contribution margin in absolute value
SELECT
    month,
    total_revenue,
    contribution_margin_pct,
    total_revenue * contribution_margin_pct AS contribution_margin
FROM analytics.profit_bridge
WHERE month >= '2024-01-01'
  AND month < '2025-01-01'
ORDER BY month;
