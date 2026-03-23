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


