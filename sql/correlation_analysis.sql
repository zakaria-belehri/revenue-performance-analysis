-- KPI correlation analysis with revenue change
SELECT
    CORR(revenue_change, active_customers) AS correlation_customers,
    CORR(revenue_change, orders) AS correlation_orders,
    CORR(revenue_change, aov) AS correlation_aov,
    CORR(revenue_change, revenue_per_customer) AS correlation_rev_per_customer,
    CORR(revenue_change, profit_margin_pct) AS correlation_margin
FROM analytics.revenue_bridge_mk;
