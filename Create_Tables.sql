This SQL queries creates the important tables & imports the CSV files.
*/

--- 1) Creating customer_ratings Table 

CREATE TABLE Customer_Ratings (
  Consumer_ID VARCHAR(50),
  Restaurant_ID VARCHAR(50),
  Overall_Rating INT,
  Food_Rating INT,
  Service_Rating INT
);

BULK INSERT Customer_Ratings
FROM 'C:\Users\yasha\OneDrive\Desktop\ajinkya\SQL Projects\Restaurant-Ratings-Analysis\ratings.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2);

--- 2) Creating customer_details table

CREATE TABLE Customer_Details (
  Consumer_ID VARCHAR(50),
  City VARCHAR(50),
  State VARCHAR(50),
  Country VARCHAR(50),
  Latitude DECIMAL(10, 6),
  Longitude DECIMAL(10, 6),
  Smoker VARCHAR(50),
  Drink_Level VARCHAR(50),
  Transportation_Method VARCHAR(50),
  Marital_Status VARCHAR(50),
  Children VARCHAR(50),
  Age INT,
  Occupation VARCHAR(50),
  Budget VARCHAR(50)
);

BULK INSERT Customer_Details
FROM 'C:\Users\yasha\OneDrive\Desktop\ajinkya\SQL Projects\Restaurant-Ratings-Analysis\consumers.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2);

--- 3) Creating Customer Preference table

CREATE TABLE Customer_Preference (
  Consumer_ID VARCHAR(50),
  Preferred_Cuisine VARCHAR(50)
);

BULK INSERT Customer_Preference
FROM 'C:\Users\yasha\OneDrive\Desktop\ajinkya\SQL Projects\Restaurant-Ratings-Analysis\consumer_preferences.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2);

--- 4) Creating restaurants table
CREATE TABLE Restaurants (
  Restaurant_ID VARCHAR(50),
  Name VARCHAR(100),
  City VARCHAR(50),
  State VARCHAR(50),
  Country VARCHAR(50),
  Zip_Code VARCHAR(50),
  Latitude DECIMAL(10, 6),
  Longitude DECIMAL(10, 6),
  Alcohol_Service VARCHAR(50),
  Smoking_Allowed VARCHAR(50),
  Price VARCHAR(50),
  Franchise VARCHAR(50),
  Area VARCHAR(50),
  Parking VARCHAR(100)
);

BULK INSERT Restaurants
FROM 'C:\Users\yasha\OneDrive\Desktop\ajinkya\SQL Projects\Restaurant-Ratings-Analysis\restaurants.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2);

--- Creating restaurant_cuisines Table 

CREATE TABLE restaurant_cuisines (
  Restaurant_ID VARCHAR(50),
  Cuisine VARCHAR(50)
);

BULK INSERT restaurant_cuisines
FROM 'C:\Users\yasha\OneDrive\Desktop\ajinkya\SQL Projects\Restaurant-Ratings-Analysis\restaurant_cuisines.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2);
