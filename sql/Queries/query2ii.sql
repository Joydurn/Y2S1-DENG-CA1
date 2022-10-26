use VideoStore
--Query 2ii View average number of rental days per title
SELECT 
    movDet.movieId,
    MAX(movDet.movieTitle) as 'Title',
    AVG(DATEDIFF(day,trans.startDate,rent.returnDate)) as 'Average Rental Days'
FROM 
    transactions trans, 
    rentPayment rent, 
    transItems,
    inventory inv,
    itemCatalog item,
    movieItem mov,
    movieDetails movDet
WHERE 
    --link FKs
    trans.transId=rent.transId 
    AND trans.transId=transItems.transId
    AND inv.invId=transItems.invId
    AND item.itemId=inv.itemId 
    AND mov.itemId=item.itemId 
    AND mov.movieId=movDet.movieId 
    --conditions
    AND trans.type='rent'
GROUP BY movDet.movieId
