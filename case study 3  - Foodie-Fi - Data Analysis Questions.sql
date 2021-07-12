/*
DESCRIBE plans;
+-----------+--------------+
| Field | Type 
+-----------+--------------+
| plan_id | int 
| plan_name | varchar(13) 
| price | decimal(5,2) 
+-----------+--------------+
DESCRIBE subscriptions;
+-------------+------+
| Field | Type 
+-------------+------+
| customer_id | int 
| plan_id | int 
| start_date | date 
+-------------+------+


B. Data Analysis Questions
1. How many customers has Foodie-Fi ever had?
2. What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value
3. What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name
4. What is the customer count and percentage of customers who have churned rounded to 1 decimal place?
5. How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?
6. What is the number and percentage of customer plans after their initial free trial?
7. What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31?
8. How many customers have upgraded to an annual plan in 2020?
9. How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi?
9B. Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc)
10. How many customers downgraded from a pro monthly to a basic monthly plan in 2020?
*/

#How many customers has Foodie-Fi ever had (with plan='trial')?
select
  count(distinct customer_id)  Total_trial_customers 
from
  subscriptions s join plans p 
on
  s.plan_id = p.plan_id
where
  p.plan_name='trial';

/* 
RESULT :
+-----------------------+
| Total_trial_customers |
+-----------------------+
|                  1000 |
+-----------------------+
*/


#What is the monthly distribution of trial plan 

select 
year(start_date),month(start_date) mth,count(s.plan_id)
from
  subscriptions s join plans p 
on
  s.plan_id = p.plan_id 
where
  p.plan_name = 'trial'
group by 1,2
order by 1,2;

/* 
RESULT : 
+------------------+------+------------------+
| year(start_date) | mth  | count(s.plan_id) |
+------------------+------+------------------+
|             2020 |    1 |               88 |
|             2020 |    2 |               68 |
|             2020 |    3 |               94 |
|             2020 |    4 |               81 |
|             2020 |    5 |               88 |
|             2020 |    6 |               79 |
|             2020 |    7 |               89 |
|             2020 |    8 |               88 |
|             2020 |    9 |               87 |
|             2020 |   10 |               79 |
|             2020 |   11 |               75 |
|             2020 |   12 |               84 |
+------------------+------+------------------+
12 rows in set (0.01 sec)
*/

#What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name

select 
  plan_name,count(s.plan_id) Total_events_after_2020
from
  subscriptions s join plans p 
on
  s.plan_id=p.plan_id 
where
  year(start_date)=2021
group by plan_name ;

/*

select 
  plan_name,count(s.plan_id) Total_events_after_2020
from
  subscriptions s join plans p 
on
  s.plan_id=p.plan_id 
where
  year(start_date)=2021
group by plan_name ;

*/
#What is the customer count and percentage of customers who have churned rounded to 1 decimal place?
with 
  tot_customers as 
(
  select count(customer_id) tot_customers from subscriptions 
),
churned as 
(
  select 
    count(distinct customer_id)  churn_customers
  from 
    subscriptions s join plans p
  on 
    s.plan_id = p.plan_id
  where plan_name='churn'
)
select 
    tot_customers,churn_customers,
    round((100*(churn_customers*1.0/tot_customers)),1) percentage_of_churned_customers
from
  tot_customers,churned;

/*

+---------------+-----------------+---------------------------------+
| tot_customers | churn_customers | percentage_of_churned_customers |
+---------------+-----------------+---------------------------------+
|          2650 |             307 |                            11.6 |
+---------------+-----------------+---------------------------------+
1 row in set (0.00 sec)

*/

#How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?

#without window function 

#logic :  
# Result set 1 : Get the start date for each customer with their plan trial , getting the min(start_date) for each customer to get the strat date of  trial record
 #Result set 2 : Get the min(start_date) for each customer with a condition that their start date should greater than the start date retrieved from the first result set.   
# Result set 3 : Filter 2nd result set for records having the plan name as churn 
# Result set 4 : Get the total unique customer count       
#calculate percenatage for 3 / 4 

with plan_start_date as 
(
  select 
    s.customer_id,min(start_date) trial_start_date 
  from
    subscriptions  s join plans p 
  on 
    s.plan_id = p.plan_id
  #where plan_name = 'trial'  #this condition is needed only if there cna be multiple trial records 
  group by customer_id
),
 plan_next_start_date as
(
  select
     s.customer_id,min(start_date) next_start_date
  from
    subscriptions  s 
  join plans p 
    on 
      s.plan_id = p.plan_id
  join plan_start_date ps 
  on 
    s.customer_id = ps.customer_id 
  and s.start_date > ps.trial_start_date
  group by 1
),
 churn_customers as 
(
  select 
    count(distinct s.customer_id) churn_customers
  from
    subscriptions  s 
  join plans p 
    on 
      s.plan_id = p.plan_id
  join plan_next_start_date ps
  on
    s.customer_id = ps.customer_id
    and s.start_date = ps.next_start_date
  where 
    plan_name = 'churn'
),
 tot_customers as 
