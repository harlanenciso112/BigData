Fábricas
INSERT INTO fabricas (codigo, nombre, direccion, ciudad, latitud, longitud)
VALUES
 ('A', 'Fábrica A', 'Zona Industrial 1', 'Medellín', 6.2518, -75.5636),
 ('B', 'Fábrica B', 'Parque Industrial Norte', 'Bello', 6.3373, -75.5581),
 ('C', 'Fábrica C', 'Vía al mar km 5', 'Turbo', 8.0926, -76.7285);
Líneas de producción
INSERT INTO lineas_produccion (id_fabrica, codigo_linea, descripcion)
VALUES
 (1, 'A1', 'Línea 1 Fábrica A'),
 (1, 'A2', 'Línea 2 Fábrica A'),
 (2, 'B1', 'Línea 1 Fábrica B'),
 (3, 'C1', 'Línea 1 Fábrica C');
Tipos de filtro
INSERT INTO tipos_filtro (nombre, descripcion, vida_util_dias, costo_usd)
VALUES
 ('Filtro Premium', 'Filtro de alta capacidad para benceno', 15, 300.00),
 ('Filtro Estándar', 'Filtro estándar de línea', 7, 180.00); 
Filtros
INSERT INTO filtros (id_linea, id_tipo_filtro, codigo_filtro, fecha_instalacion, fecha_cambio_prevista, estado)
VALUES
 (1, 1, 'A1-FILT-001', '2024-05-01', '2024-05-16', 'EN USO'),
 (2, 2, 'A2-FILT-001', '2024-05-05', '2024-05-12', 'EN USO');
Sensores
INSERT INTO sensores (id_linea, codigo_sensor, tipo_sensor, precision_ppm, unidad, fecha_instalacion)
VALUES
 (1, 'A1S01', 'MQ-135', 0.50, 'ppm', '2024-04-20'),
 (1, 'A1S02', 'MQ-135', 0.50, 'ppm', '2024-04-21'),
 (2, 'A2S01', 'MQ-135', 0.50, 'ppm', '2024-04-22');
 
Productos
INSERT INTO productos (nombre, descripcion, es_benceno, unidad_medida)
VALUES
 ('Producto X', 'Producto químico con emisión de benceno', TRUE, 'kg'),
 ('Producto Y', 'Producto químico sin benceno', FALSE, 'kg');
 
Clasificación PPM
INSERT INTO clasificacion_ppm (rango_min, rango_max, nivel, descripcion, accion_recomendada, color_alerta)
VALUES
 (0.00, 0.99, 'Bajo', 'Nivel seguro', 'Operación normal', 'Verde'),
 (1.00, 4.99, 'Moderado', 'Requiere vigilancia', 'Revisar filtros próximamente', 'Amarillo'),
 (5.00, 9.99, 'Alto', 'Peligro para la salud', 'Detener línea y revisar filtros', 'Naranja'),
 (10.00, 1000.00, 'Crítico', 'Riesgo extremo', 'Detener planta y activar protocolo de emergencia', 'Rojo');
 
Configuración fábrica
INSERT INTO configuracion_fabrica (id_fabrica, frecuencia_lectura_seg, ppm_max_permitido, dias_max_uso_filtro, fecha_creacion, observaciones)
VALUES
 (1, 10, 5.00, 15, '2024-04-01', 'Configuración inicial Fábrica A'),
 (2, 10, 5.00, 15, '2024-04-01', 'Configuración inicial Fábrica B');
 
 
Empleados
INSERT INTO empleados (documento, nombres, apellidos, cargo, telefono, email, id_fabrica)
VALUES
 ('10000001', 'Carlos', 'García', 'Operario', '3000000001', 'carlos@fabricaA.com', 1),
 ('10000002', 'Ana', 'López', 'Supervisor', '3000000002', 'ana@fabricaA.com', 1);
Turnos
INSERT INTO turnos (nombre_turno, hora_inicio, hora_fin)
VALUES
 ('Turno 1', '08:00:00', '16:00:00'),
 ('Turno 2', '16:00:00', '00:00:00'),
 ('Turno 3', '00:00:00', '08:00:00');
Asignación empleado-turno
INSERT INTO empleado_turno (id_empleado, id_turno, fecha, es_supervisor)
VALUES
 (1, 1, '2024-05-20', FALSE),
 (2, 1, '2024-05-20', TRUE);
Lecturas
INSERT INTO lecturas (
    fecha_hora, id_fabrica, id_linea, id_sensor, id_filtro, id_producto,
    ppm, temperatura, humedad, latitud, longitud, id_clasificacion_ppm, alarma_activa, origen
) VALUES
 ('2024-05-20 08:00:10', 1, 1, 1, 1, 1, 0.80, 24.5, 55.0, 6.2518, -75.5636, 1, FALSE, 'local'),
 ('2024-05-20 08:00:20', 1, 1, 1, 1, 1, 5.50, 24.7, 54.8, 6.2518, -75.5636, 3, TRUE, 'local'),
 ('2024-05-20 08:00:30', 1, 1, 2, 1, 1, 10.20, 24.9, 54.5, 6.2518, -75.5636, 4, TRUE, 'local');
