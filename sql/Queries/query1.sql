USE VideoStore

--Query 1 View total number of outgoing movies per store and per month.
SELECT 
    store.storeId,
    store.location as 'location',
    --Merge year and month together (get month name)
    CAST(DATEPART(year,trans.startDate) AS nvarchar(10)) + ' '+
    DateName( month , DateAdd( month , DATEPART(month,trans.startDate), 0 ) - 1 ) as 'month',
    COUNT(transItems.transId) as 'Rented Movies'
FROM 
    store,
    itemCatalog item,
    inventory inv,
    transItems, 
    transactions trans
WHERE 
    --link FKs
    store.storeId=inv.storeId 
    AND item.itemId=inv.itemId 
    AND inv.invId=transItems.invId
    AND transItems.transId=trans.transId 
    --conditions 
    AND item.categoryName='movie'
    AND trans.type='rent'

GROUP BY 
    --group by store, then year, then month
    store.storeId, 
	store.location,
    DATEPART(year,trans.startDate),
    DATEPART(month,trans.startDate) 
ORDER BY 
    storeId ASC,
    DATEPART(year,trans.startDate) ASC,
    DATEPART(month,trans.startDate) ASC

--ALTERNATE 1, QUERY FOR PER STORE ONLY
-- SELECT 
--     store.storeId,
--     max(store.location) as 'location',
--     COUNT(transItems.transId) as 'Rented Movies'
-- FROM 
--     store,
--     itemCatalog item,
--     inventory inv,
--     transItems, 
--     transactions trans
-- WHERE 
--     --link FKs
--     store.storeId=inv.storeId 
--     AND item.itemId=inv.itemId 
--     AND inv.invId=transItems.invId
--     AND transItems.transId=trans.transId 
--     --AND store.storeId=trans.storeId  
--     --conditions 
--     AND item.categoryName='movie'
--     AND trans.type='rent'
-- GROUP BY 
--     --group by store, then year, then month
--     store.storeId
-- ORDER BY 
--     storeId ASC



--ALTERNATE 2, QUERY FOR MONTH ONLY
-- SELECT 
--     --Merge year and month together (get month name)
--     CAST(DATEPART(year,trans.startDate) AS nvarchar(10)) + ' '+
--     DateName( month , DateAdd( month , DATEPART(month,trans.startDate), 0 ) - 1 ) as 'month',
--     COUNT(transItems.transId) as 'Rented Movies'
-- FROM 
--     itemCatalog item,
--     inventory inv,
--     transItems, 
--     transactions trans
-- WHERE 
--     --link FKs
--     item.itemId=inv.itemId 
--     AND inv.invId=transItems.invId
--     AND transItems.transId=trans.transId 
--     --AND store.storeId=trans.storeId  
--     --conditions 
--     AND item.categoryName='movie'
--     AND trans.type='rent'

-- GROUP BY 
--     --group by year, then month
--     DATEPART(year,trans.startDate),
--     DATEPART(month,trans.startDate) 
-- ORDER BY 
--     DATEPART(year,trans.startDate) ASC,
--     DATEPART(month,trans.startDate) ASC

    