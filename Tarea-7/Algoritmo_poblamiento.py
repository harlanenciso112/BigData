import csv
import random
from datetime import datetime, timedelta

import psycopg2
from psycopg2 import Error

DB_HOST = "localhost"
DB_PORT = "5432"
DB_NAME = "monitoreo-produccion"
DB_USER = "postgres"
DB_PASSWORD = "postgres"   # ajustar según instalación

def clasificar_ppm(ppm):
    if ppm < 1.0:
        return 1, "Normal", False
    elif ppm < 5.0:
        return 2, "Riesgo", True
    else:
        return 3, "Crítico", True

def generar_lecturas(num_registros=100):
    lecturas = []
    fecha_base = datetime(2025, 11, 22).date()
    hora_base = datetime.strptime("08:00:00", "%H:%M:%S")

    for i in range(1, num_registros + 1):
        hora_actual = (hora_base + timedelta(seconds=10 * (i - 1))).time()
        fecha_hora = datetime.combine(fecha_base, hora_actual)

        ppm = round(random.uniform(0.1, 15.0), 1)
        temperatura = round(random.uniform(20.0, 35.0), 1)
        humedad = round(random.uniform(30.0, 80.0), 1)
        latitud = round(6.250 + random.uniform(-0.01, 0.01), 6)
        longitud = round(-75.565 + random.uniform(-0.01, 0.01), 6)

        id_clasif, estado_texto, alarma = clasificar_ppm(ppm)

        lectura = {
            "id_lectura": i,
            "fecha": fecha_base,
            "hora": hora_actual,
            "fecha_hora": fecha_hora,
            "ppm": ppm,
            "temperatura": temperatura,
            "humedad": humedad,
            "latitud": latitud,
            "longitud": longitud,
            "id_fabrica": 1,
            "id_linea": 1,
            "id_sensor": 1,
            "id_filtro": 1,
            "id_producto": 1,
            "id_clasificacion_ppm": id_clasif,
            "estado_ppm": estado_texto,
            "alarma_activa": alarma,
            "origen": "simulado"
        }
        lecturas.append(lectura)
    return lecturas

def guardar_csv(lecturas, nombre_archivo="lecturas-sensor-A1S01.csv"):
    fieldnames = [
        "id_lectura","fecha","hora","ppm","id_sensor","id_micro",
        "linea","fabrica","latitud","longitud","estado_ppm","filtro_cercano"
    ]
    with open(nombre_archivo, mode="w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        for l in lecturas:
            fila = {
                "id_lectura": l["id_lectura"],
                "fecha": l["fecha"].strftime("%Y-%m-%d"),
                "hora": l["hora"].strftime("%H:%M:%S"),
                "ppm": l["ppm"],
                "id_sensor": "A1S01",
                "id_micro": "A1M01",
                "linea": "A1",
                "fabrica": "A",
                "latitud": l["latitud"],
                "longitud": l["longitud"],
                "estado_ppm": l["estado_ppm"],
                "filtro_cercano": "F-A1-01"
            }
            writer.writerow(fila)
    print(f"Archivo CSV generado: {nombre_archivo}")

def insertar_en_bd(lecturas):
    try:
        conn = psycopg2.connect(
            host=DB_HOST, port=DB_PORT, dbname=DB_NAME,
            user=DB_USER, password=DB_PASSWORD
        )
        cur = conn.cursor()
        insert_query = """
            INSERT INTO lecturas
            (id_lectura, fecha_hora, id_fabrica, id_linea, id_sensor,
             id_filtro, id_producto, ppm, temperatura, humedad,
             latitud, longitud, id_clasificacion_ppm, alarma_activa, origen)
            VALUES
            (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s);
        """
        for l in lecturas:
            cur.execute(insert_query, (
                l["id_lectura"], l["fecha_hora"], l["id_fabrica"],
                l["id_linea"], l["id_sensor"], l["id_filtro"],
                l["id_producto"], l["ppm"], l["temperatura"],
                l["humedad"], l["latitud"], l["longitud"],
                l["id_clasificacion_ppm"], l["alarma_activa"], l["origen"]
            ))
        conn.commit()
        print(f"{len(lecturas)} lecturas insertadas en la tabla 'lecturas'.")
    except (Exception, Error) as error:
        print("Error al insertar en la BD:", error)
    finally:
        if conn:
            cur.close()
            conn.close()

if __name__ == "__main__":
    lecturas = generar_lecturas(num_registros=100)
    guardar_csv(lecturas, "lecturas-sensor-A1S01.csv")
    insertar_en_bd(lecturas)
