CREATE TABLE sales (
  "customer_id" VARCHAR(1),
  "order_date" DATE,
  "product_id" INTEGER
);

INSERT INTO sales
  ("customer_id", "order_date", "product_id")
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
 

CREATE TABLE menu (
  "product_id" INTEGER,
  "product_name" VARCHAR(5),
  "price" INTEGER
);

INSERT INTO menu
  ("product_id", "product_name", "price")
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');
  
  
  
  

CREATE TABLE members (
  "customer_id" VARCHAR(1),
  "join_date" DATE
);

INSERT INTO members
  ("customer_id", "join_date")
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');



/* --------------------
   Case Study Questions
   --------------------*/

-- 1. What is the total amount each customer spent at the restaurant?
-- 2. How many days has each customer visited the restaurant?
-- 3. What was the first item from the menu purchased by each customer?
-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
-- 5. Which item was the most popular for each customer?
-- 6. Which item was purchased first by the customer after they became a member?
-- 7. Which item was purchased just before the customer became a member?
-- 8. What is the total items and amount spent for each member before they became a member?
-- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

-- Example Query:
-- 1. What is the total amount each customer spent at the restaurant?
SELECT 
	s.customer_id,sum(price) total_amount 
FROM
	sales s JOIN  members m 
    ON s.customer_id = m.customer_id 
	JOIN menu m1
    ON s.product_id = m1.product_id
GROUP BY 1;

-- 2. How many days has each customer visited the restaurant?
SELECT 
	customer_id,count(distinct order_date) visited_days 
FROM
	sales 
GROUP BY 1;

-- 3. What was the first item from the menu purchased by each customer?

SELECT 
	f.customer_id,product_name 
FROM
	menu m 
    JOIN 
      (SELECT 
          s.customer_id,min(product_id) product_id
      FROM
          sales s 
          JOIN
            (SELECT
                customer_id,min(order_date) first_order
            FROM
                sales
            GROUP BY 1) sf
            ON s.customer_id = sf.customer_id 
            AND s.order_date = sf.first_order
       GROUP BY 1
      )f
     ON m.product_id = f.product_id;
     
 --4. What is the most purchased item on the menu and how many times was it purchased by all customers?
 
 SELECT 
 	s.product_id,m.product_name,count(*) order_count 
 FROM
 	sales s JOIN menu m 
    ON s.product_id = m.product_id 
 GROUP BY 1,2 
 order by 3 desc 
 limit 1;
 
 -- 5. Which item was the most popular for each customer?

SELECT 
	a.customer_id,a.product_id,product_name 
FROM
  (SELECT 
      customer_id,product_id,prd_cnt,
      rank() over(partition by customer_id order by prd_cnt desc) prdrnk
  FROM
    (SELECT
        customer_id,product_id,count(*) prd_cnt
    FROM
        sales s 
    GROUP BY 1,2)a
  )a 
  JOIN menu m 
  ON a.product_id = m.product_id 
WHERE 
	prdrnk=1
order by 1,2;

-- 6. Which item was purchased first by the customer after they became a member?

   	
SELECT 
	s.customer_id,s.product_id ,m.product_name 
FROM
	sales s join menu m on s.product_id = m.product_id 
JOIN 
  (SELECT 
        s.customer_id,min(order_date)  first_order
  FROM
      sales s JOIN members m
      ON s.customer_id = m.customer_id 
   where s.order_date >=m.join_date
   GROUP BY 1
   )fo
   ON s.customer_id = fo.customer_id 
   AND s.order_date = fo.first_order
ORDER BY 1,2;

-- 7. Which item was purchased just before the customer became a member?
SELECT
	s.customer_id,s.product_id,m.product_name 
FROM
(
    SELECT
      s.customer_id,max(s.product_id) product_id 
  FROM
      sales s 
      JOIN 
        (SELECT
                s.customer_id,max(order_date) last_order
        FROM
            sales s JOIN members m 
            ON s.customer_id = m.customer_id 
        WHERE 
            s.order_date < m.join_date
        GROUP BY 1)l
       ON s.customer_id = l.customer_id 
       AND s.order_Date = l.last_order
  GROUP BY 1)s
 JOIN menu m 
 ON s.product_id = m.product_id
 order by 1;

-- 8. What is the total items and amount spent for each member before they became a member?

SELECT 
      s.customer_id,count(*) total_items,sum(price) total_amount
FROM
	sales s JOIN menu m 
    ON s.product_id = m.product_id 
    JOIN members m1
    on s.customer_id = m1.customer_id
WHERE s.order_date < m1.join_date
GROUP BY 1;

-- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

SELECT 
      c.customer_id,
      SUM(CASE WHEN product_name = 'sushi' then 2*10*price 
      ELSE 10*price END )  points
FROM
	sales c join menu p
    ON c.product_id = p.product_id 
GROUP BY 1
order by 1;

-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

SELECT 
	s.customer_id, 
    SUM(CASE WHEN order_date >= join_date AND order_date < first_week 
         THEN 2*10*price 
     	 WHEN product_name = 'sushi' THEN 2*10*price 
         ELSE 10*price
    END) as points
 FROM 
 	sales s JOIN  	
    (
      SELECT 
         customer_id,join_date,join_date + INTERVAL '1 week' first_week 
    FROM
        members
    )m ON s.customer_id = m.customer_id 
    JOIN menu m1
    ON s.product_id = m1.product_id 
 GROUP BY 1
 ORDER BY 1;
 
 --BONUS questions 
 
 SELECT 
 	s.customer_id,to_char(s.order_date,'YYYY-MM-DD') order_date,p.product_name,price,
    CASE WHEN m.customer_id is NULL THEN 'N' 
    WHEN s.order_date < m.join_date THEN 'N'
    ELSE 'Y' END member 
 FROM
 	sales s JOIN menu p 
    ON s.product_id = p.product_id 
    LEFT JOIN members m 
    ON s.customer_id = m.customer_id 
 ORDER BY 
 	1,2,3;
    
-- RANK MEMBERS ONLY 

SELECT 
	customer_id,order_date,product_name,price,member, 
    CASE WHEN member = 'N' then Null 
    ELSE rnk END ranking 
FROM
(
  	SELECT 
	customer_id,order_date,product_name,price,member, 
    rank() over(partition by customer_id,member order by order_date ) rnk 
FROM
    (SELECT 
        s.customer_id,to_char(order_date,'YYYY-MM-DD') order_date, 
        product_name,price,
        CASE WHEN m.customer_id is NULL THEN 'N'
        WHEN s.order_date < m.join_Date THEN 'N'
        ELSE 'Y' END member
    FROM
        sales s JOIN menu p 
        ON s.product_id = p.product_id 
        LEFT JOIN members m 
        ON s.customer_id = m.customer_id 
    )s
  )a
 order by 1,member,ranking;



