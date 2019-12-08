\timing
\c rselttest

-- Tickit dataset

-- ELT Queries

-- ELT Query 1
-- Total quantity sold on a given calendar date

drop table if exists elt_total_quantity_sold_by_date;
create table elt_total_quantity_sold_by_date 
as
SELECT 
caldate,
sum(qtysold) as total_quantity
FROM spectrum_eltblogpost.sales, date 
WHERE sales.dateid = date.dateid 
group by caldate;

-- ELT Query 2
-- Total quantity sold to each buyer

drop table if exists elt_total_quantity_sold_by_buyer_by_date;
create table elt_total_quantity_sold_by_buyer_by_date
as 
SELECT buyerid,caldate, firstname, lastname, total_quantity 
FROM   (SELECT buyerid, caldate, sum(qtysold) total_quantity
        FROM  spectrum_eltblogpost.sales, date
        where sales.dateid = date.dateid
        GROUP BY buyerid, caldate) Q, users
WHERE Q.buyerid = userid;

-- ELT Query 3
-- Find events in the 99.9 percentile in terms of all time gross sales

drop table if exists elt_total_price_by_eventname;
create table elt_total_price_by_eventname
as
SELECT E.eventid,eventname, total_price
FROM (SELECT eventid, total_price, ntile(1000) over(order by total_price desc) as percentile
FROM (SELECT eventid, sum(pricepaid) total_price
FROM spectrum_eltblogpost.sales
GROUP BY eventid)) Q, event E
WHERE Q.eventid = E.eventid
AND percentile = 1;
