# Use a lightweight Java runtime
FROM eclipse-temurin:17-jdk-alpine

# Metadata
LABEL maintainer="Venkatesan"

# Set working directory in container
WORKDIR /app

# Copy the Spring Boot JAR into the container
COPY target/TimelyTrave-0.0.1-SNAPShot.jar app.jar

# Expose the port your Spring Boot app runs on (default 8080)
EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java","-jar","app.jar"]
