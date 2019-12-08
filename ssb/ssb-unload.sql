-- SSB dataset

-- UNLOAD Queries 

-- UNLOAD Query 1
-- This query unloads the results from the aggregated table created by ELT Query 1 to S3 with parquet file format and proper partitioning

UNLOAD ('select * from elt_monthly_revenue_by_region_manufacturer_category_brand')
to 's3://eltblogpost/unload_parquet/monthly_revenue_by_region_manufacturer_category_brand'
iam_role 'arn:aws:iam::<Your-AWS-Account-Number>:role/redshift-elt-test-role'
maxfilesize 96 mb
FORMAT AS PARQUET
PARTITION BY (year, month, supplier_region)
allowoverwrite;

-- UNLOAD Query 2
-- This query unloads the results from the aggregated table created by ELT Query 2 to S3 with parquet file format and proper partitioning

UNLOAD ('select * from elt_monthly_revenue_by_region_city_brand')
to 's3://eltblogpost/unload_parquet/monthly_revenue_by_region_city_brand'
iam_role 'arn:aws:iam::<Your-AWS-Account-Number>:role/redshift-elt-test-role'
maxfilesize 96 mb
FORMAT AS PARQUET
PARTITION BY (year, month, supplier_region)
allowoverwrite;

-- UNLOAD Query 3
-- This query unloads the results from the aggregated table created by ELT Query 3 to S3 with parquet file format and proper partitioning

UNLOAD ('select * from elt_yearly_revenue_by_city')
to 's3://eltblogpost/unload_parquet/yearly_revenue_by_city'
iam_role 'arn:aws:iam::<Your-AWS-Account-Number>:role/redshift-elt-test-role'
maxfilesize 96 mb
FORMAT AS PARQUET
PARTITION BY (year, month)
allowoverwrite;