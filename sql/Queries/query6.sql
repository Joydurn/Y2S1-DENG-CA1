--Query 6 View total amount of penalty incurred by each customer for movies and equipment respectively
use VideoStore 
SELECT 
    c.customerId,
    MAX(c.firstName)+' '+MAX(c.lastName) as 'Name',
    --divide into movies and equipment
    CASE 
        when item.categoryName='movie' then 'movie'
        when item.categoryName in ('vcr','videoCamera') then 'equipment'
    END as 'Type',
    --calculate late charges (penalty)
    SUM(l.lateCharge*(CASE when DATEDIFF(day,t.dueDate,r.returnDate) < 0 then 0 else DATEDIFF(day,t.dueDate,r.returnDate) end)) as 'Penalty'
FROM
    customer c,
    transactions t,
    rentPayment r,
    transItems trans,
    inventory inv,
    itemCatalog item,
    lateCharge l
WHERE
    --link FKs
    c.customerId=t.customerId
    AND r.transId=t.transId
    AND t.transId=trans.transId
    AND trans.invId=inv.invId
    AND inv.itemId=item.itemId
    AND l.categoryName=item.categoryName
    --conditions
    
GROUP BY 
    c.customerId, 
    CASE 
        when item.categoryName='movie' then 'movie'
        when item.categoryName in ('vcr','videoCamera') then 'equipment'
    END
ORDER BY
    c.customerId,'Type'

--ALTERNATE query for getting 3 seperate categories
-- SELECT 
--     c.customerId,
--     MAX(c.firstName)+' '+MAX(c.lastName) as 'Name',
--     --divide into movies and equipment
--     item.categoryName,
--     --calculate late charges (penalty)
--     SUM(l.lateCharge*(CASE when DATEDIFF(day,t.dueDate,r.returnDate) < 0 then 0 else DATEDIFF(day,t.dueDate,r.returnDate) end)) as 'Penalty'
-- FROM
--     customer c,
--     transactions t,
--     rentPayment r,
--     transItems trans,
--     inventory inv,
--     itemCatalog item,
--     lateCharge l
-- WHERE
--     --link FKs
--     c.customerId=t.customerId
--     AND r.transId=t.transId
--     AND t.transId=trans.transId
--     AND trans.invId=inv.invId
--     AND inv.itemId=item.itemId
--     AND l.categoryName=item.categoryName
--     --conditions
    
-- GROUP BY 
--     c.customerId, 
--     item.categoryName
-- ORDER BY
--     c.customerId,item.categoryName
