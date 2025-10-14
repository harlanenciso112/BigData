-- 1. Crecimiento de Unidades por Producto (YOY)
-- Productos que tuvieron un incremento en las cantidades vendidas en 2024 comparado con las ventas de 2023
WITH UnidadesAnuales AS (
    SELECT
        o.id_producto,
        p.nombre AS producto,
        EXTRACT(YEAR FROM CAST(o.fecha AS DATE)) AS anio,
        SUM(o.cantidad) AS total_unidades
    FROM
        public.operaciones o
    JOIN
        public.productos p ON p.id_producto = o.id_producto
    WHERE
        EXTRACT(YEAR FROM CAST(o.fecha AS DATE)) IN (2023, 2024)
        AND o.estado = 'F' AND o.id_producto IN (1, 2, 3, 4)
    GROUP BY
        o.id_producto, p.nombre, anio
)
SELECT
    u2024.producto,
    u2023.total_unidades AS unidades_2023,
    u2024.total_unidades AS unidades_2024,
    ROUND(((u2024.total_unidades - u2023.total_unidades) * 100.0 / u2023.total_unidades)::NUMERIC, 2) AS crecimiento_unidades_porcentaje
FROM
    UnidadesAnuales u2024
JOIN
    UnidadesAnuales u2023 ON u2024.id_producto = u2023.id_producto
WHERE
    u2024.anio = 2024 AND u2023.anio = 2023
    AND u2024.total_unidades > u2023.total_unidades
ORDER BY
    crecimiento_unidades_porcentaje DESC;


-- 2. Crecimiento de Monto por Producto (YOY)
-- Productos que tuvieron un incremento en los montos de 2024 comparado con las ventas de 2023
WITH MontosAnuales AS (
    SELECT
        o.id_producto,
        p.nombre AS producto,
        EXTRACT(YEAR FROM CAST(o.fecha AS DATE)) AS anio,
        SUM(o.cantidad * p.precio) AS monto_total
    FROM
        public.operaciones o
    JOIN
        public.productos p ON p.id_producto = o.id_producto
    WHERE
        EXTRACT(YEAR FROM CAST(o.fecha AS DATE)) IN (2023, 2024)
        AND o.estado = 'F' AND o.id_producto IN (1, 2, 3, 4)
    GROUP BY
        o.id_producto, p.nombre, anio
)
SELECT
    m2024.producto,
    m2023.monto_total AS monto_2023,
    m2024.monto_total AS monto_2024,
    ROUND(((m2024.monto_total - m2023.monto_total) * 100.0 / m2023.monto_total)::NUMERIC, 2) AS crecimiento_yoy_monto_porcentaje
FROM
    MontosAnuales m2024
JOIN
    MontosAnuales m2023 ON m2024.id_producto = m2023.id_producto
WHERE
    m2024.anio = 2024 AND m2023.anio = 2023
    AND m2024.monto_total > m2023.monto_total
ORDER BY
    crecimiento_yoy_monto_porcentaje DESC;


-- 3. Top 5 Municipios con Mayor Crecimiento de Monto (YOY)
-- Los cinco (5) municipios con mejor desempeño en montos de venta en 2024 comparado con las cifras de 2023
WITH MontosAnuales AS (
    SELECT
        o.id_municipio,
        m.nombre AS municipio,
        EXTRACT(YEAR FROM CAST(o.fecha AS DATE)) AS anio,
        SUM(o.cantidad * p.precio) AS monto_total
    FROM
        public.operaciones o
    JOIN
        public.municipios m ON m.id_municipio = o.id_municipio
    JOIN
        public.productos p ON p.id_producto = o.id_producto
    WHERE
        EXTRACT(YEAR FROM CAST(o.fecha AS DATE)) IN (2023, 2024)
        AND o.estado = 'F' AND o.id_producto IN (1, 2, 3, 4)
    GROUP BY
        o.id_municipio, m.nombre, anio
)
SELECT
    m2024.municipio,
    m2023.monto_total AS monto_2023,
    m2024.monto_total AS monto_2024,
    ROUND(((m2024.monto_total - m2023.monto_total) * 100.0 / m2023.monto_total)::NUMERIC, 2) AS crecimiento_yoy_monto_porcentaje
FROM
    MontosAnuales m2024
JOIN
    MontosAnuales m2023 ON m2024.id_municipio = m2023.id_municipio
WHERE
    m2024.anio = 2024 AND m2023.anio = 2023
    AND m2023.monto_total > 0
ORDER BY
    crecimiento_yoy_monto_porcentaje DESC
LIMIT 5;


-- 4. 5 Departamentos con mayor decrecimiento de NARANJITA (Caribe 2023-2022)
WITH UnidadesAnualesCaribe AS (
    SELECT
        o.id_departamento,
        d.nombre AS departamento,
        EXTRACT(YEAR FROM CAST(o.fecha AS DATE)) AS anio,
        SUM(o.cantidad) AS total_unidades
    FROM
        public.operaciones o
    JOIN
        public.departamentos d ON d.id_departamento = o.id_departamento
    WHERE
        EXTRACT(YEAR FROM CAST(o.fecha AS DATE)) IN (2023, 2024)
        AND o.estado = 'F' AND o.id_producto = 4
        AND o.id_departamento IN (8, 13, 20, 23, 44, 47, 70, 88)
    GROUP BY
        o.id_departamento, d.nombre, anio
)
SELECT
    u2024.departamento,
    u2023.total_unidades AS unidades_2023,
    u2024.total_unidades AS unidades_2024,
    ROUND(((u2024.total_unidades - u2023.total_unidades) * 100.0 / u2023.total_unidades)::NUMERIC, 2) AS decrecimiento_yoy_porcentaje
