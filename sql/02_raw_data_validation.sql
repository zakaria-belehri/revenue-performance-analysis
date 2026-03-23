-- =========================================
-- Step 2: Raw Data Exploration & Validation
-- Objective: Understand data structure, quality, and integrity
-- =========================================

-- Checked if the raw table exists in the expected schema
SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_name = 'raw_transactions';

-- Verified current database and schema context
SELECT current_database();
SELECT current_schema();

-- Checked available tables in relevant schemas
SELECT schemaname, tablename
FROM pg_tables
WHERE schemaname IN ('raw', 'public');

-- Inspected first rows of the dataset
SELECT *
FROM raw.raw_transactions
LIMIT 5;

-- Understanding the dataset size
SELECT COUNT(*) AS total_rows
FROM raw.raw_transactions;

-- Checked for duplicate transaction IDs
SELECT 
    COUNT(DISTINCT transaction_id) AS unique_transaction_ids,
    COUNT(*) AS total_rows
FROM raw.raw_transactions;

-- Validated key numerical fields
SELECT MAX(units_sold) AS max_units_sold
FROM raw.raw_transactions;

-- Checked distribution of core business variables
SELECT 
    MIN(revenue) AS min_revenue,
    MAX(revenue) AS max_revenue,
    AVG(revenue) AS avg_revenue
FROM raw.raw_transactions;

-- Quick sanity check for marketing data
SELECT 
    MIN(ad_spend) AS min_ad_spend,
    MAX(ad_spend) AS max_ad_spend
FROM raw.raw_transactions;
