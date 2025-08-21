#!/bin/bash

# Spring Boot Calculator Application Startup Script
# This script includes necessary JVM arguments to fix Tomcat initialization issues with Java 17+

echo "Starting Spring Boot Calculator Application..."
echo "=========================================="

# Set the JAR file path
JAR_FILE="target/calculator-app-0.0.1-SNAPSHOT.jar"

# Check if the JAR file exists
if [ ! -f "$JAR_FILE" ]; then
    echo "Error: JAR file not found at $JAR_FILE"
    echo "Please run 'mvn clean package' first to build the application."
    exit 1
fi

# JVM arguments to fix Java 17 module system compatibility issues
JVM_ARGS=(
    "--add-opens=java.base/java.io=ALL-UNNAMED"
    "--add-opens=java.base/java.lang=ALL-UNNAMED"
    "--add-opens=java.base/java.lang.reflect=ALL-UNNAMED"
    "--add-opens=java.base/java.net=ALL-UNNAMED"
    "--add-opens=java.base/java.nio=ALL-UNNAMED"
    "--add-opens=java.base/java.util=ALL-UNNAMED"
    "--add-opens=java.base/sun.nio.ch=ALL-UNNAMED"
    "--add-opens=java.base/sun.nio.cs=ALL-UNNAMED"
    "--add-opens=java.base/sun.security.action=ALL-UNNAMED"
    "--add-opens=java.base/sun.util.calendar=ALL-UNNAMED"
    "--add-opens=java.naming/javax.naming.spi=ALL-UNNAMED"
    "--add-opens=java.rmi/sun.rmi.transport=ALL-UNNAMED"
)

# Additional JVM options for performance and debugging
ADDITIONAL_ARGS=(
    "-Xms512m"
    "-Xmx1024m"
    "-Dspring.profiles.active=default"
    "-Djava.awt.headless=true"
)

echo "Java Version: $(java -version 2>&1 | head -n 1)"
echo "JAR File: $JAR_FILE"
echo "Starting with JVM arguments to resolve module system issues..."
echo ""

# Run the application with proper JVM arguments
exec java "${JVM_ARGS[@]}" "${ADDITIONAL_ARGS[@]}" -jar "$JAR_FILE" "$@"