(
  select count(distinct s.customer_id) tot_customers
  from
    subscriptions s 
),
res as 
(
  select 
    tot_customers,churn_customers, round(((churn_customers*1.0/tot_customers)*100),0) percentage
  from
    churn_customers,tot_customers
)
select * from res;

#with window function
#LOGIC :  rank each plan for customers based on the start_date of plan. As per data For every customer first plan is always plan 0 - trial . so for our criteria, the 2nd rank should have the plan name as churn . 
#result set 1  : Rank customers based on their plan start date 
#result set 2  : In the result set 1 , select records with rnk=1 as trial and rank=2 as churn 
#result set 3  : Get the count of result set 2 (churn customers count)
#result set 4  : Get the total customers count 
#calculate percenatage for 3 / 4 

with custplan as
(
  select 
    customer_id,plan_id,start_date,row_number() over(partition by customer_id order by start_date) rownum
  from 
   subscriptions 
)
, custchurn_dtls as 
(
  select c.customer_id
  from
    custplan c  join plans p on c.plan_id = p.plan_id 
  
    where plan_name in ('trial','churn') and rownum in (1,2)
  group by 1
  having count(*)=2  
)
,churn_customers as 
(
  select count(*) churn_customers from custchurn_dtls
)
, tot_customers as 
(
  select count(distinct s.customer_id) tot_customers
  from
    subscriptions s 
)
select 
  tot_customers,churn_customers, round(((churn_customers*1.0/tot_customers)*100),0) percentage
  from
    churn_customers,tot_customers;
    
#6. What is the number and percentage of customer plans after their initial free trial?
#LOGIC: 
# Get the planwise, total  number of records , and grand total number of plans with planid!=0 and get the avg 
 with plan as
 (
   select 
    plan_name,totplans,sum(totplans) over() grandtot
  from
   (select 
         plan_name,count(s.plan_id) totplans
  from
    subscriptions s
    join plans p 
      on 
        s.plan_id = p.plan_id
      where plan_name !='trial'
    group by 1
  )a
)
select
    plan_name,totplans, round(((totplans*1.0/grandtot)*100),2) percentage
from
    plan
  union 
select 
  'Grand Total', sum(totplans), round(sum(((totplans*1.0/grandtot)*100)),2) 
  from plan;

/*
RESULT: 
+---------------+-----------------+------------+
| tot_customers | churn_customers | percentage |
+---------------+-----------------+------------+
|          1000 |              92 |          9 |
+---------------+-----------------+------------+
*/
#7. What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31?
 #LOGIC: 
 #Result set 1: customer wise get hte maximum start date where start date is <='2020-12-31' 
 #Result set 2: customer wise get the plan name from subscription tbale where start date is equal to start date retreived in result set 1
 #Result set 3: Group result set 2 by plan and get the precentage
 
 
 with custstartdate as 
 (
   select 
    customer_id,max(start_date) cust_start_date
   from 
    subscriptions 
   where start_date <= '2020-12-31'
  group by customer_id
 ),
 cust_plan as
 (
   select 
     s.customer_id,s.plan_id 
   from
    custstartdate c join subscriptions s
   on s.customer_id = c.customer_id and s.start_date = c.cust_start_date
 ),
 custcnt as
 (
   select 
      plan_name,cust_count,sum(cust_count) over() tot_customers
   from
   (
      select 
        plan_name,count(customer_id)  cust_count
      from
        cust_plan c join plans p 
       on c.plan_id = p.plan_id
       group by plan_name 
    )a
),
res as 
(
  select 
    plan_name,cust_count, round((100*((cust_count*1.0)/tot_customers)),2) percentage_cust
  from
    custcnt
  union 
  select 
    'Grand total',sum(cust_count),round(sum((100*((cust_count*1.0)/tot_customers))),2)
  from
    custcnt
)
 select * from res;
 
 /*
RESULT:  
+---------------+------------+-----------------+
| plan_name     | cust_count | percentage_cust |
+---------------+------------+-----------------+
| trial         |         19 |            1.90 |
| basic monthly |        224 |           22.40 |
| pro monthly   |        326 |           32.60 |
| pro annual    |        195 |           19.50 |
| churn         |        236 |           23.60 |
| Grand total   |       1000 |          100.00 |
+---------------+------------+-----------------+

 */
 
 #8. How many customers have upgraded to an annual plan in 2020?
 #LOGIC: select list of customers from subscription where plan name = pro annual and start_date is 2020
  with method1 as   #only customer count 
 (
  select 
    count(distinct customer_id) Annual_customers_in_2020
  from 
    subscriptions s join plans p on s.plan_id = p.plan_id 
  where 
    plan_name = 'pro annual' and year(start_date) = 2020
 ),
 method2 as #customer count with percentage
 (
    select 
      sum(case when plan_name = 'pro annual' then 1 else 0 end) Annual_customers , count(distinct customer_id) totalcustomers, 
      round(100*((1.0*sum(case when plan_name = 'pro annual' then 1 else 0 end))/count(distinct customer_id)),2) perc
  from 
    subscriptions s join plans p on s.plan_id = p.plan_id 
  where  year(start_date) = 2020
 )
 select * from method2;

