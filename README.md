# NYC-citi-bike
Análisis de los viajes del servicio de bicicletas en la ciudad de Nueva York.

# 📊Temas 

- [Objetivo](#objetivo)
- [Equipo](#equipo)
- [Herramientas](#herramientas)
- [Lenguajes](#lenguajes)
- [Procesamiento y análisis](#procesamiento-y-análisis)
  - [Procesamiento de los datos](#procesamiento-de-los-datos)
  - [Análisis exploratorio](#análisis-exploratorio)
- [Resultados](#resultados)
- [Conclusiones](#conclusiones)
- [Recomendaciones](#recomendaciones)
- [Pasos a seguir](#pasos-a-seguir)
- [Enlaces](#enlaces)

## Objetivo

+ Realizar un análisis descriptivo de datos del sistema de bicicletas compartidas en Nueva York para resumir y comprender las características principales del uso de las bicicletas, con el fin de obtener una visión clara y precisa del comportamiento de los usuarios y sus viajes. Esto servirá como base para futuros análisis predictivos o inferenciales que permitan optimizar el servicio y mejorar la experiencia de los usuarios.

+ **Calcular Métricas de Uso Diario**:
  + Determinar el número promedio de viajes realizados en un día.
  + Calcular las estadísticas de duración de los viaje.

+ **Evaluar Métricas Históricas**: 
  + Calcular el total de viajes realizados en el programa de bicicletas compartidas.
  + Analizar el crecimiento del número de viajes diarios a lo largo del tiempo.
  + Desglosar el total de viajes según el género/edad/tipo de suscripción/hora de los usuarios.

+ **Generar Conclusiones y Recomendaciones**:
  + Identificar patrones a partir de los datos analizados.
  + Dar recomendaciones estratégicas basadas en los hallazgos.
  + Construir pasos a seguir de acuerdo al análisis. 

## Equipo
- [Jaqueline Mera](https://github.com/JaquelineMera)

## Herramientas
+ BigQuery 
+ Google Looker Studio
+ Google Colab

## Lenguajes
+ SQL
+ Python
## Procesamiento y análisis
El flujo de trabajo incluyó varias etapas, el procesamiento de los datos, el análisis exploratorio y la representación gráfica del análisis. 

## Procesamiento de los datos
El procesamiento de los datos, se llevó a cabo en BigQuery a partir de comandos SQL, se siguieron los siguientes pasos:
+ Identificar valores nulos a través COUNTIF e IS NULL.
+ Identificar duplicados a través de COUNT, GROUP BY, HAVING.
+ Manejar variables que no son útiles en el análisis.
+ Identificar datos discrepantes en variables numéricas outliers. 
+ Comprobar y modificar tipos de datos con SAFE_CAST y CAST.
+ Crear nuevas variables utilizando EXTRACT, YEAR, MONTH, DAY, DATE, TIME. 
+ Construir un consolidado limpio a partir tablas auxiliares utilizando WITH.

Nota: Se replicaron alguno de estos pasos en Google Colab

+ Decisiones tomadas para la limpieza:
  + Convertir tripduration a minutos.
  + Crear columna stop_date - Fecha en año, mes, día.
  + Crear columna stop_time - Hora en hh:mm.
  + Crear columna status_trip - Viajes a tiempo o con retrasos de suscriptores y clientes.
  + Quitar registros donde start_station_latitude es 0 - Registros sin ubicación. 
  + Quitar registros donde start_station_latitude es mayor a 41 - Registros fuera del rango de la ciudad de NYC, dos casos en Montreal.
  + Quitar registros donde birth_year es nulo y mayor a 1924 - Registros fuera de rango, outliers de edad, personas centenarias. 
  + Quitar registros donde tripduration es mayor a 200000 segundos - Registros fuera de rango de tiempo en viaje, dos casos con varios días de retraso. 

## Análisis exploratorio
+ Agrupar datos según variables categóricas (CASE WHEN).
+ Aplicar medidas de tendencia central y dispersión (MAX, MIN, AVG, STDDEV).
+ Visualizar las variables categóricas a través de gráficos.
  
## Resultados
+ **Alta Preferencia por Suscriptores**: La mayoría de los viajes son realizados por suscriptores (43,586), lo que indica una fuerte preferencia por el servicio entre los usuarios regulares. Esto también sugiere que los suscriptores representan la base más sólida y confiable de clientes.
+ **Diferencias en el Comportamiento entre Suscriptores y Clientes**: Los suscriptores tienen un viaje promedio más largo (25.4 minutos) en comparación con los clientes (12.8 minutos). Esto podría indicar que los suscriptores utilizan el servicio para viajes más largos o regulares, mientras que los clientes esporádicos pueden estar usando las bicicletas para trayectos más cortos o recreativos.
+ **Demografía y Uso**: El uso del servicio está dominado por hombres (33,940), aunque un número significativo de mujeres (10,253) también lo utiliza. El grupo de edad más activo es de 30-39 años (15,566), seguido por los de 40-49 años (12,255). Esto sugiere que el servicio es más popular entre adultos jóvenes y de mediana edad.
Distribución por Hora: Los picos de uso se producen entre las 08:00 y las 09:00, y entre las 17:00 y las 18:00, lo que coincide con los horarios de traslado al trabajo y de regreso a casa. Este patrón sugiere que muchos usuarios utilizan el servicio como parte de su rutina diaria de desplazamiento.
![Captura_Dashboard_citibike_01](https://github.com/user-attachments/assets/876d81e1-956b-4589-9765-45a87e9ea024)
![Captura_Dashboard_citibike_02](https://github.com/user-attachments/assets/c0648ccb-3082-4458-a162-8a1caf9ae24a)


## Conclusiones
+ **Alta Preferencia por Suscriptores**:La mayoría de los viajes son realizados por suscriptores (43,586), lo que indica una fuerte preferencia por el servicio entre los usuarios regulares. Esto también sugiere que los suscriptores representan la base más sólida y confiable de clientes.
+ **Diferencias en el Comportamiento entre Suscriptores y Clientes**:Los suscriptores tienen un viaje promedio más largo (25.4 minutos) en comparación con los clientes (12.8 minutos). Esto podría indicar que los suscriptores utilizan el servicio para viajes más largos o regulares, mientras que los clientes esporádicos pueden estar usando las bicicletas para trayectos más cortos o recreativos.
+ **Demografía y Uso**:El uso del servicio está dominado por hombres (33,940), aunque un número significativo de mujeres (10,253) también lo utiliza. El grupo de edad más activo es de 30-39 años (15,566), seguido por los de 40-49 años (12,255). Esto sugiere que el servicio es más popular entre adultos jóvenes y de mediana edad.
+ **Distribución por Hora**:Los picos de uso se producen entre las 08:00 y las 09:00, y entre las 17:00 y las 18:00, lo que coincide con los horarios de traslado al trabajo y de regreso a casa. Este patrón sugiere que muchos usuarios utilizan el servicio como parte de su rutina diaria de desplazamiento.

## Recomendaciones
+ **Optimizar la Distribución de Bicicletas**:
Dada la concentración de viajes en horas pico y la desigualdad entre las estaciones de inicio y fin, sería prudente revisar la logística de redistribución de bicicletas para asegurar la disponibilidad durante los momentos de mayor demanda.
+ **Fomentar la Equidad de Género**:
Considerar campañas dirigidas a aumentar el uso entre mujeres, ya que representan una minoría en la base de usuarios. Mejorar la seguridad y la conveniencia podría ser clave para atraer a más usuarias.
+ **Expandir o Diversificar la Oferta de Planes**:
Con la mayoría de los viajes realizados por suscriptores, podría ser útil explorar la diversificación de los planes de suscripción o incentivos para atraer a más clientes no suscriptores, especialmente en áreas turísticas o de alta rotación.
+ **Mejorar la Infraestructura de Estaciones**:
Considerar la expansión de estaciones en áreas donde la demanda de bicicletas es alta pero la disponibilidad de estaciones es baja. Esto ayudaría a balancear mejor la oferta y la demanda.
** Monitorear y Reducir Retrasos**:
Analizar las causas de los retrasos en los viajes y trabajar en soluciones para reducirlos, como la mejora en la disponibilidad de estaciones o ajustes en las rutas.

## Pasos a seguir
+ **Optimización de la Redistribución de Bicicletas mediante Análisis Espacial**: Utilizar análisis de densidad de puntos y mapas de calor para identificar las áreas con mayor concentración de viajes en horas pico. Esto permitirá optimizar la redistribución de bicicletas, asegurando una disponibilidad adecuada en las estaciones con mayor demanda y reduciendo el tiempo de espera para los usuarios.
+ **Identificación de Zonas de Expansión para Nuevas Estaciones**: Realizar un análisis de accesibilidad y proximidad para identificar zonas geográficas con alta demanda de viajes pero baja densidad de estaciones de bicicletas. Estas áreas serían candidatas ideales para la expansión del servicio, lo que podría aumentar la cobertura y mejorar la satisfacción del usuario.
+ **Monitoreo y Mejora de Rutas Populares**: Analizar las rutas más frecuentemente utilizadas entre estaciones de inicio y fin mediante trayectorias espaciales. Identificar posibles cuellos de botella o zonas de congestión y trabajar en colaboración con las autoridades de la ciudad para mejorar la infraestructura ciclista en estas rutas, facilitando un flujo más eficiente de bicicletas y mejorando la seguridad del usuario.

## Enlaces
### [Dashboard](https://lookerstudio.google.com/reporting/1ac381ea-6266-4d71-b358-ff3baf2f26b5)
