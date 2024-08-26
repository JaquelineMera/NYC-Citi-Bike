-- Query nulos
-- birth year = 4,639
-- customer_plan = 50,000 columna vacia
SELECT
  COUNTIF(tripduration IS NULL) AS tripduration_nulls,
  COUNTIF(stoptime IS NULL) AS stoptime_nulls,
  COUNTIF(start_station_id IS NULL) AS start_station_id_nulls,
  COUNTIF(start_station_name IS NULL) AS start_station_name_nulls,
  COUNTIF(start_station_latitude IS NULL) AS start_station_latitude_nulls,
  COUNTIF(start_station_longitude IS NULL) AS start_station_longitude_nulls,
  COUNTIF(end_station_id IS NULL) AS end_station_id_nulls,
  COUNTIF(end_station_name IS NULL) AS end_station_name_nulls,
  COUNTIF(end_station_latitude IS NULL) AS end_station_latitude_nulls,
  COUNTIF(end_station_longitude IS NULL) AS end_station_longitude_nulls,
  COUNTIF(bikeid IS NULL) AS bikeid_nulls,
  COUNTIF(usertype IS NULL) AS usertype_nulls,
  COUNTIF(birth_year IS NULL) AS birth_year_nulls,
  COUNTIF(gender IS NULL) AS gender_nulls,
  COUNTIF(customer_plan IS NULL) AS customer_plan_nulls
FROM `nyc-citibikes-trips-jamr.citibikes_dataset.citi_bike_trips`;

-- Query duplicados 
-- No se encontraron duplicados
SELECT
  bikeid,
  COUNT(*) AS duplicate_count
FROM `nyc-citibikes-trips-jamr.citibikes_dataset.citi_bike_trips`
GROUP BY
  bikeid
HAVING COUNT(*) > 1;

-- Query rangos tripduration
-- 54566.0 min como Máximo, equivale a 37.8 dias, revisar outliers 
SELECT
  MAX(ROUND(tripduration / 60)) AS min, 
  MIN(ROUND(tripduration / 60)) AS max,
FROM
  `nyc-citibikes-trips-jamr.citibikes_dataset.citi_bike_trips`;

-- Query para obtener viajes fuera del rango de 30 y 45 minutos
-- 3,936 > 30 min
-- 978 > 45 min 
SELECT
  *
FROM
  `nyc-citibikes-trips-jamr.citibikes_dataset.citi_bike_trips`
WHERE
  (ROUND(tripduration / 60)) >= 45;

-- Query rangos birth_year
-- 2002 a 1885 
SELECT
  MAX(birth_year) AS min, 
  MIN(birth_year) AS max,
FROM
  `nyc-citibikes-trips-jamr.citibikes_dataset.citi_bike_trips`;

-- Query para obtener personas centenarias 
-- 32 personas
SELECT
  *
FROM
  `nyc-citibikes-trips-jamr.citibikes_dataset.citi_bike_trips`
WHERE
  birth_year < 1924;

-- Query rangos start_station_latitude
-- 45.5 max, 40.7 avg, 0 min, revisar datos inconsistentes 
SELECT
  MAX(start_station_latitude) AS min, 
  AVG(start_station_latitude) AS avg,
  MIN(start_station_latitude) AS max,
FROM
  `nyc-citibikes-trips-jamr.citibikes_dataset.citi_bike_trips`;

-- Query para revisar inconsistencias en latitud y longitud 
-- 3 casos, 2 estan en Montreal y 1 no tiene coordenadas 
SELECT
  *
FROM
  `nyc-citibikes-trips-jamr.citibikes_dataset.citi_bike_trips`
WHERE
  start_station_latitude = 0
  OR start_station_latitude > 41;
