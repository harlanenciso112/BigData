--CONSULTA PARA COMPARAR 2 AÑOS:
SELECT 
    producto,
    SUM(CASE WHEN anio = 2023 THEN cantidad ELSE 0 END) AS total_2023,
    SUM(CASE WHEN anio = 2024 THEN cantidad ELSE 0 END) AS total_2024
FROM public.vista_operaciones_new
GROUP BY producto
ORDER BY producto;

-- REVISANDO ANALITICA:
SELECT anio, producto, SUM(venta) AS total_venta_anual
FROM public.vista_operaciones_new
GROUP BY anio,producto
ORDER BY anio,producto;

SELECT 
    departamento,
    SUM(CASE WHEN anio = 2023 THEN cantidad ELSE 0 END) AS total_2023,
    SUM(CASE WHEN anio = 2024 THEN cantidad ELSE 0 END) AS total_2024
FROM vista_operaciones_new
GROUP BY departamento
ORDER BY departamento;

-- ANALITICA COMPARATIVA:
SELECT 
    producto,
    SUM(CASE WHEN anio = 2023 THEN cantidad ELSE 0 END) AS total_2023,
    SUM(CASE WHEN anio = 2024 THEN cantidad ELSE 0 END) AS total_2024,
    SUM(CASE WHEN anio = 2024 THEN cantidad ELSE 0 END) -
    SUM(CASE WHEN anio = 2023 THEN cantidad ELSE 0 END) AS diferencia
FROM public.vista_operaciones_new
GROUP BY producto
ORDER BY producto;

-- ANALITICA POR DEPARTAMENTO:
SELECT 
    departamento,
    SUM(CASE WHEN anio = 2023 THEN cantidad ELSE 0 END) AS total_2023,
    SUM(CASE WHEN anio = 2024 THEN cantidad ELSE 0 END) AS total_2024,
    SUM(CASE WHEN anio = 2024 THEN cantidad ELSE 0 END) -
    SUM(CASE WHEN anio = 2023 THEN cantidad ELSE 0 END) AS diferencia    
FROM vista_operaciones_new
GROUP BY departamento
ORDER BY departamento;

-- HAVING
SELECT 
    departamento,
    SUM(CASE WHEN anio = 2023 THEN cantidad ELSE 0 END) AS total_2023,
    SUM(CASE WHEN anio = 2024 THEN cantidad ELSE 0 END) AS total_2024,
    SUM(CASE WHEN anio = 2024 THEN cantidad ELSE 0 END) -
    SUM(CASE WHEN anio = 2023 THEN cantidad ELSE 0 END) AS diferencia    
FROM vista_operaciones_new
GROUP BY departamento
HAVING
    SUM(CASE WHEN anio = 2024 THEN cantidad ELSE 0 END) - 
    SUM(CASE WHEN anio = 2023 THEN cantidad ELSE 0 END) > 0
ORDER BY diferencia, departamento;

-- ANALITICA POR DEPARTAMENTO Y PRODUCTO:
SELECT 
    producto,departamento,
    SUM(CASE WHEN anio = 2023 THEN cantidad ELSE 0 END) AS total_2023,
    SUM(CASE WHEN anio = 2024 THEN cantidad ELSE 0 END) AS total_2024,
    SUM(CASE WHEN anio = 2024 THEN cantidad ELSE 0 END) -
    SUM(CASE WHEN anio = 2023 THEN cantidad ELSE 0 END) AS diferencia    
FROM vista_operaciones_new
GROUP BY departamento, producto
HAVING
    SUM(CASE WHEN anio = 2024 THEN cantidad ELSE 0 END) - 
    SUM(CASE WHEN anio = 2023 THEN cantidad ELSE 0 END) < 0
ORDER BY diferencia DESC, departamento;