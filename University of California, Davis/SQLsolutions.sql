------------------------------------------------------------------
------------------------------------------------------------------
-- HOMEWORK 1
------------------------------------------------------------------
------------------------------------------------------------------


-- COLONIAL DATABASE
------------------------------------------------------------------

-- 1)
SELECT TripName
FROM trip
WHERE Season='Late Spring';
        
-- 2)
SELECT TripName
FROM trip
WHERE (State='VT' or MaxgrpSize > 10);
       
-- 3)
SELECT TripName
FROM trip
WHERE (Season='Late Fall' or  Season='Early Fall' );
        
-- 4)
SELECT
        COUNT(TripID)
FROM
        trip
WHERE 
        (State='VT' or State='CT');
        
-- 5)
SELECT TripName
FROM trip
WHERE StartLocation!= 'New Hampshire';

-- 6)
SELECT TripName, StartLocation
FROM trip
WHERE Type='Biking';

-- 7)
SELECT TripName
FROM trip
WHERE (Type='Hiking' and Distance > 6)
ORDER BY TripName;
        
-- 8)
SELECT TripName
FROM trip
WHERE (Type='Paddling' or State='VT');
      
-- 9)
SELECT COUNT(TripID)
FROM trip
WHERE (type='Hiking' or Type='Biking');
        
-- 10)
SELECT TripName, State
FROM trip
WHERE Season='Summer'
ORDER BY State, TripName;  

-- 11)
SELECT TripName
FROM trip
RIGHT JOIN (
        SELECT tripguides.GuideNum AS GuideNum, tripguides.TripID AS TripID
        FROM  tripguides
        LEFT JOIN guide ON guide.GuideNum = tripguides.GuideNum
        WHERE (guide.FirstName='Miles' and guide.LastName='Abrams')
        ) AS JOINT 
ON trip.TripID = JOINT.TripID;

-- 11) SECND TRY (WITHOUT SUBQUERIES)
SELECT TripName
FROM trip AS A
LEFT JOIN tripguides AS B ON A.TripID = B.TripID
LEFT JOIN guide AS C ON B.GuideNum = C.GuideNum
WHERE (C.FirstName='Miles' and C.LastName='Abrams');

-- 12) 
SELECT TripName
FROM trip AS A
LEFT JOIN tripguides AS B ON A.TripID = B.TripID
LEFT JOIN guide AS C ON B.GuideNum = C.GuideNum
WHERE (C.FirstName='Rita' and C.LastName='Boyers' and A.Type='Biking');

-- 13)
SELECT C.LastName, A.TripName, A.StartLocation
FROM trip AS A
LEFT JOIN reservation AS B ON A.TripID = B.TripID
LEFT JOIN customer AS C ON B.CustomerNum = C.CustomerNum
WHERE B.TripDate='2018-07-23';

-- 14)
SELECT COUNT(ReservationID)
FROM reservation
WHERE (TripPrice >50 and TripPrice<100);

-- 15)
SELECT C.LastName, A.TripName, A.Type
FROM trip AS A
LEFT JOIN reservation AS B ON A.TripID = B.TripID
LEFT JOIN customer AS C ON B.CustomerNum = C.CustomerNum
WHERE B.TripPrice>100;

-- 16)
SELECT C.LastName
FROM reservation AS A
LEFT JOIN trip AS B ON A.TripID = B.TripID
LEFT JOIN customer AS C ON A.CustomerNum = C.CustomerNum
WHERE B.State='ME';

-- 16) (SECOND TRY)
SELECT C.LastName
FROM trip AS A
RIGHT JOIN reservation AS B ON A.TripID = B.TripID
LEFT JOIN customer AS C ON B.CustomerNum = C.CustomerNum
WHERE A.State='ME';

-- 17)
SELECT State, COUNT(TripID)
FROM trip
GROUP BY State
ORDER BY State;

