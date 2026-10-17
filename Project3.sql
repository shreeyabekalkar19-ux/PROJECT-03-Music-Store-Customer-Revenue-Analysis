SHOW DATABASES;
USE Chinook;
SHOW TABLES;

SELECT * FROM album;
SELECT * FROM artist;
SELECT * FROM customer;
SELECT * FROM employee;
SELECT * FROM genre;
SELECT * FROM invoice;
SELECT * FROM invoiceline;
SELECT * FROM mediatype;
SELECT * FROM playlist;
SELECT * FROM playlisttrack;
SELECT * FROM track;

-- Total Revenue
SELECT * FROM invoice;
SELECT SUM(Total) AS TotalRevenue FROM invoice;

-- Countries that generate the highest revenue
SELECT BillingCountry, SUM(Total) AS Revenue FROM Invoice 
GROUP BY BillingCountry 
ORDER BY Revenue DESC;

-- Top 10 customers by spending
SELECT * FROM customer;
SELECT * FROM invoice;
SELECT c.CustomerId, 
       CONCAT(FirstName, ' ', LastName) AS CustomerName, Phone, Email, 
	   SUM(i.Total) AS TotalSpent,
       ROW_NUMBER() OVER(ORDER BY SUM(i.Total) DESC) AS SpendingRank,
	   RANK() OVER(ORDER BY SUM(i.Total) DESC) AS SpendingRank_R,
	   DENSE_RANK() OVER(ORDER BY SUM(i.Total) DESC) AS SpendingRank_DR
FROM customer c 
JOIN invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, CustomerName, Phone, Email
LIMIT 10;

-- Artists who generate the highest revenue
SELECT a.Name as ArtistName, SUM(il.UnitPrice * il.Quantity) as ArtistRevenue
FROM invoiceline il 
JOIN track t ON il.TrackId = t.TrackId
JOIN album al ON t.AlbumId = al.AlbumId
JOIN artist a ON al.ArtistId = a.ArtistId
GROUP BY ArtistName
ORDER BY ArtistRevenue DESC;

-- Most popular genres
WITH MostPopularGenre AS (
     SELECT g.Name AS GenreName, SUM(il.Quantity) AS TotalTracksSold,
     RANK() OVER (ORDER BY SUM(il.Quantity) DESC) as PopularityRank
     FROM invoiceline il
     JOIN track t ON il.TrackId = t.TrackId
     JOIN genre g ON t.GenreId = g.GenreId
     GROUP BY GenreName, g.GenreId
)
SELECT * FROM MostPopularGenre 
WHERE PopularityRank <= 5;

-- Highest Sales Albums
SELECT al.Title as AlbumName, a.Name, SUM(il.Quantity * il.UnitPrice) as TotalSales
FROM invoiceline il
JOIN track t ON il.TrackId = t.TrackId
JOIN album al ON t.AlbumId = al.AlbumId
JOIN artist a ON al.ArtistId = a.ArtistId
GROUP BY AlbumName, a.Name
ORDER BY TotalSales DESC;

-- Tracks purchased most frequently
SELECT t.Name as TrackName, SUM(il.Quantity) AS TotalTracksNumber,
       ROW_NUMBER() OVER (ORDER BY SUM(il.Quantity) DESC) AS PopularTracksRanking
FROM invoiceline il
JOIN track t ON il.TrackId = t.TrackId
GROUP BY TrackName, t.TrackId
LIMIT 5;

-- Average Customer Spending 
SELECT AVG(CustomerTotal) AS AvgCustomerSpending
FROM (
    SELECT CustomerId, SUM(Total) AS CustomerTotal
    FROM Invoice
    GROUP BY CustomerId
) AS CustomerSpendingSummary;

-- Customers who never made a purchase
SELECT CustomerId, FirstName, LastName, Country FROM Customer
WHERE CustomerId NOT IN (SELECT DISTINCT CustomerId FROM Invoice);

-- Employees who support highest-value customers
SELECT e.EmployeeId, CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName, e.Country, SUM(i.Total) AS Revenue 
FROM employee e 
JOIN customer c ON e.EmployeeId = c.SupportRepId
JOIN invoice i ON c.CustomerId = i.CustomerId
GROUP BY EmployeeId, EmployeeName
ORDER BY Revenue DESC
LIMIT 10;

-- Percentage of revenue that comes from each country
SELECT BillingCountry, 
       SUM(Total) AS CountryRevenue, 
       ROUND((SUM(Total) * 100 / (SELECT SUM(Total) FROM invoice)), 2) AS PercentageRevenue
FROM invoice
GROUP BY BillingCountry
ORDER BY CountryRevenue DESC;

-- Genre that generates the highest revenue
SELECT g.Name AS GenreName, SUM(il.UnitPrice * il.Quantity) AS Revenue
FROM invoiceline il 
JOIN track t ON il.TrackId = t.TrackId
JOIN genre g ON t.GenreId = g.GenreId
GROUP BY GenreName
ORDER BY Revenue DESC;

-- Monthly or annual revenue trend
WITH MonthlyRevenue AS (
    SELECT DATE_FORMAT(InvoiceDate, '%Y-%m') AS RevenueMonth,
           SUM(Total) AS TotalRevenue
    FROM Invoice
    GROUP BY RevenueMonth
)
SELECT RevenueMonth, TotalRevenue
FROM MonthlyRevenue
ORDER BY RevenueMonth;

-- Artists that have largest number of tracks
SELECT ar.Name, ar.ArtistId, COUNT(t.TrackId) AS TrackNumber
FROM track t 
JOIN album a ON t.AlbumId = a.AlbumId
JOIN artist ar ON a.ArtistId = ar.ArtistId
GROUP BY ar.Name, ar.ArtistId
ORDER BY TrackNumber DESC;

-- Customers that have spending above average
WITH CustomerSpending AS (
	SELECT CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName, 
           c.CustomerId, 
           SUM(i.Total) AS TotalSpent
	FROM invoice i
    JOIN customer c ON i.CustomerId = c.CustomerId
    GROUP BY CustomerName, c.CustomerId
),
AverageSpending AS (
    SELECT AVG(TotalSpent) AS AverageCustomerSpend 
    FROM CustomerSpending
)
SELECT cs.CustomerId, cs.CustomerName, cs.TotalSpent,
       CASE 
           WHEN cs.TotalSpent >= (avs.AverageCustomerSpend * 1.5) THEN 'VIP'
           ELSE 'Above Average'
	   END AS SpendStatus
FROM CustomerSpending cs
CROSS JOIN AverageSpending avs
WHERE cs.TotalSpent > avs.AverageCustomerSpend
ORDER BY cs.TotalSpent DESC;