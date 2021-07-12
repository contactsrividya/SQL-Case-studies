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

The Foodie-Fi team wants you to create a new payments table for the year 2020 that includes amounts paid by each customer in the subscriptions table with the following requirements:

monthly payments always occur on the same day of month as the original start_date of any monthly paid plan
upgrades from basic to monthly or pro plans are reduced by the current paid amount in that month and start immediately
upgrades from pro monthly to pro annual are paid at the end of the current billing period and also starts at the end of the month period
once a customer churns they will no longer make payments
*/
#LOGIC: 1. for each customer get the plan end date for each plan. If no plan end date , last day of year of start date is the end date .User recursive CTE to rolldown start and end dates to get customer wised plan wise records for each month.
#2. for each customer and month, chk if there are multiple records, if current is pro month or pro premium , and previous record is basic , reduce previous record price from current record

with  recursive
custplan as 
(
  
  select 
    customer_id,plan_id,start_date,
    case  when end_date is null then date(concat(year(start_date),'-12-31'))
          else date_sub(end_date,interval 1 day ) 
    end end_date 
  from
  (
    select 
      customer_id,plan_id,start_date, lead(start_date) over(partition by customer_id order by start_date) end_date
    from 
      subscriptions 
    where 
      plan_id in (1,2,3) and year(start_date)=2020
  )a
),
custchurn as  #once a customer churns they will no longer make payments
(
  select customer_id,start_date 
  from 
  subscriptions where plan_id=4 and year(start_date)=2020
)
,custplan_dtls as 
(
  
  select 
    cp.customer_id,cp.plan_id,cp.start_date,cp.end_date
  from 
    custplan cp
  union all 
  select 
    cd.customer_id,cd.plan_id,date_add(cd.start_date,interval 1 month),cd.end_date
  from 
    custplan_dtls  cd left join custchurn c 
    on cd.customer_id = c.customer_id
  where  
      cd.plan_id in (1,2)  #repeat if it is pro monthly or pro annual
      and date_add(cd.start_date,interval 1 month) < end_date and 
      date_add(cd.start_date,interval 1 month) < coalesce(c.start_date,end_date)
),
plan_old_rate as 
(
  select 
    c.customer_id custid,c.plan_id,p.plan_name,c.start_date st_date,c.end_date,p.price,
    count(c.plan_id) over(partition by customer_id,month(c.start_date)) mth_tot, 
    lag(c.plan_id) over(partition by customer_id order by c.start_date)  prev_plan,
    lag(p.price) over(partition by customer_id order by c.start_date) prev_price
  from custplan_dtls c 
  join plans p on c.plan_id = p.plan_id
)
,plan_rate as 
(
  select 
      custid,p.plan_id,plan_name,st_date payment_date,
    case when mth_tot >1  and p.plan_id in (2,3)  and prev_plan=1 then # if current plan is pro and previous plan is basic monthly 
        price-prev_price 
    else
      p.price 
  end amount
    from plan_old_rate  p
 union all 
 select 
    custid,prev_plan,p.plan_name, st_date payment_date,prev_price amount
  from 
    plan_old_rate po join plans p on po.prev_plan = p.plan_id
  where po.plan_id=3 and prev_plan=2 
),
res as 
(
  select 
      custid,plan_id,plan_name, payment_date,amount,
      row_number() over(partition by custid order by payment_date,plan_id) rownum
  from plan_rate 
order by custid,payment_date
)
select * from res #where custid in (1,2,13,15,16,18,19)
order by custid,rownum;


/*

+--------+---------+---------------+--------------+--------+--------+
| custid | plan_id | plan_name     | payment_date | amount | rownum |
+--------+---------+---------------+--------------+--------+--------+
|      1 |       1 | basic monthly | 2020-08-08   |   9.90 |      1 |
|      1 |       1 | basic monthly | 2020-09-08   |   9.90 |      2 |
|      1 |       1 | basic monthly | 2020-10-08   |   9.90 |      3 |
|      1 |       1 | basic monthly | 2020-11-08   |   9.90 |      4 |
|      1 |       1 | basic monthly | 2020-12-08   |   9.90 |      5 |
|      2 |       3 | pro annual    | 2020-09-27   | 199.00 |      1 |
|     13 |       1 | basic monthly | 2020-12-22   |   9.90 |      1 |
|     15 |       2 | pro monthly   | 2020-03-24   |  19.90 |      1 |
|     15 |       2 | pro monthly   | 2020-04-24   |  19.90 |      2 |
|     16 |       1 | basic monthly | 2020-06-07   |   9.90 |      1 |
|     16 |       1 | basic monthly | 2020-07-07   |   9.90 |      2 |
|     16 |       1 | basic monthly | 2020-08-07   |   9.90 |      3 |
|     16 |       1 | basic monthly | 2020-09-07   |   9.90 |      4 |
|     16 |       1 | basic monthly | 2020-10-07   |   9.90 |      5 |
|     16 |       3 | pro annual    | 2020-10-21   | 189.10 |      6 |
|     18 |       2 | pro monthly   | 2020-07-13   |  19.90 |      1 |
|     18 |       2 | pro monthly   | 2020-08-13   |  19.90 |      2 |
|     18 |       2 | pro monthly   | 2020-09-13   |  19.90 |      3 |
|     18 |       2 | pro monthly   | 2020-10-13   |  19.90 |      4 |
|     18 |       2 | pro monthly   | 2020-11-13   |  19.90 |      5 |
|     18 |       2 | pro monthly   | 2020-12-13   |  19.90 |      6 |
|     19 |       2 | pro monthly   | 2020-06-29   |  19.90 |      1 |
|     19 |       2 | pro monthly   | 2020-07-29   |  19.90 |      2 |
|     19 |       2 | pro monthly   | 2020-08-29   |  19.90 |      3 |
|     19 |       3 | pro annual    | 2020-08-29   | 199.00 |      4 |
+--------+---------+---------------+--------------+--------+--------+

*/