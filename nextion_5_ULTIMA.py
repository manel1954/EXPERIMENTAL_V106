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
WINDOW_TITLE = "MMDVMHost Virtual Nextion"
WINDOW_SIZE = "480x269+8+363"  # Dimensiones fijas
WINDOW_BG_COLOR = "#152637"

# Crear ventana principal
root = tk.Tk()
root.title(WINDOW_TITLE)
root.geometry(WINDOW_SIZE)
root.configure(bg=WINDOW_BG_COLOR)


# Agregar un borde blanco de 3px alrededor de la ventana
root.config(
    bd=3,  # Border width
    highlightbackground="#1E90FF",  # Color del borde
    highlightthickness=4  # Grosor del borde
)

# Asegurar que la ventana no cambie de tamaño
root.resizable(False, False)

# Configuración de las columnas para que se distribuyan equitativamente
root.columnconfigure(0, weight=1, uniform="equal")
root.columnconfigure(1, weight=1, uniform="equal")

# Fijar la fila de la estación sin que se vea afectada por las otras filas
root.rowconfigure(0, weight=0)

# Diccionario de configuración de etiquetas
LABEL_CONFIGS = {
    "Frecuencia RX": {"fg": "#77DD77", "font": ("Arial", 12, "bold"), "row": 2, "column": 0},
    "Frecuencia TX": {"fg": "pink", "font": ("Arial", 12, "bold"), "row": 2, "column": 1},
    "IP": {"fg": "white", "font": ("Arial", 12, "bold"), "row": 3, "column": 0},
    "Estado": {"fg": "white", "font": ("Arial", 12, "bold"), "row": 3, "column": 1},
    "Ber": {"fg": "yellow", "font": ("Arial", 12, "bold"), "row": 4, "column": 0},
    "RSSI": {"fg": "yellow", "font": ("Arial", 12, "bold"), "row": 4, "column": 1},
    "Temp": {"fg": "#ff5722", "font": ("Arial", 10, "bold"), "row": 5, "column": 0},
    "TG": {"fg": "#00adb5", "font": ("Arial", 10, "bold"), "row": 5, "column": 1},
   }

# Contenedor de etiquetas
labels = {}

# Crear la etiqueta "Estación" en una fila separada (sin que se vea afectada por las demás columnas)
estacion_label = tk.Label(root, text="", bg=WINDOW_BG_COLOR, fg="#00adb5", font=("Arial", 30, "bold"))
estacion_label.grid(row=0, column=0, columnspan=2, padx=10, pady=5, sticky="nsew")

# Crear la etiqueta "TX/RX" debajo de la estación, en una nueva fila
txrx_label = tk.Label(root, text="", bg=WINDOW_BG_COLOR, fg="white", font=("Arial", 32, "bold"))
txrx_label.grid(row=1, column=0, columnspan=2, padx=10, pady=5, sticky="nsew")

# Agregar las otras etiquetas a la cuadrícula, comenzando desde la fila 2
for label_name, config in LABEL_CONFIGS.items():
    label = tk.Label(root, text=f"{label_name}: N/A", bg=WINDOW_BG_COLOR, fg=config["fg"], font=config["font"])
    label.grid(row=config["row"], column=config["column"], padx=10, pady=5, sticky="nsew")
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
    if estacion_label.cget("text") != f"{value}":
        estacion_label.config(text=f"{value}")

# Función para actualizar la etiqueta "TX/RX" directamente
def update_txrx(value):
    if txrx_label.cget("text") != f"{value}":
        txrx_label.config(text=f"{value}")

# Función para borrar la pantalla (solo "TX/RX", "Ber", "RSSI")
def clear_screen():
    txrx_label.config(text="")
    labels["Ber"].config(text="Ber: N/A")
    labels["RSSI"].config(text="RSSI: N/A")
    labels["TG"].config(text="TG: N/A")

# Función para leer y actualizar datos del puerto serie
def read_data():
    if ser and ser.in_waiting > 0:
        try:
            data = ser.read(ser.in_waiting)  # Leer todos los bytes disponibles
            data_str = data.decode('utf-8', errors='ignore')
            # Mostrar todos los datos recibidos en la terminal
            print(Fore.WHITE + Back.BLACK + f"Trafico del puerto serie: {data_str.strip()}" + Style.RESET_ALL)
        except UnicodeDecodeError as e:
            print(Fore.RED + f"Error de decodificación: {e}" + Style.RESET_ALL)
            return  # Evita continuar si hay error en la decodificación
        
        # Procesar y actualizar datos
        parsed_data = parse_data(data_str)
        print_formatted_data(parsed_data)
        
        # Borrar la pantalla si se detecta "Fecha y Hora"
        if "Fecha y Hora" in parsed_data:
            clear_screen()
        
        # Si se detecta "Fecha y Hora", actualizar el label de TX/RX con la fecha y hora
        if "Fecha y Hora" in parsed_data:
            update_txrx(parsed_data["Fecha y Hora"])
        
        for key, value in parsed_data.items():
            update_label(key, value)
        if "Estación" in parsed_data:
            update_estacion(parsed_data["Estación"])
    
    root.after(100, read_data)  # Llama a read_data de nuevo después de 100 ms

# Función para procesar y extraer datos del string recibido
def parse_data(data_str):
    result = {}
    match_patterns = {
        "Fecha y Hora": r't2.txt="([^"]+)"',
        "Estación": r'20t0.txt="([^"]+)"',
        "TX/RX": r'50t2.txt="([^"]+)"',
        "Frecuencia RX": r'1t30.txt="([^"]+)"',
        "Frecuencia TX": r'1t32.txt="([^"]+)"',
        "IP": r'1t3.txt="([^"]+)"',
        "Estado": r'1t0.txt="([^"]+)"',
        "Ber": r't7.txt="([^"]+)"',
        "RSSI": r't5.txt="([^"]+)"',
        "Temp": r'1t20.txt="([^"]+)"',
        "TG": r'1t3.txt="([^"]+)"',
    }

    for key, pattern in match_patterns.items():
        match = re.search(pattern, data_str)
        if match:
            value = match.group(1)

            # Solo añadir el valor de RSSI si contiene un guion (-)
            if key == "RSSI" and '-' not in value:
                continue  # Si no tiene el guion, no lo añadimos al resultado

            # Solo añadir el valor de IP si contiene ':'
            if key == "IP" and ':' not in value:
                continue  # Si no tiene dos puntos, no lo añadimos al resultado
                
            # Solo añadir el valor de TG si contiene ':'
            if key == "TG" and 'TG' not in value:
                continue  # Si no tiene TG, no lo añadimos al resultado

            result[key] = value  # Añadir el valor al resultado solo si cumple las condiciones

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
