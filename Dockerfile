# Stage 1: Build JAR
FROM gradle:8.3-jdk17 AS build
WORKDIR /app
COPY build.gradle settings.gradle ./
COPY src ./src
RUN gradle clean build --no-daemon

# Stage 2: Run JAR
FROM eclipse-temurin:21-jdk
WORKDIR /app
COPY --from=build /coffee-shop-telegram-bot/build/libs/*.jar app.jar

ENV PORT=8080
ENV DATABASE_URL=jdbc:mysql://localhost:3306/roth
ENV DB_USER=root
ENV DB_PASSWORD=

EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