-- 18) (CHANGE A,B,C order into left to right)
SELECT B.ReservationID, A.LastName, C.TripName
FROM reservation AS B
LEFT JOIN trip AS C ON C.TripID = B.TripID
LEFT JOIN customer AS A ON A.CustomerNum = B.CustomerNum
WHERE B.NumPersons>4;

-- 19)
SELECT C.TripName, E.FirstName, E.LastName
FROM trip AS C
LEFT JOIN tripguides AS D ON C.TripID = D.TripID
LEFT JOIN guide AS E ON E.GuideNum = D.GuideNum
WHERE C.State='NH'
ORDER BY C.TripName, E.LastName;

-- 20)
SELECT B.ReservationID, A.CustomerNum, A.LastName, A.FirstName
FROM reservation AS B
LEFT JOIN trip AS C ON C.TripID = B.TripID
LEFT JOIN customer AS A ON A.CustomerNum = B.CustomerNum
WHERE B.TripDate LIKE '2018-07-%';

-- 21)
SELECT B.ReservationID, C.TripName, A.LastName, A.FirstName, (B.TripPrice+B.OtherFees)*B.NumPersons AS TotalCost
FROM reservation AS B
LEFT JOIN trip AS C ON C.TripID = B.TripID
LEFT JOIN customer AS A ON A.CustomerNum = B.CustomerNum
WHERE B.NumPersons > 4;

-- 22)
SELECT FirstName
FROM customer
WHERE (FirstName LIKE 'L%' OR FirstName LIKE 'S%')
ORDER BY FirstName;

-- 23)
SELECT C.TripName
FROM trip AS C
LEFT JOIN reservation AS B ON C.TripID = B.TripID
WHERE (B.TripPrice <= 50 OR B.TripPrice >= 30); 

-- 24)
SELECT COUNT(TripName)
FROM trip AS C
LEFT JOIN reservation AS B ON C.TripID = B.TripID
WHERE (B.TripPrice <= 50 OR B.TripPrice >= 30);

-- 25)
SELECT C.TripID, C.TripName, B.ReservationID
FROM trip AS C
LEFT JOIN reservation AS B ON C.TripID = B.TripID 
WHERE B.ReservationID IS NULL --Also B.TripID IS NULL;
GROUP BY C.TripID;

-- 26)
SELECT CONCAT(B.TripID,' and ',C.TripID)  AS TripID,
       CONCAT(B.TripName,' and ',C.TripName) AS TripName,
       CONCAT (B.StartLocation,' and ',C.StartLocation) AS StartLocation,
       CONCAT (B.State,' and ',C.State) AS State,
       CONCAT (B.Distance,' and ',C.Distance) AS Distance,
       CONCAT (B.MaxGrpSize,' and ',C.MaxGrpSize) AS MaxGrpSize,
       CONCAT (B.Type,' and ',C.Type) AS Type,
       CONCAT (B.Season,' and ',C.Season) AS Season
FROM trip AS C
LEFT JOIN trip AS B ON C.StartLocation = B.StartLocation
WHERE B.TripID < C.TripID;

-- 27)
-- CONFUSING STATEMENT
SELECT DISTINCT A.* 
FROM customer AS A
LEFT JOIN reservation AS B ON A.CustomerNum = B.CustomerNum
WHERE (A.State='NJ' OR B.CustomerNum IS NOT NULL);

-- 28)
SELECT E.*
FROM guide AS E
LEFT JOIN tripguides AS D ON D.GuideNum=E.GuideNum
LEFT JOIN trip AS C ON C.TripID=D.TripID
WHERE C.TripID IS NULL;


-- 29) 
SELECT CONCAT(B.GuideNum,' and ',C.GuideNum)  AS GuideNum,
       CONCAT(B.LastName, B.FirstName,' and ',C.LastName, C.FirstName) AS Name,
       CONCAT (B.City, B.Address, B.PostalCode,' and ',C.City, C.Address, C.PostalCode) AS Direction,
       CONCAT (B.State,' and ',C.State) AS State,
       CONCAT (B.PhoneNum,' and ',C.PhoneNum) AS PhoneNum,
       CONCAT (B.HireDate,' and ',C.HireDate) AS HireDate
