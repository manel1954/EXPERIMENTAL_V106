# -*- coding: utf-8 -*-
import serial
import re
import time
from flask import Flask, render_template
from threading import Thread

app = Flask(__name__)

# Configuración del puerto serie
SERIAL_PORT = "/dev/virtual10"  # Cambia según tu configuración
BAUD_RATE = 9600

# Datos globales
global_data = {
    "Fecha y Hora": "N/A",
    "Estación": "N/A",
    "Frecuencia RX": "N/A",
    "Frecuencia TX": "N/A",
    "IP": "N/A",
    "Estado": "N/A",
    "Ber": "N/A",
    "LH": "N/A",
    "RSSI": "N/A",
    "Temp": "N/A",
    "TG": "N/A",
}

# Abre el puerto serie
try:
    ser = serial.Serial(SERIAL_PORT, BAUD_RATE, timeout=1)
    print(f"Conexión exitosa al puerto serie {SERIAL_PORT}")
except serial.SerialException as e:
    print(f"Error al conectar con el puerto serie: {e}")
    ser = None

# Leer datos del puerto serie
def read_serial_data():
    if ser and ser.in_waiting > 0:
        try:
            data = ser.read(ser.in_waiting).decode('utf-8', errors='ignore')
            return data
        except Exception as e:
            print(f"Error leyendo datos del puerto serie: {e}")
    return ""

# Parsear datos del puerto serie
def parse_data(data_str):
    patterns = {
        "Fecha y Hora": r't2.txt="([^"]+)"',
        "Estación": r'20t0.txt="([^"]+)"',
        "Frecuencia RX": r'\b1t30.txt="([^"]+)"\b',
        "Frecuencia TX": r'\b1t32.txt="([^"]+)"\b',
        "IP": r'\b1t3.txt="([^"]+)"\b',
        "Estado": r'\b1t0.txt="([^"]+)"\b',
        "Ber": r't[47]\.txt="([^"]+)"',
        "LH": r'50t[02]\.txt="([^"]+)"',
        "RSSI": r't[35]\.txt="([^"]+)"',
        "Temp": r'\b1t20.txt="([^"]+)"\b',
        "TG": r'\b1t[13]\.txt="([^"]+)"\b',
    }

    parsed = {}
    for key, pattern in patterns.items():
        match = re.search(pattern, data_str)
        if match:
            parsed[key] = match.group(1)
    return parsed

# Actualizar datos globales
def update_global_data(parsed_data):
    for key, value in parsed_data.items():
        global_data[key] = value

# Hilo para leer datos en segundo plano
def serial_thread():
    while True:
        data_str = read_serial_data()
        if data_str:
            print(f"Datos recibidos del puerto serie: {data_str}")
            parsed_data = parse_data(data_str)
            update_global_data(parsed_data)
        time.sleep(1)

# Ruta principal de Flask
@app.route('/')
def index():
    return render_template('index.html', data=global_data)

if __name__ == '__main__':
    # Inicia el hilo de lectura del puerto serie
    thread = Thread(target=serial_thread, daemon=True)
    thread.start()

    # Inicia el servidor Flask
    app.run(debug=True, port=5000)
