/*# Question 4.a.i - What is the total number of trip for each month */
SELECT YEAR(pickup_datetime) year,
       MONTH(pickup_datetime) month,
       COUNT (1) number_of_trips
FROM nyc_view
GROUP BY YEAR(pickup_datetime), MONTH(pickup_datetime)
ORDER BY 1,2

/* # Question 4.a.ii - Which weekday had the most trip */
WITH trip_rank AS(
SELECT *,
        RANK() OVER(PARTITION BY year,month ORDER BY number_of_trips DESC) rank
FROM (
        SELECT 
            YEAR(pickup_datetime) year, 
            MONTH(pickup_datetime) month,
            week_day_abb weekday,
            Count(*)  number_of_trips

        FROM nyc_view
        GROUP BY YEAR(pickup_datetime), MONTH(pickup_datetime), week_day_abb      
        ORDER BY 1,2,3
)
)
SELECT * FROM trip_rank
WHERE rank = 7
ORDER BY year,month

/* # Question 4.a.iii Which hour of the day had the most trip */
WITH trip_rank AS(
SELECT *,
        RANK() OVER(PARTITION BY year,month ORDER BY total_number_of_trips DESC) rank
FROM (
        SELECT 
            YEAR(pickup_datetime) year, 
            MONTH(pickup_datetime) month,
            Hour(pickup_datetime) hour,
            Count(*) total_number_of_trips

        FROM nyc_view
        GROUP BY YEAR(pickup_datetime), MONTH(pickup_datetime), hour(pickup_datetime)  
        ORDER BY 1,2,3
)
)
SELECT * FROM trip_rank
WHERE rank = 1
ORDER BY year,month


/*
# Question 4.a.iv What was the average number of passenger? 
### Avg passenger = total Passenger / total number of Trip */
SELECT 
    YEAR(pickup_datetime) year, 
    MONTH(pickup_datetime) month,
    SUM(passenger_count) total_passenger_count,
    COUNT(*) total_trip_count,
    FLOOR((SUM(passenger_count)/COUNT(*))) avg_passenger_count
FROM nyc_view
GROUP BY YEAR(pickup_datetime), MONTH(pickup_datetime)
ORDER By 1,2

/* 
# Question 4.a.v What was the average amount paid per trip? */
SELECT 
    YEAR(pickup_datetime) year, 
    MONTH(pickup_datetime) month,
    ROUND((SUM(total_amount)/COUNT(*)), 2) avg_amount_per_trip
FROM nyc_view
GROUP BY YEAR(pickup_datetime), MONTH(pickup_datetime)
ORDER BY 1,2


/*
# Question 4.a.vi What was the average amount paid per passenger? */
SELECT 
    YEAR(pickup_datetime) year, 
    MONTH(pickup_datetime) month,
    ROUND((SUM(total_amount)/SUM(passenger_count)),2) avg_amount_paid_by_passenger
FROM nyc_view
GROUP BY YEAR(pickup_datetime), MONTH(pickup_datetime)
ORDER BY 1,2



/* Question 4.b.i For Each Taxi Color 
## What was the average, median, mini and max trip_duration in seconds */
SELECT 
    taxi_campany,
    MIN(trip_duration_sec) min_trip_duration_sec,
    MAX(trip_duration_sec) max_trip_duration_sec,
    APPROX_PERCENTILE(trip_duration_sec, 0.5) median_trip_duration_sec
FROM nyc_view
GROUP BY taxi_campany

/*
#### Q-4.b.ii For Each Taxi Color What was the average, median, mini and max trip distance in Km */
SELECT 
    taxi_campany,
    ROUND((MIN(trip_distance)/0.621371),2) min_trip_dist_km,
    ROUND((MAX(trip_distance)/0.621371),2) max_trip_dist_km,
    ROUND((APPROX_PERCENTILE(trip_distance, 0.5)),2) median_trip_dist_km
FROM nyc_view
GROUP BY taxi_campany

/* 
# #### Q-4.b.iii For Each Taxi Color What was the average, median, mini and max speed in Km per hour */
SELECT 
    taxi_campany,
    MIN(speed_km_hr) min_speed_km_hr,
    MAX(speed_km_hr) max_speed_km_hr,
    APPROX_PERCENTILE(speed_km_hr, 0.5) median_speed_km_hr
FROM nyc_view
GROUP BY taxi_campany

/* #### Q-4.c What was the percentage of trips where the driver received tips? */
SET tipped_trip_count = (SELECT COUNT(*) tipped_trip_count
FROM nyc_view
WHERE tip_amount > 0)                           

SELECT ROUND((${tipped_trip_count}/COUNT(*)) * 100, 2) trip_percent_with_tips
FROM nyc_view


/* #### Q-4.d What was the percentage of trips where the driver received tips >= 10$ ? */
SET high_tip_trip_count = (SELECT COUNT(*) high_tip_trip_count
FROM nyc_view
WHERE tip_amount >= 10)                           

SELECT ROUND((${high_tip_trip_count}/COUNT(*)) * 100, 2) trip_percent_with_morethan_10dollars_tips
FROM nyc_view

/* ### Q.4.e.i For each bin of trip duration - what is the average speed (Km per hour) - speed_km_hr */

SELECT	trip_duration_range_mins,
		ROUND(SUM(speed_km_hr)/ COUNT(*),2) average_speed_km_per_hr
FROM nyc_view
GROUP BY trip_duration_range_mins

/* ### Q.4.e.ii For each bin of trip duration - what is the average distance (dist per dollar) */

SELECT trip_duration_range_mins,
       SUM(trip_distance)/0.621371 total_distance,
       SUM(total_amount) sum_fare_amount,
       ROUND(((SUM(trip_distance)/0.621371) /  SUM(total_amount)), 2) avg_dist_km_per_dollar
       
FROM nyc_view
GROUP BY trip_duration_range_mins       
