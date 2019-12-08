\timing
\c rselttest

-- Tickit dataset

-- Setting the query group to unload_query which has concurrency scaling mode turned on
set query_group to 'unload_query';

-- UNLOAD Query 2
-- This query unloads the results from the aggregated table created by ELT Query 2 to S3 with parquet file format and proper partitioning

UNLOAD ('select * from elt_total_quantity_sold_by_buyer_by_date')
to 's3://eltblogpost/unload_parquet/total_quantity_sold_by_buyer'
iam_role 'arn:aws:iam::<Your-AWS-Account-Number>:role/redshift-elt-test-role'
maxfilesize 96 mb
FORMAT AS PARQUET
PARTITION BY (caldate)
allowoverwrite;