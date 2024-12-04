# Используем официальный образ OpenJDK как базовый образ
FROM openjdk:23-jdk-slim

# Устанавливаем рабочую директорию в контейнере
WORKDIR /app

# Копируем jar файл вашего приложения в контейнер
COPY . /app/afisha-shop.jar

EXPOSE 8080

# Команда для запуска вашего приложения
ENTRYPOINT ["java", "-jar", "/app/afisha-shop.jar"]