FROM guide AS C
LEFT JOIN guide AS B ON C.State = B.State
WHERE B.GuideNum < C.GuideNum;

-- 30)
SELECT CONCAT(B.GuideNum,' and ',C.GuideNum)  AS GuideNum,
       CONCAT(B.LastName, B.FirstName,' and ',C.LastName, C.FirstName) AS Name,
       CONCAT (B.State, B.Address, B.PostalCode,' and ',C.State, C.Address, C.PostalCode) AS Direction,
       CONCAT (B.City,' and ',C.City) AS City,
       CONCAT (B.PhoneNum,' and ',C.PhoneNum) AS PhoneNum,
       CONCAT (B.HireDate,' and ',C.HireDate) AS HireDate
FROM guide AS C
LEFT JOIN guide AS B ON C.City = B.City
WHERE B.GuideNum < C.GuideNum;

------------------------------------------------------------------


-- ENTERTAINMENT AGENCY DATABASE!
------------------------------------------------------------------

-- 1)
SELECT AgtFirstName, AgtLastName, AgtPhoneNumber
FROM agents
ORDER BY AgtFirstName, AgtLastName;

-- 2)
SELECT EngagementNumber, StartDate
FROM Engagements
ORDER BY StartDate DESC, EngagementNumber ASC;

-- 3)
SELECT AgtFirstName, AgtLastName, DateHired, DATEADD(month, 6, DateHired) AS DatePerfomanceReview
FROM agents;

-- 4)
SELECT *
FROM Engagements
WHERE (StartDate < '2017-11-01' AND EndDate >= '2017-10-01');

-- 5)
SELECT *
FROM Engagements
WHERE ((StartDate < '2017-11-01' AND EndDate >= '2017-10-01') AND (StartTime BETWEEN '12:00:00' AND '17:00:00'));

-- 6)
SELECT *
FROM Engagements
WHERE StartDate=EndDate;

-- 7)
-- IN COLUMNS
SELECT AgentID, StartDate, EndDate
FROM Engagements
ORDER BY AgentID,StartDate;

-- AGGROUPATED STRING
SELECT AgentID, STRING_AGG(StartDate, ' ,  ') WITHIN GROUP ( ORDER BY StartDate ASC)  AS List_dates
FROM Engagements
GROUP BY AgentID; 

SELECT * -- PIVOT for SQL Server (DOESN'T WORK IN H2, WHERE I'M CURRENTLY WORKING)
FROM (
        SELECT DISTINCT AgentID, StartDate
        FROM Engagements
        ORDER BY AgentID, StartDate
) AS A PIVOT(
    MAX(TRUE) FOR CAST(AgentID AS CHAR) IN (
        SELECT DISTINCT StartDate
        FROM Engagements
        ORDER BY StartDate
        )
) AS PIV;

-- 8)
-- IN COLUMN
SELECT DISTINCT CustomerID, EntertainerID
FROM Engagements
ORDER BY CustomerID, EntertainerID;

-- IN A AGGROUPATED STRING
SELECT A.CustomerID, STRING_AGG(DISTINCT B.EntertainerID , ' , ') WITHIN GROUP (ORDER BY EntertainerID ASC) AS List_entertainers
FROM Customers AS A
LEFT JOIN Engagements AS B ON A.CustomerID=B.CustomerID
GROUP BY A.CustomerID;

-- PIVOT for SQL Server (DOESN'T WORK IN H2, WHERE I'M CURRENTLY WORKING)
SELECT * 
FROM (
        SELECT DISTINCT CustomerID, EntertainerID
        FROM Engagements
        ORDER BY CustomerID, EntertainerID
) AS A PIVOT(
    MAX(TRUE) FOR EntertainerID IN (
        SELECT DISTINCT EntertainerID
        FROM Engagements
        ORDER BY EntertainerID
    )
) AS PIV;

