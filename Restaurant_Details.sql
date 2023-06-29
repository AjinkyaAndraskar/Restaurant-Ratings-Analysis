This SQL queries analyzes the restaurants & their cuisine type. This helps to understand the types of restaurants & their cuisines.
*/



---  Total restaurants in each state
SELECT
    State,
    COUNT(restaurant_id) as Total_restaurant
FROM
    restaurants
GROUP BY
    State
ORDER BY
    Total_restaurant DESC;


---  Total restaurants in each city
SELECT
    city,
    COUNT(restaurant_id) as Total_restaurant
FROM
    restaurants
GROUP BY
    city
ORDER BY
    Total_restaurant DESC;


---  Restaurants count by alcohol service 
SELECT
    alcohol_service,
    COUNT(restaurant_id) as Total_restaurant
FROM
    restaurants
GROUP BY
    alcohol_service
ORDER BY
    Total_restaurant DESC;


---  Restaurants count by smoking allowed
SELECT
    smoking_allowed,
    COUNT(restaurant_id) as Total_restaurant
FROM
    restaurants
GROUP BY
    smoking_allowed
ORDER BY
    Total_restaurant DESC;


---  Alcohol & Smoking analysis
SELECT
    alcohol_service,
    smoking_allowed,
    COUNT(restaurant_id) as Total_restaurant
FROM
    restaurants
GROUP BY
    alcohol_service,
    smoking_allowed
ORDER BY
    Total_restaurant DESC;

--- Restaurants count by Price
SELECT
    price,
    COUNT(restaurant_id) as Total_restaurant
FROM
    restaurants
GROUP BY
    price
ORDER BY
    Total_restaurant DESC;


--- Restaurants count by packing
SELECT
    parking,
    COUNT(restaurant_id) as Total_restaurant
FROM
    restaurants
GROUP BY
    parking
ORDER BY
    Total_restaurant DESC;


---  Count of Restaurants by cuisines
SELECT
    cuisine,
    COUNT(restaurant_id) AS Total_restaurant
FROM
    restaurant_cuisines
GROUP BY
    cuisine
ORDER BY
    Total_restaurant DESC;


---  Preferred cuisines of each customer
SELECT
    b.name,
    COUNT(a.cuisine) AS Total_cuisines,
    STRING_AGG(a.cuisine, ',') AS Cuisines
FROM
    restaurant_cuisines AS a
INNER JOIN
    restaurants AS b ON a.restaurant_id = b.restaurant_id
GROUP BY
    b.name
ORDER BY
    Total_cuisines DESC;



---  Restaurant price analysis for each cuisine

SELECT
    b.cuisine,
    SUM(CASE WHEN a.price = 'High' THEN 1 ELSE 0 END) AS High,
    SUM(CASE WHEN a.price = 'Medium' THEN 1 ELSE 0 END) AS Medium,
    SUM(CASE WHEN a.price = 'Low' THEN 1 ELSE 0 END) AS Low
FROM
    restaurants AS a
INNER JOIN
    restaurant_cuisines AS b ON a.restaurant_id = b.restaurant_id
GROUP BY
    b.cuisine
ORDER BY
    b.cuisine;


---  Finding out count of each cuisine in each state

SELECT
    b.cuisine,
    SUM(CASE WHEN a.state = 'Morelos' THEN 1 ELSE 0 END) AS Morelos,
    SUM(CASE WHEN a.state = 'San Luis Potosi' THEN 1 ELSE 0 END) AS San_Luis_Potosi,
    SUM(CASE WHEN a.state = 'Tamaulipas' THEN 1 ELSE 0 END) AS Tamaulipas
FROM
    restaurants AS a
INNER JOIN
    restaurant_cuisines AS b ON a.restaurant_id = b.restaurant_id
GROUP BY
    b.cuisine
ORDER BY
    b.cuisine;
