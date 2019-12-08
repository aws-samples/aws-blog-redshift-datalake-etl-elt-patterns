\timing
\c rselttest

-- SSB dataset

-- Setting the query group to unload_query which has concurrency scaling mode turned on
set query_group to 'unload_query';

-- UNLOAD Query 2
-- This query unloads the results from the aggregated table created by ELT Query 2 to S3 with parquet file format and proper partitioning

UNLOAD ('select * from elt_monthly_revenue_by_region_city_brand')
to 's3://eltblogpost/unload_parquet/monthly_revenue_by_region_city_brand'
iam_role 'arn:aws:iam::<Your-AWS-Account-Number>:role/redshift-elt-test-role'
maxfilesize 96 mb
FORMAT AS PARQUET
PARTITION BY (year, month, supplier_region)
allowoverwrite;
