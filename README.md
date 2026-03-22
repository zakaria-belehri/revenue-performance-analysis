# Revenue Performance Analysis

End-to-end e-commerce revenue and profitability analysis using SQL and Looker Studio, with driver decomposition and business insights.

## Business Objective

This project analyzes an e-commerce business to answer three core questions:

1. How did the business perform throughout 2024?
2. What explains changes in revenue?
3. Is growth translating into healthy profitability?

## Project Scope

The analysis covers the full workflow from raw data exploration to KPI modeling, driver decomposition, dashboard creation, and business recommendations.

## Tools Used

- SQL
- PostgreSQL / DBeaver
- Looker Studio
- Business KPI analysis
- Correlation analysis

## Key Business Questions

- How did revenue evolve across the year?
- What are the main drivers of revenue change?
- Which factors explain profit fluctuations?
- Which KPIs are most strongly related to revenue performance?

## Key Insights

- Revenue is strongly driven by **order volume and active customers**, confirming a volume-based business model.
- Average Order Value (AOV) shows a **negative relationship with revenue growth**, suggesting larger baskets may reduce purchase frequency.
- Profit margin correlation indicates that growth is partly driven by **discounting or customer acquisition costs**.
- Contribution margin remains stable at ~46.6%, meaning pricing and cost structure are consistent across the year.

## Business Interpretation

The business is currently operating as a **volume-driven model**, where growth depends on increasing customer activity rather than increasing order size.

This suggests:

- Growth is scalable but sensitive to demand
- Increasing AOV may harm conversion or frequency
- Profitability depends heavily on efficient customer acquisition

## Recommendations

- Focus on **customer retention and repeat purchases** rather than increasing basket size  
- Improve **marketing efficiency** to reduce dependency on discount-driven growth  
- Optimize **COGS and logistics** to protect margins at scale  

## Dashboard Preview

Dashboard screenshots are available in the `/dashboard` folder.

## Repository Structure

```text
revenue-performance-analysis
│
├── dashboard/              # Dashboard screenshots
├── sql/                    # SQL analysis files
├── LICENSE
└── README.md