FROM
    UnidadesAnualesCaribe u2024
JOIN
    UnidadesAnualesCaribe u2023 ON u2024.id_departamento = u2023.id_departamento
WHERE
    u2024.anio = 2024 AND u2023.anio = 2023 AND u2023.total_unidades > 0
ORDER BY
    decrecimiento_yoy_porcentaje ASC
LIMIT 5;


-- 5. Variación % Anual de Monto del Producto LIMÓN-FRESA (YOY)
WITH MontosAnuales AS (
    SELECT
        EXTRACT(YEAR FROM CAST(o.fecha AS DATE)) AS anio,
        SUM(o.cantidad * p.precio) AS monto_total
    FROM
        public.operaciones o
    JOIN
        public.productos p ON p.id_producto = o.id_producto
    WHERE
        EXTRACT(YEAR FROM CAST(o.fecha AS DATE)) IN (2023, 2024)
        AND o.estado = 'F' AND o.id_producto = 1
    GROUP BY
        anio
)
SELECT
    m2023.monto_total AS monto_2023,
    m2024.monto_total AS monto_2024,
    ROUND(((m2024.monto_total - m2023.monto_total) * 100.0 / m2023.monto_total)::NUMERIC, 2) AS variacion_yoy_monto_porcentaje
FROM
    MontosAnuales m2023
JOIN
    MontosAnuales m2024 ON m2024.anio = 2024
WHERE
    m2023.anio = 2023;


-- 6. Crecimiento % de Monto Mensual en Diciembre (YOY)
WITH MontosMensuales AS (
    SELECT
        EXTRACT(YEAR FROM CAST(o.fecha AS DATE)) AS anio,
        SUM(o.cantidad * p.precio) AS monto_total
    FROM
        public.operaciones o
    JOIN
        public.productos p ON p.id_producto = o.id_producto
    WHERE
        EXTRACT(YEAR FROM CAST(o.fecha AS DATE)) IN (2023, 2024)
        AND EXTRACT(MONTH FROM CAST(o.fecha AS DATE)) = 12
        AND o.estado = 'F' AND o.id_producto IN (1, 2, 3, 4)
    GROUP BY
        anio
)
SELECT
    m2023.monto_total AS monto_diciembre_2023,
    m2024.monto_total AS monto_diciembre_2024,
    ROUND(((m2024.monto_total - m2023.monto_total) * 100.0 / m2023.monto_total)::NUMERIC, 2) AS crecimiento_diciembre_yoy_porcentaje
FROM
    MontosMensuales m2023
JOIN
    MontosMensuales m2024 ON m2024.anio = 2024
WHERE
    m2023.anio = 2023;


-- 7. Crecimiento % de Monto en Q1 (YOY)
WITH MontosTrimestrales AS (
    SELECT
        EXTRACT(YEAR FROM CAST(o.fecha AS DATE)) AS anio,
        SUM(o.cantidad * p.precio) AS monto_total
    FROM
        public.operaciones o
    JOIN
        public.productos p ON p.id_producto = o.id_producto
    WHERE
        EXTRACT(YEAR FROM CAST(o.fecha AS DATE)) IN (2023, 2024)
        AND EXTRACT(MONTH FROM CAST(o.fecha AS DATE)) IN (1, 2, 3)
        AND o.estado = 'F' AND o.id_producto IN (1, 2, 3, 4)
    GROUP BY
        anio
)
SELECT
    m2023.monto_total AS monto_q1_2023,
    m2024.monto_total AS monto_q1_2024,
    ROUND(((m2024.monto_total - m2023.monto_total) * 100.0 / m2023.monto_total)::NUMERIC, 2) AS crecimiento_q1_yoy_porcentaje
FROM
    MontosTrimestrales m2023
JOIN
    MontosTrimestrales m2024 ON m2024.anio = 2024
WHERE
    m2023.anio = 2023;


-- 8. Crecimiento % de Unidades en Q4 (YOY)
WITH UnidadesTrimestrales AS (
    SELECT
        EXTRACT(YEAR FROM CAST(o.fecha AS DATE)) AS anio,
        SUM(o.cantidad) AS total_unidades
    FROM
        public.operaciones o
    WHERE
        EXTRACT(YEAR FROM CAST(o.fecha AS DATE)) IN (2023, 2024)
        AND EXTRACT(MONTH FROM CAST(o.fecha AS DATE)) IN (10, 11, 12)
        AND o.estado = 'F' AND o.id_producto IN (1, 2, 3, 4)
    GROUP BY
        anio
)
SELECT
    u2023.total_unidades AS unidades_q4_2023,
    u2024.total_unidades AS unidades_q4_2024,
    ROUND(((u2024.total_unidades - u2023.total_unidades) * 100.0 / u2023.total_unidades)::NUMERIC, 2) AS crecimiento_q4_yoy_porcentaje
FROM
    UnidadesTrimestrales u2023
JOIN
    UnidadesTrimestrales u2024 ON u2024.anio = 2024
WHERE
    u2023.anio = 2023;

