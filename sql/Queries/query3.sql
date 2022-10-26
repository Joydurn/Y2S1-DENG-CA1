use VideoStore 
--Query 3 View 10 most frequently reserved titles for last year
SELECT TOP (10) --change 10 to whatever number
    movDet.movieId,
    max(movDet.movieTitle) as 'Title',
    COUNT(transItems.transId) as 'Times Reserved'
FROM 
    transactions trans, 
    transItems,
    inventory inv,
    itemCatalog item,
    movieItem mov,
    movieDetails movDet
WHERE 
    --link FKs
    trans.transId=transItems.transId
    AND inv.invId=transItems.invId
    AND item.itemId=inv.itemId 
    AND mov.itemId=item.itemId 
    AND mov.movieId=movDet.movieId 
    --conditions
    AND trans.type='reserve'
    AND trans.startDate > DATEADD(year,-1,GETDATE())
GROUP BY 
    movDet.movieId
ORDER BY 'Times Reserved' DESC