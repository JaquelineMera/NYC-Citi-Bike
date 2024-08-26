-- Query limpieza de consolidado
WITH modified_data AS (
  SELECT
    ROUND(tripduration / 60.0) AS tripduration_minutes, 
    DATE(stoptime) AS stop_date, 
    TIME(stoptime) AS stop_time,
    start_station_id,
    start_station_name,
    start_station_latitude,
    start_station_longitude,
    end_station_id,
    end_station_name,
    end_station_latitude,
    end_station_longitude,
    bikeid,
    usertype,
    EXTRACT(YEAR FROM CURRENT_DATE()) - birth_year AS age, 
    birth_year,
    gender,
    customer_plan
  FROM
    `nyc-citibikes-trips-jamr.citibikes_dataset.citi_bike_trips`
  WHERE
    start_station_latitude != 0 
    AND start_station_latitude <= 41 
    AND birth_year > 1924
    AND tripduration <= 200000
)

SELECT
  tripduration_minutes,
  stop_date,
  EXTRACT(YEAR FROM stop_date) AS year,
  EXTRACT(MONTH FROM stop_date) AS month,
  EXTRACT(DAY FROM stop_date) AS day,
  stop_time,
  EXTRACT(HOUR FROM TIME(stop_time)) AS hour, 
  start_station_id,
  start_station_name,
  start_station_latitude,
  start_station_longitude,
  end_station_id,
  end_station_name,
  end_station_latitude,
  end_station_longitude,
  bikeid,
  usertype,
  CASE
    WHEN tripduration_minutes <= 30 AND usertype = 'Customer' THEN 'Cliente a tiempo'
    WHEN tripduration_minutes > 30 AND usertype = 'Customer' THEN 'Cliente con retraso'
    WHEN tripduration_minutes <= 45 AND usertype = 'Subscriber' THEN 'Suscriptor a tiempo'
    WHEN tripduration_minutes > 45 AND usertype = 'Subscriber' THEN 'Suscriptor con retraso'
    ELSE 'Otra categoría'
  END AS status_trip,
  age,
  birth_year,
  gender
FROM
  modified_data;
-- Cambios:
-- Convertir tripduration a minutos
-- Crear columna stop_date
-- Crear columna stop_time
-- Crear columnas de año, mes y dia
-- Crear columna status_trip
-- Quitar registros donde start_station_latitude es 0
-- Quitar registros donde start_station_latitude es mayor a 41
-- Quitar registros donde birth_year es mayor a 1924 personas menores a 100a
-- Quitar registros donde tripduration es mayor a 200000 segundos 
-- Se excluyeron 2 outliers de tripduration