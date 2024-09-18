create database pro;
use pro;
select* from purchase;
SELECT DISTINCT customername
FROM purchase;
CREATE TEMPORARY TABLE temp_unique_customer (
    unique_customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(255));
    
INSERT INTO temp_unique_customers (customer_name)
SELECT DISTINCT customername
FROM purchase;

ALTER TABLE purchase
ADD COLUMN unique_customer_id INT;

set sql_safe_updates=0;
UPDATE purchase p
JOIN temp_unique_customers uc
 ON p.customername = uc.customer_name                            
SET p.unique_customer_id = uc.unique_customer_id;

DROP TEMPORARY TABLE temp_unique_customers;

select *from purchase order by customername;

SELECT customername,unique_customer_id, COUNT(*) AS name_count
FROM purchase
GROUP BY customername,2
HAVING COUNT(*) > 1;

select customername,unique_customer_id 
from purchase 
where unique_customer_id=126 or unique_customer_id=128;

CREATE TEMPORARY TABLE temp_unique_product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product VARCHAR(255));
    
    INSERT INTO temp_unique_product (product)
SELECT DISTINCT productname
FROM purchase;

ALTER TABLE purchase
ADD COLUMN product_id INT;

select *from purchase order by productid;



update purchase p
join temp_unique_product tp on 
p.productname=tp.product
SET p.product_id = tp.product_id;

alter table purchase
drop column product_id;

DROP TEMPORARY TABLE temp_unique_product;


alter table purchase
drop column customerid;

select * from purchase 
order by customerid;


ALTER TABLE purchase
RENAME COLUMN unique_customer_id TO CustomerID;

update purchase
set productid=productid + 200;

update purchase
set customerid= customerid + 5000;


create table products (
productid int primary key,
productname varchar(200),
productcategory varchar(200));

create table customers (
customerid int primary key,
customername varchar(200),
country varchar(50));

ALTER TABLE customers
MODIFY COLUMN country varchar(200);



insert into products
select distinct productid,productname,productcategory 
from purchase;
select* from products;

insert into customers (customerid,customername,country)
select  customerid, min(customername),min(country)
from purchase
group by customerid;

select * from purchase;

ALTER TABLE purchase
DROP COLUMN customername,
DROP COLUMN productname,
DROP COLUMN productcategory,
DROP COLUMN country;

use pro;

select* from purchase;
select * from customers;
select * from products;

select customername,productname,purchaseprice
 from purchase p
 join customers c on p.customerid = c.customerid
 join products pd on p.productid = pd.productid;
 
 select customername,round(sum(purchaseprice*purchasequantity),1) from customers c
 join purchase p on p.customerid = c.customerid 
 group by c.customerid 
 order by 2 desc;
 
 select Country,round(sum(purchaseprice*purchasequantity),2) as Total_revanue
 from customers c
 join purchase p on
 c.customerid = p.customerid
 group by country
 order by 2 desc
 limit 10;
 
 select Country,round(sum(purchaseprice*purchasequantity),2) as Total_revanue
 from customers c
 join purchase p on
 c.customerid = p.customerid
 group by country
 order by 2 asc
 limit 10;
 
 select p.productid,productname,round(sum(purchaseprice*purchasequantity),2)
 from products p join purchase pc on p.productid=pc.productid
 group by p.productid,productname
 order by 3 desc;
 
 use pro;
 
select* from purchase p join customers c on p.customerid=c.customerid join products pd on p.productid = pd.productid order by p.productid;
 
 
 with cte as (SELECT 
    month(purchasedate),monthname(purchasedate) AS Month,
    round(SUM(PurchasePrice * PurchaseQuantity),2) AS TotalRevenue
FROM 
    purchase
GROUP BY 
    1,2
order by
    1)
select month,totalrevenue from cte;