--Query 5 view monthly revenue of the company from last 12 months EXCLUDING late charges
use VideoStore

DECLARE @ThisDate DATE = GETDATE() --replace GETDATE() with any date 'YYYYMMDD'

SELECT 
    DATEPART(year,r.returnDate) as 'Year',
    DATEPART(month,r.returnDate) as 'Month',
    CASE 
        WHEN SUM(item.chargeDaily*DATEDIFF(day,t.startDate,r.returnDate)) is null THEN 0
        ELSE SUM(item.chargeDaily*DATEDIFF(day,t.startDate,r.returnDate)) END as 'Month Revenue'
FROM
    rentPayment r,
    transactions t,
    transItems trans,
    inventory inv,
    itemCatalog item
WHERE 
    --link FKs 
    r.transId=t.transId
    AND t.transId=trans.transId
    AND trans.invId=inv.invId
    AND inv.itemId=item.itemId
    --conditions for date
    AND ( DATEDIFF(DAY,r.returnDate, @ThisDate) <= 365  AND DATEDIFF(DAY,r.returnDate, @ThisDate) > 0--either 365 days before (not negative)
    OR (MONTH(r.returnDate)=MONTH(DATEADD(year,-1,@ThisDate)) AND YEAR(r.returnDate)=YEAR(DATEADD(year,-1,@ThisDate))) --OR in last year's same month
    OR (MONTH(r.returnDate)=MONTH(@ThisDate) AND YEAR(r.returnDate)=YEAR(@ThisDate))) --OR in this year's same month
GROUP BY 
    DATEPART(year,r.returnDate),
    DATEPART(month,r.returnDate)
ORDER BY 
    DATEPART(year,r.returnDate) DESC,
    DATEPART(month,r.returnDate) DESC
