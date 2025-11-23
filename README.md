# Fundamentos de Big Data | Grupo 103 | ET0043

Este repositorio contiene el desarrollo de las tareas del grupo 2 de la asignatura **Fundamentos de Big Data G103** de la **Institución Universitaria Pascual Bravo**.  

---
# Grupo 2
## 👥 Integrantes del grupo
- Harlan Santiago Enciso Riaño
- Miguel Angel Rojas Pabon
- Maria Camila Rodriguez Ortiz

---
## Tarea 2
En esta tarea realizamos el diseño conceptual y lógico de la base de datos, acompañado del diagrama de Chen y el diccionario de datos. Posteriormente llevamos a cabo el proceso ETL con su respectiva limpieza, donde identificamos y corregimos registros con problemas en la tabla operaciones y definimos una estrategia para depurar aquellos datos no válidos. También actualizamos un algoritmo en Python para solucionar el problema de transformación de formatos de fecha, desarrollamos las consultas SQL solicitadas y presentamos los resultados tanto en tablas como en gráficos. Adicionalmente calculamos los tiempos de procesamiento según la cantidad de registros, elaboramos un video explicativo de todo el procedimiento y presentamos un análisis de los resultados con sus conclusiones sobre la relevancia académica y profesional de este trabajo. Finalmente, como valor agregado, incluimos el diagrama de flujo del algoritmo ETL.

## Tarea 3
En esta tarea realizamos el diseño y construcción del Cuadro de Mando Integral (CMI) y el Tablero de Mando (Dashboard), a partir de los datos procesados en las etapas anteriores. Se definieron métricas y KPI relevantes para analizar el desempeño de la empresa y se implementaron visualizaciones en Metabase y Tableau Public. Además, se elaboró un análisis de resultados, conclusiones y reflexiones individuales, junto con un video explicativo que resume el desarrollo y los hallazgos del proyecto.

## Tarea 6
En esta tarea realizamos el diseño del Gobierno de Datos y la estructura general de un proyecto Big Data pensado para enfrentar el problema de monitoreo y control de gases tóxicos en las fábricas de “Sustancias Locas”. A partir del caso de estudio, analizamos todos los componentes necesarios para construir una arquitectura sólida: sensores, microcontroladores, frecuencia de lecturas, almacenamiento local, comunicación con la nube, necesidades de ETL, y los criterios para asegurar integridad, disponibilidad y trazabilidad de los datos. También identificamos los roles, las políticas y las reglas que requiere un Gobierno de Datos funcional dentro de un entorno industrial que trabaja 24/7. A lo largo del trabajo, organizamos la información según los requerimientos, revisamos cálculos de volúmenes, ciclos de limpieza, riesgos operativos y elementos críticos que impactan el diseño. Finalmente, se elaboró un análisis global que explica por qué este tipo de gobierno y arquitectura son necesarios para escalar, mantener y auditar un sistema de monitoreo que tiene implicaciones directas en la salud humana y la seguridad ambiental.

## Tarea 7
En esta tarea diseñamos una Arquitectura de Sistema de Información completa para soportar un flujo Big Data en tiempo real, desde la captura en los sensores MQ-135 hasta la visualización en tableros locales y en la nube. Tomamos como base el caso de estudio y detallamos cómo se integran los componentes de hardware y software: los microcontroladores ESP8266, el servidor local, el almacenamiento en PostgreSQL, las APIs de envío de datos, la ingesta masiva en AWS mediante Kinesis Firehose, el almacenamiento S3, el procesamiento ETL con Glue, las consultas analíticas en Redshift y la visualización en QuickSight y Metabase. También se incluyó la clasificación de niveles de ppm, los flujos de alerta, los ciclos de limpieza, el dimensionamiento del almacenamiento y la posible ampliación a tres fábricas con carga distribuida y escalabilidad mediante Hadoop. Además, se evaluó el desempeño de la arquitectura con una simulación del proceso completo (ETL, analítica, visualización) para verificar que la solución puede operar y responder en tiempo real. El informe recoge todo el diseño, los cálculos, la justificación técnica y las conexiones entre cada pieza para que el sistema funcione de forma consistente y continua.