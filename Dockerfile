
FROM openjdk:8-jdk-stretch

WORKDIR /app

RUN apt-get update && \
    apt-get install -y maven=3.6.0-1 \
    curl=7.52.1-5+deb9u12 \
    git && \
    rm -rf /var/lib/apt/lists/*

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

USER root

EXPOSE 8081

CMD ["java", "-jar", "target/calculator-app-0.0.1-SNAPSHOT.jar"]
