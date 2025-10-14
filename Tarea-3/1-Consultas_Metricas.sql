-- Los cinco municipios con mayor cantidad de gaseosas vendidas en 2023

SELECT
    m.nombre AS municipio,
    SUM(o.cantidad) AS total_unidades
FROM
    public.operaciones o
JOIN
    public.municipios m ON m.id_municipio = o.id_municipio
WHERE
    EXTRACT(YEAR FROM CAST(o.fecha AS DATE)) = 2023 
    AND o.estado = 'F'                             
    AND o.id_producto IN (1, 2, 3, 4)             
GROUP BY
    m.nombre
ORDER BY
    total_unidades DESC
LIMIT 5;

-- Los cinco (5) departamentos con menor monto ventas de gaseosas en 2023

SELECT
    d.nombre AS departamento,
    SUM(o.cantidad * p.precio) AS monto_total_ventas
FROM
    public.operaciones o
JOIN
    public.departamentos d ON d.id_departamento = o.id_departamento
JOIN
    public.productos p ON p.id_producto = o.id_producto
WHERE
    EXTRACT(YEAR FROM CAST(o.fecha AS DATE)) = 2023 
    AND o.estado = 'F'                             
    AND o.id_producto IN (1, 2, 3, 4)             
GROUP BY
    d.nombre
ORDER BY
    monto_total_ventas ASC
LIMIT 5;

-- Los diez (10) municipios con mayores cantidades de venta de unidades en mayo 2023

SELECT 
    m.nombre AS municipio, 
    SUM(o.cantidad) AS total_unidades_vendidas 
FROM 
    public.operaciones o 
JOIN 
    public.municipios m ON m.id_municipio = o.id_municipio 
WHERE 
    EXTRACT(YEAR FROM CAST(o.fecha AS DATE)) = 2023 
    AND EXTRACT(MONTH FROM CAST(o.fecha AS DATE)) = 5 
    AND o.estado = 'F' AND o.id_producto IN (1, 2, 3, 4) 
GROUP BY 
    m.nombre 
ORDER BY 
    total_unidades_vendidas DESC 
LIMIT 10;

-- Total de montos de ventas por producto en la Región Caribe en 2023

SELECT
    p.nombre AS producto,
    SUM(o.cantidad * p.precio) AS monto_total_ventas
FROM
    public.operaciones o
JOIN
    public.departamentos d ON d.id_departamento = o.id_departamento
JOIN
    public.productos p ON p.id_producto = o.id_producto
WHERE
    EXTRACT(YEAR FROM CAST(o.fecha AS DATE)) = 2023 
    AND o.estado = 'F'
    AND o.id_producto IN (1, 2, 3, 4)
    GROUP BY
    p.nombre
ORDER BY
    monto_total_ventas DESC;

-- Total de cantidades vendidas por producto en la Región Centro Sur

SELECT
    p.nombre AS producto,
    SUM(o.cantidad) AS total_unidades_vendidas
FROM
    public.operaciones o
JOIN
    public.departamentos d ON d.id_departamento = o.id_departamento
JOIN
    public.productos p ON p.id_producto = o.id_producto
WHERE
    EXTRACT(YEAR FROM CAST(o.fecha AS DATE)) = 2023 
    AND o.estado = 'F'
    AND o.id_producto IN (1, 2, 3, 4)
GROUP BY
    p.nombre
ORDER BY
    total_unidades_vendidas DESC;


-- El monto promedio de venta por cada registro (transacción) en 2023.

SELECT
    ROUND(
        SUM(o.cantidad * p.precio)::NUMERIC 
        /
        COUNT(o.id_registro), 
        2
    ) AS monto_promedio_por_registro
FROM
    public.operaciones o
JOIN
    public.productos p ON p.id_producto = o.id_producto
WHERE
    EXTRACT(YEAR FROM CAST(o.fecha AS DATE)) = 2023 
    AND o.estado = 'F'
    AND o.id_producto IN (1, 2, 3, 4);

-- Porcentaje de registros de operación con estado 'F' sobre el total de registros en el período 2023.

SELECT
    ROUND(
        (
            SUM(CASE WHEN o.estado = 'F' THEN 1 ELSE 0 END)::NUMERIC
        ) 
        * 100.0 / COUNT(o.id_registro), 
        2
    ) AS tasa_finalizadas_porcentaje
FROM
    public.operaciones o
WHERE
    EXTRACT(YEAR FROM CAST(o.fecha AS DATE)) = 2023 
    AND o.id_producto IN (1, 2, 3, 4);

-- Crecimiento o decrecimiento porcentual en el monto total de ventas entre 2023 y 2022.

WITH VentasAnuales AS (
    SELECT
        EXTRACT(YEAR FROM CAST(o.fecha AS DATE)) AS anio,
        SUM(o.cantidad * p.precio) AS monto_total
    FROM
        public.operaciones o
    JOIN
        public.productos p ON p.id_producto = o.id_producto
    WHERE
        EXTRACT(YEAR FROM CAST(o.fecha AS DATE)) IN (2023, 2024)
        AND o.estado = 'F'
        AND o.id_producto IN (1, 2, 3, 4)
    GROUP BY 
        anio
)


