# Retail Sales Analysis Using SQL

---

## Project Overview
This project analyzes a retail sales dataset containing **1000 transactions** using SQL to extract meaningful business insights.  
The main objective is to understand customer behavior, evaluate product performance, and identify key revenue and profit trends.

---

## Tools & Technologies
- **MySQL**
- **SQL** (Joins, Aggregations, Window Functions, CASE Statements)
- **GitHub**

---

## Dataset Description
The dataset includes:
- Transaction details  
- Product category and product name  
- Quantity and total amount  
- Customer demographics (**Age Group, Gender**)  
- Transaction date  

Additionally, a **`products`** table was created containing:
- Supplier  
- Cost per unit  

---

## Data Preparation
- Converted date from string to DATE format using:
```sql 
STR_TO_DATE()
- Created a products table
- Joined tables using JOIN

## Key Business Questions Answered
 Revenue Analysis
Which product category generates the highest total revenue?
What is the total revenue per month?
How do product categories compare in terms of:
Total revenue
Number of transactions
Average order value

---

## Customer Analysis
Customer segmentation based on spending levels:
Low Spending
Medium Spending
High Spending
Analysis by:
Age group
Gender

---

## Profit Analysis
- Profit was calculated using:
```sql
Total Amount - (Cost Per Unit × Quantity)

This analysis identified:
- Most profitable products
- Top 3 most profitable transactions per category (using window functions)
- Transactions resulting in losses
