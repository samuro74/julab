# 🚀 Contenedor Docker con JupyterLab en Español

Este proyecto proporciona un contenedor **Docker** preconfigurado con **JupyterLab en español** y un conjunto de librerías de ciencia de datos, machine learning y procesamiento de texto.  
El entorno incluye soporte para **PySpark** (Java), configuración de contraseña fija y volúmenes persistentes para que no pierdas tu trabajo entre sesiones.

---

## ✨ Características principales

- 🖥️ **JupyterLab en Español** (con `jupyterlab-language-pack-es-ES`).
- 🔑 **Acceso con contraseña fija** (`admin123`).
- 💾 **Volumen persistente** para guardar notebooks y datos entre reinicios.
- ⚡ **Librerías incluidas**:
  - Manipulación de datos: `numpy`, `pandas`, `scipy`, `statsmodels`.
  - Machine Learning: `scikit-learn`, `catboost`, `lightgbm`, `pycaret`, `tensorflow-cpu`, `optuna`.
  - Visualización: `matplotlib`, `seaborn`, `plotly`.
  - NLP: `nltk`.
  - Big Data: `pyspark`, `findspark`.
  - Manejo de PDFs: `pdfplumber`.
  - Entorno Jupyter: `jupyterlab`, `ipykernel`.

---

## 📂 Estructura del repositorio

```
.
├── Dockerfile
├── docker-compose.yml
├── requirements.txt  (opcional)
├── data/             (volumen persistente de notebooks y datasets)
└── README.md
```

---

## 🚀 Instrucciones de uso

### 1. Clonar el repositorio
```bash
git clone https://github.com/tuusuario/jupyterlab-es.git
cd jupyterlab-es
```

### 2. Crear carpeta para tus notebooks
```bash
mkdir data
```

### 3. Construir la imagen
```bash
docker-compose build
```

### 4. Levantar el contenedor
```bash
docker-compose up -d
```

> El flag `-d` hace que el servicio corra en segundo plano.

---

## 🔑 Acceso a JupyterLab

1. Abre tu navegador en:  
   👉 [http://localhost:8888](http://localhost:8888)  
2. Ingresa la contraseña fija:  
   ```
   admin123
   ```

---

## 📌 Volúmenes persistentes

- Todos los notebooks y datasets que guardes en `/workspace` dentro del contenedor se almacenan en la carpeta `./data` en tu máquina host.
- Esto asegura que no se pierda tu trabajo al reiniciar o recrear el contenedor.

---

## 🌍 Idioma Español

El contenedor incluye la extensión `jupyterlab-language-pack-es-ES` y está configurado para **arrancar siempre en español**.  
Además, si montas un volumen en `~/.jupyter`, puedes guardar configuraciones personalizadas (como idioma, tema, atajos de teclado).

---

## ⚙️ Comandos útiles

- Ver logs del contenedor:
  ```bash
  docker logs -f jupyterlab_es
  ```

- Reiniciar servicio:
  ```bash
  docker-compose restart
  ```

- Detener contenedor:
  ```bash
  docker-compose down
  ```

- Entrar al contenedor:
  ```bash
  docker exec -it jupyterlab_es bash
  ```

---

## 🛠️ Requisitos

- [Docker](https://docs.docker.com/get-docker/)  
- [Docker Compose](https://docs.docker.com/compose/)

---

## 🤝 Contribuciones

¡Las contribuciones son bienvenidas!  
Puedes enviar un **pull request** o abrir un **issue** con sugerencias o mejoras.

---

## 📜 Licencia

Este proyecto está bajo la licencia MIT. Puedes usarlo, modificarlo y compartirlo libremente.
