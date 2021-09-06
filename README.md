# Prueba_gluky_DE

Explicación de la solución para la prueba de Data Engineer Gluky

Punto 1. Se utilizo la API de twitter para recolectar diariamente (0-100) tweets de un tema aleatorio y se tomaron los autores de estos tweets como los usuarios simulados solicitados por el ejercicio, seguido de esto convierte esta información no estructurada en una tabla que es cargada desde python a un bucket en GCP. Después desde python se hace la creación de la tabla externa conectada a los activos csv del bucket (API GCS) y se crea una vista con los usuarios únicos a partir de la última fecha de actualización para evitar usuarios duplicados (API BigQuery).

Punto 2. Se hace una conexión directa entre BigQuery Data Studio para la construcción de un reporte gerencial que se actualiza automaticamente con los cambios en la fuente, se toma el dataset público de ventas de licor en IOWA. Este reporte permite adaptarse a las necesidades del usuario por medio de filtros y también permite descargar los datos subyacentes en Excel o el reporte en PDF.

LINK: https://datastudio.google.com/s/rSnkQReV8HI

3. En python para simular el reporsitorio de puntos, se toman los usuarios únicos almacenados en la vista de BQ (API BQ) y se realizar un proceso aleatorio donde se generan 700 transacciones, de asignaciones y redenciones de puntos. Estos son exportados a una tabla en MySQL. Después desde python se extrae la información de los puntos y la información de los usuarios de BQ para hacer la integración de la información y procesamiento para poder ver por usuario/mes los puntos recibidos, puntos redimidos y su respectivo saldo, esta información es cargada a GCS (API GCS) y posteriormente conectada con Data Studio para crear un reporte que permita visualizar la información.

LINK: https://datastudio.google.com/s/mwFs12hkyVI

4. Para este ejercicio se tomaron 10.000 registros de las ventas de licor en IOWA posteriores al 2019 desde la consolo de BQ y se exporta este archivo a python, con este archivo se hace crean 3 funciones: 1. que permite calcular las metas para cada producto vendido con el promedio por mes de cada vendedor, esta permite elegir la variable a tomar entre las existentes en el dataframe que son botellas vendidas, litros vendidos o dolares vendidos. 2 y 3 son dos funciones relacioada que permiten decidir cual es el periodo de tiempo a liquidar y los respectivos puntos a entregar por cumplor la meta mensual de cada producto vendido.

5. Tal como lo menciona el enunciado se hace la extracción de los archivos contenidos en el ZIP y se cargar a través de la API de GCS con Python. Después (desde python también) se realiza la extracción de los archivos csv, su concatenación y carga a una bd de staging en MySQL (local). Finalmente para cada tabla del modelo estrella se crea una vista de transformación con los datos requeridos en cada tabla y su respectivo proceso almacenado para actualizarse cuando el origen se modifique.

Las librerias utilizadas en la prueba fueron: 
requests
json
nump
time
os
pandas
google.cloud.storage
os
datetime, timedelta, date
google.cloud.bigquery
dateutil.relativedelta.relativedelta
random
mysql.connector.mysql
sqlalchemy.create_engine
pymysql
zipfile
gcsfs
