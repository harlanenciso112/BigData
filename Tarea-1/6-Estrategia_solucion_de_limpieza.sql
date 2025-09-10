--Problema: Algunos registros de la tabla 'operaciones' no contienen información completa.
--Se identificaron los siguientes casos: cantidades en cero, cantidades negativas, departamentos
--faltantes e identificadores de producto incompletos.

--Propuesta de solución: Aplicar técnicas de imputación y reglas de negocio para recuperar
--la información, evitando la eliminación de registros.

--Cantidades = 0:
UPDATE operaciones o
SET cantidad = sub.promedio
FROM (
    SELECT id_producto, id_municipio, ROUND(AVG(cantidad)) AS promedio
    FROM operaciones
    WHERE cantidad > 0
    GROUP BY id_producto, id_municipio
) sub
WHERE o.cantidad = 0
  AND o.id_producto = sub.id_producto
  AND o.id_municipio = sub.id_municipio;

--Cantidades negativas:
UPDATE operaciones
SET cantidad = ABS(cantidad)
WHERE cantidad < 0;

--Departamentos faltantes (id_departamento=0):
UPDATE operaciones o
SET id_departamento = m.id_departamento
FROM municipios m
WHERE o.id_departamento = 0
  AND o.id_municipio = m.id_municipio;

--Productos faltantes (id_producto=0):
UPDATE operaciones
SET id_producto = 4
WHERE id_producto = 0
  AND id_municipio IN (
      SELECT id_municipio
      FROM municipios m
      JOIN departamentos d ON d.id_departamento = m.id_departamento
      WHERE m.nombre ILIKE 'Tamesis'
        AND d.nombre ILIKE 'Antioquia'
  );