/*

+------------------+----------------+-------+
| Annual_customers | totalcustomers | perc  |
+------------------+----------------+-------+
|              195 |           1000 | 19.50 |
+------------------+----------------+-------+

*/

#9. How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi?
#Result set 1: get the inital start date for customers who enrolled in annual plan 
#Result set 2: get the start date for customers with annual plan and days difference between result 1 and annual plan start date 
#Calculate average (count(customers)/sum(date diff) )

with initialdate as 
(
  select 
    customer_id,min(start_date) first_plan_date 
  from 
    subscriptions s join plans p on s.plan_id = p.plan_id
  group by 1
),
annualplan as 
(
  select 
    s.customer_id,i.first_plan_date,s.start_date annual_plan_date , 
    datediff(s.start_date,first_plan_date) days_diff
  from subscriptions s join plans p on s.plan_id = p.plan_id 
  join initialdate i on s.customer_id = i.customer_id 
  where p.plan_name = 'pro annual'
),
avg_per_customer as
(
  select 
     count(distinct customer_id) annual_customers, 
     sum(days_diff) total_days,
      round((1.0*sum(days_diff)) / count(distinct customer_id),0) Average_days_per_customer
  from annualplan
)
select * from avg_per_customer;

/*
RESULT 

+------------------+------------+---------------------------+
| annual_customers | total_days | Average_days_per_customer |
+------------------+------------+---------------------------+
|              258 |      26992 |                       105 |
+------------------+------------+---------------------------+

*/
#9B. Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc)


with initialdate as 
(
  select 
    customer_id,min(start_date) first_plan_date 
  from 
    subscriptions s join plans p on s.plan_id = p.plan_id
  group by 1
),
annualplan as 
(
  select 
    s.customer_id,i.first_plan_date,s.start_date annual_plan_date , 
    datediff(s.start_date,first_plan_date) days_diff
  from subscriptions s join plans p on s.plan_id = p.plan_id 
  join initialdate i on s.customer_id = i.customer_id 
  where p.plan_name = 'pro annual'
),
thirtydayaverage as
(
  select 
    (days_diff div 30) thirtydayrange , count(distinct customer_id) total_customers, 
     sum(days_diff) total_days,
      round((1.0*sum(days_diff)) / count(distinct customer_id),0) Average_days_per_customer
  from 
    annualplan
  group by 1
),
res as 
(
  select 
  case 
    when thirtydayrange =0 then 'Less than 30 days'
    else concat((thirtydayrange-1)*30," - ", thirtydayrange*30)
  end Days_Range,
  total_customers tot_cust,total_days tot_days,Average_days_per_customer avg_days
from
    thirtydayaverage
)
select * from res;

/*
RESULT 

+-------------------+----------+----------+----------+
| Days_Range        | tot_cust | tot_days | avg_days |
+-------------------+----------+----------+----------+
| Less than 30 days |       48 |      458 |       10 |
| 0 - 30            |       25 |     1046 |       42 |
| 30 - 60           |       33 |     2339 |       71 |
| 60 - 90           |       35 |     3494 |      100 |
| 90 - 120          |       43 |     5721 |      133 |
| 120 - 150         |       35 |     5654 |      162 |
| 150 - 180         |       27 |     5139 |      190 |
| 180 - 210         |        4 |      897 |      224 |
| 210 - 240         |        5 |     1286 |      257 |
| 240 - 270         |        1 |      285 |      285 |
| 270 - 300         |        1 |      327 |      327 |
| 300 - 330         |        1 |      346 |      346 |
+-------------------+----------+----------+----------+
*/

#11. How many customers downgraded from a pro monthly to a basic monthly plan in 2020?
#LOGIC:
#Result set 1: get list of customers having pro monthly start date in 2020
#Result set 2 : For the customers in result set 1, get list of customers having  basic monthly plan and basic monthly plan start date is greater than the start date in result set 1 . (By doing result set 1 first, even if a customer joins pro in 2020 and moves to basic in 2021, their records will get selected)


with procustomers as 
(
  select customer_id,start_date pro_start_date
  from
    subscriptions s join plans p on s.plan_id = p.plan_id 
  where 
    year(start_date)=2020 
    and plan_name = 'pro monthly'
),
res as
(
  select 
    s.customer_id  
  from
    subscriptions s join plans p on s.plan_id = p.plan_id 
    join procustomers p on s.customer_id = p.customer_id
    and s.start_date > p.pro_start_date
  and  p.plan_name = 'basic monthly'
)
select * from res;

