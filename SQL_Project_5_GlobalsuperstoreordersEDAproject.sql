select * from globalsuperstoreorders;

SELECT COUNT(*) FROM globalsuperstoreorders; -- counting the data comparing it to excel file

select * from globalsuperstoreorders -- selecting and displaying everything in order by the first column (ROW ID)
order by 1;

select OrderID,count(*)  -- narrowing the data selection with the parameters of grouping the data in to group id w/count(*) >1
from globalsuperstoreorders
group by OrderID
having count(*)>1;

select * from globalsuperstoreorders -- checking for uniqueness of order ID or if it does have duplicates.
where OrderID = 'IN-2011-10286';

select RowID,OrderID,count(*) from globalsuperstoreorders -- looking for duplicates even with these combination
group by RowID,OrderID
having count(*)>1;

select * from globalsuperstoreorders -- checking if there are mistakes. Order Date shoul be ahead than ship date.
where ShipDate < OrderDate;

select distinct ShipMode from globalsuperstoreorders; ## identifying the different types of ship modes within the data

SELECT globalsuperstoreorders.*,DATEDIFF(STR_TO_DATE(ShipDate, '%m/%d/%Y'), STR_TO_DATE(OrderDate, '%m/%d/%Y')) AS numofdays
FROM globalsuperstoreorders                    ## finding out the gap between the number of days from orderdate and shipping date
WHERE ShipMode = 'Second Class'
	and ShipDate is not null
    and OrderDate is not null;


SELECT MIN(a.numberofdays), MAX(a.numberofdays) #getting the max and min number of days w/ a ship mode = second class
FROM (
    SELECT DATEDIFF(STR_TO_DATE(ShipDate, '%m/%d/%Y'), STR_TO_DATE(OrderDate, '%m/%d/%Y')) AS numberofdays
    FROM globalsuperstoreorders
    WHERE ShipMode = 'Second Class'
) a;

SELECT MIN(a.numberofdays), MAX(a.numberofdays) #getting the max and min number of days w/ a ship mode = First Class
FROM (
    SELECT DATEDIFF(STR_TO_DATE(ShipDate, '%m/%d/%Y'), STR_TO_DATE(OrderDate, '%m/%d/%Y')) AS numberofdays
    FROM globalsuperstoreorders
    WHERE ShipMode = 'First Class'
) a;

SELECT MIN(a.numberofdays), MAX(a.numberofdays) #getting the max and min number of days w/ a ship mode = Same Day
FROM (
    SELECT DATEDIFF(STR_TO_DATE(ShipDate, '%m/%d/%Y'), STR_TO_DATE(OrderDate, '%m/%d/%Y')) AS numberofdays
    FROM globalsuperstoreorders
    WHERE ShipMode = 'Same Day'
) a;

SELECT MIN(a.numberofdays), MAX(a.numberofdays) #getting the max and min number of days w/ a ship mode = Standard Class
FROM (
    SELECT DATEDIFF(STR_TO_DATE(ShipDate, '%m/%d/%Y'), STR_TO_DATE(OrderDate, '%m/%d/%Y')) AS numberofdays
    FROM globalsuperstoreorders
    WHERE ShipMode = 'Standard Class'
) a;

select CustomerID, OrderID, count(*) #checking if there are multiple orders (if the customer can order multiple orders)
from globalsuperstoreorders
group by CustomerID,OrderID
order by CustomerID;



