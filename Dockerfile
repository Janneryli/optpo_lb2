# Используем базовый образ с Python
FROM python:3.8-slim

# Устанавливаем зависимости для сборки
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libgtk2.0-dev \
    pkg-config \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libtbbmalloc2 \
    libtbb-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем Python-библиотеку OpenCV без графического интерфейса
RUN pip install opencv-python-headless numpy

# Копируем файлы проекта в контейнер
WORKDIR /app
COPY . .

# Команда для запуска скрипта
CMD ["python", "app.py"]
