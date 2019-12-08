\timing
\c rselttest

-- SSB dataset

-- Setting the query group to unload_query which has concurrency scaling mode turned on
set query_group to 'unload_query';

-- UNLOAD Query 3
-- This query unloads the results from the aggregated table created by ELT Query 3 to S3 with parquet file format and proper partitioning

UNLOAD ('select * from elt_yearly_revenue_by_city')
to 's3://eltblogpost/unload_parquet/yearly_revenue_by_city'
iam_role 'arn:aws:iam::<Your-AWS-Account-Number>:role/redshift-elt-test-role'
maxfilesize 96 mb
FORMAT AS PARQUET
PARTITION BY (year, month)
allowoverwrite;
