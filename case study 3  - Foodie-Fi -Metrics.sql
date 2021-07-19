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

TD. Outside The Box Questions
The following are open ended questions which might be asked during a technical interview for this case study - there are no right or wrong answers, but answers that make sense from both a technical and a business perspective make an amazing impression!

How would you calculate the rate of growth for Foodie-Fi?
What key metrics would you recommend Foodie-Fi management to track over time to assess performance of their overall business?
What are some key customer journeys or experiences that you would analyse further to improve customer retention?
If the Foodie-Fi team were to create an exit survey shown to customers who wish to cancel their subscription, what questions would you include in the survey?
What business levers could the Foodie-Fi team use to reduce the customer churn rate? How would you validate the effectiveness of your ideas?


#1. What is the month wise 
        1) cumulative customer count , 
        2) new customer count 
        3) rate of growh 
*/
