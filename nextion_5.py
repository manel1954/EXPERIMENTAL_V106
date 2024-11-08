# -*- coding: utf-8 -*-
import tkinter as tk
import serial
import threading
import re
from queue import Queue
from colorama import Fore, Style, init

# Inicializar colorama para colores en la consola
init()

# Configuración del puerto serie
SERIAL_PORT = "/dev/virtual2"  # Cambia esto según tu sistema
BAUD_RATE = 9600

# Configuración de la ventana de Tkinter
root = tk.Tk()
root.title("Monitor MMDVMHost - Nextion")
root.geometry("350x250+13+372")
root.configure(bg="#152637")

# Crear widgets para mostrar datos
labels = {
    "Estacion": tk.Label(root, text="Estacion: N/A", fg="#ff8c00", font=("Arial", 16, "bold"), anchor="w"),
    "Frecuencia": tk.Label(root, text="Frecuencia: N/A", fg="#ff8c00", font=("Arial", 16, "bold"), anchor="w"),
    "Temperatura": tk.Label(root, text="Temperatura: N/A", fg="yellow", font=("Arial", 12, "bold"), anchor="w"),
    "TX/RX": tk.Label(root, text="TX/RX: N/A", fg="white", bg="#483d8b", font=("Arial", 16, "bold"), anchor="w"),
    "IP": tk.Label(root, text="IP: N/A", fg="#ff0", bg="#483d8b", font=("Arial", 12, "bold"), anchor="w"),
    "Estado": tk.Label(root, text="Estado: N/A", fg="white", bg="#483d8b", font=("Arial", 16, "bold"), anchor="w"),
    "Ber": tk.Label(root, text="Ber: N/A", fg="#ff8c00", bg="#483d8b", font=("Arial", 12, "bold"), anchor="w"),
    "MMDVM": tk.Label(root, text="MMDVM: N/A", fg="#ff8c00", bg="#483d8b", font=("Arial", 16, "bold"), anchor="w"),
}

for label in labels.values():
    label.pack(fill="x", padx=10, pady=2, anchor="w")  # Alinear las etiquetas a la izquierda

# Cola para comunicar datos entre hilos
data_queue = Queue()

# Función para actualizar etiquetas en la GUI
def update_label(field, value):
    if field in labels:
        labels[field].config(text=f"{field}: {value}")

# Función para procesar los datos recibidos
def parse_data(data_str):
    result = {}
    
    # Expresiones regulares para extraer datos
    patterns = {
        "Estacion": r'20t0.txt="([^"]+)"',
        "TX/RX": r'50t2.txt="([^"]+)"',
        "Frecuencia": r'1t32.txt="([^"]+)"',
        "IP": r'20t3.txt="([^"]+)"',
        "Temperatura": r'1t20.txt="([^"]+)"',
        "Estado": r'1t0.txt="([^"]+)"',
        "Ber": r'1t7.txt="([^"]+)"',
        "MMDVM": r'1t1.txt="([^"]+)"',
    }
    
    for key, pattern in patterns.items():
        match = re.search(pattern, data_str)
        if match:
            result[key] = match.group(1)

    return result

# Función para leer los datos del puerto serie en un hilo separado
def read_data():
    try:
        with serial.Serial(SERIAL_PORT, BAUD_RATE, timeout=1) as ser:
            while True:
                data = ser.readline()
                if data:
                    data_str = data.decode('utf-8', errors='ignore')
                    print(Fore.WHITE + f"Datos recibidos: {data_str}" + Style.RESET_ALL)
                    parsed_data = parse_data(data_str)
                    data_queue.put(parsed_data)  # Colocar los datos en la cola
    except serial.SerialException as e:
        print(Fore.RED + f"Error al conectar con el puerto: {e}" + Style.RESET_ALL)
    except Exception as e:
        print(Fore.RED + f"Error desconocido: {e}" + Style.RESET_ALL)

# Función para sincronizar datos con la GUI
def sync_data():
    while not data_queue.empty():
        parsed_data = data_queue.get()
        for key, value in parsed_data.items():
            update_label(key, value)
    root.after(100, sync_data)  # Llamar de nuevo tras 100 ms

# Crear un hilo para la lectura de los datos
read_thread = threading.Thread(target=read_data, daemon=True)
read_thread.start()

# Iniciar sincronización de datos en la GUI
sync_data()

# Ejecutar la interfaz gráfica
root.mainloop()
