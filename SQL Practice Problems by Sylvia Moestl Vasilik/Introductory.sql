--Questions from the book "SQL Practice Problems by Sylvia Moestl Vasilik"
--Database: NorthWind sample database from Microsoft
--Beginner level: Q1 to Q19

--Q1. Return all fields from all the shippers
select * from Shippers

--Q2. Select only name & description from the category table
select CategoryName, Description from Categories

--Q3. We’d like to see just the FirstName, LastName, and HireDate of all the employees with the Title of Sales Representative.
select FirstName, LastName, HireDate from Employees where Title = 'Sales Representative'

--Q4. Now we’d like to see the same columns as above, but only for those employees that both have the title of 
-- Sales Representative, and also are in the United States.
select FirstName, LastName, HireDate from Employees where Title = 'Sales Representative' and 
Country = 'USA'

--Q5. Show all the orders placed by a specific employee. The EmployeeID for this Employee (Steven Buchanan) is 5.
select * from Orders where EmployeeID = 5

--Q6. In the Suppliers table, show the SupplierID, ContactName, and ContactTitle for those Suppliers
--whose ContactTitle is not Marketing Manager.
select SupplierID, ContactName, ContactTitle from Suppliers where ContactTitle != 'Marketing Manager'

--Q7. In the products table, we’d like to see the ProductID and ProductName for those products where the
--ProductName includes the string “queso”.
select ProductID, ProductName from Products where ProductName like '%queso%'

--Q8. Write a query that shows the OrderID, CustomerID, and ShipCountry for the orders where
-- the ShipCountry is either France or Belgium.
select OrderID, CustomerID,  ShipCountry from Orders where ShipCountry = 'France' or ShipCountry = 'Belgium'

--Q9. we want to show all the orders from any Latin American country. But we don’t have a list of 
-- Latin American countries : Brazil Mexico Argentina Venezuela
select * from Orders where ShipCountry in ('Brazil','Mexico', 'Argentina', 'Venezuela')

-- Q10. For all the employees in the Employees table, show the FirstName, LastName, Title, and BirthDate.
-- Order the results by BirthDate, so we have the oldest employees first.
select FirstName, LastName, Title, BirthDate from Employees order by BirthDate

-- Q11. In the output of the query above, showing the Employees in order of BirthDate, we see the time of
--the BirthDate field, which we don’t want. Show only the date portion of the BirthDate field.
select FirstName, LastName, Title, cast(BirthDate as date) as BirthDate from Employees order by BirthDate
-- Or
select FirstName, LastName, Title, convert(date, BirthDate, 105) as BirthDate from Employees order by BirthDate

-- Q12. Show the FirstName and LastName columns from the Employees table, and then create a new column
-- called FullName, showing FirstName and LastName joined together in one column, with a space in-between.
select FirstName, LastName, concat(FirstName,' ', LastName) as FullName from Employees

--Q13. In the OrderDetails table, we have the fields UnitPrice and Quantity. Create a new field, TotalPrice, 
--that multiplies these two together. We’ll ignore the Discount field for now. In addition, show the 
--OrderID, ProductID, UnitPrice, and Quantity. Order by OrderID and ProductID.
select OrderID, ProductID, UnitPrice, Quantity, (UnitPrice * Quantity) as TotalPrice from OrderDetails
order by OrderID, ProductID

--Q14. How many customers do we have in the Customers table?
select count(*) from Customers

--Q15. Show the date of the first order ever made in the Orders table.
select min(OrderDate) as FirstOrder from Orders

--Q16. Show a list of countries where the Northwind company has customers
select distinct(country) as Country from Customers 
--Or
select country from Customers group by Country

--Q17. Show a list of all the different values in the Customers table for ContactTitles. Also include a
--count for each ContactTitle.
select ContactTitle, count(ContactTitle) as countTitles from Customers group by ContactTitle

--Q18. We’d like to show, for each product, the associated Supplier. Show the ProductID, ProductName, and the
--CompanyName of the Supplier. Sort by ProductID.
select  P.ProductID, P.ProductName, S.CompanyName from Products P left join Suppliers S 
on P.SupplierID = S.SupplierID

--Q19. We’d like to show a list of the Orders that were made, including the Shipper that was used. Show the
--OrderID, OrderDate (date only), and CompanyName of the Shipper, and sort by OrderID.
--In order to not show all the orders (there’s more than 800), show only those rows with an OrderID of less
--than 10300.
select O.OrderID, cast(O.OrderDate as date) as OrderDate, S.CompanyName from Orders O left join Shippers S on 
O.ShipVia = S.ShipperID where O.OrderID <10300 order by O.OrderID
