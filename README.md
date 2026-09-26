# Skill Nexis Internship – Week 2

## SQL for Data Analysis

This project was completed as part of my **Skill Nexis internship – Week 2** assignment.

### Objective
Analyze a sample sales database using SQL and practice common data-analysis techniques.

### Dataset
The supplied dataset contains **200 sales records** and **200 unique customers**.

Columns:
- `order_id`
- `customer_name`
- `order_date`
- `category`
- `sub_category`
- `product_name`
- `quantity`
- `unit_price`
- `total_price`
- `region`

### SQL Concepts Covered
- SELECT
- WHERE
- GROUP BY
- ORDER BY
- SUM()
- AVG()
- COUNT()
- CASE statements
- Subqueries
- JOINs

### Main Analysis
The queries identify total revenue, average order value, top customers, order counts, regional/category sales, high-value orders, above-average orders, monthly sales, and customer summaries using a JOIN.

### Dataset Summary
- Total records/orders: **200**
- Unique customers: **200**
- Total revenue: **2,420,107.00**
- Average order value: **12,100.53**

### Tools Used
- MySQL
- MySQL Workbench
- SQL
- Git
- GitHub
- Excel/CSV

### Project Structure
```text
skillnexis-week2-sql-data-analysis/
├── README.md
├── analysis.sql
└── sales_data.csv
```

### How to Run
1. Open MySQL Workbench.
2. Open `analysis.sql`.
3. Create the database and `sales` table.
4. Import `sales_data.csv` into `sales` using the Table Data Import Wizard.
5. Run the analysis queries.
6. Review the results for top customers, average order value, regional/category sales, and other analysis.