-- PIVOT MANUALLY
SELECT 
        CustomerID,
        MAX(CASE WHEN EntertainerID = 1001 THEN TRUE ELSE NULL END) AS _1001,
        MAX(CASE WHEN EntertainerID = 1002 THEN TRUE ELSE NULL END) AS _1002,
        MAX(CASE WHEN EntertainerID = 1003 THEN TRUE ELSE NULL END) AS _1003,
        MAX(CASE WHEN EntertainerID = 1004 THEN TRUE ELSE NULL END) AS _1004,
        MAX(CASE WHEN EntertainerID = 1005 THEN TRUE ELSE NULL END) AS _1005,
        MAX(CASE WHEN EntertainerID = 1006 THEN TRUE ELSE NULL END) AS _1006,
        MAX(CASE WHEN EntertainerID = 1007 THEN TRUE ELSE NULL END) AS _1007,
        MAX(CASE WHEN EntertainerID = 1008 THEN TRUE ELSE NULL END) AS _1008,
        MAX(CASE WHEN EntertainerID = 1009 THEN TRUE ELSE NULL END) AS _1009,
        MAX(CASE WHEN EntertainerID = 1010 THEN TRUE ELSE NULL END) AS _1010,
        MAX(CASE WHEN EntertainerID = 1011 THEN TRUE ELSE NULL END) AS _1011,
        MAX(CASE WHEN EntertainerID = 1012 THEN TRUE ELSE NULL END) AS _1012,
        MAX(CASE WHEN EntertainerID = 1013 THEN TRUE ELSE NULL END) AS _1013,
        MAX(CASE WHEN EntertainerID = 1014 THEN TRUE ELSE NULL END) AS _1014,
        MAX(CASE WHEN EntertainerID = 1015 THEN TRUE ELSE NULL END) AS _1015
FROM Engagements
GROUP BY CustomerID;

-- PIVOT MANUALLY TO CHECK A SIGNLE EnterteinerID=@cnt
SET @cnt=1004; 
SELECT 
        CustomerID,
        MAX(CASE WHEN EntertainerID =@cnt THEN TRUE ELSE NULL END) AS Chosen_cnt
FROM Engagements
GROUP BY CustomerID;
       
-- PIVOT MANUALLY WITH A WHILE LOOP FOR EntertainerID's 
--(WHILE DOES NOT WORK IN H2 EITHER, SO IT MIGHT CONTAIN SOME MINOR SYNTAXIS ERRORS)
SET @cnt=1001; 
WHILE @cnt < 1016
BEGIN
        SELECT 
                CustomerID,
                MAX(CASE WHEN EntertainerID =@cnt THEN TRUE ELSE NULL END) AS @cnt
        FROM Engagements
        GROUP BY CustomerID
        SET @cnt= @cnt+1
END;     
        
-- 9)
(SELECT
         A.AgtZipCode AS ZipCode,
         STRING_AGG(DISTINCT A.AgentID, ' , ') WITHIN GROUP (ORDER BY A.AgentID ASC) AS Agents_in_zipcode,
         STRING_AGG(DISTINCT B.EntertainerID, ' , ') WITHIN GROUP (ORDER BY B.EntertainerID ASC) AS Entertainers_in_zipcode
FROM Agents AS A
LEFT JOIN Entertainers AS B ON A.AgtZipCode=B.EntZipCode
GROUP BY A.AgtZipCode)
UNION
(SELECT
         B.EntZipCode AS ZipCode,
         STRING_AGG(DISTINCT A.AgentID, ' , ') WITHIN GROUP (ORDER BY A.AgentID ASC) AS Agents_in_zipcode,
         STRING_AGG(DISTINCT B.EntertainerID, ' , ') WITHIN GROUP (ORDER BY B.EntertainerID ASC) AS Entertainers_in_zipcode
FROM Agents AS A
RIGHT JOIN Entertainers AS B ON A.AgtZipCode=B.EntZipCode
GROUP BY B.EntZipCode);

-- 10)
SELECT EntStageName, EntPhoneNumber, EntCity
FROM Entertainers
WHERE EntCity IN ('Bellevue','Redmond','Woodinville')
ORDER BY EntStageName;

