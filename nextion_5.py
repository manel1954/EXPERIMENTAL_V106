# -*- coding: utf-8 -*-
import tkinter as tk
import serial
import threading
import re
from colorama import Fore, Back, Style

# Inicializar colorama para colores en la consola
from colorama import init
init()

# Puerto serie virtual donde MMDVMHost enviará los comandos
SERIAL_PORT = "/dev/virtual2"  # Asegúrate de que coincida con el puerto de socat
BAUD_RATE = 9600

# Configuración de la ventana de Tkinter
root = tk.Tk()
root.title("Monitor de Comandos de MMDVMHost - Nextion")
root.geometry("350x210+20+400")  # Posiciona la ventana a 100px desde la izqu
#root.geometry("300x200")
root.configure(bg="#483d8b")  # Fondo negro para la ventana

# Crear widgets para mostrar datos
labels = {
    #"Fecha y Hora": tk.Label(root, text="Fecha y Hora: --/--/-- --:--:--", fg="white", bg="#483d8b", anchor="w"),
    "Hotspot": tk.Label(root, text="Hotspot: N/A", fg="#ff8c00", bg="#483d8b", anchor="w", font=("Arial", 16, "bold")),
    "": tk.Label(root, text="Indicativo", fg="white", bg="#483d8b", anchor="w", font=("Arial", 20, "bold")),  
    "Frecuencia": tk.Label(root, text="Frecuencia: N/A", fg="#ff8c00", bg="#483d8b", anchor="w", font=("Arial", 12, "bold")),
    "IP": tk.Label(root, text="IP: N/A", fg="#ff0", bg="#483d8b", anchor="w"),
    "Temperatura": tk.Label(root, text="Temperatura: N/A", fg="yellow", bg="#483d8b", anchor="w", font=("Arial", 12, "bold")),
    #"TG": tk.Label(root, text="TG: N/A", fg="white", bg="#483d8b", anchor="w"),
    "Estado": tk.Label(root, text="Estado: N/A", fg="white", bg="#483d8b", anchor="w",font=("Arial", 16, "bold")),
   
}

for idx, label in enumerate(labels.values()):
    label.pack(fill="x", padx=10, pady=2)

# Botón para salir de la aplicación
#exit_button = tk.Button(root, text="Salir", command=root.quit, bg="green", fg="white", font=("Arial", 12, "bold"))
#exit_button.pack(pady=10)

# Función para actualizar etiquetas en la GUI
def update_label(field, value):
    if field in labels:
        labels[field].config(text=f"{field}: {value}")

# Función para leer los datos del puerto serie
def read_data():
    try:
        # Abre el puerto serie para leer los datos
        with serial.Serial(SERIAL_PORT, BAUD_RATE, timeout=1) as ser:
            while True:
                # Lee los datos del puerto serie
                data = ser.readline()
                if data:
                    data_str = data.decode('utf-8', errors='ignore')  # Decodificar los datos
                    print(Fore.WHITE + Back.BLACK + f"Datos recibidos: {data_str}" + Style.RESET_ALL)  # Fondo negro
                    parsed_data = parse_data(data_str)
                    for key, value in parsed_data.items():
                        root.after(0, update_label, key, value)

    except serial.SerialException as e:
        print(Fore.RED + Back.BLACK + f"Error al conectar con el puerto: {e}" + Style.RESET_ALL)
    except Exception as e:
        print(Fore.RED + Back.BLACK + f"Error desconocido: {e}" + Style.RESET_ALL)

def parse_data(data_str):
    """
    Función para procesar y ordenar los datos de acuerdo con el formato esperado.
    Extrae la fecha, indicativo, frecuencia, IP y otros campos de los comandos.
    """
    result = {}

    # Buscar las distintas partes de los comandos usando expresiones regulares
    #date_match = re.search(r't2.txt="([0-9/ :]+)"', data_str)
    #if date_match:
    #    result["Fecha y Hora"] = date_match.group(1)

    hotspot_match = re.search(r'20t0.txt="([^"]+)"', data_str)
    if hotspot_match:
        result["Hotspot"] = hotspot_match.group(1)
    
    indicativo_match = re.search(r'50t2.txt="([^"]+)"', data_str)
    if indicativo_match:
        result[""] = indicativo_match.group(1)

    freq_match = re.search(r'1t32.txt="([^"]+)"', data_str)
    if freq_match:
        result["Frecuencia"] = freq_match.group(1)

    ip_match = re.search(r't3.txt="([^"]+)"', data_str)
    if ip_match:
        result["IP"] = ip_match.group(1)

    temp_match = re.search(r'1t20.txt="([^"]+)"', data_str)
    if temp_match:
        result["Temperatura"] = temp_match.group(1)

    #tg_match = re.search(r'1t10.txt="([^"]+)"', data_str)
    #if tg_match:
    #    result["TG"] = tg_match.group(1)

    status_match = re.search(r'1t0.txt="([^"]+)"', data_str)
    if status_match:
        result["Estado"] = status_match.group(1)

    return result

# Crear un hilo para la lectura de los datos
read_thread = threading.Thread(target=read_data, daemon=True)
read_thread.start()

# Ejecutar la interfaz gráfica de Tkinter
root.mainloop()
