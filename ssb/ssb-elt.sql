-- SSB dataset

-- ELT Queries

-- ELT Query 1
-- This query is used to summarize the revenue by manufacturer, category, and brand per month per year for all regions.

drop table if exists elt_monthly_revenue_by_region_manufacturer_category_brand;
create table elt_monthly_revenue_by_region_manufacturer_category_brand 
as
select d_month as month, d_year as year,s_region as supplier_region,p_mfgr as manufacturer,p_category as category, p_brand1 as brand, sum(lo_revenue) revenue
from lineorder, dwdate, part, supplier
where lo_orderdate = d_datekey
and lo_partkey = p_partkey
and lo_suppkey = s_suppkey
group by d_month, d_year,s_region,p_mfgr,p_category, p_brand1;

-- ELT Query 2
-- This query is used to summarize the monthly revenue by brand by supplier region and city.

drop table if exists elt_monthly_revenue_by_region_city_brand;
create table elt_monthly_revenue_by_region_city_brand 
as
select d_month as month, d_year as year,s_region as supplier_region,s_city as supplier_city, p_brand1 brand, sum(lo_revenue) revenue
from lineorder, dwdate, part, supplier
where lo_orderdate = d_datekey
and lo_partkey = p_partkey
and lo_suppkey = s_suppkey
group by d_month, d_year,s_region,s_city,p_brand1;

-- ELT Query 3
-- This query is to drill down in time by customer city, supplier city, month, and year

drop table if exists elt_yearly_revenue_by_city;
create table elt_yearly_revenue_by_city
as
select c_city as customer_city, s_city as supplier_city, d_year as year, d_month as month, sum(lo_revenue) as revenue
from customer, lineorder, supplier, dwdate
where lo_custkey = c_custkey
and lo_suppkey = s_suppkey
and lo_orderdate = d_datekey
group by c_city, s_city, d_year, d_month;