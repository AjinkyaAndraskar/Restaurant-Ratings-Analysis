* Title :-        **Restaurant Ratings Analysis**
* Created by :-   Ajinkya Andraskar
* Date :-         29-06-2023
* Tool used:-     Microsoft SQL Server Management Studio

# Introduction :- 
* In this project, we will be analyzing restaurant ratings data to gain insights into the performance of various restaurants.
* I have used SQL to extract, transform and analyze the data.
* The insights gained from this analysis will be used to understand the factors that influence a restaurant's rating and make recommendations for improvement.
* I will examine the relationship between different variables such as the location, cuisine and price range of the restaurants and their ratings.
* I will also do sentiment analysis to analyse most favorable restaurants of customers

# Data :- 
* This dataset contains restaurant ratings in Mexico provided by actual consumers and spans from 2012. The data consists of 5 CSV files and was obtained from a reliable source.
* Customer Details: The table contains customer information.
* Customer preference: This table contains customer cuisine preferences.
* Restaurants: The dataset includes restaurant details
* Restaurant's Cuisine: The table contains cuisines offered by each restaurant.
* Customer Ratings: This dataset is the main table in the project. It includes information regarding customer ratings.

# Approach :
* Obtained the ratings data for restaurants from a publicly accessible source and imported it into a SQL database.
* Leveraged SQL to perform data cleaning tasks on the acquired data, ensuring it is in a structured format suitable for analysis. These tasks encompassed eliminating duplicate records, addressing missing values, and standardizing data formats.
* Utilized SQL to extract pertinent details from the dataset, including the average rating for each restaurant, the count of reviews, and the restaurant's location. This involved querying the data using SQL statements to retrieve the desired information for analysis and reporting purposes.
* Leveraged advanced SQL techniques to perform an in-depth analysis of the datasets, aiming to uncover patterns and trends within the data. This involved employing complex SQL queries, aggregations, and functions to gain insights into the data and identify significant patterns or trends that can inform decision-making and provide valuable insights.
* By employing SQL commands and functions, we thoroughly scrutinized a wide range of metrics.
* The insights derived from this analysis served as the foundation for generating valuable recommendations aimed at enhancing the performance of the restaurants. Furthermore, we identified opportunities where the data could be leveraged to drive informed business decisions, resulting in strategic advantages for the establishments involved.

# SQL Functions Used :
* DDL
* DML
* Joins
* Subqueries
* Multiple joins
* Case statements
* Logical conditions
* Nested subqueries
* Windows functions

-------
# Key Insights:-
## 1. Customer Demographics: [Click Here](https://github.com/AjinkyaAndraskar/Restaurant-Ratings-Analysis/blob/main/Customer_demographics.sql)
► 62% customers are from "San Luis Potosi".<br>
► 70% customers have medium budget & 0.4% customers have high budget.<br>
► Most of the drinkers & smokers are students and they are casual drinkers or social drinkers.<br>
► 80% of our customers are in the age bucket of 18-25.<br>
► Most preferred cuisines are Mexican, American, Pizzeria, Cafeteria & Coffee shop.

## 2. Restaurant Details: [Click Here](https://github.com/AjinkyaAndraskar/Restaurant-Ratings-Analysis/blob/main/Restaurant_Details.sql)
► There are a total 129 restaurants & majority are in the city of "San Luis Potosi".<br>
► Only 41 restaurants are serving drinks & 65 restaurants don't have parking.<br>
► Most restaurants offer cuisines like Mexican, Bar, Cafeteria, Fast Food, Brewery, Seafood, Burgers.<br>
► 18% of restaurants are of High budget, 49% of them are of Medium budget & 33% are low budget.

## 3. Ratings Analysis: [Click Here](https://github.com/AjinkyaAndraskar/Restaurant-Ratings-Analysis/blob/main/%F0%9D%97%A5%F0%9D%97%AE%F0%9D%98%81%F0%9D%97%B6%F0%9D%97%BB%F0%9D%97%B4%F0%9D%98%80%20%F0%9D%97%94%F0%9D%97%BB%F0%9D%97%AE%F0%9D%97%B9%F0%9D%98%86%F0%9D%98%80%F0%9D%97%B6%F0%9D%98%80.sql)
► There are 26 restaurants who received an average overall rating of more than 1.50.<br>
► 44% responses from the customers were positive for the food experience.<br>
► 22% responses from the customers were negative for overall experience.<br>
► 131 customers are visiting their local restaurants & 14 customers are visiting outside of their locality.<br>
► Customers from cities of Ciudad Victoria, Cuernavaca & jiutepec are visiting restaurants of San Luis Potosi.<br>
► I have analyzed the best restaurants for each cuisine based on average ratings.<br>
► I have analyzed bad restaurants for each cuisine based on average ratings.<br>
► For overall & food experience best average cuisine is International & for food experience it is Mexican.<br>
► There are 293 responses (25%) of customers who gave the highest ratings in all the experiences.

------
# Strategies:
⭐ I found that the average rating for food experience in our dataset was around 1.21/2.00. This indicates that overall, customers were pleased with their dining experiences. But some restaurants didn't receive good ratings for the service. So the restaurants should focus on improving their service experience.<br>
⭐ Most of the good restaurants are in the city of San Luis Potosi for which outsiders were travelling to this city. I can improve our food & services in other cities as well.<br>
⭐ American cuisine is the second most preferred cuisine by customers but I don't have that many restaurants with american cuisine. I can improve the business in that segment as well.<br>
⭐ Students & teenagers are more into drinking & smoking so I can plan some marketing strategy for them like special student entry or student discount to acquire customers.
