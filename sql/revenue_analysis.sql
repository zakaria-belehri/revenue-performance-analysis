-- Revenue trend analysis
SELECT
    month,
    total_revenue,
    contribution_margin_pct,
    contribution_margin
FROM profit_bridge
ORDER BY month;
