SELECT *, ABS(correlation) AS correlation_strength
FROM demand_summary
ORDER BY correlation_strength DESC;

-- add correlation_strength column to demand_summary table
ALTER TABLE demand_summary ADD COLUMN correlation_strength DECIMAL(4,2);

-- updates correlation_strength column with ABS (absolute value) of correlation
-- so negative (temperature-driven) and positive (rain-driven) relationships can be compared fairly by strength
UPDATE demand_summary
SET correlation_strength = ABS(correlation);

SELECT *
FROM demand_summary;