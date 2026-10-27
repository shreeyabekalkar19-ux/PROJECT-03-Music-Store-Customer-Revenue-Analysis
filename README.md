# Music Store Customer & Revenue Analytics using SQL

## 1. Business Problem
A digital music store utilizing the Chinook database wants to evaluate its commercial performance and customer purchasing dynamics. The Management aims to identify high-value customer segments, pinpoint top-performing artists and genres, analyze international revenue distribution, and uncover opportunities to optimize customer lifetime value. The objective of this analysis is to leverage relational SQL queries to extract commercial insights, measure retention, and guide content acquisition strategy.

## 2. Dataset
The dataset used for this project is the Chinook Database, which models a digital media store including tables for artists, albums, media tracks, invoices, and customers.
Source: https://github.com/lerocha/chinook-database

## 3. Database Schema
1. Click on source link and open Data Sources folder.
2. Download Chinook_MySql.sql file from the folder.
3. Open the file on MySQL Workbench and run the file
4. Open the database 'Chinook' created.
   
## 4. Business Questions
1. What is the total sales revenue?
2. What are the yearly and monthly sales trends?
3. Which products generate the highest revenue?
4. Which products have the highest sales quantity?
5. Which product categories perform best?
6. Who are the top customers?
7. Which sales territories generate the most revenue?
8. Which salespersons have the highest sales?
9. What is the average order value?
10. Which products have declining sales?
11. What percentage of total revenue comes from the top 10 products?
12. What are the best-performing product categories by year?
13. Which customers have made multiple purchases?
14. How does sales performance vary across territories?
15. Which products have high quantity sales but relatively low revenue?

## 5. SQL Concepts Used
1. JOIN - CROSS JOIN, JOIN
2. GROUP BY
3. ORDER BY
4. HAVING
5. CASE
6. Subqueries
7. Common Table Expressions (CTEs) - WITH clause
8. Window functions - SUM(), COUNT()
9. Ranking - ROW_NUMBER(), RANK(), OVER(ORDER BY ), DENSE_RANK()
10. Date functions - DATE_FORMAT()

## 6. Key Findings
1. The USA, Canada, and France account for the largest share of revenue, representing over 40% of total international sales.
2. Spending per customer shows moderate variance.
3. Rock is the highest selling genre, followed by Latin and Metal.
4. Monthly revenue has some variance with the highest revenue being during the month of January, 2022.
5. Artists who have the largest number of tracks are Iron Maiden, U2 and Led Zeppelin
6. Revenue generated per sales support employee is evenly distributed across team members, reflecting balanced account distribution.

## 7. Business Recommendations
1. Prioritize marketing campaigns and catalog expansion around high-revenue genres like Rock and Metal, while pairing niche or slower-selling genres with popular tracks in discounted bundle promotions to boost overall volume.
2. Expand targeted ad campaigns in core markets like North America, while streamlining checkout experiences and introducing localized payment methods to capture market share in high-potential European regions.
3. Launch an automated loyalty program tailored for high-value customers to drive repeat purchases, improve long-term retention, and maximize lifetime value (LTV).

## 8. Conclusion
This SQL case study highlights key operational drivers within the digital music store ecosystem. By leveraging analytical queries, multi-table joins, and CTEs, actionable paths were identified to optimize music catalog acquisition and increase customer lifetime value.
