# -*- coding: utf-8 -*-
import tkinter as tk
import serial
import re
from colorama import Fore, Back, Style, init

# Inicializar colorama para colores en la consola
init()

# Configuración de puerto serie
SERIAL_PORT = "/dev/virtual2"  # Ajusta para que coincida con el puerto de socat
BAUD_RATE = 9600

# Configuración de la ventana de Tkinter
WINDOW_TITLE = "Monitor MMDVMHost - Nextion"
WINDOW_SIZE = "480x250+13+372"  # Dimensiones fijas
WINDOW_BG_COLOR = "#152637"

# Crear ventana principal
root = tk.Tk()
root.title(WINDOW_TITLE)
root.geometry(WINDOW_SIZE)
root.configure(bg=WINDOW_BG_COLOR)

# Asegurar que la ventana no cambie de tamaño
root.resizable(False, False)

# Configuración de las columnas para que se distribuyan equitativamente
root.columnconfigure(0, weight=1, uniform="equal")
root.columnconfigure(1, weight=1, uniform="equal")

# Fijar la fila de la estación sin que se vea afectada por las otras filas
root.rowconfigure(0, weight=0)

# Diccionario de configuración de etiquetas con colores modificados para "Frecuencia RX" y "Frecuencia TX"
LABEL_CONFIGS = {
    "Frecuencia RX": {"fg": "green", "font": ("Arial", 12, "bold"), "row": 2, "column": 0},
    "Frecuencia TX": {"fg": "pink", "font": ("Arial", 12, "bold"), "row": 2, "column": 1},
    "IP": {"fg": "white", "font": ("Arial", 12, "bold"), "row": 3, "column": 0},
    "Estado": {"fg": "white", "font": ("Arial", 12, "bold"), "row": 3, "column": 1},
    "Ber": {"fg": "yellow", "font": ("Arial", 12, "bold"), "row": 4, "column": 0},
    "RSSI": {"fg": "yellow", "font": ("Arial", 12, "bold"), "row": 4, "column": 1},
    "Temp": {"fg": "#ff5722", "font": ("Arial", 12, "bold"), "row": 5, "column": 0},
    
}

# Contenedor de etiquetas
labels = {}

# Crear la etiqueta "Estación" en una fila separada (sin que se vea afectada por las demás columnas)
estacion_label = tk.Label(root, text="Estación: N/A", bg=WINDOW_BG_COLOR, fg="#00adb5", font=("Arial", 24, "bold"))
estacion_label.grid(row=0, column=0, columnspan=2, padx=10, pady=5, sticky="w")

# Crear la etiqueta "TX/RX" debajo de la estación, en una nueva fila
txrx_label = tk.Label(root, text="TX/RX: N/A", bg=WINDOW_BG_COLOR, fg="white", font=("Arial", 20, "bold"))
txrx_label.grid(row=1, column=0, columnspan=2, padx=10, pady=5, sticky="w")

# Agregar las otras etiquetas a la cuadrícula, comenzando desde la fila 2
for label_name, config in LABEL_CONFIGS.items():
    label = tk.Label(root, text=f"{label_name}: N/A", bg=WINDOW_BG_COLOR, anchor="w", fg=config["fg"], font=config["font"])
    label.grid(row=config["row"], column=config["column"], padx=10, pady=5, sticky="w")
    labels[label_name] = label

# Abre el puerto serie una vez
try:
    ser = serial.Serial(SERIAL_PORT, BAUD_RATE, timeout=1)
except serial.SerialException as e:
    print(Fore.RED + Back.BLACK + f"Error al conectar con el puerto: {e}" + Style.RESET_ALL)
    ser = None

# Función para actualizar etiquetas en la GUI solo si el valor cambió
def update_label(field, value):
    if field in labels and labels[field].cget("text") != f"{field}: {value}":
        labels[field].config(text=f"{field}: {value}")

# Función para actualizar la etiqueta "Estación" directamente
def update_estacion(value):
    if estacion_label.cget("text") != f"Estación: {value}":
        estacion_label.config(text=f"Estación: {value}")

# Función para actualizar la etiqueta "TX/RX" directamente
def update_txrx(value):
    if txrx_label.cget("text") != f"TX/RX: {value}":
        txrx_label.config(text=f"TX/RX: {value}")

# Función para leer y actualizar datos del puerto serie
def read_data():
    if ser and ser.in_waiting > 0:
        data = ser.readline()
        if data:
            data_str = data.decode('utf-8', errors='ignore')
            
            # Mostrar todos los datos recibidos en la terminal
            print(Fore.WHITE + Back.BLACK + f"Trafico del puerto serie: {data_str.strip()}" + Style.RESET_ALL)
            
            # Procesar los datos para extraer los campos relevantes
            parsed_data = parse_data(data_str)
            
            # Mostrar los datos procesados de forma ordenada
            print_formatted_data(parsed_data)
            
            # Actualizar los valores en la interfaz gráfica
            for key, value in parsed_data.items():
                update_label(key, value)
            
            # Actualizar la etiqueta "Estación" con el valor correspondiente
            if "Estación" in parsed_data:
                update_estacion(parsed_data["Estación"])
            
            # Actualizar la etiqueta "TX/RX" con el valor correspondiente
            if "TX/RX" in parsed_data:
                update_txrx(parsed_data["TX/RX"])
    
    root.after(100, read_data)  # Llama a read_data de nuevo después de 100 ms

# Función para procesar y extraer datos del string recibido
def parse_data(data_str):
    result = {}
    match_patterns = {
        "Estación": r'20t0.txt="([^"]+)"',
        "Frecuencia RX": r'1t30.txt="([^"]+)"',
        "Frecuencia TX": r'1t32.txt="([^"]+)"',
        "TX/RX": r'50t2.txt="([^"]+)"',
        "IP": r'1t3.txt="([^"]+)"',
        "Estado": r'1t0.txt="([^"]+)"',
        "Ber": r'1t7.txt="([^"]+)"',
        "RSSI": r'1t5.txt="([^"]+)"',
        "Temp": r'1t20.txt="([^"]+)"',
    }

    for key, pattern in match_patterns.items():
        match = re.search(pattern, data_str)
        if match:
            result[key] = match.group(1)

    return result

# Función para imprimir los datos de forma organizada en la terminal
def print_formatted_data(parsed_data):
    print(Fore.WHITE + Back.BLACK + "Datos recibidos:" + Style.RESET_ALL)
    print(f"{'Campo':<15} {'Valor'}")
    print("-" * 30)
    for key, value in parsed_data.items():
        print(f"{key:<15}: {value}")

# Iniciar la lectura de datos
read_data()

# Ejecutar la interfaz gráfica de Tkinter
root.mainloop()
