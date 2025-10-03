# Stage 1: Build JAR
FROM eclipse-temurin:21-jdk AS build
WORKDIR /app

# Install Gradle
RUN apt-get update && \
    apt-get install -y wget unzip && \
    wget https://services.gradle.org/distributions/gradle-8.3-bin.zip -P /tmp && \
    unzip /tmp/gradle-8.3-bin.zip -d /opt && \
    ln -s /opt/gradle-8.3/bin/gradle /usr/bin/gradle

# Copy project files
COPY build.gradle settings.gradle ./
COPY src ./src

# Build the Spring Boot JAR
RUN gradle clean build --no-daemon -x test

# Stage 2: Run JAR
FROM eclipse-temurin:21-jdk
WORKDIR /app

# Copy the JAR from build stage
COPY --from=build /app/build/libs/*.jar app.jar

# Environment variables
ENV PORT=8080
ENV DATABASE_URL=jdbc:mysql://localhost:3306/roth
ENV DB_USER=root
ENV DB_PASSWORD=

EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]