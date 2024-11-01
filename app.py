import cv2
import sys

def detect_faces(image_path):
    # Загружаем изображение
    img = cv2.imread(image_path)

    # Загружаем классификатор для лиц
    face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')

    # Преобразуем изображение в оттенки серого
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

    # Ищем лица на изображении
    faces = face_cascade.detectMultiScale(gray, 1.1, 4)

    # Проверяем, найдены ли лица
    if len(faces) == 0:
        print("Лица не найдены.")
    else:
        print(f"Найдено {len(faces)} лицо(ев):")
        for (x, y, w, h) in faces:
            print(f"Лицо найдено на координатах X:{x} Y:{y} ширина:{w} высота:{h}")

if __name__ == '__main__':
    # Получаем путь до изображения
    if len(sys.argv) > 1:
        image_path = sys.argv[1]
    else:
        image_path = 'image.jpg'  # файл по умолчанию

    detect_faces(image_path)
