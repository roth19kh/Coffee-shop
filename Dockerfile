FROM eclipse-temurin:21-jdk
WORKDIR /app
COPY target/*.jar app.jar

# Optional defaults
ENV PORT=8080
ENV DATABASE_URL=jdbc:mysql://db:3306/roth
ENV DB_USER=root
ENV DB_PASSWORD=

EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]