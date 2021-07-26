/*
High Level Sales Analysis
1. What was the total quantity sold for all products?
2. What is the total generated revenue for all products before discounts?
3. What was the total discount amount for all products?*/

#.Total High level sales 

select 
  sum(qty)  total_qty_sold, 
  sum(qty*price) total_revenue,
  sum(discount) total_discount
from
  sales;
  
/*


+----------------+---------------+----------------+
| total_qty_sold | total_revenue | total_discount |
+----------------+---------------+----------------+
|          45216 |       1289453 |         182700 |
+----------------+---------------+----------------+
1 row in set (0.02 sec)

*/

#Month wise high level sales 
select 
  year(start_txn_time) Yr,Month(start_txn_time) Mth,
  sum(qty)  total_qty_sold, 
  sum(qty*price) total_revenue,
  sum(discount) total_discount
from
  sales
group by yr,mth 
order by yr,mth
;
  
/*
-----

+------+------+----------------+---------------+----------------+
| Yr   | Mth  | total_qty_sold | total_revenue | total_discount |
+------+------+----------------+---------------+----------------+
| 2021 |    1 |          14788 |        420672 |          60947 |
| 2021 |    2 |          14820 |        421554 |          60356 |
| 2021 |    3 |          15608 |        447227 |          61397 |
+------+------+----------------+---------------+----------------+

*/

  
/*
Transaction Analysis
How many unique transactions were there?
What is the average unique products purchased in each transaction?
What are the 25th, 50th and 75th percentile values for the revenue per transaction?
What is the average discount value per transaction?
What is the percentage split of all transactions for members vs non-members?
What is the average revenue for member transactions and non-member transactions?  
*/

#1. How many unique transactions were there?

select 
  count(distinct txn_id) unique_transactions 
from 
  sales;


#2. What is the average unique products purchased in each transaction?

#LOGIC:   100* (total products purchase / total transactions )

select 
  round(100*(count(distinct prod_id)*1.0 / count(distinct txn_id)),2) avg_prodcnt_per_transaction
from
  sales;
  
#3. What are the 25th, 50th and 75th percentile values for the revenue per transaction?


select 
  (sum(qty*price)*1.0)/count(distinct txn_id) revenue_per_transaction, 
  (sum(qty*price)*1.0)/count(distinct txn_id) *.25  twentyfifth,
  (sum(qty*price)*1.0)/count(distinct txn_id) *.50  fifty,
  (sum(qty*price)*1.0)/count(distinct txn_id) *.75  seventyfive 
from
  sales;
  

#4. What is the average discount value per transaction?

select (sum(discount)*1.0)/count(distinct txn_id) avg_discount_per_transaction 
from 
sales ;


#5. What is the percentage split of all transactions for members vs non-members?
select 
 round(100* ((count(distinct case when member=True then txn_id end) *1.0)/ count(distinct txn_id) ),2) member_transaction ,
round(100*  ((count(distinct case when member=False then txn_id end) *1.0)/ count(distinct txn_id) ),2)  non_member_transaction
from 
  sales;

#6. What is the average revenue for member transactions and non-member transactions?  
select
   (sum(case when member=True then qty*price end)*1.0)/(count(distinct case when member=True then txn_id end))  as member_revenue,
      (sum(case when member=False then qty*price end)*1.0)/(count(distinct case when member=False then txn_id end))  as non_member_revenue
from
     sales;


/*What are the top 3 products by total revenue before discount?
What is the total quantity, revenue and discount for each segment?
What is the top selling product for each segment?
What is the total quantity, revenue and discount for each category?
What is the top selling product for each category?
What is the percentage split of revenue by product for each segment?
What is the percentage split of revenue by segment for each category?
What is the percentage split of total revenue by category?
What is the total transaction “penetration” for each product? (hint: penetration = number of transactions where at least 1 quantity of a product was purchased divided by total number of transactions)
What is the most common combination of at least 1 quantity of any 3 products in a 1 single transaction?
Reporting Challenge
*/

#1. What are the top 3 products by total revenue before discount?
select product_id,product_name,sum(qty*s.price) revenue
from
  sales s join product_details p 
on
  s.prod_id = p.product_id
group by 1,2
order by 3 desc
limit 3;

/*

+------------+------------------------------+---------+
| product_id | product_name                 | revenue |
+------------+------------------------------+---------+
| 2a2353     | Blue Polo Shirt - Mens       |  217683 |
| 9ec847     | Grey Fashion Jacket - Womens |  209304 |
| 5d267b     | White Tee Shirt - Mens       |  152000 |
+------------+------------------------------+---------+
*/

