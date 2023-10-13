--Retrieve the first and last names of all employees in the "dbo.DimEmployee" table.
SELECT  FirstName,LastName FROM dbo.DimEmployee;
------------------------------------------------

--Retrieve the product names and list prices for products in the "dbo.DimProduct" table where the list price is greater than $1,000

SELECT EnglishProductName,ListPrice FROM DBO.DimProduct
WHERE ListPrice > 1000
ORDER BY ListPrice DESC;

------------------------------------------------

--Retrieve the product names and standard costs for products in the "dbo.DimProduct" table, ordered by standard cost in descending order.

SELECT EnglishProductName,StandardCost FROM DBO.DimProduct
ORDER BY StandardCost DESC;

------------------------------------------------
/* 4.	Retrieve the product names and category names for products in the "dbo.DimProduct" table along with their corresponding categories
from the "dbo.DimProductCategory" table.*/
SELECT TOP 100 * FROM DBO.DimProduct

SELECT TOP 100 * FROM DBO.DimProductCategory

SELECT EnglishProductName,C.EnglishProductCategoryName FROM DBO.DimProduct P 
JOIN DimProductSubcategory PS
ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey
JOIN DimProductCategory C
ON PS.ProductCategoryKey = C.ProductCategoryKey;

-------------------------------------------------

/*Calculate the total sales amount for each product in the "dbo.FactInternetSales" table
and display the product names along with their total sales amounts.
 */
SELECT TOP 100 * FROM SalesSchema.FactInternetSales
SELECT TOP 100 * FROM DBO.DimProduct

SELECT P.EnglishProductName,SUM(SalesAmount) AS TotalSalesAmount
FROM SalesSchema.FactInternetSales AS FIS
JOIN DBO.DimProduct AS P
ON FIS.ProductKey = P.ProductKey
GROUP BY P.EnglishProductName;

------------------------------------------------
/*Find the number of employees in each department in the "dbo.DimEmployee" 
table and display the department names along with the employee counts.*/
SELECT [DepartmentName], Count([EmployeeKey]) AS TOTALEMPLOYEE
FROM dbo.DimEmployee
GROUP BY DepartmentName;

-----------------------------------------------
/*Retrieve the first and last names of employees in the "dbo.DimEmployee" table who
have a job title of "Engineering Manager" (use a subquery).
*/
SELECT FirstName,LastName FROM DBO.DimEmployee
WHERE Title = (SELECT Title FROM DBO.DimEmployee
WHERE Title = 'Engineering Manager')

------------------------------------------------

SELECT TOP 100 * FROM DimCustomer
SELECT * FROM SalesSchema.FactInternetSales

SELECT LastName,FirstName FROM DimCustomer 
WHERE CustomerKey = (
SELECT TOP 1 CustomerKey AS TotalExpenses FROM SalesSchema.FactInternetSales)

SELECT LastName,FirstName,CustomerKey FROM DimCustomer
WHERE CustomerKey IN (11000,11001,11002);
----------------------------------------------
/* CTEs */

/*Create a CTE that calculates the average list price for products in the 
"dbo.DimProduct" table and then retrieve the product names along with their list prices, 
indicating whether each product's list price is above or below the average. */

SELECT AVG (ListPrice) from DimProduct

WITH AvgListPrice AS (
	SELECT AVG(ListPrice) AS AvgPrice
	from DimProduct
	)
SELECT p.EnglishProductName ,
	CASE WHEN p.ListPrice > AvgListPrice.AvgPrice THEN 'Above Average'
	ELSE 'Below Average' END AS PriceCategory
FROM dbo.DimProduct p
CROSS JOIN AvgListPrice
where p.listprice is not null 

----------------------------------------------------
/*Calculate the cumulative sales amount for each day in the 
"dbo.FactInternetSales" table, ordered by date, and display the date 
along with the cumulative sales amount.*/

SELECT OrderDate,SUM(SalesAmount) OVER 
		(ORDER BY OrderDate) AS CumulativeSalesAmount	
FROM SalesSchema.FactInternetSales
ORDER BY OrderDate

----------------------------------------------------

/*
9.	Retrieve the product names and standard costs for products in the 
"dbo.DimProduct" table where the standard cost is less than the average 
standard cost for all products, and the product name starts with the letter 'B'.
*/
SELECT EnglishProductName,StandardCost
FROM DBO.DimProduct
WHERE StandardCost <= (SELECT AVG(StandardCost) AS AverageStandardCost
FROM DBO.DimProduct) AND LEFT(EnglishProductName,1)= 'B'
