-- converts daily weather table to weekly weather table for fair analysis with PyTrends tables
CREATE VIEW weekly_weather AS
SELECT 
	DATE_SUB(date, INTERVAL MOD(WEEKDAY(date) + 1, 7) DAY) AS week_start,
    ROUND(AVG(temperature_2m_max), 1) AS average_temp_max,
    ROUND(AVG(temperature_2m_min), 1) AS average_temp_min,
    ROUND(AVG(temperature_2m_mean), 1) AS average_temp_mean,
    ROUND(SUM(rain_sum), 1) AS total_rain
FROM vancouver_weather_daily
GROUP BY week_start
ORDER BY week_start;

-- joins weekly_weather to trends_cold table based off of week
CREATE VIEW joined_cold AS
SELECT *
FROM weekly_weather AS w
INNER JOIN trends_cold AS tc
	ON w.week_start = tc.date;

-- joins weekly_weather to trends_rain table based off of week
CREATE VIEW joined_rain AS
SELECT *
FROM weekly_weather AS w
INNER JOIN trends_rain AS tr
	ON w.week_start = tr.date;

-- joins weekly_weather to trends_warm table based off of week
CREATE VIEW joined_warm AS
SELECT *
FROM weekly_weather AS w
INNER JOIN trends_warm AS tw
	ON w.week_start = tw.date;