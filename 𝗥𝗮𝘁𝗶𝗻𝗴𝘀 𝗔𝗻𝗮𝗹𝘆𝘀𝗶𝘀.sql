----This SQL queries analyzes the ratings given by customers to restaurants. This helps to understand the customer choice & restaurants performance better.
*/

---  Ratings given by customer for restaurants
SELECT
	   b.consumer_id,
	   a.name,
	   b.overall_rating,
	   b.food_rating,
	   b.service_rating
FROM
	   Restaurants AS a
INNER JOIN
	   Customer_Ratings AS b ON a.Restaurant_ID = b.Restaurant_ID
ORDER BY
	   b.Restaurant_ID;


---  Average ratings of each restaurant including it's cuisine type
SELECT
	   a.name,
	   ROUND(AVG(b.overall_rating), 2) AS overall_Rating,
	   ROUND(AVG(b.food_rating), 2) AS food_rating,
	   ROUND(AVG(b.service_rating), 2) AS service_rating,
	   c.cuisine
FROM
	   Restaurants AS a
INNER JOIN
	   Customer_Ratings AS b ON a.Restaurant_ID = b.Restaurant_ID
INNER JOIN
	   restaurant_cuisines AS c ON a.Restaurant_ID = c.Restaurant_ID
GROUP BY
	   a.name, c.cuisine
ORDER BY
	   a.name;


---  Creating new columns for sentiment analysis
ALTER TABLE customer_ratings ADD overall_senti VARCHAR(50) NULL;
ALTER TABLE customer_ratings ADD food_senti VARCHAR(50) NULL;
ALTER TABLE customer_ratings ADD service_senti VARCHAR(50) NULL;


SELECT * FROM customer_ratings;


---  Updating the new columns with the sentiments 

UPDATE customer_ratings
SET overall_senti = CASE 
			 WHEN overall_rating = 0 THEN 'Negative'
			 WHEN overall_rating = 1 THEN 'Neutral'	
			 WHEN overall_rating = 2 THEN 'Positive'
			 END
WHERE overall_senti IS NULL;

UPDATE customer_ratings
SET food_senti = CASE 
		      WHEN food_rating = 0 THEN 'Negative'
		      WHEN food_rating = 1 THEN 'Neutral'	
		      WHEN food_rating = 2 THEN 'Positive'
		      END
WHERE food_senti IS NULL;

UPDATE customer_ratings
SET service_senti = CASE 
			 WHEN service_rating = 0 THEN 'Negative'
			 WHEN service_rating = 1 THEN 'Neutral'	
			 WHEN service_rating = 2 THEN 'Positive'
			 END
WHERE service_senti IS NULL;




---  Conduct a sentimental analysis of total count of customers
CREATE VIEW overall AS (
SELECT 
	overall_senti,
	count(consumer_id) as total_customers
FROM 	customer_ratings
GROUP BY overall_senti
);

CREATE VIEW food AS (
SELECT 
	food_senti,
	count(consumer_id) as total_customers
FROM 	customer_ratings
GROUP BY food_senti
);

CREATE VIEW service AS (
SELECT 
	service_senti,
	count(consumer_id) as total_customers
FROM 	customer_ratings
GROUP BY service_senti
);

SELECT
	   a.overall_senti as Sentiment,
	   a.total_customers as Overall_Rating,
	   b.total_customers as food_Rating,
	   c.total_customers as service_Rating
FROM       overall as a
INNER JOIN food as b
ON         a.overall_senti = b.food_senti
INNER JOIN service as c
ON         a.overall_senti = c.service_senti;

---  List of Customers visiting local or outside restaurants

SELECT 
	   a.consumer_id,
	   b.city AS customer_city,
	   c.name,
	   c.city AS restaurant_city,
	   a.overall_senti,
	   a.food_senti,
	   a.service_senti,
	   CASE WHEN b.city = c.city THEN 'Local' ELSE 'Outside' END AS Location_preference
FROM       customer_ratings AS a
INNER JOIN customer_details AS b
ON         a.consumer_id = b.consumer_id
INNER JOIN restaurants AS c
ON         a.restaurant_id = c.restaurant_id;



---  Count of customers visiting local and outside restaurants

SELECT 
	Location_preference,
	COUNT(*) AS total_customers,
	COUNT(DISTINCT id) AS distinct_customers
FROM (
	SELECT 
		a.consumer_id AS id,
		b.city AS customer_city,
		c.name,
		c.city AS restaurant_city,
		a.overall_senti,
		a.food_senti,
		a.service_senti,
		CASE WHEN b.city = c.city THEN 'Local' ELSE 'Outside' END AS Location_preference
	FROM customer_ratings AS a
	INNER JOIN customer_details AS b
		ON a.consumer_id = b.consumer_id
	INNER JOIN restaurants AS c
		ON a.restaurant_id = c.restaurant_id
) AS cte
GROUP BY Location_preference;

		
		
---  Trend of customers visiting outside restaurants

SELECT 
	customer_id,
	customer_city,
	restaurant_city,
	CONCAT_WS(' - ', customer_city, restaurant_city) AS direction,
	restaurant_name		
