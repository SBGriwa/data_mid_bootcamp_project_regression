-- Create a database called house_price_regression--
CREATE DATABASE IF NOT EXISTS  house_price_regression;

-- Create a table `house_price_data`
USE house_price_regression;

DROP TABLE IF EXISTS house_price_data;

CREATE TABLE house_price_data (
  `Id` int UNIQUE NOT NULL, 
  `Date` char(20) DEFAULT NULL,
  `Bedrooms` int  DEFAULT NULL, 
  `Bathrooms` float DEFAULT NULL,
  `Sqft Living` float DEFAULT NULL,
  `Sqft Lot` float DEFAULT NULL,
  `Floors` float DEFAULT NULL,
  `Waterfront` int DEFAULT NULL,
  `View` int DEFAULT NULL,
  `Condition` int DEFAULT NULL,
  `Grade` int DEFAULT NULL,
  `Sqft Above` float DEFAULT NULL,
  `Sqft Basement` float DEFAULT NULL,
  `yr_built` year DEFAULT NULL,
  `Yr Renovated` year DEFAULT NULL,
  `Zipcode` int DEFAULT NULL,
  `Lat` float DEFAULT NULL,
  `Long` float DEFAULT NULL,
  `Sqft Living15` float DEFAULT NULL,
  `Sqft Lot15` float DEFAULT NULL,
  `Price` int DEFAULT NULL,
  CONSTRAINT PRIMARY KEY (Id)
);


-- Import the data from the csv file into the table.

-- Select all the data from table `house_price_data`
select * from house_price_data;

-- Use the alter table command to drop the column `date`
ALTER TABLE house_price_data
DROP COLUMN date;

select * from house_price_data
limit 10;

-- Use sql query to find how many rows of data you have.

SELECT COUNT(*) FROM house_price_data;

-- Now we will try to find the unique values in some of the categorical columns
SELECT  count(DISTINCT(Bedrooms)) FROM house_price_data;

SELECT  count(DISTINCT(Floors)) FROM house_price_data;
SELECT  count(DISTINCT(Bathrooms)) FROM house_price_data;
SELECT  count(DISTINCT(house_price_regression.house_price_data.condition_)) FROM house_price_data;
SELECT  count(DISTINCT(Grade)) FROM house_price_data;

-- Arrange the data in a decreasing order by the price of the house.
SELECT * FROM house_price_data
ORDER BY price DESC limit 10;


-- Return only the IDs of the top 10 most expensive houses in your data.
SELECT Id FROM house_price_data
ORDER BY price DESC limit 10;


-- What is the average price of all the properties in your data?
SELECT AVG(Price) AS AveragePrice FROM house_price_data;

-- In this exercise we will use simple group by to check the properties of some of the categorical variables
SELECT bedrooms, AVG(price) AS avgprice
FROM house_price_data
GROUP BY bedrooms;

SELECT bedrooms, AVG(sqft_living) AS Avg_sqft_living
FROM house_price_data
GROUP BY bedrooms;

SELECT waterfront, AVG(price) AS avgprice_waterfront
FROM house_price_data
GROUP BY waterfront;

SELECT  condition_, AVG(grade)
FROM house_price_data
GROUP BY condition_;

SELECT   grade, AVG(condition_) AS AVG FROM house_price_data
GROUP BY grade;


-- One of the customers is only interested in the following houses :
   -- Number of bedrooms either 3 or 4
   --  Bathrooms more than 3
   --  One Floor
   --  No waterfront
   --  Condition should be 3 at least
   --  Grade should be 5 at least
   --  Price less than 300000

SELECT bedrooms, bathrooms, floors, waterfront, condition_, grade, price FROM house_price_data
 WHERE (bedrooms = 3 or bedrooms = 4)
		and bathrooms >= 3.00
        and floors = 1
        and waterfront = 0
        and condition_ >= 3
        and grade >= 5
        and price < 300000;


-- find out the list of properties whose prices are twice more than the average of all the properties

SELECT * FROM house_price_data
WHERE price >= (SELECT AVG(price) AS AVG FROM house_price_data) *2;


-- 13 -- Since this is something that the senior management is regularly interested in, create a view of the same query.

CREATE VIEW Senior_management_view as
SELECT * FROM house_price_data
WHERE price >= (SELECT AVG(price) AS AVG FROM house_price_data) *2;


-- 14 -- What is the difference in average prices of the properties with three and four bedrooms?


-- What are the different locations where properties are available in your database? (distinct zip codes)
SELECT  count(DISTINCT(Zipcode)) FROM house_price_data;
SELECT  DISTINCT(Zipcode) FROM house_price_data;

-- Show the list of all the properties that were renovated.
SELECT* FROM house_price_data
WHERE yr_renovated != 0;

SELECT  count(DISTINCT(yr_renovated)) FROM house_price_data
WHERE yr_renovated != 0;

-- Provide the details of the property that is the 11th most expensive property in your database.
SELECT * FROM house_price_data
ORDER BY price DESC
LIMIT 10,1;




