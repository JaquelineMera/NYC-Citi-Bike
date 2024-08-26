--- Métricas de uso de un día promedio ---
-- Query métricas de la duracion de un viaje
SELECT
 AVG(tripduration_minutes) AS avg_tripduration,
 MAX(tripduration_minutes) AS max_tripduration,
 MIN(tripduration_minutes) AS min_tripduration,
 STDDEV(tripduration_minutes) AS stddev_tripduration,
FROM
 `nyc-citibikes-trips-jamr.citibikes_resultados.consolidado_citibikes`;
-- Query número de viajes que se realizan en promedio al día
SELECT
  AVG(daily_trips) AS promedio_viajes_por_dia
FROM (
  SELECT
    stop_date,
    COUNT(*) AS daily_trips
  FROM
    `nyc-citibikes-trips-jamr.citibikes_resultados.consolidado_citibikes`
  GROUP BY
    stop_date
);
--- Métricas históricas ---
-- Query total de viajes 
SELECT
  COUNT(*) AS total_viajes
FROM
  `nyc-citibikes-trips-jamr.citibikes_resultados.consolidado_citibikes`
;
-- Query total de viajes por año
SELECT
  EXTRACT(YEAR FROM stop_date) AS year,
  COUNT(*) AS total_viajes_por_year
FROM
  `nyc-citibikes-trips-jamr.citibikes_resultados.consolidado_citibikes`
GROUP BY
  year
ORDER BY
  year;
-- Query total de viajes por día 
  SELECT
    stop_date,
    COUNT(*) AS daily_trips
  FROM
    `nyc-citibikes-trips-jamr.citibikes_resultados.consolidado_citibikes`
  GROUP BY
    stop_date;
-- Query total de viajes por género
SELECT 
  gender,
  COUNT(*) AS total_viajes
FROM 
  `nyc-citibikes-trips-jamr.citibikes_resultados.consolidado_citibikes`
GROUP BY 
  gender;
-- Query total de viajes por edad
SELECT 
  CASE 
    WHEN age BETWEEN 20 AND 29 THEN '20-29'
    WHEN age BETWEEN 30 AND 39 THEN '30-39'
    WHEN age BETWEEN 40 AND 49 THEN '40-49'
    WHEN age BETWEEN 50 AND 59 THEN '50-59'
    WHEN age BETWEEN 60 AND 69 THEN '60-69'
    WHEN age BETWEEN 70 AND 79 THEN '70-79'
    WHEN age >= 80 THEN '80+'
  END AS age_range,
  COUNT(*) AS total_viajes
FROM 
  `nyc-citibikes-trips-jamr.citibikes_resultados.consolidado_citibikes`
GROUP BY 
  age_range
ORDER BY 
  age_range;
-- Query total de viajes por tipo de subscripción
SELECT 
  usertype,
  COUNT(*) AS total_viajes
FROM 
  `nyc-citibikes-trips-jamr.citibikes_resultados.consolidado_citibikes`
GROUP BY 
  usertype;
-- Query total de viajes por salida
SELECT 
  start_station_name,
  COUNT(*) AS total_viajes
FROM 
  `nyc-citibikes-trips-jamr.citibikes_resultados.consolidado_citibikes`
GROUP BY 
  start_station_name
ORDER BY total_viajes DESC;
-- Query total de viajes por destino
SELECT 
  end_station_name,
  COUNT(*) AS total_viajes
FROM 
  `nyc-citibikes-trips-jamr.citibikes_resultados.consolidado_citibikes`
GROUP BY 
  end_station_name
ORDER BY total_viajes DESC;
-- Query total de viajes por hora
SELECT
  EXTRACT(HOUR FROM TIME(stop_time)) AS hora,
  COUNT(*) AS numero_de_viajes
FROM
  `nyc-citibikes-trips-jamr.citibikes_resultados.consolidado_citibikes`
GROUP BY
  hora
ORDER BY
  hora;