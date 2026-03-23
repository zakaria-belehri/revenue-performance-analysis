-- =========================================
-- Project: E-commerce Revenue Performance Analysis
-- Author: Zakaria Belehri
-- Step 1: Initial database setup
-- =========================================

-- Create the main database for the project
-- (Run this once if the database does not already exist)
CREATE DATABASE ecommerce_portfolio;

-- Create schemas to separate raw data from transformed data
-- This helps keep the pipeline clean and organized

CREATE SCHEMA IF NOT EXISTS raw;
CREATE SCHEMA IF NOT EXISTS analytics;

-- raw: contains the original, unprocessed data
-- analytics: contains cleaned, transformed, and business-ready tables
