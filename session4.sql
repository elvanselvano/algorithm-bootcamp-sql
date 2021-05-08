USE CoffeeShop

SELECT *
FROM Customer as c, HeaderTransaction as ht
where c.CustomerID = ht.CustomerID

SELECT *
FROM (Customer as c
JOIN HeaderTransaction as ht on c.CustomerID = ht.CustomerID)

JOIN DetailTransaction as dt on ht.TransactionID = dt.TransactionID

SELECT *
FROM Customer

SELECT *
FROM HeaderTransaction

SELECT *
FROM Customer as c 
LEFT JOIN HeaderTransaction as ht on c.CustomerID = ht.CustomerID

SELECT *
FROM HeaderTransaction as ht
RIGHT JOIN Customer as c on ht.CustomerID = c.CustomerID

SELECT *
FROM DetailTransaction as dt
RIGHT JOIN Coffee as c on dt.CoffeeID = c.CoffeeID

SELECT *
FROM Customer as c
FULL JOIN HeaderTransaction as ht on c.CustomerID = ht.CustomerID

SELECT CustomerID
FROM Customer
UNION ALL
SELECT CustomerID
FROM HeaderTransaction

SELECT CustomerID
FROM Customer
INTERSECT
SELECT CustomerID
FROM HeaderTransaction

SELECT CustomerID
FROM HeaderTransaction
INTERSECT
SELECT CustomerID
FROM Customer

SELECT CustomerID
FROM Customer
EXCEPT
SELECT CustomerID
FROM HeaderTransaction

SELECT CustomerID
FROM HeaderTransaction
EXCEPT
SELECT CustomerID
FROM Customer

GO

-- get without intercept
(SELECT CustomerID
FROM Customer
UNION
SELECT CustomerID
FROM HeaderTransaction)
EXCEPT
(SELECT CustomerID
FROM Customer
INTERSECT
SELECT CustomerID
FROM HeaderTransaction)