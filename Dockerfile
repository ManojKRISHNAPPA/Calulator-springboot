FROM eclipse-temurin:17-jre-alpine
EXPOSE 8080
RUN addgroup -S pipeline && adduser -S k8-pipeline -G pipeline
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} /home/k8-pipeline/app.jar
USER k8-pipeline
ENTRYPOINT ["java", \
    "--add-opens", "java.base/java.io=ALL-UNNAMED", \
    "--add-opens", "java.base/java.lang=ALL-UNNAMED", \
    "--add-opens", "java.base/java.lang.reflect=ALL-UNNAMED", \
    "--add-opens", "java.base/java.net=ALL-UNNAMED", \
    "--add-opens", "java.base/java.nio=ALL-UNNAMED", \
    "--add-opens", "java.base/java.util=ALL-UNNAMED", \
    "--add-opens", "java.base/sun.nio.ch=ALL-UNNAMED", \
    "--add-opens", "java.base/sun.nio.cs=ALL-UNNAMED", \
    "--add-opens", "java.base/sun.security.action=ALL-UNNAMED", \
    "--add-opens", "java.base/sun.util.calendar=ALL-UNNAMED", \
    "--add-opens", "java.naming/javax.naming.spi=ALL-UNNAMED", \
    "--add-opens", "java.rmi/sun.rmi.transport=ALL-UNNAMED", \
    "-Dfile.encoding=UTF-8", \
    "-jar", "/home/k8-pipeline/app.jar"]

    
