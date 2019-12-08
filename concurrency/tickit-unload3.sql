\timing
\c rselttest

-- Tickit dataset

-- Setting the query group to unload_query which has concurrency scaling mode turned on
set query_group to 'unload_query';

-- UNLOAD Query 3
-- This query unloads the results from the aggregated table created by ELT Query 3 to S3 with parquet file format and proper partitioning

UNLOAD ('select * from elt_total_price_by_eventname')
to 's3://eltblogpost/unload_parquet/total_price_by_eventname'
iam_role 'arn:aws:iam::<Your-AWS-Account-Number>:role/redshift-elt-test-role'
maxfilesize 96 mb
FORMAT AS PARQUET
PARTITION BY (eventid)
allowoverwrite;