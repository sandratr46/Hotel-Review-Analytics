# Hotel Review Analytics: What Drives Customer Satisfaction?

## Business Task

Hotels receive large volumes of customer reviews but often lack a structured approach to understand what drives satisfaction.

This project aims to:

* Identify key factors influencing hotel ratings
* Evaluate performance across customer segments
* Detect gaps between expected and actual service quality

---

## Dataset Overview

The dataset consists of three relational tables:

* **hotels**: hotel attributes (location, base scores, star rating)
* **reviews**: customer ratings across multiple dimensions
* **users**: customer demographics (age group, traveller type)

### Size

* Hotels: 25 records
* Users: 2,000 records
* Reviews: 50,000 records
* Date range: 2020-01-01 to 2025-12-31

### Key Metrics

* `score_overall`
* `score_cleanliness`, `score_staff`, `score_facilities`, `score_location`,`score_comfort`,`score_value_for_money`
* `*_base` (expected hotel performance)

Source: https://www.kaggle.com/datasets/alperenmyung/international-hotel-booking-analytics

! Note: The dataset is synthetic. Insights are directional and not tied to real hotel operations.

---

## Tools Used

* SQL (MySQL Workbench)
* Power BI
* Excel

---

## Data Preparation

* Validated primary and foreign key relationships. For further modelling task and queries

* Performed duplicate checks across all tables (*no duplicates found*)
  <img width="800" height="436" alt="image" src="https://github.com/user-attachments/assets/5c3a9ce6-6e9c-4d8d-ab32-88db61b4d7e0" />


* Conducted NULL and data quality audits (*no NULL values detected*)
  <img width="596" height="922" alt="image" src="https://github.com/user-attachments/assets/6b0f876b-6ad5-4f63-a6e7-d6a3f3645807" />

* Standardized categorical variables for consistency

---

## Exploratory Data Analysis

### Rating Distribution

  <img width="391" height="256" alt="image" src="https://github.com/user-attachments/assets/ba5e5ff1-3864-45af-996b-4168b57f2c79" />

* Ratings are skewed toward higher values, with most reviews between 8–9
* Indicates generally positive customer experiences


### Review Trend (Monthly)

<img width="457" height="359" alt="image" src="https://github.com/user-attachments/assets/78791863-ee00-435c-a5f1-e1e684ebfed2" />

* Review volume peaks in June–July, suggesting strong seasonal demand

---

## Driver Analysis

### Correlation Analysis
  
<img width="1871" height="117" alt="image" src="https://github.com/user-attachments/assets/d5e5305e-2243-46e4-bf81-f4941a09b393" />

* Correlation analysis shows that cleanliness and comfort have the strongest relationships with overall ratings, indicating they are key factors associated with customer satisfaction.

* *Limitations*: correlation does not imply causation. While cleanliness is strongly associated with ratings, additional analysis is required to confirm its causal impact.
  
### Bucket Analysis

* To further explore these relationships, bucket analysis was conducted. The results show that ratings increase consistently across all drivers as scores improve.
    <img width="453" height="239" alt="image" src="https://github.com/user-attachments/assets/dcfb66ac-0054-44a6-ad4e-cda80e7d798e" />

* Among them, facilities and cleanliness exhibit the strongest marginal impact, with the steepest increase in ratings, while location shows minimal influence. This suggests that improving facilities and cleanliness offers the greatest potential to enhance customer satisfaction.

---

## Customer Segmentation

  ### Travel Type
  <img width="258" height="93" alt="image" src="https://github.com/user-attachments/assets/3adf4fa3-a5c1-447d-8495-0123a607b876" />

* Business travellers tend to give lower ratings compared to other groups, indicating higher expectations

* Family travellers tend to give higher ratings

### Age Group
  <img width="206" height="107" alt="image" src="https://github.com/user-attachments/assets/c6f4e743-7967-4b60-be70-93e0d792ea04" />

* Ratings are consistent across age groups, suggesting expectations do not vary significantly by age

* Users aged 25–44 generate the majority of reviews

---

## Geographic Analysis

* Hotel ratings vary across countries
  
  <img width="253" height="356" alt="image" src="https://github.com/user-attachments/assets/be4c2b1b-188e-4f1b-bdca-9f7b9a81676c" />

* Some regions consistently outperform others, suggesting differences in service standards

---

## Expectation vs Reality

* Actual customer ratings were compared with baseline expectations (`*_base`)
* Most hotels underperform expectations, with actual ratings generally lower than baseline scores
  
<img width="1270" height="446" alt="image" src="https://github.com/user-attachments/assets/fc0ead98-0fec-4d1c-a7dc-95cde76d3d68" />

---

## Data Visualization

The dashboard enables users to identify key satisfaction drivers, compare hotel performance, and detect underperforming service areas.


### Drivers Analysis Dashboard

* Driver relationships (cleanliness, value, comfort, facilities, staff, location)
* Customer segmentation
* Geographic performance
<img width="581" height="330" alt="image" src="https://github.com/user-attachments/assets/b49be441-2d12-484a-96d2-248ddae38ebb" />


### Performance Analysis Dashboard

* Interactive hotel-level view
* Displays ranking, average rating, review volume, and performance gaps
<img width="581" height="330" alt="image" src="https://github.com/user-attachments/assets/4204c62a-cdc6-45b7-a618-9f5209315598" />


---

## Key Insights

**After examining the data set by using EDA and Visualization, the following key insights are determined**

* Cleanliness and facilities show the strongest relationship with overall ratings,suggesting it is a key factor influencing customer satisfaction.
* Facilities demonstrate the largest performance gap and represent the primary area for improvement
* Review volume peaks during summer (June–July), indicating seasonal demand patterns
* Business travellers are the most critical segment, consistently giving lower ratings
* Users aged 25–44 generate the majority of reviews
* Most hotels underperform expectations compared to baseline scores
* Regional differences suggest inconsistent service standards

---

## Conclusion

This analysis demonstrates how structured data exploration can uncover actionable insights into customer satisfaction. By focusing on key drivers such as cleanliness and facilities, hotels can make targeted improvements to enhance overall guest experience.
