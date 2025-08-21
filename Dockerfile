# ---------- Stage 1: Build the application ----------
FROM maven:3.9.6-eclipse-temurin-17 AS builder

# Set working directory
WORKDIR /build

# Copy source code
COPY . .

# Build the application (skip tests if desired)
RUN mvn clean package -DskipTests

# ---------- Stage 2: Create runtime image ----------
FROM eclipse-temurin:17-jdk

# Create a non-root user
# Create a non-root user
RUN addgroup --gid 1001 appuser && \
    adduser --uid 1001 --gid 1001 --home /home/appuser --shell /bin/bash --disabled-password --gecos "" appuser && \
    mkdir -p /app && chown -R appuser:appuser /app


USER appuser

# Set working directory
WORKDIR /app

# Copy the built JAR from the previous stage
COPY --from=builder /build/target/*.jar app.jar

# Expose port
EXPOSE 8081

# Define the startup command
ENTRYPOINT ["java", "-jar", "app.jar"]
