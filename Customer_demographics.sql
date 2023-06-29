---This SQL queries analyzes the customers & their cuisines preferences. This helps to understand the types of customers & their preferences.
*/


---  Total Customers in each state
SELECT
    State,
    COUNT(consumer_id) AS Total_Customers
FROM
    customer_details
GROUP BY
    State
ORDER BY
    Total_Customers DESC;

	
	
---  Total Customers in each city
SELECT
    city,
    COUNT(consumer_id) AS Total_Customers
FROM
    customer_details
GROUP BY
    city
ORDER BY
    Total_Customers DESC;

---  Budget level of customers
SELECT
    budget,
    COUNT(consumer_id) AS Total_Customers
FROM
    customer_details
WHERE
    budget IS NOT NULL
GROUP BY
    budget;


---  Total Smokers by Occupation
SELECT
    occupation,
    COUNT(consumer_id) AS Smokers
FROM
    customer_details
WHERE
    smoker = 'Yes'
GROUP BY
    occupation;


---  Drinking level of students
SELECT
    drink_level,
    COUNT(consumer_id) AS student_count
FROM
    customer_details
WHERE
    occupation = 'Student' AND occupation IS NOT NULL
GROUP BY
    drink_level;


---  Transportation methods of customers
SELECT
    transportation_method,
    COUNT(consumer_id) AS Total_Customers
FROM
    customer_details
WHERE
    transportation_method IS NOT NULL
GROUP BY
    transportation_method
ORDER BY
    Total_Customers DESC;


---  Adding Age Bucket Column 
ALTER TABLE customer_details
ADD Age_Bucket VARCHAR(50);



--- Updating the Age Bucket column with case when condition
UPDATE customer_details
SET age_bucket = CASE
                    WHEN age > 60 THEN '61 and Above'
                    WHEN age > 40 THEN '41 - 60'
                    WHEN age > 25 THEN '26 - 40'
                    WHEN age >= 18 THEN '18 - 25'
                END
WHERE age_bucket IS NULL;
				  
	
	
---  Total customers in each age bucket
SELECT 
	 age_bucket,
	 count(consumer_id) as Total_Customers
FROM 	 customer_details
GROUP BY age_bucket
ORDER BY age_bucket;

	

--- Total customers count & smokers count in each age percent 
SELECT 
	 age_bucket,
	 count(consumer_id) as total,
	 count(case when smoker = 'Yes' then consumer_id end) as smokerscount
FROM 	 customer_details
GROUP BY age_bucket
ORDER BY age_bucket;



SELECT * FROM customer_preference
	
---  Top 20 preferred cuisines
SELECT 
	 preferred_cuisine,
	 count(consumer_id) AS total_customers
FROM 	 customer_preference	
GROUP BY preferred_cuisine
ORDER BY total_customers DESC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY;



---  Preferred cuisines of each customer
SELECT 
    consumer_id,
    count(preferred_cuisine) AS total_cuisines,
    STRING_AGG(preferred_cuisine, ',') AS Cuisines
FROM 
    customer_preference
GROUP BY 
    consumer_id
ORDER BY 
    total_cuisines DESC;



--- Customer Budget analysis for each cuisine

SELECT
    b.preferred_cuisine,
    SUM(CASE WHEN a.budget = 'High' THEN 1 ELSE 0 END) AS High,
    SUM(CASE WHEN a.budget = 'Medium' THEN 1 ELSE 0 END) AS Medium,
    SUM(CASE WHEN a.budget = 'Low' THEN 1 ELSE 0 END) AS Low
FROM
    customer_details AS a
INNER JOIN
    customer_preference AS b ON a.consumer_id = b.consumer_id
GROUP BY
    b.preferred_cuisine
ORDER BY
    b.preferred_cuisine;


--- Finding out count of each cuisine in each state

SELECT
    a.state,
    b.preferred_cuisine
FROM
    customer_details AS a
INNER JOIN
    customer_preference AS b ON a.consumer_id = b.consumer_id
GROUP BY
    a.state, b.preferred_cuisine
ORDER BY
    a.state;

SELECT
    b.preferred_cuisine,
    SUM(CASE WHEN a.state = 'Morelos' THEN 1 ELSE 0 END) AS Morelos,
    SUM(CASE WHEN a.state = 'San Luis Potosi' THEN 1 ELSE 0 END) AS San_Luis_Potosi,
    SUM(CASE WHEN a.state = 'Tamaulipas' THEN 1 ELSE 0 END) AS Tamaulipas
FROM
    customer_details AS a
INNER JOIN
    customer_preference AS b ON a.consumer_id = b.consumer_id
GROUP BY
    b.preferred_cuisine
ORDER BY
    b.preferred_cuisine;



---  Finding out count of each cuisine in each age bucket
SELECT
    b.preferred_cuisine,
    SUM(CASE WHEN a.age_bucket = '18 - 25' THEN 1 ELSE 0 END) AS [18 - 25],
    SUM(CASE WHEN a.age_bucket = '26 - 40' THEN 1 ELSE 0 END) AS [26 - 40],
    SUM(CASE WHEN a.age_bucket = '41 - 60' THEN 1 ELSE 0 END) AS [41 - 60],
    SUM(CASE WHEN a.age_bucket = '61 and Above' THEN 1 ELSE 0 END) AS [61+]
FROM
    customer_details AS a
INNER JOIN
    customer_preference AS b ON a.consumer_id = b.consumer_id
GROUP BY
    b.preferred_cuisine
ORDER BY
    b.preferred_cuisine;
