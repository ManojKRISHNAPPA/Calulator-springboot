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
RUN addgroup -g 1001 -S appuser && \
    adduser -u 1001 -S appuser -G appuser

USER appuser

# Set working directory
WORKDIR /app

# Copy the built JAR from the previous stage
COPY --from=builder /build/target/*.jar app.jar

# Expose port
EXPOSE 8081

# Define the startup command
ENTRYPOINT ["java", "-jar", "app.jar"]
