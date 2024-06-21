# Use an official Java runtime as a parent image
FROM eclipse-temurin:21-jre-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file into the container
COPY target/productapi-0.0.1-SNAPSHOT.jar /app/product-api.jar

# Expose the port the application runs on
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "/app/product-api.jar"]