# E-commerce Revenue Performance Analysis

End-to-end analysis of an e-commerce business using SQL and Looker Studio, focused on understanding revenue drivers and profitability.

---

## Business Objective

This project answers three main questions:

1. How did the business perform in 2024?  
2. What explains changes in revenue?  
3. Is growth translating into profit?  

---

## Dashboard Preview

![Dashboard 1](dashboard/dashboard_page_1.png)  
![Dashboard 2](dashboard/dashboard_page_2.png)

---

## Key Takeaways

- Revenue is mainly driven by **customers and order volume**  
- AOV is **not a strong growth lever**  
- Contribution margin is stable (~46.6%)  
- Profit is sensitive to **marketing spend**  
- December shows a **sharp drop likely due to demand or data issues**  

---

## Interpretation

The business operates as a **volume-driven model**.

Growth depends more on:
- acquiring customers  
- increasing order volume  

Since margins are stable, the key challenge is **efficient growth**, not pricing.

---

## Recommendations

- Focus on **retention** (repeat purchases)  
- Improve **marketing efficiency**  
- Prioritize **frequency over basket size**  
- Investigate the December drop  

---

## Project Structure

revenue-performance-analysis/
├── dashboard/
├── sql/
├── business_analysis/
├── README.md
└── LICENSE


---

## Workflow

Raw data → Cleaning → Fact table → KPIs → Revenue bridge → Profit bridge → Dashboard → Business insights

---

## Tools

- SQL (PostgreSQL)
- DBeaver
- Looker Studio

---

## Takeaway

This project shows how to go from raw data to clear business decisions.
