create table orders(
order_id varchar(30),
customer_id numeric(38,0),
order_datetime timestamp,
item_id varchar(10),
order_quantity numeric(38,0));

insert into orders values
('A-001', 32483 , '2018-12-15 09:15:22' , 'B000', 3);
insert into orders values
('A-005', 21456 , '2019-01-12 09:28:35' , 'B001', 1);
insert into orders values
('A-005', 21456 , '2019-01-12 09:28:35' , 'B005' , 1);


CREATE table items(
item_id varchar(10),
item_category varchar(20));

Insert into items values
('B000','Outdoors');

Insert into items values
('B001','Outdoors');

Insert into items values
('B002','Outdoors');

Insert into items values
('B003','Kitchen');
Insert into items values
('B004','Kitchen');


select * from orders;
select * from items;


/* Questions */
-- Q1: How many UNITS have been ordered yesterday? UNITS is the total quantity ordered.
-- Output as: Units
SELECT 
 sum(order_quantity) 
 
FROM 
  orders
WHERE
  cast(order_datetime as date) = date_sub(cast(sysdate() as date) , interval 1 day);
-- Q2: How many UNITS have been ordered in the last 7 days (including today) in EACH and EVERY category? Please consider SEVEN calendar days in total, including today.
-- Please consider ALL categories, even those which have zero orders.
-- Output as: Category | Units
select 
  i.item_category category,coalesce(sum(order_quantity),0) units
from
  items i left join orders o 
on
  i.item_id = o.item_id
 where cast(order_datetime as date) >= date_sub(cast(sysdate() as date), interval 6 day)
group by 1;
-- Q3: How many UNITS in EACH and EVERY category have been ordered on each day of the week in the last 7 days (including today)?
-- Output as: Category | Sunday_units | Monday_units | Tuesday_units | Wednesday_units | Thursday_units | Friday_units | Saturday_units
 
select 
  i.item_category category,  
  sum(case when DAYOFWEEK(order_datetime)=1 then order_quantity else 0 end) sunday_units,
  sum(case when DAYOFWEEK(order_datetime)=2 then order_quantity else 0 end) Monday_units,
  sum(case when DAYOFWEEK(order_datetime)=3 then order_quantity else 0 end) Tuesday_units,
  sum(case when DAYOFWEEK(order_datetime)=4 then order_quantity else 0 end) Wednesday_units,
  sum(case when DAYOFWEEK(order_datetime)=5 then order_quantity else 0 end) Thursday_units,
  sum(case when DAYOFWEEK(order_datetime)=6 then order_quantity else 0 end) Friday_units,
  sum(case when DAYOFWEEK(order_datetime)=7 then order_quantity else 0 end) Saturday_units
FROM
  items i left join orders o 
 ON
   i.item_id = o.item_id 
 WHERE 
   cast(order_datetime as date) >= date_sub(cast(order_datetime  as date), interval 6 day) 
GROUP BY 
  i.item_category;
  
-- Q4: It is possible for customers to place multiple orders on a single date.
-- For ALL customers, write a query to get the earliest ORDER_ID for each customer for each date they placed an order.
-- Output as: Customer_id | Order_date | First_order_id
 
Select 
  customer_id,cast(order_datetime as date) order_date, min(order_id) First_order_id
from
  orders 
group by 1,2
order by 1,2;
 
-- Q5: Write a query to get the second earliest ORDER_ID for each customer for each date they placed AT LEAST two orders.
-- Output as: Customer_id | Order_date | Second_order_id

select 
    Customer_id,order_date,order_id Second_order_id
from
(
    select 
      distinct a.customer_id,cast(a.order_datetime as date) order_Date,a.order_id, rank() over(partition by a.customer_id,cast(a.order_datetime as date) order by a.order_id ) rnk
     from
     orders a
     join 
    (   select 
            customer_id,cast(order_datetime as date) order_date  
        from
            orders 
        group by 1,2 
        having count(*)>=2
        )o
    on a.customer_id = o.customer_id 
    and cast(a.order_datetime as date) = o.order_date
)a
where rnk=2;










