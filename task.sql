-- 13-06-2024 || SQL Tasks

create database datasets

use datasets

create table EmpTable(EmployeeID int, FirstName varchar(50),LastName varchar(50));

insert into EmpTable values(1,'John','Doe');

insert into EmpTable values(2,'Jane','Smith');

insert into EmpTable values(3,'Alice','Jhonson');

select * 
from EmpTable;

Create table Products_Table(ProductID int, ProductName varchar(50),ProductDescription varchar(50));


insert into Products_Table values(101,'Widget A','A standard widget');

insert into Products_Table values(102,'Gadget B	','A fancy new gadget');

insert into Products_Table values(103,'Thingamajig	','A very useful tool');

select * 
from Products_Table;

Create table SalesOrders_Table(SalesOrderID	int,OrderDate datetime,TotalAmount float);

insert into SalesOrders_Table values (1001,'2023-01-15 14:33:00',150.00)

insert into SalesOrders_Table values (1002,'2023-03-22 10:45:00',200.00)

insert into SalesOrders_Table values (1003,'2024-05-17 09:20:00',350.00)


select *
from SalesOrders_Table 

create table Customers_Table(CustomerID int, CustomerName varchar(50), Address varchar(50))


insert into Customers_Table values (201, 'Acme Corp', '123 Main St')

insert into Customers_Table values (202, 'Globex Inc', '456 Elm St')

insert into Customers_Table values (203, 'Initech', '789 Oak St')

select *
from Customers_Table


-- Ex 1
select EmployeeID, UPPER(concat(FirstName,LastName)) as FullName
from EmpTable;

-- Ex 2
select ProductID, ProductName, LEN(ProductDescription) as DescriptionLength
from Products_Table 

-- Ex-3

select SalesOrderID, format(OrderDate,'yyyy-MM-dd') as FormattedOrderDate
from SalesOrders_Table

-- Ex 4

select CustomerID, CustomerName, TRIM(Address) as CleanedAddress
from Customers_Table


-- Ex 5

select *
from SalesOrders_Table

select datepart(YEAR,OrderDate) as Year,sum(TotalAmount) as TotalSales
FROM SalesOrders_Table
group by datepart(YEAR,OrderDate)


--Question 1

CREATE TABLE DepartmentTable (
  DepartmentID INT PRIMARY KEY,
  DepartmentName VARCHAR(50)
);

INSERT INTO DepartmentTable VALUES
  (101, 'Sales'),
  (102, 'Engineering'),
  (103, 'Marketing');

ALTER TABLE EmpTable
ADD DepartmentID INT;

ALTER TABLE EmpTable
ADD CONSTRAINT FK_EmpTable_DepartmentTable
FOREIGN KEY (DepartmentID)
REFERENCES DepartmentTable(DepartmentID);

UPDATE EmpTable
SET DepartmentID = 101
WHERE EmployeeID IN (1);

UPDATE EmpTable
SET DepartmentID = 102
WHERE EmployeeID IN (2);

UPDATE EmpTable
SET DepartmentID = 103
WHERE EmployeeID IN (3);


select * from DepartmentTable



-- 1
SELECT 
  e.EmployeeID,
  CONCAT(UPPER(e.FirstName), ' ', UPPER(e.LastName)) AS FullName,
  LOWER(d.DepartmentName) AS DepartmentName
FROM 
  EmpTable e
JOIN 
  DepartmentTable d ON e.DepartmentID = d.DepartmentID


-- 2
select ProductID, ProductName, LEN(ProductDescription) as DescriptionLength, REVERSE(ProductDescription) as ReversedDescription
from Products_Table

-- Question 3

ALTER TABLE SalesOrders_Table
ADD CustomerID INT;


UPDATE SalesOrders_Table
SET CustomerID = (
  SELECT CustomerID
  FROM Customers_Table
  WHERE Customers_Table.CustomerID = SalesOrders_Table.CustomerID
);
truncate table SalesOrders_Table;

INSERT INTO SalesOrders_Table (SalesOrderID, CustomerID, OrderDate, TotalAmount)
VALUES
  (1001, 201, '2023-01-15 14:33:00', 150.00),
  (1002, 202, '2023-03-22 10:45:00', 200.00),
  (1003, 201, '2024-05-17 09:20:00', 350.00);


  -- 3

  select s.CustomerID,c.CustomerName,datepart(year,s.OrderDate) as Year,s.TotalAmount as TotalSales from SalesOrders_Table s,Customers_Table c 
  where s.CustomerID = c.CustomerID ;


  --4
  SELECT 
  ProductID,
  ProductName,
  REPLACE(ProductDescription, 'useful', 'beneficial') AS ModifiedDescription
FROM 
  Products_Table
WHERE 
  ProductDescription LIKE '%useful%'


  -- 5
  select s.SalesOrderID,c.CustomerName,FORMAT(s.OrderDate, 'yyyy-MM-dd') as FormattedOrderDate,s.TotalAmount from SalesOrders_Table s,Customers_Table c 
  where s.CustomerID = c.CustomerID ;




