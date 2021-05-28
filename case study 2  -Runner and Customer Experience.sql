/*Runner and Customer Experience*/



/*How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)*/

select 
  EXTRACT('week'  from registration_date) week_number, count(runner_id) total_runners 
from 
  runners
group by 
  week_number
order by 1;



/*What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?*/

select 
  runner_id, extract(min from avg((cast(ro.pickup_time as timestamp)) -co.order_time))
from
  customer_orders co
  join runner_orders ro
on
  co.order_id = ro.order_id
where coalesce(cancellation,'')=''
group by 1;

/*Is there any relationship between the number of pizzas and how long the order takes to prepare?
CONCLUSION- No there is no relationsip as the average time to preapare an orederis around 10 mins.*/

select 
  co.order_id,count(pizza_id), extract(min from avg((cast(ro.pickup_time as timestamp)) -co.order_time)) mins_to_prepare_order, 
  round(extract(min from avg((cast(ro.pickup_time as timestamp)) -co.order_time))/count(pizza_id)) avg_time
from
  customer_orders co
  join runner_orders ro
on
  co.order_id = ro.order_id
where coalesce(cancellation,'')=''
group by 1;


/*What was the average distance travelled for each customer?*/

select
  customer_id, avg(cast(replace(replace(replace(distance,'km',''),'null','0'),'','0') as float))
from
 customer_orders co
join 
 runner_orders ro
 on co.order_id=ro.order_id
group by customer_id
;


/*What was the difference between the longest and shortest delivery times for all orders?*/
SELECT 
  extract(min from (max(cast(pickup_time as timestamp)-order_time))) longest_time,
  extract(min from (min(cast(pickup_time as timestamp)-order_time))) shortest_time 
FROM
  customer_orders co 
JOIN
  runner_orders ro 
ON 
  co.order_id = ro.order_id 
where coalesce(cancellation,'')='';





/*What was the average speed for each runner for each delivery and do you notice any trend for these values?*/
with r as 
(
  SELECT 
    runner_id,order_id,
    cast(replace(replace(replace(distance,'km',''),'null','0'),'','0') as float) distance,
    cast(replace(replace(replace(replace(duration,'minutes',''),'mins',''),'null','0'),'minute','') as float) duration
  FROM
    runner_orders
  where coalesce(cancellation,'')=''
)
SELECT runner_id, 100*(sum(distance)*1.0/sum(duration))
from r
group by 1
  ;



/*What is the successful delivery percentage for each runner?*/

select runner_id,round(100* (sum(success)*1.0/ count(order_id)),2) percentage
from
  (select runner_id, order_id, ( case when coalesce(replace(cancellation,'null',''),'') = ''  then 1 else 0 end) success
  from runner_orders)a
group by 1;
