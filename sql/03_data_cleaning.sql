-- =========================================
-- Project: E-commerce Revenue Performance Analysis
-- Author: Zakaria Belehri
-- Step 3: Standardize raw column names and data types
-- =========================================

-- Renamed columns to snake_case for cleaner downstream analysis

ALTER TABLE raw.raw_transactions 
RENAME COLUMN "Revenue" TO revenue;

ALTER TABLE raw.raw_transactions 
RENAME COLUMN "Transaction_ID" TO transaction_id;

ALTER TABLE raw.raw_transactions 
RENAME COLUMN "Customer_ID" TO customer_id;

ALTER TABLE raw.raw_transactions 
RENAME COLUMN "Product_ID" TO product_id;

ALTER TABLE raw.raw_transactions 
RENAME COLUMN "Transaction_Date" TO transaction_date;

ALTER TABLE raw.raw_transactions 
RENAME COLUMN "Units_Sold" TO units_sold;

ALTER TABLE raw.raw_transactions 
RENAME COLUMN "Discount_Applied" TO discount_applied;

ALTER TABLE raw.raw_transactions 
RENAME COLUMN "Clicks" TO clicks;

ALTER TABLE raw.raw_transactions 
RENAME COLUMN "Impressions" TO impressions;

ALTER TABLE raw.raw_transactions 
RENAME COLUMN "Conversion_Rate" TO conversion_rate;

ALTER TABLE raw.raw_transactions 
RENAME COLUMN "Category" TO category;

ALTER TABLE raw.raw_transactions 
RENAME COLUMN "Region" TO region;

ALTER TABLE raw.raw_transactions 
RENAME COLUMN "Ad_CTR" TO ad_ctr;

ALTER TABLE raw.raw_transactions 
RENAME COLUMN "Ad_CPC" TO ad_cpc;

ALTER TABLE raw.raw_transactions 
RENAME COLUMN "Ad_Spend" TO ad_spend;

-- Converted transaction_date to DATE format
ALTER TABLE raw.raw_transactions 
ALTER COLUMN transaction_date TYPE DATE
USING transaction_date::date;
