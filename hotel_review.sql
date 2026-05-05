
-- TABLE CREATION (assign PK,FK constraint)
CREATE TABLE hotels (
    hotel_id INT PRIMARY KEY,
    hotel_name VARCHAR(100),
    city VARCHAR(100),
    country VARCHAR(100),
    star_rating DECIMAL(3,2),
    lat DECIMAL(10,6),
    lon DECIMAL(10,6),
    cleanliness_base DECIMAL(3,2),
    comfort_base DECIMAL(3,2),
    facilities_base DECIMAL(3,2),
    location_base DECIMAL(3,2),
    staff_base DECIMAL(3,2),
    value_for_money_base DECIMAL(3,2)
);

ALTER TABLE users
ADD CONSTRAINT users_userid_pk PRIMARY KEY(user_ID);

        
ALTER TABLE reviews
ADD CONSTRAINT review_reviewid_pk PRIMARY KEY (review_id),
ADD CONSTRAINT review_user_fk 
    FOREIGN KEY (user_id) REFERENCES users(user_id),
ADD CONSTRAINT review_hotel_fk 
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id);
    
-- Check total rows
SELECT 'reviews' AS table_name, COUNT(*) FROM reviews
UNION ALL
SELECT 'users', COUNT(*) FROM users
UNION ALL
SELECT 'hotels', COUNT(*) FROM hotels;

	
-- DATA CLEANING

-- Duplicate check
SELECT hotel_id, COUNT(*)
FROM hotels
GROUP BY hotel_id
HAVING COUNT(*) > 1;

SELECT user_id, COUNT(*)
FROM users
GROUP BY user_id
HAVING COUNT(*) > 1;

SELECT review_id, COUNT(*)
FROM reviews
GROUP BY review_id
HAVING COUNT(*) > 1;

-- 2.Null Check

##Reviews table
SELECT 
    COUNT(*) AS total_rows,
    SUM(score_overall IS NULL) AS null_overall,
    SUM(score_cleanliness IS NULL) AS null_cleanliness,
    SUM(score_comfort IS NULL) AS null_comfort,
    SUM(score_facilities IS NULL) AS null_facilities,
    SUM(score_location IS NULL) AS null_location,
    SUM(score_staff IS NULL) AS null_staff,
    SUM(score_value_for_money IS NULL) AS null_value,
    SUM(review_text IS NULL) AS null_review_text
FROM reviews;

##Users table
SELECT 
    COUNT(*) AS total_rows,
    SUM(user_gender IS NULL) AS null_gender,
    SUM(country IS NULL) AS null_country,
    SUM(age_group IS NULL) AS null_age,
    SUM(traveller_type IS NULL) AS null_traveller,
    SUM(join_date IS NULL) AS null_join_date
FROM users;

##Hotels table
SELECT 
    COUNT(*) AS total_rows,
    SUM(hotel_name IS NULL) AS null_name,
    SUM(city IS NULL) AS null_city,
    SUM(country IS NULL) AS null_country,
    SUM(star_rating IS NULL) AS null_star,
    SUM(lat IS NULL) AS null_lat,
    SUM(lon IS NULL) AS null_lon
FROM hotels;

-- NUMERIC STATS
## Central tendency
SELECT 
	ROUND(AVG(score_overall),4),
    MIN(score_overall),
    MAX(score_overall),
    ROUND(STDDEV(score_overall),4)
FROM reviews;

##Frequency Distribution of Rating
SELECT 
	score_overall,
    COUNT(*) 
FROM reviews
GROUP BY score_overall
ORDER by score_overall DESC;

##How does amount of review distribute through out the year (monthly)
SELECT 
    DATE_FORMAT (review_date,'%Y-%m') AS `year_month`,
    COUNT(*) AS total_reviews
FROM reviews
GROUP BY `year_month`
ORDER BY `year_month`;

-- RELATIONSHIP & CORRELATION

##Drivers of rating , Correlation
SELECT  
	(AVG(score_cleanliness * score_overall) - AVG(score_cleanliness) * AVG(score_overall)) 
	/ (STDDEV(score_cleanliness) * STDDEV(score_overall)) AS corr_cleanliness,
	(AVG(score_comfort * score_overall) - AVG(score_comfort) * AVG(score_overall)) 
    / (STDDEV(score_comfort) * STDDEV(score_overall)) AS corr_comfort,
	(AVG(score_facilities * score_overall) - AVG(score_facilities) * AVG(score_overall)) 
    / (STDDEV(score_facilities) * STDDEV(score_overall)) AS corr_facilities,
	(AVG(score_location * score_overall) - AVG(score_location) * AVG(score_overall)) 
    / (STDDEV(score_location) * STDDEV(score_overall)) AS corr_location,
	(AVG(score_staff * score_overall) - AVG(score_staff) * AVG(score_overall)) 
    / (STDDEV(score_staff) * STDDEV(score_overall)) AS corr_staff,
    (AVG(score_value_for_money * score_overall) - AVG(score_value_for_money) * AVG(score_overall)) 
	/ (STDDEV(score_value_for_money) * STDDEV(score_overall)) AS corr_value
FROM reviews;

##Group Analysis(bucket)

SELECT 
    ROUND(score_cleanliness, 0) AS cleanliness_bucket,
    ROUND(AVG(score_overall), 2) AS avg_rating,
    COUNT(*) AS total_reviews
FROM reviews
GROUP BY cleanliness_bucket
ORDER BY cleanliness_bucket;

