FROM openjdk:8-jdk-buster

WORKDIR /app

RUN apt-get update && \
    apt-get install -y maven curl git && \
    rm -rf /var/lib/apt/lists/*

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

EXPOSE 8081

CMD ["java", "-jar", "target/calculator-app-0.0.1-SNAPSHOT.jar"]
