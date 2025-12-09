FROM python:3.10-slim-bookworm

# Variables de entorno
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=es_CO.UTF-8 \
    LC_ALL=es_CO.UTF-8 \
    PYTHONUNBUFFERED=1

# Actualizar pip
RUN pip install --upgrade pip

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y --no-install-recommends \
    locales \
    openjdk-17-jdk-headless \
    build-essential \
    curl \
    git \
    tesseract-ocr \
    tesseract-ocr-spa \
    poppler-utils \
    && rm -rf /var/lib/apt/lists/*

# Configurar locale español
RUN sed -i '/es_CO.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen

# Directorio de trabajo
WORKDIR /workspace

# Instalar librerías (ipyflow removido)
RUN pip install --no-cache-dir \
    catboost \
    findspark \
    ipykernel \
    jupyterlab \
    jupyterlab-language-pack-es-ES \
    jupyterlab-spreadsheet-editor \
    jupyterlab-spreadsheet \
    jupytext \
    lightgbm \
    lxml \
    matplotlib \
    nltk \
    numpy \
    openpyxl \
    optuna \
    pandas \
    pdfplumber \
    plotly \
    pycaret \
    pyspark \
    scikit-learn \
    scipy \
    seaborn \
    statsmodels \
    tensorflow-cpu \
    xlsxwriter \
    pytesseract \
    pdf2image

# Configurar password usando nuevo estándar de Jupyter Server 2.x
RUN mkdir -p /root/.jupyter && \
    python3 - <<EOF
from jupyter_server.auth import passwd
import json

hashed = passwd("admin123")  # Contraseña
config = {
    "IdentityProvider": {
        "hashed_password": hashed
    }
}

with open("/root/.jupyter/jupyter_server_config.json", "w") as f:
    json.dump(config, f, indent=2)
EOF

# Configurar idioma español (JupyterLab 4.x usa apputils-extension)
RUN mkdir -p /root/.jupyter/lab/user-settings/@jupyterlab/apputils-extension && \
    echo '{ "locale": "es" }' > \
    /root/.jupyter/lab/user-settings/@jupyterlab/apputils-extension/themes.json

# Desactivar papelera (delete directo) — JupyterLab 4.x usa filebrowser-extension
RUN mkdir -p /root/.jupyter/lab/user-settings/@jupyterlab/filebrowser-extension && \
    echo '{ "useTrash": false }' > \
    /root/.jupyter/lab/user-settings/@jupyterlab/filebrowser-extension/browser.json

# Exponer puerto
EXPOSE 8888

# Comando para ejecutar JupyterLab sin parámetros obsoletos
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--ContentsManager.delete_to_trash=False"]
