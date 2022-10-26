use VideoStore
--Query 4 View 100 best customers in terms of money paid to the company
SELECT TOP(100)
    c.customerId,
    MAX(c.firstName)+' '+MAX(c.lastName) as 'Name',
    --calculate rent charge
    SUM(item.chargeDaily*DATEDIFF(day,t.startDate,r.returnDate)+ --then calculate late charges (if any)
    l.lateCharge*(CASE when DATEDIFF(day,t.dueDate,r.returnDate) < 0 then 0 else DATEDIFF(day,t.dueDate,r.returnDate) end))
    as 'Money Paid ($)'
FROM 
    rentPayment r, 
    transactions t, 
    customer c,
    transItems trans, 
    inventory inv, 
    itemCatalog item,
    lateCharge l
WHERE 
    --link FKs
    r.transId=t.transId 
    AND t.transId=trans.transid
    AND t.customerId=c.customerId
    AND trans.invId=inv.invId
    AND inv.itemId=item.itemId 
    AND l.categoryName=item.categoryName
    --conditions
    AND t.startDate<r.returnDate --in case of incorrect data (return before renting impossible)
GROUP BY c.customerId
ORDER BY 'Money Paid ($)' DESC
