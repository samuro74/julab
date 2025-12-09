# Configuración de JupyterLab para evitar el uso de papelera de reciclaje
# Al eliminar archivos desde la interfaz web de Jupyter, se borran directamente
# sin pasar por la papelera (trash).

c = get_config()  #noqa

# Desactivar el envío de archivos a la papelera al borrarlos
c.FileContentsManager.delete_to_trash = False
