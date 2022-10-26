use VideoStore

--Query 2i View average number of rental days per customer
SELECT 
    c.customerId,
    MAX(c.firstName)+' '+MAX(c.lastName) as 'Name',
    AVG(DATEDIFF(day,t.startDate,rent.returnDate)) as 'Average Rental Days'
FROM transactions t, rentPayment rent, customer c
WHERE 
    --link FKs
    t.transId=rent.transId 
    AND t.customerId=c.customerId 
    --conditions
    AND t.type='rent'
    AND t.startDate<rent.returnDate --in case of incorrect data (return before renting impossible)
GROUP BY c.customerId
ORDER BY c.customerId
