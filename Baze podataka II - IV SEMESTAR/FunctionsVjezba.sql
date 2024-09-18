/* Basic Update:

Task: Update a single column in a table.
Scenario: You have a table Employees with columns EmployeeID, FirstName, and Salary. Increase the salary of the employee with EmployeeID = 5 by 500.
Hint: Use WHERE to target a specific row.
sql */

UPDATE Northwind.dbo.Employees
SET Salary = Salary + 500
WHERE EmployeeID = 5

/* Update All Rows:

Task: Update a column for all rows in the table.
Scenario: In the Products table, set the Discount column to 10% for all products.
Hint: Don’t use a WHERE clause to affect all rows */

UPDATE Northwind.dbo.Products
SET Discount = 0.1

/* Update NULL Values:

Task: Replace NULL values in a column.
Scenario: In the Orders table, update the ShippingCost column by setting all NULL values to 5.
Hint: Use IS NULL to target the rows where the value is NULL */

UPDATE Northwind.dbo.Orders
SET ShippingCost = 5
WHERE ShippingCost is null

/* Update Based on Another Column:

Task: Use the value from one column to update another column.
Scenario: In the Products table, update the Price column by increasing all prices by 20% if the Category is 'Electronics'.
Hint: Use WHERE to filter rows by category. */

UPDATE Northwind.dbo.Products
SET UnitPrice = UnitPrice * (1.20)
WHERE Category = 'Electronics'

/* Conditional Update:

Task: Update based on a condition that compares multiple columns.
Scenario: In the Employees table, set the Bonus column to 1000 for 
employees whose Salary is greater than 50,000 but less than 70,000. */

UPDATE Northwind.dbo.Employees
SET Bonus = 1000
WHERE Salary > 50000 AND Salary < 70000

/* Update Multiple Columns:

Task: Update multiple columns in a single statement.
Scenario: In the Customers table, update the City to 
'New York' and Country to 
'USA' for customers whose CustomerID is greater than 1000 */
UPDATE Northwind.dbo.Customers
SET City = 'New York', Country = 'USA'
WHERE CustomerID > 1000

/* Update Using Data from Another Table:

Task: Use data from one table to update another table.
Scenario: You have two tables: 
Products and Suppliers. The Products table has a
SupplierID, and you want to
update the Products table’s Price to 20% off for all 
products from suppliers located in 'Canada'
(from the Suppliers table). */

UPDATE Products
SET Price = Price * (1-0.2)
FROM Products AS P
INNER JOIN Suppliers S ON P.supplierID = S.supplierID
WHERE S.country = 'Canada'