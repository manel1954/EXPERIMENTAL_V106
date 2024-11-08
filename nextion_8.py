# -*- coding: utf-8 -*-
import tkinter as tk
import serial
import threading
import re
from colorama import Fore, Back, Style, init

# Inicializar colorama para colores en la consola
init()

# Configuración de puerto serie
SERIAL_PORT = "/dev/virtual2"  # Ajusta para que coincida con el puerto de socat
BAUD_RATE = 9600

# Configuración de la ventana de Tkinter
WINDOW_TITLE = "Monitor MMDVMHost - Nextion"
WINDOW_SIZE = "480x340+25+55"  # Tamaño y posición específica de la ventana
WINDOW_BG_COLOR = "#303841"  # Fondo oscuro

# Crear ventana principal
root = tk.Tk()
root.title(WINDOW_TITLE)
root.geometry(WINDOW_SIZE)  # Restablece la posición de la ventana
root.configure(bg=WINDOW_BG_COLOR)

# Icono de ventana (si tienes un archivo .ico)
# root.iconbitmap("icono.ico")  # Reemplaza "icono.ico" con la ruta del archivo de icono

# Diccionario de configuración de etiquetas para un estilo uniforme
LABEL_CONFIGS = {
    "Estación": {"fg": "#00adb5", "font": ("Arial", 16, "bold")},
    "Frecuencia": {"fg": "#00adb5", "font": ("Arial", 16, "bold")},
    "TX/RX": {"fg": "white", "font": ("Arial", 16, "bold")},
    "IP": {"fg": "#eeeeee", "font": ("Arial", 12, "bold")},
    "MMDVM": {"fg": "#eeeeee", "font": ("Arial", 12, "normal")},
    "Estado": {"fg": "white", "font": ("Arial", 16, "bold")},
    "Temperatura": {"fg": "#ff5722", "font": ("Arial", 14, "bold")},
    "Ber": {"fg": "#ffdd59", "font": ("Arial", 16, "bold")},
}

# Contenedor de etiquetas
labels = {}
for label_name, config in LABEL_CONFIGS.items():
    frame = tk.Frame(root, bg=WINDOW_BG_COLOR, pady=5)
    frame.pack(fill="x", padx=10, pady=2)
    label = tk.Label(frame, text=f"{label_name}: N/A", bg=WINDOW_BG_COLOR, anchor="w", **config)
    label.pack(side="left", padx=10)
    labels[label_name] = label

# Función para actualizar etiquetas en la GUI
def update_label(field, value):
    if field in labels:
        labels[field].config(text=f"{field}: {value}")

# Función para leer y actualizar datos de manera no bloqueante
def read_data_non_blocking():
    try:
        # Abre el puerto serie
        ser = serial.Serial(SERIAL_PORT, BAUD_RATE, timeout=1)
    except serial.SerialException as e:
        print(Fore.RED + Back.BLACK + f"Error al conectar con el puerto: {e}" + Style.RESET_ALL)
        return

    def poll_serial():
        """Función que se ejecuta periódicamente para leer del puerto serie."""
        if ser.in_waiting > 0:
            data = ser.readline()
            if data:
                data_str = data.decode('utf-8', errors='ignore')
                print(Fore.WHITE + Back.BLACK + f"Datos recibidos: {data_str}" + Style.RESET_ALL)
                parsed_data = parse_data(data_str)
                for key, value in parsed_data.items():
                    update_label(key, value)
        
        # Llama de nuevo a poll_serial después de 100 ms
        root.after(100, poll_serial)
    
    # Inicia la función de polling de serie
    poll_serial()

# Función para procesar y extraer datos del string recibido
def parse_data(data_str):
    """
    Extrae información específica de los datos recibidos usando expresiones regulares.
    """
    result = {}

    match_patterns = {
        "Estación": r'20t0.txt="([^"]+)"',
        "Frecuencia": r'1t32.txt="([^"]+)"',
        "TX/RX": r'50t2.txt="([^"]+)"',
        "IP": r'20t3.txt="([^"]+)"',
        "MMDVM": r'1t1.txt="([^"]+)"',
        "Estado": r'1t0.txt="([^"]+)"',
        "Temperatura": r'1t20.txt="([^"]+)"',
        "Ber": r'1t7.txt="([^"]+)"',
    }

    for key, pattern in match_patterns.items():
        match = re.search(pattern, data_str)
        if match:
            result[key] = match.group(1)

    return result

# Iniciar hilo para la lectura de datos en modo no bloqueante
threading.Thread(target=read_data_non_blocking, daemon=True).start()

# Ejecutar la interfaz gráfica de Tkinter
root.mainloop()