-- 11) 
SELECT EngagementNumber, StartDate, EndDate
FROM Engagements
WHERE EndDate = StartDate+4;

-- 12)
-- DIFERENT CONTRACTS IN ORDER IN EACH STRING
SELECT EntertainerID, STRING_AGG( CONCAT('Start: ',StartDate,', End: ', EndDate, ', $: ', ContractPrice), '  | | |  ')  AS Different_Contracts
FROM Engagements
GROUP BY EntertainerID;

-- DIFFERENT CONTRACTS IN COLUMNS
SELECT EntertainerID, StartDate, EndDate, ContractPrice
FROM Engagements
GROUP BY EntertainerID, EngagementNumber;

-- 13) REAPETED QUESTION

-- 14) 
SELECT DISTINCT EntertainerID
FROM Engagements AS A
LEFT JOIN  Customers AS B ON A.CustomerID=B.CustomerID
WHERE B.CustLastName IN ('Berg', 'Hallmark');

-- 15)
SELECT AgentID, STRING_AGG(StartDate,' ,  ') WITHIN GROUP (ORDER BY StartDate ASC) AS Dates_Booked
FROM Engagements
GROUP BY AgentID;

-- 16) 
SELECT CustomerID, STRING_AGG(DISTINCT EntertainerID,' ,  ') WITHIN GROUP (ORDER BY EntertainerID ASC) AS Entertainers_Booked
FROM Engagements
GROUP BY CustomerID;

-- 17) REPEATED QUESTION 9

-- 18)
SELECT A.EntertainerID
FROM Entertainers AS A
LEFT JOIN Engagements AS B ON A.EntertainerID=B.EntertainerID
WHERE B.EntertainerID IS NULL;

-- 19)
SELECT A.StyleName, STRING_AGG(CustomerID, ' ,  ') WITHIN GROUP (ORDER BY PreferenceSeq ASC) AS Customers_that_prefer_it
FROM Musical_Styles AS A
LEFT JOIN Musical_Preferences AS B ON A.StyleID= B.StyleID
GROUP BY A.StyleName;

-- 20)
SELECT A.AgentID
FROM Agents AS A
LEFT JOIN Engagements AS B ON A.AgentID=B.AgentID
WHERE B.AgentID IS NULL;
-- IF THERE WERE ENGAGEMENTS WITHOUT ENTERTAINERS, WE WOULD CHANGE THIS, BUT IT IS NOT THE CASE

-- 21)
SELECT A.CustomerID
FROM Customers AS A
LEFT JOIN Engagements AS B ON A.CustomerID=B.CustomerID
WHERE B.CustomerID IS NULL;

-- 22) ??? Entertainers don't book engagements, I'll supose it is and engagements they ahve taken place
SELECT EntertainerID, STRING_AGG(EngagementNumber, ' , ') AS Engagements_participed
FROM Engagements
GROUP BY EntertainerID;

-- 23)
(SELECT CustomerID, CONCAT(CustFirstName,' ',CustLastName) AS CustomerName, NULL AS EntertainerID, NULL AS EntertainerName
FROM Customers)
UNION
(SELECT NULL,NULL,EntertainerID, EntStageName
FROM Entertainers);

-- 24)
(SELECT EntertainerID AS EntertainerID_plays_contemporary , NULL AS CustomerID_likes_contemporary
FROM Entertainer_Styles AS A
LEFT JOIN Musical_Styles AS B ON A.StyleID=B.StyleID
WHERE B.StyleName='Contemporary')
UNION
(SELECT NULL, CustomerID 
FROM Musical_preferences AS A
LEFT JOIN Musical_styles AS B ON A.StyleID=B.StyleID
WHERE B.StyleName='Contemporary'); 

-- 25)
(SELECT AgentID, CONCAT(AgtFirstName,' ',AgtLastName) AS AgentName, NULL AS EntertainerID, NULL AS EntertainerName
FROM Agents)
UNION
(SELECT NULL,NULL,EntertainerID, EntStageName
FROM Entertainers);