#2. What is the total quantity, revenue and discount for each segment?
select 
  segment_name,sum(qty) total_qty, sum(qty*s.price) total_revenue , sum(discount) tot_discount
from
  sales s join product_details  p 
on 
  s.prod_id = p.product_id 
group by 1
order by 1;

/*

+--------------+-----------+---------------+--------------+
| segment_name | total_qty | total_revenue | tot_discount |
+--------------+-----------+---------------+--------------+
| Jacket       |     11385 |        366983 |        45452 |
| Jeans        |     11349 |        208350 |        45740 |
| Shirt        |     11265 |        406143 |        46043 |
| Socks        |     11217 |        307977 |        45465 |
+--------------+-----------+---------------+--------------+
4 rows in set (0.04 sec)
*/

#3. What is the top selling product for each segment?
with segment_rnk as 
(
  select 
    segment_name,product_id, sum(qty*s.price) total_revenue,
    rank() over(partition by segment_name order by sum(qty*s.price) desc) rnk
  from
    sales s join product_details  p 
  on 
    s.prod_id = p.product_id 
  group by 1,2
)
select segment_name,product_id 
from
  segment_rnk where rnk=1;
  
/*
+--------------+------------+
| segment_name | product_id |
+--------------+------------+
| Jacket       | 9ec847     |
| Jeans        | e83aa3     |
| Shirt        | 2a2353     |
| Socks        | f084eb     |
+--------------+------------+
4 rows in set (0.04 sec)

*/
  
#4. What is the total quantity, revenue and discount for each category?
select 
  category_id,sum(qty) total_qty, sum(qty*s.price) total_revenue , sum(discount) tot_discount
from
  sales s join product_details  p 
on 
  s.prod_id = p.product_id 
group by 1;

/*

+-------------+-----------+---------------+--------------+
| category_id | total_qty | total_revenue | tot_discount |
+-------------+-----------+---------------+--------------+
|           1 |     22734 |        575333 |        91192 |
|           2 |     22482 |        714120 |        91508 |
+-------------+-----------+---------------+--------------+
2 rows in set (0.04 sec)
*/


#5. What is the top selling product for each category?
select 
  category_id,product_id
from
(
  select 
    category_id,product_id, sum(qty*s.price) total_revenue , 
    rank() over(partition by category_id order by sum(qty*s.price) desc) rnk
  from
    sales s join product_details  p 
  on 
    s.prod_id = p.product_id 
  group by 1,2
)a
where rnk=1
order by 1,2;

/*


+-------------+------------+
| category_id | product_id |
+-------------+------------+
|           1 | 9ec847     |
|           2 | 2a2353     |
+-------------+------------+
2 rows in set (0.04 sec)
*/


#6. What is the percentage split of revenue by product for each segment?
select 
  segment_name,product_id,
  round(100*((revenue*1.0)/sum(revenue) over(partition by segment_name)),2) percentage
from
(
  select 
    segment_name,product_id,sum(qty*s.price) revenue
    from
      sales s join product_details  p 
    on 
      s.prod_id = p.product_id 
    group by 1,2
)a
order by 1,3 desc;

/*

+--------------+------------+------------+
| segment_name | product_id | percentage |
+--------------+------------+------------+
| Jacket       | 9ec847     |      57.03 |
| Jacket       | d5e9a6     |      23.51 |
| Jacket       | 72f5d4     |      19.45 |
| Jeans        | e83aa3     |      58.15 |
| Jeans        | c4a632     |      24.06 |
| Jeans        | e31d39     |      17.79 |
| Shirt        | 2a2353     |      53.60 |
| Shirt        | 5d267b     |      37.43 |
| Shirt        | c8d436     |       8.98 |
| Socks        | f084eb     |      44.33 |
| Socks        | 2feb6b     |      35.50 |
| Socks        | b9a74d     |      20.18 |
+--------------+------------+------------+
12 rows in set (0.06 sec)
*/



#7.What is the percentage split of revenue by segment for each category?
select 
  category_id,segment_name,
  round(100*((revenue*1.0)/sum(revenue) over(partition by category_id)),2) percentage
from
(
  select 
    category_id,segment_name,sum(qty*s.price) revenue
  from
        sales s join product_details  p 
      on 
        s.prod_id = p.product_id 
      group by 1,2
)a
order by 1,3 desc;

