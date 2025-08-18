# Intentionally use an older Java 17 base image
FROM eclipse-temurin:17-jdk
EXPOSE 8081
ARG JAR_FILE=target/*.jar
ADD ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]