SELECT 
    ROUND(score_comfort, 0) AS comfort_bucket,
    ROUND(AVG(score_overall), 2) AS avg_rating,
    COUNT(*) AS total_reviews
FROM reviews
GROUP BY comfort_bucket
ORDER BY comfort_bucket;

SELECT 
    ROUND(score_facilities, 0) AS facilities_bucket,
    ROUND(AVG(score_overall), 2) AS avg_rating,
    COUNT(*) AS total_reviews
FROM reviews
GROUP BY facilities_bucket
ORDER BY facilities_bucket;

SELECT 
    ROUND(score_location, 0) AS location_bucket,
    ROUND(AVG(score_overall), 2) AS avg_rating,
    COUNT(*) AS total_reviews
FROM reviews
GROUP BY location_bucket
ORDER BY location_bucket;

SELECT 
    ROUND(score_staff, 0) AS staff_bucket,
    ROUND(AVG(score_overall), 2) AS avg_rating,
    COUNT(*) AS total_reviews
FROM reviews
GROUP BY staff_bucket
ORDER BY staff_bucket;

-- CUSTOMER SEGMENTATION DISTRIBUTION
##Travaller_type 
SELECT
	u.traveller_type,
    ROUND(AVG(r.score_overall),2) AS avg_rating,
    COUNT(*) AS total_reviews
FROM reviews r
JOIN users u
ON r.user_id = u.user_id
GROUP BY u.traveller_type
ORDER BY avg_rating DESC;

##Age group
SELECT 
    u.age_group,
    ROUND(AVG(r.score_overall),2) AS avg_rating,
    COUNT(*) AS total_reviews
FROM reviews r
JOIN users u ON r.user_id = u.user_id
GROUP BY u.age_group;

-- GEOGRAPHIC ANALYSIS
SELECT 
    h.country,
    ROUND(AVG(r.score_overall),2) AS avg_rating,
    COUNT(*) AS total_reviews
FROM reviews r
JOIN hotels h 
ON r.hotel_id = h.hotel_id
GROUP BY h.country
ORDER BY avg_rating DESC;

-- HOTEL PERFORMANCE
## Hotel ranking - top 10
SELECT 
    h.hotel_name,
    ROUND(AVG(r.score_overall),2) AS avg_rating,
    COUNT(*) AS reviews
FROM reviews r
JOIN hotels h ON r.hotel_id = h.hotel_id
GROUP BY h.hotel_name
ORDER BY avg_rating DESC
LIMIT 10;

## Rating expectation vs reality
SELECT 
    h.hotel_name,
    COUNT(*) AS total_reviews,

    ROUND(AVG(r.score_cleanliness), 2) AS actual_cleanliness,
    h.cleanliness_base,
    ROUND(AVG(r.score_cleanliness) - h.cleanliness_base, 2) AS gap_cleanliness,

    ROUND(AVG(r.score_comfort), 2) AS actual_comfort,
    h.comfort_base,
    ROUND(AVG(r.score_comfort) - h.comfort_base, 2) AS gap_comfort,

    ROUND(AVG(r.score_facilities), 2) AS actual_facilities,
    h.facilities_base,
    ROUND(AVG(r.score_facilities) - h.facilities_base, 2) AS gap_facilities,

    ROUND(AVG(r.score_location), 2) AS actual_location,
    h.location_base,
    ROUND(AVG(r.score_location) - h.location_base, 2) AS gap_location,

    ROUND(AVG(r.score_staff), 2) AS actual_staff,
    h.staff_base,
    ROUND(AVG(r.score_staff) - h.staff_base, 2) AS gap_staff,

	ROUND(AVG(r.score_value_for_money), 2) AS actual_staff,
    h.value_for_money_base,
    ROUND(AVG(r.score_value_for_money) - h.value_for_money_base, 2) AS gap_value
    
FROM reviews r
JOIN hotels h ON r.hotel_id = h.hotel_id
GROUP BY 
    h.hotel_name,
    h.cleanliness_base,
    h.comfort_base,
    h.facilities_base,
    h.location_base,
    h.staff_base,
    h.value_for_money_base;
    
-- Separate different driver metrics for base score and actual score for POWERBI visualization    
SELECT 
    r.hotel_id,
    'Cleanliness' AS metric,
    r.score_cleanliness AS actual_value,
    h.cleanliness_base AS base_value
FROM reviews r
JOIN hotels h ON r.hotel_id = h.hotel_id

UNION ALL

SELECT 
    r.hotel_id,
    'Comfort',
    r.score_comfort,
    h.comfort_base
FROM reviews r
JOIN hotels h ON r.hotel_id = h.hotel_id

UNION ALL

SELECT 
    r.hotel_id,
    'Facilities',
    r.score_facilities,
    h.facilities_base
FROM reviews r
JOIN hotels h ON r.hotel_id = h.hotel_id

UNION ALL

SELECT 
    r.hotel_id,
    'Location',
    r.score_location,
    h.location_base
FROM reviews r
JOIN hotels h ON r.hotel_id = h.hotel_id

UNION ALL

SELECT 
    r.hotel_id,
    'Staff',
    r.score_staff,
    h.staff_base
FROM reviews r
JOIN hotels h ON r.hotel_id = h.hotel_id

UNION ALL

SELECT 
    r.hotel_id,
    'Value for Money',
    r.score_value_for_money,
    h.value_for_money_base
FROM reviews r
JOIN hotels h ON r.hotel_id = h.hotel_id;
    
    
    
    

