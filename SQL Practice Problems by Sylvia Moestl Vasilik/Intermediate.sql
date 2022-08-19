--Questions from the book "SQL Practice Problems by Sylvia Moestl Vasilik"
--Database: NorthWind sample database from Microsoft
--Intermediate level: Q20 to Q31

--Q20. The total number of products in each category. Sort the results by the total number of products, 
--in descending order.
select C.CategoryName, count(productID) as NumberofProducts  from Products P left join
Categories C on P.CategoryID = C.CategoryID group by C.CategoryName

--Q21. In the Customers table, show the total number of
--customers per Country and City.
select count(*) as NumberofCustomers, Country, City from Customers group by Country, City

--Q22. What products do we have in our inventory that should be reordered? For now, just use the fields
--UnitsInStock and ReorderLevel, where UnitsInStock is less than the ReorderLevel, ignoring the fields
--UnitsOnOrder and Discontinued. Order the results by ProductID.
select ProductID, ProductName from Products where UnitsInStock < ReorderLevel

--Q23. Now we need to incorporate these fields— UnitsInStock, UnitsOnOrder, ReorderLevel,
--Discontinued—into our calculation. We’ll define “products that need reordering” with the following:
--UnitsInStock plus UnitsOnOrder are less than or equal to ReorderLevel and The Discontinued flag is false (0).
select ProductID, ProductName from Products where (UnitsInStock +  UnitsOnOrder) <= ReorderLevel  and
Discontinued = '0'

----------------------------------------------------------------Case statement-----------------------------------------------------------
--Q24. A salesperson for Northwind is going on a business trip to visit customers, and would like to see a list of
--all customers, sorted by region, alphabetically. However, he wants the customers with no region
--(null in the Region field) to be at the end, instead of at the top, where you’d normally find the null values.
--Within the same region, companies should be sorted by CustomerID.
select CustomerID, CompanyName, Region from Customers order by Region Desc
--Or
select CustomerID, CompanyName, Region,
Case 
 when Region is null then 1
 else 0
 End as dummyVal
 from Customers   
 Order by dummyVal

-- Q25. Some of the countries we ship to have very high freight charges. We'd like to investigate some more
--shipping options for our customers, to be able to offer them lower freight charges. Return the three
--ship countries with the highest average freight overall, in descending order by average freight.
select Top 3 ShipCountry, avg(Freight) as AverageFreight from Orders
group by ShipCountry
order by AverageFreight desc

--Q26. We're continuing on the question above on high freight charges. Now, instead of using all the orders
--we have, we only want to see orders from the year 1998.
select Top 3 ShipCountry, avg(Freight) as AverageFreight from Orders where year(OrderDate) = 1998
group by ShipCountry order by AverageFreight desc

--Q27. Same problem as above using between statement
select Top 3 ShipCountry, avg(Freight) as AverageFreight from Orders where OrderDate between '1997-12-31'
and '1999-01-01'
group by ShipCountry order by AverageFreight desc

------------------------------------------------------------Date functions-------------------------------------------------------------------
--Q28. We're continuing to work on high freight charges. We now want to get the three ship countries with the
--highest average freight charges. But instead of filtering for a particular year, we want to use the last
--12 months of order data, using as the end date the last OrderDate in Orders.
select Top 3 ShipCountry, avg(Freight) as AverageFreight from Orders where 
dateadd(mm, -12, (select max(OrderDate) from Orders)) < = OrderDate
group by ShipCountry order by AverageFreight desc
--Or
select Top 3 ShipCountry, avg(Freight) as AverageFreight from Orders where 
datediff(mm, OrderDate, (select max(OrderDate) from Orders)) <= 12
group by ShipCountry Order by AverageFreight desc

-------------------------------------------------------Joining four tables------------------------------------------------------------------
--Q29. We're doing inventory, and need to show information like the below, for all orders. Sort by OrderID and
--Product ID. EmployeeID LastName OrderID ProductName Quantity
select D.ProductID, E.EmployeeID, E.LastName, O.OrderID, P.ProductName, D.Quantity from Orders O
left join Employees E on O.EmployeeID = E.EmployeeID 
left join OrderDetails D on O.OrderID = D.OrderID
left join Products P on D.ProductID = P.ProductID

-------------------------------------------------------Except------------------------------------------------------------------------------------
--Q30. There are some customers who have never actually placed an order. Show these customers.
(select C.CompanyName, O.OrderID from Customers C left join Orders O 
on C.CustomerID = O.CustomerID)
except
(select C.CompanyName,O.OrderID from Customers C join Orders O 
on C.CustomerID = O.CustomerID)
--or
select C.CompanyName, O.OrderID from Customers C  left join Orders O 
on C.CustomerID = O.CustomerID  where O.OrderID is null 