------------------------------------------------------------------


-- ACCOUNTS PAYABLE DATABASE!
------------------------------------------------------------------

-- 1)
SELECT *
FROM invoices;

-- 2)
SELECT invoice_number, invoice_date, invoice_total
FROM invoices
ORDER BY invoice_total DESC;

-- 3)
SELECT *
FROM invoices
WHERE (invoice_date >= '2014-06-01' AND invoice_date <= '2014-06-30');

-- 4)
SELECT *
FROM vendors
ORDER BY vendor_contact_last_name ASC, vendor_contact_first_name ASC;

-- 5)
-- choosing letter
SELECT vendor_contact_last_name, vendor_contact_first_name
FROM vendors
WHERE (vendor_contact_last_name LIKE 'A%' 
        OR vendor_contact_last_name LIKE 'B%'
        OR vendor_contact_last_name LIKE 'C%'
        OR vendor_contact_last_name LIKE 'E%')
ORDER BY vendor_contact_last_name ASC, vendor_contact_first_name ASC;

-- with higers and lowers
SELECT vendor_contact_last_name, vendor_contact_first_name
FROM vendors
WHERE (vendor_contact_last_name < 'D' 
        OR (vendor_contact_last_name >= 'E' AND vendor_contact_last_name < 'F'))
ORDER BY vendor_contact_last_name ASC, vendor_contact_first_name ASC;

-- 6)
SELECT invoice_due_date, (invoice_total+credit_total-payment_total)*1.10 AS next_invoice
FROM invoices
WHERE ((invoice_total+credit_total-payment_total)>=500 AND (invoice_total+credit_total-payment_total)<=1000)
ORDER BY Invoice_due_date DESC;

-- 7)
SELECT invoice_number, invoice_total, -payment_total+credit_total AS payment_credit_total, invoice_total-(payment_total-credit_total) AS balance_due
FROM invoices
WHERE invoice_total-(payment_total-credit_total) > 50
ORDER BY balance_due DESC
LIMIT 5;

-- 8)
SELECT *
FROM invoices
WHERE invoice_total-(payment_total-credit_total) > 0;

-- 9)
SELECT A.vendor_name
FROM vendors AS A
RIGHT JOIN (
        SELECT *
        FROM invoices
        WHERE invoice_total-(payment_total-credit_total) > 0
) AS B ON A.vendor_id=B.vendor_id;

-- 10)
SELECT A.account_description, B.*
FROM general_ledger_accounts AS A
RIGHT JOIN vendors AS B ON A.account_number=B.default_account_number;

-- 11)
SELECT B.vendor_id, STRING_AGG( A.line_item_description, '  | | |  ') AS Invoices_each_vendor
FROM invoice_line_items AS A
RIGHT JOIN (
        SELECT C.*
        FROM invoices AS C
        RIGHT JOIN vendors AS D ON C.vendor_id=D.vendor_id
        ) AS B ON A.invoice_id=B.invoice_id
 GROUP BY B.vendor_id;

-- 12) 
SELECT vendor_contact_last_name, STRING_AGG(CONCAT('ID: ', vendor_id,', NUM:' ,vendor_id), '  |  ') AS vendor_acounts
FROM vendors
GROUP BY vendor_contact_last_name
HAVING COUNT(*)>1;

-- easier (only name)
SELECT vendor_contact_last_name
FROM vendors
GROUP BY vendor_contact_last_name
HAVING COUNT(*)>1;

-- 13)
SELECT account_number
FROM general_ledger_accounts AS A
LEFT JOIN vendors AS B ON A.account_number=B.default_account_number
WHERE B.default_account_number IS NULL
ORDER BY Account_number;

-- 14)
SELECT 
        vendor_name, 
        (CASE WHEN vendor_state='CA' THEN 'CA' ELSE 'Outside CA' END) AS Vendor_state
FROM vendors
ORDER BY vendor_name;

------------------------------------------------------------------







