/*
Pizza Metrics
How many pizzas were ordered?
*/
SELECT
  COUNT(pizza_id)
FROM
  customer_orders;
  
-- RESULT - 14
  
  /*
  How many unique customer orders were made?
  */
  
SELECT
  COUNT(DISTINCT ORDER_ID)
FROM
  customer_orders;
/* RESULT - 10 - - How many successful orders were delivered by each runner ? */


SELECT
  runner_id,
  count(order_id)
FROM
  runner_orders
WHERE
  coalesce(cancellation, '') = ''
GROUP BY
  runner_id;
- - How many of each type of pizza was delivered ?
SELECT
  pizza_id,
  count(*)
FROM
  customer_orders co
  JOIN runner_orders ro ON co.order_id = ro.order_id
WHERE
  COALESCE(ro.cancellation, '') != ''
GROUP BY
  pizza_id;

/*

How many Vegetarian
  and Meatlovers were ordered by each customer ?
*/

SELECT
  customer_id,
  sum(
    case
      when pizza_name = 'Meatlovers' then 1
      else 0
    end
  ) Meatlovers,
  sum(
    case
      when pizza_name = 'Vegetarian' then 1
      else 0
    end
  ) Vegetarian
FROM
  customer_orders co
  JOIN runner_orders ro ON co.order_id = ro.order_id
  JOIN pizza_names pn ON co.pizza_id = pn.pizza_id
WHERE
  COALESCE(ro.cancellation, '') != ''
group by
  1
order by
  1;
/* What was the maximum number of pizzas delivered in a single order ?*/

SELECT
  order_id,
  cnt
FROM
  (
    SELECT
      order_id,
      cnt,
      rank() over(
        order by
          cnt desc
      ) rnk
    FROM
      (
        SELECT
          co.order_id,
          COUNT(pizza_id) cnt
        FROM
          customer_orders co
          JOIN runner_orders ro ON co.order_id = ro.order_id
        WHERE
          COALESCE(ro.cancellation, '') != ''
        GROUP BY
          1
      ) a
  ) a
WHERE
  rnk = 1;
  
/* For each customer,how many delivered pizzas had at least 1 change and how many had no changes ? */


SELECT
  customer_id,
  sum(
    case
      when (
        coalesce(exclusions, '') = ''
        or coalesce(extras, '') = ''
      ) then 1
      else 0
    end
  ) as change,
  count(*) - sum(
    case
      when (
        coalesce(exclusions, '') = ''
        or coalesce(extras, '') = ''
      ) then 1
      else 0
    end
  ) as Nochange,
  count(*) total
FROM
  customer_orders co
  JOIN runner_orders ro ON co.order_id = ro.order_id
WHERE 
  COALESCE(ro.cancellation, '') != ''
GROUP BY
  1
order by
  1;

/* How many pizzas were delivered that had both exclusions and extras ? */


SELECT 
  count(pizza_id) total_delivered
FROM
  customer_orders co
  JOIN runner_orders ro ON co.order_id = ro.order_id
WHERE 
  COALESCE(ro.cancellation, '') != '' and  coalesce(exclusions, '') != ''
        and coalesce(extras, '') != '';

/*What was the total volume of pizzas ordered for each hour of the day ? What was the volume of orders for each day of the week ? */


SELECT ro.order_id,pickup_time
FROM
  customer_orders co
  JOIN runner_orders ro ON co.order_id = ro.order_id
