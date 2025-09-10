Identificación, análisis y corrección de registros con problemas en la tabla “operaciones”. Tip: tiene que cargar la tabla operaciones primero (utilice script) 

En el proceso de análisis y normalización de la base de datos del sistema de operaciones, se presentaron inconsistencias en el almacenamiento de las fechas y se detectaron registros incompletos que afectaba la calidad de los datos.
Durante la revisión de la tabla operaciones se identificó que el campo fecha estaba definido como character varying (texto).
 Esto ocasiona que las fechas se almacenarán en distintos formatos, tales como: DD/MM/YYYY,  MM-DD-YYYY,  YYYY-MM-DD 
Esta falta de uniformidad complicaba las consultas y generaba errores al procesar las fechas.

- Para identificar los formatos presentes se realizó la consulta:
SELECT DISTINCT fecha
FROM operaciones
LIMIT 50;
- Normalización de registros en formato DD/MM/YYYY y MM-DD-YYYY
UPDATE operaciones
SET fecha = TO_CHAR(TO_DATE(fecha, 'DD/MM/YYYY'), 'YYYY-MM-DD')
WHERE fecha LIKE '%/%';
UPDATE operaciones
SET fecha = TO_CHAR(TO_DATE(fecha, 'MM-DD-YYYY'), 'YYYY-MM-DD')
WHERE fecha LIKE '%-%' AND LENGTH(fecha) = 10;

Una vez corregidos los formatos, se modificó la estructura de la columna para evitar futuros errores:
ALTER TABLE operaciones
ALTER COLUMN fecha TYPE date
USING TO_DATE(fecha, 'YYYY-MM-DD');