------------------------------------------------------------------
------------------------------------------------------------------
-- HOMEWORK 2
------------------------------------------------------------------
------------------------------------------------------------------


-- COLONIAL DB
------------------------------------------------------------------

-- EXCERCICE 1) 

SELECT B.ReservationID, B.tripID, B.TripDate
FROM reservation AS B
LEFT JOIN trip AS C ON B.TripID=C.TripID
WHERE C.State = 'ME';


SELECT B.ReservationID, B.tripID, B.TripDate
FROM trip AS C
LEFT JOIN reservation AS B ON B.TripID=C.TripID
WHERE (C.State = 'ME' AND B.ReservationID IS NOT NULL);


SELECT B.ReservationID, B.tripID, B.TripDate
FROM trip AS C
RIGHT JOIN reservation AS B ON B.TripID=C.TripID
WHERE C.State = 'ME';


SELECT B.ReservationID, B.tripID, B.TripDate
FROM reservation AS B
LEFT JOIN (
        SELECT TripID, State
        FROM trip  
) AS C ON B.TripID=C.TripID
WHERE C.State = 'ME';


SELECT B.ReservationID, B.tripID, B.TripDate
FROM reservation AS B
LEFT JOIN (
        SELECT TripID, State
        FROM trip
        WHERE State = 'ME'
) AS C ON B.TripID=C.TripID
WHERE C.State IS NOT NULL;


SELECT B.ReservationID, B.tripID, B.TripDate
FROM reservation AS B
RIGHT JOIN (
        SELECT TripID, State
        FROM trip
        WHERE State = 'ME'
) AS C ON B.TripID=C.TripID
WHERE B.ReservationID IS NOT NULL;
-- in the subqueries ones, you can also change the order of the JOINS!



-- ENTERTAINMENT AGENCY DB
---------------------------------------------------------------

-- EXCERCICE 2)

SELECT DISTINCT A.EntertainerID
FROM engagements AS A
LEFT JOIN (
        SELECT CustomerID, CustLastName
        FROM customers
) AS B ON A.CustomerID = B.CustomerID
WHERE B.CustLastName IN ('Berg', 'Hallmark');
-- You can change the 'DISTINCT' for a last line: 'GROUP BY A.EntertainerID';


SELECT DISTINCT A.EntertainerID
FROM engagements AS A
LEFT JOIN (
        SELECT CustomerID, CustLastName
        FROM customers
        WHERE CustLastName IN ('Berg', 'Hallmark')
) AS B ON A.CustomerID = B.CustomerID
WHERE B.CustomerID IS NOT NULL;
-- You can change the 'DISTINCT' for a last line: 'GROUP BY A.EntertainerID';


SELECT DISTINCT A.EntertainerID
FROM engagements AS A
RIGHT JOIN (
        SELECT CustomerID, CustLastName
        FROM customers
        WHERE CustLastName IN ('Berg', 'Hallmark')
) AS B ON A.CustomerID = B.CustomerID;
-- You can change the 'DISTINCT' for a last line: 'GROUP BY A.EntertainerID';


SELECT DISTINCT B.EntertainerID
FROM customers AS A
LEFT JOIN (  -- Can be 'RIGHT JOIN' also 
        SELECT EntertainerID,CustomerID
        FROM engagements
) AS B ON A.CustomerID = B.CustomerID
WHERE A.CustLastName IN ('Berg', 'Hallmark');
-- You can change the 'DISTINCT' for a last line: 'GROUP BY A.EntertainerID';


-- EXCERCICE 3)

SELECT A.AgentID
FROM agents AS A
LEFT JOIN (
        SELECT EngagementNumber, AgentID 
        FROM engagements
) AS B ON A.AgentID=B.AgentID
WHERE B.EngagementNumber IS NULL;


SELECT A.AgentID
FROM engagements AS B
RIGHT JOIN (
        SELECT AgentID 
        FROM agents
) AS A ON A.AgentID=B.AgentID
WHERE B.EngagementNumber IS NULL;


