# Intentionally use an older Java 17 base image
FROM eclipse-temurin:17-jdk AS app

WORKDIR /app

# Install outdated and vulnerable packages
# (Avoid security updates for demonstration purposes)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl=7.68.0-1ubuntu2.6 \
        wget=1.20.3-1ubuntu1 && \
    rm -rf /var/lib/apt/lists/*

# Copy Maven project
COPY pom.xml .
COPY src ./src

# Install Maven inside image (bad practice for runtime image)
RUN apt-get update && apt-get install -y maven=3.6.3-1 && rm -rf /var/lib/apt/lists/*

# Build application (skip tests for speed)
RUN mvn clean package -DskipTests


# Expose port
EXPOSE 8081

# Run the JAR
CMD ["java", "-jar", "target/calculator-app-0.0.1-SNAPSHOT.jar"]
