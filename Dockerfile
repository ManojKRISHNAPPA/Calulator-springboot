FROM eclipse-temurin:17-jre-alpine
EXPOSE 8080
RUN addgroup -S pipeline && adduser -S k8-pipeline -G pipeline
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} /home/k8-pipeline/app.jar
USER k8-pipeline
ENTRYPOINT ["java","-jar","/home/k8-pipeline/app.jar"]