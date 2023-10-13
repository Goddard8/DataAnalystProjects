/*Altering And Dropping Schema*/
--ALTER SCHEMA dbo TRANSFER SalesSchema.FactInternetSales
--DROP SCHEMA SalesSchema

--CREATING SCHEMA
CREATE SCHEMA SalesSchema;

--ALTERING AND TRANSFERRING SALESSCHEMA TO TABLE
ALTER SCHEMA SalesSchema TRANSFER dbo.FactInternetSales;

--CREATING A TABLE
CREATE TABLE ProductReviews_v2(
ReviewID INT PRIMARY KEY,
ProductID INT,
RatingID INT,
ReviewText VARCHAR(MAX),
ReviewDate DATE
)

--ALTERING THE TABLE AND ADDING A COLUMN
ALTER TABLE dbo.ProductReviews_v2
ADD Product_Description VARCHAR(100)

--ALTERNING TABLE CHANGING VARCHAR TO MAX
ALTER TABLE dbo.ProductReviews_v2
ALTER COLUMN Product_Description VARCHAR(MAX)

--DROPPING COLUMNG "PRODUCT_DESCRIPTION" FROM PRODUCTREVIEWS_V2
ALTER TABLE dbo.ProductReviews_v2
DROP COLUMN Product_Description

--SCRIPT FOR VIEWING THE PRIMARY FOR EACH TABLE
SELECT 
	KU.table_name as TABLENAME,
	column_name as PRIMARYKEYCOLUMN
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS TC

INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KU
	ON TC.CONSTRAINT_TYPE = 'PRIMARY KEY'
	AND TC.CONSTRAINT_NAME = KU.CONSTRAINT_NAME
	AND KU.table_name = 'DimDate'

	--DROPPING A PRIMARY KEY
ALTER TABLE DimDate
DROP CONSTRAINT PK_DimDate

--ADDING PK
ALTER TABLE DimDate --Tablename
ADD CONSTRAINT PK_DimDate PRIMARY KEY (Datekey); --ColumnName*/

--ADDING FOREIGN KEY CONSTRAINT
ALTER TABLE SalesSchema.FactInternetSales
ADD CONSTRAINT FK_FactInternetSales_DimDate
FOREIGN KEY (OrderDateKey) REFERENCES DimDate(DateKey)