FROM (
	SELECT 
		a.consumer_id AS customer_id,
		b.city AS customer_city,
		c.name AS restaurant_name,
		c.city AS restaurant_city,
		a.overall_senti,
		a.food_senti,
		a.service_senti,
		CASE WHEN b.city = c.city THEN 'Local' ELSE 'Outside' END AS Location_preference
	FROM customer_ratings AS a
	INNER JOIN customer_details AS b
		ON a.consumer_id = b.consumer_id
	INNER JOIN restaurants AS c
		ON a.restaurant_id = c.restaurant_id
) AS cte
WHERE Location_preference = 'Outside';


		
		
---  Count of direction trend from above query

SELECT
	direction,
	COUNT(customer_id) AS total_customers
FROM (
	SELECT 
		customer_id,
		customer_city,
		restaurant_city,
		CONCAT_WS(' - ', customer_city, restaurant_city) AS direction,
		restaurant_name
	FROM (
		SELECT 
			a.consumer_id AS customer_id,
			b.city AS customer_city,
			c.name AS restaurant_name,
			c.city AS restaurant_city,
			a.overall_senti,
			a.food_senti,
			a.service_senti,
			CASE WHEN b.city = c.city THEN 'Local' ELSE 'Outside' END AS Location_preference
		FROM customer_ratings AS a
		INNER JOIN customer_details AS b ON a.consumer_id = b.consumer_id
		INNER JOIN restaurants AS c ON a.restaurant_id = c.restaurant_id
	) AS cte
	WHERE Location_preference = 'Outside'
) AS cte2
GROUP BY direction;


---  Cuisine preferences vs cuisine consumed

SELECT 
	   a.consumer_id,
	   STRING_AGG(b.preferred_cuisine, ',') AS customer_preferences,
	   d.name,
	   c.cuisine AS restaurant_cuisine
FROM customer_ratings AS a
INNER JOIN customer_preference AS b
	ON a.consumer_id = b.consumer_id
INNER JOIN restaurant_cuisines AS c
	ON a.restaurant_id = c.restaurant_id
INNER JOIN restaurants AS d
	ON a.restaurant_id = d.restaurant_id
GROUP BY a.consumer_id, d.name, c.cuisine;



---  Best restaurants for each cuisines by different ratings

CREATE VIEW average_analysis AS
SELECT 
	   a.name,
	   ROUND(AVG(b.overall_rating), 2) AS overall_rating,
	   ROUND(AVG(b.food_rating), 2) AS food_rating,
	   ROUND(AVG(b.service_rating), 2) AS service_rating,
	   c.cuisine
FROM       restaurants AS a 
INNER JOIN customer_ratings AS b
ON         a.restaurant_id = b.restaurant_id
INNER JOIN restaurant_cuisines AS c
ON         a.restaurant_id = c.restaurant_id
GROUP BY   a.name, c.cuisine;

CREATE VIEW best AS
SELECT 
     cuisine,
     First_value(name) OVER(PARTITION BY cuisine ORDER BY overall_rating DESC) AS best_for_overall,
     First_value(name) OVER(PARTITION BY cuisine ORDER BY food_rating DESC) AS best_for_food,
     First_value(name) OVER(PARTITION BY cuisine ORDER BY service_rating DESC) AS best_for_service
FROM average_analysis;

SELECT *
FROM best
GROUP BY cuisine, best_for_overall, best_for_food, best_for_service
ORDER BY cuisine;


	
---  Best restaurants for each cuisines by different ratings
	
CREATE VIEW count_cuisines AS
SELECT 	
	 cuisine,
	 count(cuisine) as count
FROM     average_analysis
GROUP BY cuisine;

CREATE VIEW bad AS
SELECT 
	cuisine,
	First_value(name) OVER(PARTITION BY cuisine ORDER BY overall_rating) AS bad_for_overall,
	First_value(name) OVER(PARTITION BY cuisine ORDER BY food_rating) AS bad_for_food,
	First_value(name) OVER(PARTITION BY cuisine ORDER BY service_rating) AS bad_for_service	
FROM    ( 	
	    SELECT 
		       a.name,
		       ROUND(AVG(a.overall_rating), 2) AS overall_rating,
		       ROUND(AVG(a.food_rating), 2) AS food_rating,
		       ROUND(AVG(a.service_rating), 2) AS service_rating,
		       a.cuisine,
		       cc.count
	    FROM       average_analysis AS a
	    INNER JOIN count_cuisines AS cc
	    ON         a.cuisine = cc.cuisine
	    WHERE      cc.count > 1	
	    GROUP BY   a.name, a.cuisine, cc.count
	    ORDER BY   a.cuisine) AS least;

SELECT   *
FROM     bad
GROUP BY cuisine, bad_for_overall, bad_for_food, bad_for_service
ORDER BY cuisine;


	
---  Best cuisines by different ratings
	
SELECT TOP 1
	First_value(cuisine) OVER(ORDER BY overall_rating DESC) as overall,
	First_value(cuisine) OVER(ORDER BY food_rating DESC) as food,
	First_value(cuisine) OVER(ORDER BY service_rating DESC) as service
FROM average_analysis;



---  Total customers with highest ratings in all different criteria
SELECT 
    COUNT(consumer_id) as total_customers
FROM 
    customer_ratings
WHERE 
    overall_rating = 2 AND
    food_rating = 2 AND
    service_rating = 2;

