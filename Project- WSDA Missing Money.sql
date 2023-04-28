/*
Project Description: Money has gone missing from 2011-2012 and WASD Music has tasked us with finding out who the primary suspect is.
*/




/*
Created by: Addison Ratchford
Created Date: 04-26-2023
Project Queston 1: How Many transactons took plac
*/

--1.) How many transactions took place between 2011-2012

SELECT
	count(*)
FROM
	Invoice
WHERE
	InvoiceDate >= '2011-01-01' and InvoiceDate  <= '2012-01-01'


	
	
	/*
Created by: Addison Ratchford
Created Date: 04-27-2023
Description: Project Question 2
1.) Get a list of customers who made purchases between 2011-2012
2..) Get a list of customers, sales reps, total transations amounts for each customer between 2011-2012
3.) How many Transactions are abouve the average transaction amount during the same time?
4.) What was average transaction amount for each year that WSDA Music CO has been in business
*/

-- 1. Get a list of customers who made purchases between 2011 and 2012

SELECT
	c.FirstName,
	c.LastName,
	i.total
FROM
	invoice as i 
inner JOIN
	Customer as c 
WHERE
	InvoiceDate >= '2011-01-01' and InvoiceDate <= '2012-12-31'
ORDER by
	i.total DESC
	
	
	
	
--2 Get a list of customers, sales reps, total transations amounts for each customer between 2011-2012

SELECT
	c.FirstName as [Customer FN],
	c.LastName AS [Customer LN],
	e.FirstName as [Employee FN],
	e.LastName AS [Employee LN],
	i.total
FROM
	invoice as i
INNER JOIN
	customer as c
ON
i.CustomerId = c.CustomerId
inner JOIN
	employee as e
ON
	e.EmployeeId = c.CustomerId
WHERE
	InvoiceDate >= '2011-01-01' and InvoiceDate <= '2012-12-31'
ORDER by
	i.total DESC
	
	
-- 3.) How many Transactions are abouve the average transaction amount during the same time?
	
SELECT
	round(avg(total),2) as [Avg Transaction Amount]
FROM
	Invoice
WHERE
InvoiceDate >= '2011-01-01' and InvoiceDate <= '2012-12-31'
	
-- Get the number of transaction above the average transaction amount
	
SELECT
	count(total) as [num of Transaction Above Avg]
FROM
		Invoice
WHERE
	total>
						(				SELECT
											round(avg(total),2) as [avg Transaction Amount]
										FROM
											Invoice
										WHERE
											InvoiceDate >= '2011-01-01' and InvoiceDate <= '2012-12-31'
						)
AND
InvoiceDate >= '2011-01-01' and InvoiceDate <= '2012-12-31'
						
--4.) What was the average transaction amount for each year that WSDA Music has been in business?

SELECT
	round(avg(total),2) as [Avg Transaction Amount],
	strftime ('%Y', InvoiceDate) as [Year]
FROM
	Invoice
GROUP by
	strftime ('%Y', InvoiceDate)
	
	/*
Created by: Addison Ratchford
Created Date: 04-27-2023
Description: Project Challenge 3
1.) Get a list of employees who exceed the average transaction amount from sales they generated during 2011-2012
2..) Create a commission Payout Coloumn that displays each employees commission based on 15% of annual sales
3.) Which employee had the highest commission 
4.) List the customers that were served by the employee identified in the last question
5.) Which Customer made the highest purchase
6.) Look at the customer record, anything suspect?
7.) Who can you conclude is the primary person of interest 
*/

--1.) Get a list of employees who exceed the average transaction amount from sales they generated during 2011-2012

SELECT
	e.FirstName,
	e.LastName,
	sum(i.total) as [Total Sales]
FROM
	invoice as i 
inner JOIN
	Customer as c
ON 
 i.CustomerId = c.CustomerId
inner JOIN
	Employee as e
ON 
	e.EmployeeId = c.SupportRepId
WHERE
		InvoiceDate >= '2011-01-01' and InvoiceDate <= '2012-12-31'
AND
	i.total > 11.66  
GROUP by
	e.FirstName,
	e.LastName
ORDER by
	e.LastName
	
--2..) Create a commission Payout Coloumn that displays each employees commission based on 15% of annual sales

SELECT
	e.FirstName,
	e.LastName,
	sum(i.total) as [total sales],
	round (sum(i.total) *.15,2) as [Commission Payout]
		
FROM
	Invoice as i
INNER JOIN
	Customer as c
ON
	i.CustomerId = c.CustomerId
INNER JOIN
	Employee as e
ON
e.EmployeeId = c.SupportRepId
GROUP by
	e.FirstName,
	e.LastName
ORDER by
	e.LastName	
	
--3.) Who had the highest commision?
--Jane Peacock $275.09	
	
--4.) List the customers that Jane Peaccock had 

SELECT
	c.FirstName as [Customer FN],
	c.LastName AS [Customer LN],
	e.FirstName as [Employee FN],
	e.LastName AS [Employee LN],
	sum(i.total) as [Total Sales],
	round(sum(i.total)*.15,2) as [Commision Payout]
FROM
	invoice as i
INNER JOIN
	customer as c
ON
i.CustomerId = c.CustomerId
inner JOIN
	employee as e
ON
	e.EmployeeId = c.SupportRepId
WHERE
	InvoiceDate >= '2011-01-01' and InvoiceDate <= '2012-12-31'
AND
e.LastName = 'Peacock'
GROUP By
	c.FirstName,
	c.LastName,
	e.FirstName,
	e.LastName
ORDER by
[Total Sales] DESC	
	
--5.) Which customer made the highest purchase
			-- John Doeein
			
			
--6.) Does the customer record look suspicious?

SELECT
	*
FROM
	Customer as c
WHERE
	c.LastName = 'Doeein'  				--Support Id equals 3 
	
-- 7.) Who is our Primary Person of Interest?
		-- Jane Peacock
	
	
	
	
	
	
	
	
	
	
	
	
	









	
	