-- Data Validation

-- make sure correct amount of rows and dates were imported from .csv

SELECT COUNT(*), MIN(date), MAX(date) FROM vancouver_weather_daily;

SELECT COUNT(*), MIN(date), MAX(date) FROM trends_rain;

SELECT COUNT(*), MIN(date), MAX(date) FROM trends_cold;

SELECT COUNT(*), MIN(date), MAX(date) FROM trends_warm;

-- make sure dates from vancouver_weather_daily align with trends tables (2025-01-02 to 2025-12-28) to limit skewing of analysis

SELECT date, length(date) FROM vancouver_weather_daily;

-- removed the whitespace from the date column in vancouver_weather

UPDATE vancouver_weather_daily
SET date = TRIM(date);

DELETE FROM vancouver_weather_daily
WHERE date < '2022-01-02';

DELETE FROM vancouver_weather_daily
WHERE date > '2025-12-28';

DELETE FROM trends_rain
WHERE date < '2022-01-01';

DELETE FROM trends_cold
WHERE date < '2022-01-01';

DELETE FROM trends_warm
WHERE date < '2022-01-01';

-- check for null values

SELECT * FROM vancouver_weather_daily
WHERE date IS NULL
   OR temperature_2m_max IS NULL
   OR temperature_2m_mean IS NULL
   OR temperature_2m_min IS NULL
   OR rain_sum IS NULL;
   
SELECT * FROM trends_cold
WHERE DATE IS NULL
	OR insulated_jacket IS NULL
    OR base_layer IS NULL
    OR winter_gloves IS NULL
    OR wool_socks IS NULL
    OR beanie IS NULL;
    
SELECT * FROM trends_rain
WHERE DATE IS NULL
	OR rain_jacket IS NULL
    OR waterproof_boots IS NULL
    OR rain_pants IS NULL
    OR umbrella IS NULL
    OR rubber_boots IS NULL;
    
SELECT * FROM trends_warm
WHERE DATE IS NULL
	OR hiking_boots IS NULL
    OR sandals IS NULL
    OR light_jacket IS NULL
    OR sun_hat IS NULL
    OR shorts IS NULL;
    
-- checking where (min <= mean AND mean <= max) is FALSE for vancouver_weather_daily

SELECT * FROM vancouver_weather_daily
WHERE NOT(temperature_2m_min <= temperature_2m_mean AND temperature_2m_mean <= temperature_2m_max);