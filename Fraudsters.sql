WITH counter AS (
    SELECT USER_ID
    FROM transactions AS a 
    WHERE 
        coalesce((SELECT sum(amount) FROM transactions WHERE TYPE = 'TOPUP' AND USER_ID = a.USER_ID),0.0) -
            coalesce((SELECT sum(amount) FROM transactions WHERE TYPE <> 'TOPUP' AND USER_ID = a.USER_ID),0.0) 
            < 0      
    GROUP BY USER_ID
)
SELECT count() FROM counter limit 10;
