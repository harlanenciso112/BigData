CREATE DATABASE "monitoreo-producción"; 

CREATE TABLE fabricas (
	id_fabrica   SERIAL PRIMARY KEY,
	codigo       VARCHAR(10)  NOT NULL UNIQUE,
	nombre       VARCHAR(100) NOT NULL,
	direccion    VARCHAR(150),
	ciudad       VARCHAR(80),
	latitud      NUMERIC(9,6),
	longitud     NUMERIC(9,6),
	estado       VARCHAR(20)  DEFAULT 'ACTIVA'
);
CREATE TABLE lineas_produccion (
	id_linea     SERIAL PRIMARY KEY,
	id_fabrica   INT NOT NULL REFERENCES fabricas(id_fabrica),
	codigo_linea VARCHAR(10) NOT NULL,
	descripcion  VARCHAR(100),
	estado       VARCHAR(20) DEFAULT 'ACTIVA'
);
 





CREATE TABLE sensores (
	id_sensor    	SERIAL PRIMARY KEY,
	id_linea     	INT NOT NULL REFERENCES lineas_produccion(id_linea),
	codigo_sensor	VARCHAR(10) NOT NULL,
	tipo_sensor  	VARCHAR(50) NOT NULL,
	precision_ppm	NUMERIC(6,2),
	unidad       	VARCHAR(10) DEFAULT 'ppm',
	fecha_instalacion DATE,
	estado       	VARCHAR(20) DEFAULT 'ACTIVO'
);
 CREATE TABLE tipos_filtro (
	id_tipo_filtro SERIAL PRIMARY KEY,
	nombre     	VARCHAR(50) NOT NULL,
	descripcion	VARCHAR(150),
	vida_util_dias INT,
	costo_usd  	NUMERIC(10,2)
);
 CREATE TABLE filtros (
	id_filtro         	SERIAL PRIMARY KEY,
	id_linea          	INT NOT NULL REFERENCES lineas_produccion(id_linea),
	id_tipo_filtro    	INT NOT NULL REFERENCES tipos_filtro(id_tipo_filtro),
	codigo_filtro     	VARCHAR(20) NOT NULL,
	fecha_instalacion 	DATE NOT NULL,
	fecha_cambio_prevista DATE,
	fecha_cambio_real 	DATE,
	estado            	VARCHAR(20) DEFAULT 'EN USO'
);
 
CREATE TABLE productos (
	id_producto  SERIAL PRIMARY KEY,
	nombre       VARCHAR(80)  NOT NULL,
	descripcion  VARCHAR(150),
	es_benceno   BOOLEAN  	DEFAULT FALSE,
	unidad_medida VARCHAR(10) DEFAULT 'kg'
);
 
CREATE TABLE clasificacion_ppm (
	id_clasificacion_ppm SERIAL PRIMARY KEY,
	rango_min        	NUMERIC(10,2) NOT NULL,
	rango_max        	NUMERIC(10,2) NOT NULL,
	nivel            	VARCHAR(30)   NOT NULL,
	descripcion      	VARCHAR(200),
	accion_recomendada   VARCHAR(200),
	color_alerta     	VARCHAR(20)
);
 
CREATE TABLE configuracion_fabrica (
	id_config        	SERIAL PRIMARY KEY,
	id_fabrica       	INT NOT NULL REFERENCES fabricas(id_fabrica),
	frecuencia_lectura_seg INT NOT NULL,
	ppm_max_permitido	NUMERIC(10,2),
	dias_max_uso_filtro  INT,
	fecha_creacion   	DATE NOT NULL,
	observaciones    	VARCHAR(200)
);
 
CREATE TABLE empleados (
	id_empleado SERIAL PRIMARY KEY,
	documento   VARCHAR(20)  NOT NULL UNIQUE,
	nombres     VARCHAR(80)  NOT NULL,
	apellidos   VARCHAR(80)  NOT NULL,
	cargo       VARCHAR(50),
	telefono    VARCHAR(20),
	email       VARCHAR(100),
	id_fabrica  INT REFERENCES fabricas(id_fabrica)
);
 
CREATE TABLE turnos (
	id_turno     SERIAL PRIMARY KEY,
	nombre_turno VARCHAR(20) NOT NULL,
	hora_inicio  TIME    	NOT NULL,
	hora_fin     TIME    	NOT NULL
);
 
CREATE TABLE empleado_turno (
	id_empleado_turno SERIAL PRIMARY KEY,
	id_empleado   	INT NOT NULL REFERENCES empleados(id_empleado),
	id_turno      	INT NOT NULL REFERENCES turnos(id_turno),
	fecha         	DATE NOT NULL,
	es_supervisor 	BOOLEAN DEFAULT FALSE
);
 


CREATE TABLE lecturas (
	id_lectura      	BIGSERIAL PRIMARY KEY,
	fecha_hora      	TIMESTAMP  	NOT NULL,
	id_fabrica      	INT        	NOT NULL REFERENCES fabricas(id_fabrica),
	id_linea        	INT        	NOT NULL REFERENCES lineas_produccion(id_linea),
	id_sensor       	INT        	NOT NULL REFERENCES sensores(id_sensor),
	id_filtro       	INT        	REFERENCES filtros(id_filtro),
	id_producto     	INT        	NOT NULL REFERENCES productos(id_producto),
	ppm             	NUMERIC(10,2)  NOT NULL,
	temperatura     	NUMERIC(5,2),
	humedad         	NUMERIC(5,2),
	latitud         	NUMERIC(9,6),
	longitud        	NUMERIC(9,6),
	id_clasificacion_ppm INT       	NOT NULL REFERENCES clasificacion_ppm(id_clasificacion_ppm),
	alarma_activa   	BOOLEAN    	DEFAULT FALSE,
	origen          	VARCHAR(20)	DEFAULT 'local'
);
