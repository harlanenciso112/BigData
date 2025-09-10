-- Seleccionar los 8 departamentos con mayor volumen de ventas (monto) de productos
-- ordenados de mayor a menor. Datos solicitados: nombre de departamento y monto total
-- por departamento de todos los productos. Nota: Recuerde que tiene agrupar por departamento
SELECT departamento,
       SUM(venta) AS monto_total
FROM vista_operaciones
GROUP BY departamento
ORDER BY monto_total DESC
LIMIT 8;


-- Seleccionar los 15 municipios con mayor cantidad de productos vendidos
-- en el departamento de Antioquia ordenados de mayor a menor. Datos solicitados:
-- nombre municipio y cantidad total por municipio. Nota: Recuerde que tiene agrupar por municipio
SELECT municipio,
       SUM(cantidad) AS total_cantidad
FROM vista_operaciones
WHERE departamento = 'Antioquia'
GROUP BY municipio
ORDER BY total_cantidad DESC
LIMIT 15;


-- Seleccionar los 5 departamentos con mayor cantidad de gaseosas vendidas
-- del producto “MANZALOCA” ordenados de mayor a menor. Datos solicitados: 
-- nombre de departamento y cantidad total por departamento. Nota: Recuerde 
-- que tiene agrupar por departamento y filtrar por el producto.
SELECT departamento,
       SUM(cantidad) AS total_cantidad
FROM vista_operaciones
WHERE producto = 'MANZALOCA'
GROUP BY departamento
ORDER BY total_cantidad DESC
LIMIT 5;


-- Seleccione los 5 municipios con el menor monto de ventas de gaseosas ordenados de menor a mayor.
-- Datos solicitados: nombre del departamento al que pertenece, nombre municipio y monto total de ventas
-- por municipio. Nota: Recuerde que tiene agrupar por municipio
SELECT departamento,
       municipio,
       SUM(venta) AS monto_total
FROM vista_operaciones
GROUP BY departamento, municipio
ORDER BY monto_total ASC
LIMIT 5;


--Consultar la cantidad de gaseosas vendidas de cada producto por cada región ordenados de mayor a menor.
SELECT d.codigo_region AS region,
       producto,
       SUM(cantidad) AS total_cantidad
FROM vista_operaciones vo
JOIN departamentos d ON vo.id_departamento = d.id_departamento
GROUP BY d.codigo_region, producto
ORDER BY total_cantidad DESC;


--Consultar el total del monto de ventas de cada producto en Antioquia de mayor a menor.
SELECT producto,
       SUM(venta) AS monto_total
FROM vista_operaciones
WHERE departamento = 'Antioquia'
GROUP BY producto
ORDER BY monto_total DESC;

