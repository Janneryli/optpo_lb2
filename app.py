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

    # Рисуем прямоугольники вокруг найденных лиц
    for (x, y, w, h) in faces:
        cv2.rectangle(img, (x, y), (x+w, y+h), (255, 0, 0), 2)

    # Отображаем результат
    # Вместо cv2.imshow('img', img)
    cv2.imwrite('output.jpg', img)
    print("Изображение с распознанными лицами сохранено как output.jpg")

if __name__ == '__main__':
    # Получаем путь до изображения
    if len(sys.argv) > 1:
        image_path = sys.argv[1]
    else:
        image_path = 'image.jpg'  # файл по умолчанию

    detect_faces(image_path)
