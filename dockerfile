FROM python:3.10-slim-bookworm

# Variables de entorno
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=es_CO.UTF-8 \
    LC_ALL=es_CO.UTF-8 \
    PYTHONUNBUFFERED=1

# Actualizar pip
RUN pip install --upgrade pip

# Instalar dependencias del sistema, incluyendo tesseract-ocr y poppler-utils
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

# Configurar locale en español
RUN sed -i '/es_CO.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen

# Crear directorio de trabajo
WORKDIR /workspace

# Instalar JupyterLab, librerías requeridas y librerías OCR para Python
RUN pip install --no-cache-dir \
    catboost \
    findspark \
	ipyflow \
    ipykernel \
    jupyterlab \
    jupyterlab-language-pack-es-ES \
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

# Configurar password fijo para Jupyter
RUN mkdir -p /root/.jupyter && \
    python3 -c "from jupyter_server.auth import passwd; \
    open('/root/.jupyter/jupyter_server_config.json','w').write('{\"ServerApp\": {\"password\": \"' + passwd(\"admin123\") + '\"}}')"

# Configurar JupyterLab en español por defecto (persistente)
RUN mkdir -p /root/.jupyter/lab/user-settings/@jupyterlab/translation-extension && \
    echo '{ "locale": "es" }' > /root/.jupyter/lab/user-settings/@jupyterlab/translation-extension/plugin.jupyterlab-settings

# Exponer puerto de Jupyter
EXPOSE 8888

# Comando por defecto: ejecutar JupyterLab en español
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--ServerApp.i18n_language=es"]
