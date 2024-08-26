-- Query para ver outliers en tripduration
WITH quartiles AS (
  SELECT
    APPROX_QUANTILES(tripduration, 4)[OFFSET(1)] AS Q1, 
    APPROX_QUANTILES(tripduration, 4)[OFFSET(3)] AS Q3 
  FROM
    `nyc-citibikes-trips-jamr.citibikes_dataset.citi_bike_trips`
),
iqr_calculation AS (
  SELECT
    Q1,
    Q3,
    (Q3 - Q1) AS IQR, 
    Q1 - 1.5 * (Q3 - Q1) AS lower_bound, 
    Q3 + 1.5 * (Q3 - Q1) AS upper_bound 
  FROM
    quartiles
)
SELECT
  t.*,
  iqr.lower_bound,
  iqr.upper_bound
FROM
  `nyc-citibikes-trips-jamr.citibikes_dataset.citi_bike_trips` t
CROSS JOIN
  iqr_calculation iqr
WHERE
  t.tripduration < iqr.lower_bound 
  OR t.tripduration > iqr.upper_bound; 
