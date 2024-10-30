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

# Устанавливаем директорию для исходного кода OpenCV
WORKDIR /opencv_build

# Клонируем репозиторий OpenCV с GitHub
RUN git clone --branch 4.x https://github.com/opencv/opencv.git
RUN git clone --branch 4.x https://github.com/opencv/opencv_contrib.git

# Создаем директорию для сборки
RUN mkdir -p opencv/build

WORKDIR /opencv_build/opencv/build

# Сборка OpenCV с дополнительными модулями из opencv_contrib
RUN cmake -D CMAKE_BUILD_TYPE=RELEASE \
          -D CMAKE_INSTALL_PREFIX=/usr/local \
          -D OPENCV_EXTRA_MODULES_PATH=/opencv_build/opencv_contrib/modules \
          -D WITH_TBB=ON \
          -D WITH_V4L=ON \
          -D WITH_QT=OFF \
          -D WITH_OPENGL=ON \
          -D BUILD_EXAMPLES=OFF \
          .. && \
    make -j$(nproc) && \
    make install && \
    ldconfig

# Удаляем исходники после сборки для уменьшения размера образа
RUN rm -rf /opencv_build

# Копируем файлы проекта в контейнер
WORKDIR /app
COPY . .

# Устанавливаем зависимости Python
RUN pip install numpy

# Команда для запуска скрипта
CMD ["python", "app.py"]