/*

+-------------+--------------+------------+
| category_id | segment_name | percentage |
+-------------+--------------+------------+
|           1 | Jacket       |      63.79 |
|           1 | Jeans        |      36.21 |
|           2 | Shirt        |      56.87 |
|           2 | Socks        |      43.13 |
+-------------+--------------+------------+
4 rows in set (0.05 sec)

*/

#8. What is the percentage split of total revenue by category?
#without using window function 

select 
   round(100*(1.0*sum(case when category_id =1 then (qty*s.price)  else 0 end)) / (sum(qty*s.price)),2) category_1,
   round(100*(1.0*sum(case when category_id =2 then (qty*s.price)  else 0 end)) / (sum(qty*s.price)),2) category_2
from
  sales s join product_details p 
on 
  s.prod_id = p.product_id ;
                                                                            

/*

+------------+------------+
| category_1 | category_2 |
+------------+------------+
|      44.62 |      55.38 |
+------------+------------+
1 row in set (0.03 sec)
*/


#with using window function
select 
  category_id,round(100*(revenue*1.0)/sum(revenue) over(),2) percentage
from
(
  select 
    category_id,sum(qty*s.price) revenue 
  from
    sales s join product_details p 
  on 
    s.prod_id = p.product_id 
  group by 1
)a;

/*

+-------------+------------+
| category_id | percentage |
+-------------+------------+
|           1 |      44.62 |
|           2 |      55.38 |
+-------------+------------+
2 rows in set (0.04 sec)
*/


#9. What is the total transaction “penetration” for each product? (hint: penetration = number of transactions where at least 1 quantity of a product was purchased divided by total number of transactions)



#9. What is the total transaction “penetration” for each product? (hint: penetration = number of transactions where at least 1 quantity of a product was purchased divided by total number of transactions)

with prod_trans as
(
  select 
      p.product_id, count(distinct txn_id) txncnt
   from
       product_details p  join sales s
    on 
      p.product_id =s.prod_id
    group by 1
),
trans_cnt as 
(
  select 
    count(distinct txn_id) tot_trans
  from
    sales
)

  select 
    product_id, txncnt,tot_trans,round(100*((txncnt*1.0)/tot_trans),2)  percentage_penertration
  from
    prod_trans,trans_cnt

/*
+------------+--------+-----------+-------------------------+
| product_id | txncnt | tot_trans | percentage_penertration |
+------------+--------+-----------+-------------------------+
| 2a2353     |   1268 |      2500 |                   50.72 |
| 2feb6b     |   1258 |      2500 |                   50.32 |
| 5d267b     |   1268 |      2500 |                   50.72 |
| 72f5d4     |   1250 |      2500 |                   50.00 |
| 9ec847     |   1275 |      2500 |                   51.00 |
| b9a74d     |   1243 |      2500 |                   49.72 |
| c4a632     |   1274 |      2500 |                   50.96 |
| c8d436     |   1242 |      2500 |                   49.68 |
| d5e9a6     |   1247 |      2500 |                   49.88 |
| e31d39     |   1243 |      2500 |                   49.72 |
| e83aa3     |   1246 |      2500 |                   49.84 |
| f084eb     |   1281 |      2500 |                   51.24 |
+------------+--------+-----------+-------------------------+
12 rows in set (0.07 sec)
*/


#10. What is the most common combination of at least 1 quantity of any 3 products in a 1 single transaction?
with seltxn as
(
  select 
    txn_id,count(distinct prod_id) 
  from 
    sales
  group by 1
  having count(distinct prod_id)=3
),
trans_prod as
(
  select distinct s.txn_id,prod_id
  from sales s join seltxn t 
  where s.txn_id=t.txn_id
)
,prod_dtls as
(
  select 
    distinct p1.prod_id prod1,p2.prod_id prod2,p3.prod_id prod3,p1.txn_id
  from
    trans_prod p1  join trans_prod p2 
    on p1.txn_id = p2.txn_id and p1.prod_id !=p2.prod_id 
    join trans_prod p3
    on p3.txn_id = p2.txn_id and  p3.prod_id !=p1.prod_id and p3.prod_id !=p2.prod_id
    order by 1,2,3
),
res as
(
  select  
      prod1,prod2,prod3,count(txn_id) txncnt, 
  rank() over(partition by prod1,prod2,prod3 order by count(txn_id) ) rnk
  from 
    prod_dtls
  group by 1,2,3
  order by 4 desc
)
select distinct prod1,prod2,prod3
from res
where rnk=1

