\timing
\c rselttest

-- Tickit dataset

-- UNLOAD Queries 

-- UNLOAD Query 1
-- This query unloads the results from the aggregated table created by ELT Query 1 to S3 with parquet file format and proper partitioning

UNLOAD ('select * from elt_total_quantity_sold_by_date')
to 's3://eltblogpost/unload_parquet/total_quantity_sold_by_date'
iam_role 'arn:aws:iam::<Your-AWS-Account-Number>:role/redshift-elt-test-role'
maxfilesize 96 mb
FORMAT AS PARQUET
PARTITION BY (caldate)
allowoverwrite;

-- UNLOAD Query 2
-- This query unloads the results from the aggregated table created by ELT Query 2 to S3 with parquet file format and proper partitioning

UNLOAD ('select * from elt_total_quantity_sold_by_buyer_by_date')
to 's3://eltblogpost/unload_parquet/total_quantity_sold_by_buyer'
iam_role 'arn:aws:iam::<Your-AWS-Account-Number>:role/redshift-elt-test-role'
maxfilesize 96 mb
FORMAT AS PARQUET
PARTITION BY (caldate)
allowoverwrite;

-- UNLOAD Query 3
-- This query unloads the results from the aggregated table created by ELT Query 3 to S3 with parquet file format and proper partitioning

UNLOAD ('select * from elt_total_price_by_eventname')
to 's3://eltblogpost/unload_parquet/total_price_by_eventname'
iam_role 'arn:aws:iam::<Your-AWS-Account-Number>:role/redshift-elt-test-role'
maxfilesize 96 mb
FORMAT AS PARQUET
PARTITION BY (eventid)
allowoverwrite;
